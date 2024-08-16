pageextension 51000 "PSC Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("Posting Description")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. field.', Comment = '%';
            }
        }
    }
}