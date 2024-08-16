codeunit 51002 "PSC API Management Core"
{
    procedure GetJsonToken(PJsonObject: JsonObject; PKey: Text): JsonToken
    var
        JNameToken: JsonToken;
    begin
        PJsonObject.Get(PKey, JNameToken);
        exit(JNameToken);
    end;

    procedure ParseDate(Token: JsonToken): Date
    var
        DateParts: List of [Text];
        Year: Integer;
        Month: Integer;
        Day: Integer;
    begin
        // Error handling omitted from example
        DateParts := Token.AsValue().AsText().Split('/');
        Evaluate(Day, DateParts.Get(1));
        Evaluate(Month, DateParts.Get(2));
        Evaluate(Year, DateParts.Get(3));
        exit(DMY2Date(Day, Month, Year));
    end;

    procedure InsertAPILog(ActionPage: Enum "PSC Action Page"; MethodType: Enum "PSC Method Type"; Direction: Enum "PSC Direction"; JsonReq_log: Text; var TxtResponse: Text; StatusInterface: Enum "PSC Status Interface"; Key1: Code[30]; Key2: Code[30]; Key3: Code[30]; ErrorTxt: Text; var RefId: Integer)
    var
        APILog: Record "PSC Interface Log";
    begin
        APILog.INIT;
        APILog."PSC Method Type" := MethodType;
        APILog."PSC Action Page" := ActionPage;
        APILog."PSC Direction" := Direction;
        APILog."PSC Status" := StatusInterface;
        case APILog."PSC Action Page" of
            "PSC Action Page"::"Sales Invoice", "PSC Action Page"::"Sales Credit Memo":
                begin
                    APILog."PSC Primary Key Caption" := StrSubstNo('[1: Document_Type]');
                end;
        end;
        APILog."PSC Primary Key Value 1" := Key1;
        APILog."PSC Primary Key Value 2" := Key2;
        APILog."PSC Primary Key Value 3" := Key3;
        APILog.INSERT(true);
        RefId := APILog."PSC Entry No.";

        SetAPIDetail(APILog, APILog.FIELDNO("PSC Description"), ErrorTxt, TEXTENCODING::UTF8);
        SetAPIDetail(APILog, APILog.FIELDNO("PSC Json Log"), JsonReq_log, TEXTENCODING::UTF8);
        SetAPIDetail(APILog, APILog.FIELDNO("PSC Response Log"), TxtResponse, TEXTENCODING::UTF8);
    end;

    local procedure SetAPIDetail(var APILog: Record "PSC Interface Log"; FIELDNO: Integer; JsonTxt: Text; pEncoding: TextEncoding)
    var
        OutStream: OutStream;
    begin
        IF JsonTxt = '' THEN
            EXIT;

        CASE FIELDNO OF
            APILog.FIELDNO("PSC Description"):
                BEGIN
                    Clear(APILog."PSC Description");
                    APILog."PSC Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                END;
            APILog.FIELDNO("PSC Json Log"):
                BEGIN
                    CLEAR(APILog."PSC Json Log");
                    APILog."PSC Json Log".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                END;
            APILog.FIELDNO("PSC Response Log"):
                BEGIN
                    Clear(APILog."PSC Response Log");
                    APILog."PSC Response Log".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                END;
        END;
        OutStream.WriteText(JsonTxt);
        IF APILog.MODIFY THEN;
    end;
}

