page 51001 "PSC GenBusPostingGroupMapping"
{
    //AutoSplitKey = true;
    Caption = 'Lines';
    // DelayedInsert = true;
    // LinksAllowed = false;
    // MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "PSC GenBusPostingGroupMapping";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Gen. Control"; Rec."Gen. Control")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Control field.', Comment = '%';
                }
                field("Gen Bus. Posting Group"; Rec."Gen Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen Bus. Posting Group field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                // field("Line No."; Rec."Line No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                // }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}