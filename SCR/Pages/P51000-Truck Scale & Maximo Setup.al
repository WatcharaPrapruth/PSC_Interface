page 51000 "PSC Truck Scale & Maximo Setup"
{
    AdditionalSearchTerms = 'finance setup,general ledger setup,g/l setup';
    ApplicationArea = Basic, Suite;
    Caption = 'Truck Scale & Maximo Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "PSC Truck Scale & Maximo Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("API Configuration")
            {
                Caption = 'API Configuration';

                field("Enable API"; Rec."Enable API")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable API field.', Comment = '%';
                }
                field("Maximo - API Vendor URL"; Rec."Maximo - API Vendor URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximo - API Vendor URL field.', Comment = '%';
                }
                field("Maximo - API COA URL"; Rec."Maximo - API COA URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximo - API COA URL field.', Comment = '%';
                }
                field(APIUpdateReceiveStatusURL; Rec.APIUpdateReceiveStatusURL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximo - API Update Receive Status URL field.', Comment = '%';
                }
                field("Truck Scale – Sal. INV Header Type"; Rec."Name (Thai)")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                    trigger OnAssistEdit()
                    begin
                        SelectCaptionReport(Rec);
                    end;
                }
            }
            group("Gen. Bus. Posting Group Mapping")
            {
                Caption = 'Gen. Bus. Posting Group Mapping';
                part(GenBusPostingGroupMapping; "PSC GenBusPostingGroupMapping")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Enabled = true;
                    SubPageLink = "Primary Key" = field("Primary Key");
                    //UpdatePropagation = Both;
                }
            }
            group("Number Series")
            {
                Caption = 'Interface No.Series';
                field("Maximo – Purch Inv. Nos."; Rec."Maximo – Purch Inv. Nos.")
                {
                    ToolTip = 'Specifies the value of the Maximo – Purch Inv. Nos. field.', Comment = '%';
                }
                field("Maximo – Purch Cr. Memo Nos."; Rec."Maximo – Purch Cr. Memo Nos.")
                {
                    ToolTip = 'Specifies the value of the Maximo – Purch Cr. Memo Nos. field.', Comment = '%';
                }
                field("Truck Scale – Sales Inv. Nos."; Rec."Truck Scale – Sales Inv. Nos.")
                {
                    ToolTip = 'Specifies the value of the Truck Scale – Sales Inv. Nos. field.', Comment = '%';
                }
                field(TruckScaleSalesCrMemoNos; Rec.TruckScaleSalesCrMemoNos)
                {
                    ToolTip = 'Specifies the value of the Truck Scale – Sales Cr. Memo Nos. field.', Comment = '%';
                }
            }

            group("Interface Inventory Batch Setup")
            {
                Caption = 'Interface Inventory Batch Setup';
                field("Maximo(Issue) – Template"; Rec."Maximo(Issue) – Template")
                {
                    ToolTip = 'Specifies the value of the Maximo(Issue) – Template field.', Comment = '%';
                }
                field("Maximo(Issue) – Batch Name"; Rec."Maximo(Issue) – Batch Name")
                {
                    ToolTip = 'Specifies the value of the Maximo(Issue) – Batch Name field.', Comment = '%';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemJournalBatch: Record "Item Journal Batch";
                    begin
                        if Rec."Maximo(Issue) – Template" <> '' then
                            ItemJournalBatch.SetFilter("Journal Template Name", '%1|%2', '', Rec."Maximo(Issue) – Template");

                        if ItemJournalBatch.Get(Rec."Maximo(Issue) – Batch Name") then;
                        if PAGE.RunModal(0, ItemJournalBatch) = ACTION::LookupOK then begin
                            Text := ItemJournalBatch.Name;
                            exit(true);
                        end;
                    end;
                }
                field("Maximo(Transfer) – Template"; Rec."Maximo(Transfer) – Template")
                {
                    ToolTip = 'Specifies the value of the Maximo(Transfer) – Template field.', Comment = '%';
                }
                field("Maximo(Transfer) – Batch Name"; Rec."Maximo(Transfer) – Batch Name")
                {
                    ToolTip = 'Specifies the value of the Maximo(Transfer) – Batch Name field.', Comment = '%';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemJournalBatch: Record "Item Journal Batch";
                    begin
                        if Rec."Maximo(Transfer) – Template" <> '' then
                            ItemJournalBatch.SetFilter("Journal Template Name", '%1|%2', '', Rec."Maximo(Transfer) – Template");

                        if ItemJournalBatch.Get(Rec."Maximo(Transfer) – Batch Name") then;
                        if PAGE.RunModal(0, ItemJournalBatch) = ACTION::LookupOK then begin
                            Text := ItemJournalBatch.Name;
                            exit(true);
                        end;
                    end;
                }
                field(MaximoRevaluationTemplate; Rec.MaximoRevaluationTemplate)
                {
                    ToolTip = 'Specifies the value of the Maximo (Revaluation) - Template field.', Comment = '%';
                }
                field(MaximoRevaluationBatchName; Rec.MaximoRevaluationBatchName)
                {
                    ToolTip = 'Specifies the value of the Maximo (Revaluation) - Batch Name field.', Comment = '%';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemJournalBatch: Record "Item Journal Batch";
                    begin
                        if Rec.MaximoRevaluationTemplate <> '' then
                            ItemJournalBatch.SetFilter("Journal Template Name", '%1|%2', '', Rec.MaximoRevaluationTemplate);

                        if ItemJournalBatch.Get(Rec.MaximoRevaluationBatchName) then;
                        if PAGE.RunModal(0, ItemJournalBatch) = ACTION::LookupOK then begin
                            Text := ItemJournalBatch.Name;
                            exit(true);
                        end;
                    end;
                }
            }
            group("Interface Dimension Setup")
            {
                Caption = 'Interface Dimension Setup';
                field("Budget Code"; Rec."Budget Code")
                {
                    ToolTip = 'Specifies the value of the Budget Code field.', Comment = '%';
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ToolTip = 'Specifies the value of the Cost Center Code field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

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

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    procedure SelectCaptionReport(var truckScaleSetup: Record "PSC Truck Scale & Maximo Setup")
    var
        ltSelectCaptionReport: Record "YVS Caption Report Setup";
        ltCaptionReport: Page "YVS Caption Report List";
        pDocumentType: Enum "YVS Document Type Report";
    begin
        CLEAR(ltCaptionReport);
        ltSelectCaptionReport.reset();
        ltSelectCaptionReport.SetRange("Document Type", pDocumentType::"Sales Invoice");
        ltCaptionReport.SetTableView(ltSelectCaptionReport);
        ltCaptionReport.LookupMode := true;
        if ltCaptionReport.RunModal() = Action::LookupOK then begin
            ltCaptionReport.GetRecord(ltSelectCaptionReport);
            truckScaleSetup."Entry No." := ltSelectCaptionReport."Entry No.";
            truckScaleSetup."Document Type" := ltSelectCaptionReport."Document Type";
            truckScaleSetup."Name (Thai)" := ltSelectCaptionReport."Name (Thai)";
            truckScaleSetup."Name (Eng)" := ltSelectCaptionReport."Name (Eng)";
        end;
        Clear(ltCaptionReport);
    end;
}