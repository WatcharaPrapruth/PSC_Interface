table 51000 "PSC Truck Scale & Maximo Setup"
{
    Caption = 'Truck Scale & Maximo Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        //Tab : API Configuration
        field(2; "Enable API"; Boolean)
        {
            Caption = 'Enable API';
            DataClassification = CustomerContent;
        }

        field(3; "Maximo - API Vendor URL"; Text[250])
        {
            Caption = 'Maximo - API Vendor URL';
            DataClassification = CustomerContent;
        }
        field(4; "Maximo - API COA URL"; Text[250])
        {
            Caption = 'Maximo - API COA URL';
            DataClassification = CustomerContent;
        }
        field(5; APIUpdateReceiveStatusURL; Text[250])
        {
            Caption = 'Maximo - API Update Receive Status URL';
            DataClassification = CustomerContent;
        }
        field(16; "Document Type"; enum "YVS Document Type Report")
        {
            Caption = 'Document Type';
            //TableRelation = "YVS Caption Report Setup";
            DataClassification = CustomerContent;
        }

        field(17; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "YVS Caption Report Setup";
            DataClassification = CustomerContent;
        }

        field(18; "Name (Thai)"; Text[50])
        {
            Caption = 'Truck Scale – Sal. INV Header Type';
            DataClassification = CustomerContent;
        }
        field(19; "Name (Eng)"; Text[50])
        {
            Caption = 'Name (Eng)';
            DataClassification = CustomerContent;
        }

        //Tab : Number Series
        field(6; "Maximo – Purch Inv. Nos."; Code[20])
        {
            Caption = 'Maximo – Purch Inv. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(7; "Maximo – Purch Cr. Memo Nos."; Code[20])
        {
            Caption = 'Maximo – Purch Cr. Memo Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; "Truck Scale – Sales Inv. Nos."; Code[20])
        {
            Caption = 'Truck Scale – Sales Inv. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(9; "TruckScaleSalesCrMemoNos"; Code[20])
        {
            Caption = 'Truck Scale – Sales Cr. Memo Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        //Tab : Interface Inventory Batch Setup
        field(10; "Maximo(Issue) – Template"; Code[10])
        {
            Caption = 'Maximo(Issue) – Template';
            TableRelation = "Item Journal Template";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                if "Maximo(Issue) – Batch Name" = '' then
                    exit
                else
                    "Maximo(Issue) – Batch Name" := '';
            end;
        }
        field(11; "Maximo(Issue) – Batch Name"; Code[10])
        {
            Caption = 'Maximo(Issue) – Batch Name';
            DataClassification = CustomerContent;
        }
        field(12; "Maximo(Transfer) – Template"; Code[10])
        {
            Caption = 'Maximo(Transfer) – Template';
            TableRelation = "Item Journal Template";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                if "Maximo(Transfer) – Batch Name" = '' then
                    exit
                else
                    "Maximo(Transfer) – Batch Name" := '';
            end;
        }
        field(13; "Maximo(Transfer) – Batch Name"; Code[10])
        {
            Caption = 'Maximo(Transfer) – Batch Name';
            DataClassification = CustomerContent;
        }
        field(20; "MaximoRevaluationTemplate"; Code[10])
        {
            Caption = 'Maximo (Revaluation) - Template';
            TableRelation = "Item Journal Template";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                if MaximoRevaluationBatchName = '' then
                    exit
                else
                    MaximoRevaluationBatchName := '';
            end;
        }
        field(21; "MaximoRevaluationBatchName"; Code[10])
        {
            Caption = 'Maximo (Revaluation) - Batch Name';
            DataClassification = CustomerContent;
        }

        //Tab : Interface Dimension Setup
        field(14; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = CustomerContent;
            AccessByPermission = TableData "Dimension Combination" = R;
            TableRelation = Dimension;
        }
        field(15; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            DataClassification = CustomerContent;
            AccessByPermission = TableData "Dimension Combination" = R;
            TableRelation = Dimension;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}