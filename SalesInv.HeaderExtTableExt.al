tableextension 50102 "Sales Inv. Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "External Payment Id"; Text[50])
        {
            Caption = 'External Payment Id'; // Stripe PaymentIntent ID 
        }
        field(50101; "External Payment Status"; Option)
        {
            Caption = 'External Payment Status';
            OptionMembers = " ",Pending,Succeeded,Failed;
        }
        field(50102; "Idempotency Key"; Guid)
        {
            Caption = 'Idempotency Key'; // Prevents duplicate charges
        }
    }
}
