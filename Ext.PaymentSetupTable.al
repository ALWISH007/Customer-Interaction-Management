table 50100 "Ext. Payment Setup"
{
    DataClassification = CustomerContent; // Tells Microsoft what type of data this table holds
    Caption = 'External Payment Setup';

    fields
    {
        // Primary key, just to ensure we always have a single row
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata; // Not business data
        }

        field(10; "Provider"; Text[30])
        {
            Caption = 'Provider'; // e.g., Stripe, PayPal 
        }

        field(20; "Base URL"; Text[250])
        {
            Caption = 'Base URL'; // e.g., https://api.stripe.com 
        }

        field(30; "Secret Hint"; Text[100])
        {
            Caption = 'Secret Hint';

        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
