table 51003 "Car Brand"
{
    DataClassification = CustomerContent;
    Caption = 'Car Brand';

    fields
    {
        // field(1; Name; Text[100])
        // {
        //     Caption = 'Name';
        // }
        field(1; Name; Integer)
        {
            Caption = 'Name';
            AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Country"; Text[100])
        {
            Caption = 'Country';
        }
        field(4; InitField; Text[100])
        {
            Caption = 'Init Filed';
        }
        field(5; CountLine; Integer)
        {
            Caption = 'Count Line';
            DataClassification = ToBeClassified;
        }
        field(6; CountLineTmp; Integer)
        {
            Caption = 'Count Line Temp';
            DataClassification = ToBeClassified;
        }
        field(7; "Status"; Enum "PSC Status Interface")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(8; "Error message"; Text[2048])
        {
            Caption = 'Error message';
            DataClassification = CustomerContent;
        }
        field(9; TestBlob; Blob)
        {
            Caption = 'Test Blob';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}