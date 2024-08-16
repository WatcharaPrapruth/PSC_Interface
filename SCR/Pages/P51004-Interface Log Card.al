page 51004 "PSC Interface Log Card"
{
    ApplicationArea = All;
    Caption = 'Interface Log Card';
    PageType = Card;
    SourceTable = "PSC Interface Log";
    Editable = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("PSC Entry No."; Rec."PSC Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("PSC Method Type"; Rec."PSC Method Type")
                {
                    ToolTip = 'Specifies the value of the Method Type field.', Comment = '%';
                }
                field("PSC Interface Path"; Rec."PSC Interface Path")
                {
                    ToolTip = 'Specifies the value of the Interface Path field.', Comment = '%';
                }

                field("PSC Action Page"; Rec."PSC Action Page")
                {
                    ToolTip = 'Specifies the value of the Action Page field.', Comment = '%';
                }
                field("PSC Direction"; Rec."PSC Direction")
                {
                    ToolTip = 'Specifies the value of the Direction field.', Comment = '%';
                }
                field("PSC Status"; Rec."PSC Status")
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(JsonDescTxt; JsonDescTxt)
                {
                    Caption = 'Description';
                    //MultiLine = true;
                }
                field("PSC Primary Key Caption"; Rec."PSC Primary Key Caption")
                {
                    ToolTip = 'Specifies the value of the Primary Key Caption field.', Comment = '%';
                }
                field("PSC Primary Key Value 1"; Rec."PSC Primary Key Value 1")
                {
                    ToolTip = 'Specifies the value of the Primary Key Value 1 field.', Comment = '%';
                }
                field("PSC Primary Key Value 2"; Rec."PSC Primary Key Value 2")
                {
                    ToolTip = 'Specifies the value of the Primary Key Value 2 field.', Comment = '%';
                }
                field("PSC Primary Key Value 3"; Rec."PSC Primary Key Value 3")
                {
                    ToolTip = 'Specifies the value of the Primary Key Value 3 field.', Comment = '%';
                }


            }
            group(Log)
            {
                Caption = 'Log';
                group(JsonLog)
                {
                    Caption = 'Json Log';
                    field(JsonReqTxt; JsonReqTxt)
                    {
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group(ResLog)
                {
                    Caption = 'Response Log';
                    field(JsonResTxt; JsonResTxt)
                    {
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
            }
        }
    }
    trigger OnAfterGetRecord()

    begin
        JsonReqTxt := GetReqJsonPretty(Rec.FieldNo("PSC Json Log"));
        JsonResTxt := GetReqJsonPretty(Rec.FieldNo("PSC Response Log"));
        //JsonDescTxt := GetReqJsonPretty(Rec.FieldNo("PSC Description"));
        JsonDescTxt := Rec.GetApiDetail(Rec.FieldNo("PSC Description"));
    end;

    var
        JsonReqTxt: Text;
        JsonResTxt: Text;
        JsonDescTxt: Text;

    local procedure GetReqJsonPretty(pFieldNo: Integer): Text
    var
        Jobj: JsonObject;
        JsonTxt: Text;
    begin
        JsonTxt := Rec.GetApiDetail(pFieldNo);
        if (JsonTxt = '') or (pFieldNo = Rec.FieldNo("PSC Description")) then
            exit('');

        Jobj.ReadFrom(JsonTxt);
        exit(PrettyPrintJsonContent(Jobj));
    end;

    procedure PrettyPrintJsonContent(jObject: JsonObject): Text
    begin
        exit(DoPrettyPrintJsonContent(jObject, 0));
    end;

    local procedure DoPrettyPrintJsonContent(jObject: JsonObject; Indent: Integer): Text;
    var
        tb: TextBuilder;
    begin
        tb.AppendLine(GetIndent(Indent) + '{');

        tb.Append(FormatJsonContent(jObject, Indent));

        tb.AppendLine(GetIndent(Indent) + '}');

        exit(tb.ToText());
    end;

    local procedure FormatJsonContent(jObject: JsonObject; var Indent: Integer): Text;
    var
        ValueContent: Text;
        Counter: Integer;
        i: Integer;
        tb: TextBuilder;
        jArray: JsonArray;
        jToken: JsonToken;
        ValuePair: Label '"%1":"%2"', Locked = true;
    begin
        Indent += 1;

        foreach jToken in jObject.Values do begin
            case (true) of
                jToken.IsArray:
                    begin
                        jArray := jToken.AsArray();
                        tb.AppendLine(GetIndent(Indent) + '"' + GetTokenName(jToken) + '"' + ':' + '[');
                        for i := 0 to (jArray.Count - 1) do begin
                            jArray.Get(i, jToken);
                            tb.Append(DoPrettyPrintJsonContent(jToken.AsObject(), Indent + 1));
                        end;
                        tb.AppendLine(GetIndent(Indent) + ']');
                    end;
                jToken.IsObject:
                    begin
                        tb.AppendLine(GetIndent(Indent) + '"' + GetTokenName(jToken) + '"' + ':');
                        tb.Append(DoPrettyPrintJsonContent(jToken.AsObject(), Indent));
                    end;
                jToken.IsValue:
                    begin
                        Clear(ValueContent);
                        if (not jToken.AsValue().IsNull) and (not jToken.AsValue().IsUndefined) then
                            ValueContent := jToken.AsValue().AsText();
                        ValueContent := GetIndent(Indent) + StrSubstNo(ValuePair, GetTokenName(jToken), ValueContent);
                        if (Counter < (jObject.Values.Count - 1)) then
                            ValueContent += ',';
                        tb.AppendLine(ValueContent);
                    end;
            end;

            Counter += 1;
        end;

        Indent -= 1;

        exit(tb.ToText());
    end;

    procedure GetTokenName(jToken: JsonToken) Output: Text
    begin
        Output := jToken.Path;

        while (StrPos(Output, '.') > 0) do
            Output := CopyStr(Output, StrPos(Output, '.') + 1);

        exit(Output);
    end;

    local procedure GetIndent(Count: Integer) IndentValue: Text
    var
        Spacer: Char;
        i: Integer;
    begin
        Spacer := 12288;
        for i := 1 to Count do
            IndentValue += Spacer;
    end;

}
