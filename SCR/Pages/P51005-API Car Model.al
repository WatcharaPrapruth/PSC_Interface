page 51005 "API Car Model"
{
    PageType = API;

    APIVersion = 'v1.0';
    APIPublisher = 'bctech';
    APIGroup = 'demo';

    EntityCaption = 'Car Model';
    EntitySetCaption = 'Car Models';
    EntityName = 'carModel';
    EntitySetName = 'carModels';

    ODataKeyFields = SystemId;
    SourceTable = "Car Model";

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
                field(brandId; Rec."Brand Id")
                {
                    Caption = 'Brand Id';
                }
                field(power; Rec.Power)
                {
                    Caption = 'Power';
                }
                field(fuelType; Rec."Fuel Type")
                {
                    Caption = 'Fuel Type';
                }
            }
        }
    }

    var
        carBrand: Record "Car Brand";
        countLine: Integer;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        process();
    end;

    local procedure process()
    begin

        if run() then begin
            carBrand.Status := "PSC Status Interface"::Success;
            carBrand.Modify(true);
            Commit();
        end
        else begin
            carBrand.Status := "PSC Status Interface"::Failed;
            carBrand."Error message" := GetLastErrorText();
            carBrand.Modify(true);
            Commit();
            Error(GetLastErrorText());
        end;
    end;

    local procedure getCarBrand()
    begin
        if not carBrand.GetBySystemId(Rec."Brand Id") then
            Error('Not get car brand');
    end;

    [TryFunction]
    local procedure run()
    var
        carModelCount: Record "Car Model";

        lineHeader: Integer;
        errorMessage: Text;
    begin
        getCarBrand();

        carModelCount.RESET;
        carModelCount.SETRANGE("Brand Id", Rec."Brand Id");
        countLine := carModelCount.count + 1;
        // carBrand.CountLineTmp := carBrand.CountLineTmp + 1;
        // countLine := carBrand.CountLineTmp;

        lineHeader := carBrand.CountLine;

        if lineHeader = countLine then begin
            carBrand.CountLineTmp := countLine;
            carBrand.Modify(true);
            Commit();
        end;


        // carBrand.Modify(true);
        // Commit();

    end;
}