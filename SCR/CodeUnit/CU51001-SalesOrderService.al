codeunit 51001 "PSC Sales order service"
{
    var
        apiMgtCore: Codeunit "PSC API Management Core";
        salesHeader: Record "Sales Header";
        salesLine: Record "Sales Line";
        ActionPage: Enum "PSC Action Page";
        Direction: Enum "PSC Direction";
        StatusInterface: Enum "PSC Status Interface";
        MethodType: Enum "PSC Method Type";
        Key1: Text[30];
        RefId: Integer;
        Sales_Header: Label 'Sales Header';
        Seles_Line: Label 'Sales Line';
        isNull: Label '%1 must have a value in %2. It cannot be zero or empty.';
        cannot_be_found: Label 'The field %1 of table %2 contains a value (%3) that cannot be found in the related table';
        Invoice: Label 'Invoice';
        Credit_Memo: Label 'Credit Memo';
        JSaleHeader: JsonObject;
        JSaleLineArray: JsonArray;
        //Sales header
        Document_Type: Label 'Document_Type';
        No: Label 'No';
        Posting_Description: Label 'Posting_Description';
        Sell_to_Customer_No: Label 'Sell_to_Customer_No';
        Posting_Date: Label 'Posting_Date';
        Location_Code: Label 'Location_Code';
        Batch_No: Label 'Batch_No';
        Payment_Term_Code: Label 'Payment_Term_Code';
        Due_Date: Label 'Due_Date';
        Ship_to_Code: Label 'Ship_to_Code';
        External_Document_No: Label 'External_Document_No';
        Document_Date: Label 'Document_Date';
        DM_Ship_to: Label 'DM_Ship_to';
        VAT_Bus_Posting_Group: Label 'VAT_Bus_Posting_Group';
        Transaction_ID: Label 'Transaction_ID';
        sales_lines: Label 'sales_lines';

        //Sales line
        Line_No: Label 'Line_No';
        Type: Label 'Type';
        //No: Label '';
        Description: Label 'Description';
        "Description_2": Label 'Description_2';
        Quantity: Label 'Quantity';
        Unit_of_Measure_Code: Label 'Unit_of_Measure_Code';
        Unit_Price: Label 'Unit_Price';
        VAT_Prod_Posting_Group: Label 'VAT_Prod_Posting_Group';

    procedure RunService(pRequest: Text) Response: Text
    var
        JsonReq_log: Text;
    begin
        if process(pRequest) then begin
            StatusInterface := "PSC Status Interface"::Success;
            initJsonLog(pRequest, JsonReq_log, Response, '');
            apiMgtCore.InsertAPILog(ActionPage, MethodType, Direction,
                            JsonReq_log, Response, StatusInterface,
                            Key1, '', '',
                            '', RefId); // เก็บ Log
        end
        else begin
            StatusInterface := "PSC Status Interface"::Failed;
            initJsonLog(pRequest, JsonReq_log, Response, GetLastErrorText());
            apiMgtCore.InsertAPILog(ActionPage, MethodType, Direction,
                            JsonReq_log, Response, StatusInterface,
                            Key1, '', '',
                            GetLastErrorText(), RefId); // เก็บ Log
            // Commit();
            // Error(GetLastErrorText());
        end;
    end;

    [TryFunction]
    local procedure process(pRequest: Text)
    begin
        init(pRequest);
        validate();
        insertData();
    end;

    local procedure init(pRequest: Text)
    var
        JsonToken: JsonToken;
        JSaleLinesToken: JsonToken;
    begin
        ActionPage := "PSC Action Page"::"Sales Invoice";
        Direction := "PSC Direction"::Inbound;
        StatusInterface := "PSC Status Interface"::Failed;
        MethodType := "PSC Method Type"::Insert;

        if JsonToken.ReadFrom(format(pRequest)) then begin
            JSaleHeader := JsonToken.AsObject();
            Key1 := apiMgtCore.GetJsonToken(JSaleHeader, No).AsValue().AsText();
            if JSaleHeader.Get(sales_lines, JSaleLinesToken) then begin
                JSaleLineArray := JSaleLinesToken.AsArray();
            end;
        end;
    end;

    local procedure validate()
    var
        JSaleLine: JsonObject;
        JSaleLineToken: JsonToken;
    begin
        ValidateSalesHeader(JSaleHeader);
        foreach JSaleLineToken in JSaleLineArray do begin
            JSaleLine := JSaleLineToken.AsObject();
            ValidateSalesLine(JSaleLine);
        end;
    end;

    local procedure ValidateSalesHeader(var JSaleHeader: JsonObject)
    var
        testText: Text;
    begin
        ValidateSalesHeaderFieldName(JSaleHeader);
        ValidateSalesHeaderMandatory(JSaleHeader);
    end;

    local procedure ValidateSalesHeaderFieldName(var JSaleHeader: JsonObject)
    begin
        apiMgtCore.GetJsonToken(JSaleHeader, Document_Type);
        apiMgtCore.GetJsonToken(JSaleHeader, No);
        apiMgtCore.GetJsonToken(JSaleHeader, Posting_Description);
        apiMgtCore.GetJsonToken(JSaleHeader, Sell_to_Customer_No);
        apiMgtCore.GetJsonToken(JSaleHeader, Posting_Date);
        apiMgtCore.GetJsonToken(JSaleHeader, Location_Code);
        apiMgtCore.GetJsonToken(JSaleHeader, Batch_No);
        apiMgtCore.GetJsonToken(JSaleHeader, Payment_Term_Code);
        apiMgtCore.GetJsonToken(JSaleHeader, Due_Date);
        apiMgtCore.GetJsonToken(JSaleHeader, Ship_to_Code);
        apiMgtCore.GetJsonToken(JSaleHeader, External_Document_No);
        apiMgtCore.GetJsonToken(JSaleHeader, Document_Date);
        apiMgtCore.GetJsonToken(JSaleHeader, DM_Ship_to);
        apiMgtCore.GetJsonToken(JSaleHeader, VAT_Bus_Posting_Group);
        apiMgtCore.GetJsonToken(JSaleHeader, Transaction_ID);
        apiMgtCore.GetJsonToken(JSaleHeader, sales_lines);
    end;

    local procedure ValidateSalesHeaderMandatory(var JSaleHeader: JsonObject)
    var
        textTmp: Text;
        dateTmp: Date;
    begin
        textTmp := apiMgtCore.GetJsonToken(JSaleHeader, Document_Type).AsValue().AsText();

        if not ((FORMAT(textTmp) = Invoice) OR (FORMAT(textTmp) = Credit_Memo)) then begin
            Error(StrSubstNo(cannot_be_found, Document_Type, Sales_Header, textTmp));
        end
        else begin
            if (FORMAT(textTmp) = Invoice) then
                ActionPage := "PSC Action Page"::"Sales Invoice"
            else
                ActionPage := "PSC Action Page"::"Sales Credit Memo";
        end;

        if apiMgtCore.GetJsonToken(JSaleHeader, No).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, No, Sales_Header))
        else
            Key1 := apiMgtCore.GetJsonToken(JSaleHeader, No).AsValue().AsText();

        if apiMgtCore.GetJsonToken(JSaleHeader, Posting_Description).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Posting_Description, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Sell_to_Customer_No).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Sell_to_Customer_No, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Posting_Date).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Posting_Date, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Location_Code).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Location_Code, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Batch_No).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Batch_No, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Payment_Term_Code).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Payment_Term_Code, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Due_Date).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Due_Date, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Ship_to_Code).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Ship_to_Code, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, External_Document_No).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, External_Document_No, Sales_Header));

        //dateTmp := apiMgtCore.ParseDate(apiMgtCore.GetJsonToken(JSaleHeader, Document_Date));

        if apiMgtCore.GetJsonToken(JSaleHeader, Document_Date).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Document_Date, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, DM_Ship_to).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, DM_Ship_to, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, VAT_Bus_Posting_Group).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, VAT_Bus_Posting_Group, Sales_Header));

        if apiMgtCore.GetJsonToken(JSaleHeader, Transaction_ID).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Transaction_ID, Sales_Header));
    end;

    local procedure ValidateSalesLine(var JSaleLine: JsonObject) ret: Boolean;
    var
        testText: Text;
        testInt: Integer;
    begin
        ret := true;

        ValidateSalesLineFieldName(JSaleLine);
        ValidateSalesLineMandatory(JSaleLine);
    end;

    local procedure ValidateSalesLineFieldName(var JSaleLine: JsonObject)
    begin
        apiMgtCore.GetJsonToken(JSaleLine, Line_No);
        apiMgtCore.GetJsonToken(JSaleLine, Type);
        apiMgtCore.GetJsonToken(JSaleLine, No);
        apiMgtCore.GetJsonToken(JSaleLine, Description);
        apiMgtCore.GetJsonToken(JSaleLine, Description_2);
        apiMgtCore.GetJsonToken(JSaleLine, Quantity);
        apiMgtCore.GetJsonToken(JSaleLine, Unit_of_Measure_Code);
        apiMgtCore.GetJsonToken(JSaleLine, Unit_Price);
        apiMgtCore.GetJsonToken(JSaleLine, VAT_Prod_Posting_Group);
    end;

    local procedure ValidateSalesLineMandatory(var JSaleLine: JsonObject)
    var
        textTmp: Text;
        dateTmp: Date;
    begin

        if apiMgtCore.GetJsonToken(JSaleLine, Line_No).AsValue().AsInteger() = 0 then
            Error(StrSubstNo(isNull, Line_No, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, Type).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Type, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, No).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, No, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, Description).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Description, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, Quantity).AsValue().AsInteger() = 0 then
            Error(StrSubstNo(isNull, Quantity, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, Unit_of_Measure_Code).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, Unit_of_Measure_Code, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, Unit_Price).AsValue().AsInteger() = 0 then
            Error(StrSubstNo(isNull, Unit_Price, Seles_Line));

        if apiMgtCore.GetJsonToken(JSaleLine, VAT_Prod_Posting_Group).AsValue().AsText() = '' then
            Error(StrSubstNo(isNull, VAT_Prod_Posting_Group, Seles_Line));

    end;

    local procedure initJsonLog(pRequest: Text; var JsonReq_log: Text; var Response: Text; Remark: text)
    var
        JSaleHeader: JsonObject;
        JSaleLine: JsonObject;
        JResponse: JsonObject;
        JResObj: JsonObject;

        JSaleLinesToken: JsonToken;
        JSaleLineToken: JsonToken;
        JsonToken: JsonToken;

        JSaleLineArray: JsonArray;
        JResArr: JsonArray;

    begin
        JsonReq_log := pRequest.Replace('\"', '"');

        JResObj.Add('PrimaryKeyValue1', Key1);
        JResArr.Add(JResObj);
        JResponse.Add('Key_ID', JResArr);
        JResponse.Add('Status', Format(StatusInterface));
        JResponse.Add('Remark', Remark);
        JResponse.WriteTo(Response);
    end;

    local procedure insertData()
    var
        JSaleLine: JsonObject;
        JSaleLineToken: JsonToken;
        salesHeaderTmp: Record "Sales Header" temporary;
        salesLineTmp: Record "Sales Line" temporary;
    begin
        insertSalesHeader(JSaleHeader, salesHeaderTmp);
        if not salesHeaderTmp.IsEmpty then begin
            salesHeaderTmp.Init();
            salesHeader.TransferFields(salesHeaderTmp);
            salesHeader.Insert();
        end;
        foreach JSaleLineToken in JSaleLineArray do begin
            JSaleLine := JSaleLineToken.AsObject();
            Clear(salesLine);
            insertSalesLine(JSaleLine, salesLineTmp);
            if not salesLineTmp.IsEmpty then begin
                salesLineTmp.Init();
                salesLine.TransferFields(salesLineTmp);
                salesLine.Insert();
            end;
        end;
    end;

    local procedure insertSalesLine(var JSaleLine: JsonObject; var salesLineTmp: Record "Sales Line" temporary)
    begin
        salesLineTmp.Validate("Line No.", apiMgtCore.GetJsonToken(JSaleLine, Line_No).AsValue().AsInteger());
        //apiMgtCore.GetJsonToken(JSaleLine, Type);
        salesLineTmp.Validate("No.", apiMgtCore.GetJsonToken(JSaleLine, No).AsValue().AsCode());
        salesLineTmp.Validate(Description, apiMgtCore.GetJsonToken(JSaleLine, Description).AsValue().AsText());
        salesLineTmp.Validate("Description 2", apiMgtCore.GetJsonToken(JSaleLine, Description_2).AsValue().AsText());
        salesLineTmp.Validate(Quantity, apiMgtCore.GetJsonToken(JSaleLine, Quantity).AsValue().AsDecimal());
        salesLineTmp.Validate("Unit of Measure Code", apiMgtCore.GetJsonToken(JSaleLine, Unit_of_Measure_Code).AsValue().AsCode());
        salesLineTmp.Validate("Unit Price", apiMgtCore.GetJsonToken(JSaleLine, Unit_Price).AsValue().AsDecimal());
        //apiMgtCore.GetJsonToken(JSaleLine, Unit_Price);
        salesLineTmp.Validate("VAT Prod. Posting Group", apiMgtCore.GetJsonToken(JSaleLine, VAT_Prod_Posting_Group).AsValue().AsCode());
    end;

    local procedure insertSalesHeader(var JSaleHeader: JsonObject; var salesHeaderTmp: Record "Sales Header" temporary)
    var
        textTmp: Text;
    begin
        salesHeaderTmp.Init();

        textTmp := apiMgtCore.GetJsonToken(JSaleHeader, Document_Type).AsValue().AsText();
        case textTmp of
            Invoice:
                salesHeaderTmp.Validate("Document Type", "Sales Document Type"::Invoice);
            Credit_Memo:
                salesHeaderTmp.Validate("Document Type", "Sales Document Type"::"Credit Memo");
        end;

        salesHeaderTmp.Validate("No.", apiMgtCore.GetJsonToken(JSaleHeader, No).AsValue().AsText());
        salesHeaderTmp.Validate("Posting Description", apiMgtCore.GetJsonToken(JSaleHeader, Posting_Description).AsValue().AsText());
        salesHeaderTmp.Validate("Sell-to Customer No.", apiMgtCore.GetJsonToken(JSaleHeader, Sell_to_Customer_No).AsValue().AsText());
        salesHeaderTmp.Validate("Posting Date", apiMgtCore.ParseDate(apiMgtCore.GetJsonToken(JSaleHeader, Posting_Date)));
        salesHeaderTmp.Validate("Location Code", apiMgtCore.GetJsonToken(JSaleHeader, Location_Code).AsValue().AsText());
        //apiMgtCore.GetJsonToken(JSaleHeader, Batch_No);
        salesHeaderTmp.Validate("Payment Terms Code", apiMgtCore.GetJsonToken(JSaleHeader, Payment_Term_Code).AsValue().AsText());
        salesHeaderTmp.Validate("Due Date", apiMgtCore.ParseDate(apiMgtCore.GetJsonToken(JSaleHeader, Due_Date)));
        salesHeaderTmp.Validate("Ship-to Code", apiMgtCore.GetJsonToken(JSaleHeader, Ship_to_Code).AsValue().AsText());
        salesHeaderTmp.Validate("External Document No.", apiMgtCore.GetJsonToken(JSaleHeader, External_Document_No).AsValue().AsText());
        salesHeaderTmp.Validate("Document Date", apiMgtCore.ParseDate(apiMgtCore.GetJsonToken(JSaleHeader, Document_Date)));
        //apiMgtCore.GetJsonToken(JSaleHeader, DM_Ship_to);
        salesHeaderTmp.Validate("VAT Bus. Posting Group", apiMgtCore.GetJsonToken(JSaleHeader, VAT_Bus_Posting_Group).AsValue().AsText());
        //apiMgtCore.GetJsonToken(JSaleHeader, Transaction_ID);
        salesHeaderTmp.Insert(true);
    end;
}