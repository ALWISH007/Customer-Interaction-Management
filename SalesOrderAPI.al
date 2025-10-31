// Create API page for Sales Orders
page 50101 "Sales Order API"
{
    PageType = API;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));
    DelayedInsert = true;
    APIPublisher = 'BCPublisher';
    APIGroup = 'Ecomerce';
    EntityName = 'salesOrder';
    EntitySetName = 'salesOrders';
    Caption = 'Sales Order API';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            field(orderId; Rec."No.")
            {
            }
            field(customerId; Rec."Sell-to Customer No.")
            {
            }
            field(orderDate; Rec."Order Date")
            {
            }
            field(status; Rec.Status)
            {
            }
        }
    }

    // Add actions for creating lines, etc.
    procedure GetServerDateTime(): Text
    begin
        exit(Format(CurrentDateTime, 0, 9));
    end;
}