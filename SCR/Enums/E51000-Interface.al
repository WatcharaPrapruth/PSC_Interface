enum 51000 "PSC Method Type"
{
    Extensible = true;
    value(0; " ") { Caption = ' '; }
    value(1; "Insert") { Caption = 'Insert'; }
    value(2; "Update") { Caption = 'Update'; }
    value(3; "Delete") { Caption = 'Delete'; }
}

enum 51001 "PSC Action Page"
{
    Extensible = true;
    value(0; " ") { Caption = ' '; }
    value(1; "Vendor") { Caption = 'Vendor'; }
    value(2; "Chart of account") { Caption = 'Chart of account'; }
    value(3; "Item") { Caption = 'Item'; }
    value(4; "Purchase Invoice") { Caption = 'Purchase Invoice'; }
    value(5; "Purchase Credit Memo") { Caption = 'Purchase Credit Memo'; }
    value(6; "Item Journal") { Caption = 'Item Journal'; }
    value(7; "Item Reclassification Journal") { Caption = 'Item Reclassification Journal'; }
    value(8; "Sales Invoice") { Caption = 'Sales Invoice'; }
    value(9; "Sales Credit Memo") { Caption = 'Sales Credit Memo'; }
}
enum 51002 "PSC Direction"
{
    Extensible = true;
    value(0; "Inbound") { Caption = 'Inbound'; }
    value(1; "Outbound") { Caption = 'Outbound'; }
}

enum 51003 "PSC Status Interface"
{
    Extensible = true;
    value(0; " ") { Caption = ' '; }
    value(1; "Success") { Caption = 'Success'; }
    value(2; "Failed") { Caption = 'Failed'; }
}

enum 51004 "Fuel Type"
{
    Extensible = true;
    value(0; Petrol)
    {
        Caption = 'Petrol';
    }
    value(1; Diesel)
    {
        Caption = 'Diesel';
    }
    value(2; Electric)
    {
        Caption = 'Electric';
    }
}
