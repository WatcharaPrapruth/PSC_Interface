page 51006 "API Car Brand"
{
    PageType = API;

    APIVersion = 'v1.0';
    APIPublisher = 'bctech';
    APIGroup = 'demo';

    EntityCaption = 'Car Brand';
    EntitySetCaption = 'Car Brands';
    EntityName = 'carBrand';
    EntitySetName = 'carBrands';

    ODataKeyFields = SystemId;
    SourceTable = "Car Brand";

    Extensible = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }

                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(country; Rec.Country)
                {
                    Caption = 'Country';
                }
                field(countLine; Rec.CountLine)
                {
                    Caption = 'Count Line';
                }

                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(errorMessage; Rec."Error message")
                {
                    Caption = 'Error message';
                }
                field(countLineTmp; Rec.CountLineTmp)
                {
                    Caption = 'Count Line Temp';
                }
                field(testBlob; Rec.TestBlob)
                {
                    Caption = 'Test Blob';
                }
            }

            part(carModels; "API Car Model")
            {
                Caption = 'Car Models';
                EntityName = 'carModel';
                EntitySetName = 'carModels';
                SubPageLink = "Brand Id" = Field(SystemId);
            }
        }
    }
    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     process();
    // end;

    // local procedure process()
    // var
    //     stringError: Text;
    //     outS: OutStream;
    // begin
    //     if run() then begin
    //         Rec.Status := "PSC Status Interface"::Success;
    //     end
    //     else begin
    //         Rec.Status := "PSC Status Interface"::Failed;
    //         Rec."Error message" := GetLastErrorText();
    //         Rec.Insert();
    //         Commit();
    //         Error(GetLastErrorText());
    //     end;
    // end;

    // [TryFunction]
    // local procedure run()
    // begin
    //     validate();
    //     init();
    // end;

    // local procedure validate()
    // begin
    //     if Rec.Description = '' then
    //         Error('Description ค่่าว่าง');

    // end;

    // local procedure init()
    // begin
    //     Rec.InitField := StrSubstNo('%1 %2', Rec.InitField, 'H');
    //     Rec.Status := "PSC Status Interface"::Success;
    // end;
}