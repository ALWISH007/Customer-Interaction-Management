codeunit 50103 "MyIntegrationAPI"
{
    // Make methods accessible from outside
    procedure ProcessCustomerOrder(CustomerNo: Code[20]; OrderAmount: Decimal): Text
    var
        Customer: Record Customer;
    begin
        if not Customer.Get(CustomerNo) then
            exit('Customer not found');

        // Your business logic
        if OrderAmount > 10000 then
            exit('Order processed successfully - Priority handling')
        else
            exit('Order processed successfully');
    end;

    procedure GetServerDateTime(): Text
    begin
        exit(Format(CurrentDateTime, 0, 9));
    end;
}