table 51005 "Test Log"
{
    Caption = 'Interface Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "PSC Method Type"; Enum "PSC Method Type")
        {
            Caption = 'Method Type';
            DataClassification = CustomerContent;
        }
        field(3; "PSC Interface Path"; Text[200])
        {
            Caption = 'Interface Path';
            DataClassification = CustomerContent;
        }
        field(4; "PSC Action Page"; Enum "PSC Action Page")
        {
            Caption = 'Action Page';
            DataClassification = CustomerContent;
        }
        field(5; "PSC Direction"; Enum "PSC Direction")
        {
            Caption = 'Direction';
            DataClassification = CustomerContent;
        }
        field(6; "PSC Status"; Enum "PSC Status Interface")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(7; "PSC Description"; Blob)
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "PSC Primary Key Caption"; Text[100])
        {
            Caption = 'Primary Key Caption';
            DataClassification = CustomerContent;
        }
        field(9; "PSC Primary Key Value 1"; Code[30])
        {
            Caption = 'Primary Key Value 1';
            DataClassification = CustomerContent;
        }
        field(10; "PSC Primary Key Value 2"; Code[30])
        {
            Caption = 'Primary Key Value 2';
            DataClassification = CustomerContent;
        }
        field(11; "PSC Primary Key Value 3"; Code[30])
        {
            Caption = 'Primary Key Value 3';
            DataClassification = CustomerContent;
        }
        field(12; "PSC Json Log"; Blob)
        {
            Caption = 'Json Log';
            DataClassification = CustomerContent;
        }
        field(13; "PSC Response Log"; Blob)
        {
            Caption = 'Response Log';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
