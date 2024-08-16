table 51001 "PSC GenBusPostingGroupMapping"
{
    Caption = 'Gen. Bus. Posting Group Mapping';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'No.';
            TableRelation = "PSC Truck Scale & Maximo Setup";
            DataClassification = CustomerContent;
        }
        field(3; "Gen. Control"; Code[50])
        {
            Caption = 'Gen. Control';
            DataClassification = CustomerContent;

        }

        field(4; "Gen Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen Bus. Posting Group';
            DataClassification = CustomerContent;
        }

        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key", "Line No.")
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
    var
        lastNum: Integer;
        genBusPostingGroupMapping: Record "PSC GenBusPostingGroupMapping";
    begin
        lastNum := 1;
        if genBusPostingGroupMapping.FindLast() then
            lastNum := genBusPostingGroupMapping."Line No." + 1;

        Rec."Line No." := lastNum;
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