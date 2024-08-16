page 51002 "Keng Test"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    //SourceTable = TableName;

    layout
    {
        area(Content)
        {
            // repeater(GroupName)
            // {
            //     field(Name; NameSource)
            //     {
            //         ApplicationArea = All;

            //     }
            // }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(SalesInvoice)
            {
                ApplicationArea = All;
                Caption = 'Sales invoice';

                trigger OnAction()
                var
                    apiMgtService: Codeunit "PSC API Management Service";
                    request: Text;
                begin
                    request := '{"Document_Type":"Invoice","No":"P_INVOCICE","Posting_Description":"ค่าขายเกลือ","Sell_to_Customer_No":"T0003","Posting_Date":"02/07/2022","Location_Code":"00000","Batch_No":"SOP24-0001","Payment_Term_Code":"AA","Due_Date":"02/07/2022","Ship_to_Code":"MTP1","External_Document_No":"SRP2201-006","Document_Date":"02/07/2022","DM_Ship_to":"TP1","VAT_Bus_Posting_Group":"VATB2","Transaction_ID":"00000","sales_lines":[{"Line_No":10000,"Type":"Item","No":"1000-000-0001","Description":"66049/63-5311*73-4571","Description_2":"","Quantity":28600,"Unit_of_Measure_Code":"KG","Unit_Price":34.48000000,"VAT_Prod_Posting_Group":"2SAL-VAT7%"},{"Line_No":20000,"Type":"Item","No":"1000-000-0001","Description":"66049/63-5311*73-4571","Description_2":"","Quantity":28600,"Unit_of_Measure_Code":"KG","Unit_Price":34.48000000,"VAT_Prod_Posting_Group":"2SAL-VAT7%"}]}';
                    Message(apiMgtService.SalesOrderService(request));
                end;
            }

            action(DeleteCar)
            {
                ApplicationArea = All;
                Caption = 'Delete Car';

                trigger OnAction()
                var
                    carBrand: Record "Car Brand";
                    carModel: Record "Car Model";
                    OutStream: OutStream;
                begin
                    carBrand.DeleteAll(true);
                    carModel.DeleteAll(true);
                    Commit();

                    Clear(carBrand);
                    Clear(carModel);
                    carBrand.Init();
                    carBrand.Description := 'AA';

                    Clear(carBrand.TestBlob);
                    carBrand.TestBlob.CreateOutStream(OutStream, TEXTENCODING::UTF8);
                    OutStream.WriteText('Test gen text file');

                    carBrand.Insert();
                    Commit();

                    // if not MyProcedure() then begin
                    //     Clear(carBrand);
                    //     carBrand.Init();
                    //     carBrand.Description := 'CC';
                    //     carBrand.Insert();
                    //     Error('BB');
                    // end

                    //Message('Delete complete');
                end;
            }
        }
    }

    [TryFunction]
    local procedure MyProcedure()
    var
        carBrand: Record "Car Brand";
    begin
        carBrand.Init();
        carBrand.Description := 'BB';
        carBrand.Insert();
        Error('AA');
    end;
}