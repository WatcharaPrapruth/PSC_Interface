page 51003 "PSC Interface Log List"
{
    ApplicationArea = All;
    Caption = 'Interface Log List';
    PageType = List;
    SourceTable = "PSC Interface Log";
    UsageCategory = Lists;
    CardPageId = "PSC Interface Log Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PSC Entry No."; Rec."PSC Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("PSC Method Type"; Rec."PSC Method Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Method Type field.', Comment = '%';
                }
                field("PSC Interface Path"; Rec."PSC Interface Path")
                {
                    ToolTip = 'Specifies the value of the Interface Path field.', Comment = '%';
                }
                field("PSC Action Page"; Rec."PSC Action Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Action Page field.', Comment = '%';
                }
                field(JsonDescTxt; JsonDescTxt)
                {
                    Caption = 'Description';
                }
                field("PSC Status"; Rec."PSC Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("PSC Description"; Rec."PSC Description")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("PSC Primary Key Caption"; Rec."PSC Primary Key Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Primary Key Caption field.', Comment = '%';
                }
                field("PSC Primary Key Value 1"; Rec."PSC Primary Key Value 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Primary Key Value 1 field.', Comment = '%';
                }
                field("PSC Primary Key Value 2"; Rec."PSC Primary Key Value 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Primary Key Value 2 field.', Comment = '%';
                }
                field("PSC Primary Key Value 3"; Rec."PSC Primary Key Value 3")
                {
                    ToolTip = 'Specifies the value of the Primary Key Value 3 field.', Comment = '%';
                }

            }
        }
    }
    var
        JsonDescTxt: Text;

    trigger OnAfterGetRecord()

    begin
        JsonDescTxt := Rec.GetApiDetail(Rec.FieldNo("PSC Description"));
    end;
}
