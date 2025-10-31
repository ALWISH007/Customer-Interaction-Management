codeunit 50100 "Customer Tier Management"
{
    procedure CalculateAllCustomerTiers()
    var
        Customer: Record Customer;
        CustomerTier: Record "Customer Tier";
        CountUpdated: Integer;
    begin

        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Total Lifetime Sales");
                if CalculateCustomerTier(Customer) then
                    CountUpdated += 1;
            until Customer.Next() = 0;

        Message('%1 customer tiers updated.', CountUpdated);
    end;

    procedure CalculateCustomerTier(var Customer: Record Customer): Boolean
    var
        CustomerTier: Record "Customer Tier";
        NewTier: Code[10];
        OldTier: Code[10];
    begin
        OldTier := Customer."Customer Tier";

        // Find appropriate tier based on lifetime sales
        CustomerTier.SetCurrentKey("Minimum Sales Amount");
        CustomerTier.SetAscending("Minimum Sales Amount", true);
        CustomerTier.SetRange("Minimum Sales Amount", 0, Customer."Total Lifetime Sales");

        if CustomerTier.FindLast() then
            NewTier := CustomerTier.Code
        else
            NewTier := '';

        if Customer."Customer Tier" <> NewTier then begin
            Customer."Customer Tier" := NewTier;
            Customer.Modify();
            exit(true);
        end;

        exit(false);
    end;

    // Event to automatically recalculate tier when sales change
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterSalesInvoiceLineInsert(var Rec: Record "Sales Invoice Line")
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Sell-to Customer No.") then begin
            CalculateCustomerTier(Customer);
        end;
    end;
}