table 50103 "Customer Tier"
{
    DataClassification = CustomerContent;
    Caption = 'Customer Tier';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Minimum Sales Amount"; Decimal)
        {
            Caption = 'Minimum Sales Amount';
        }
        field(4; "Discount Percentage"; Decimal)
        {
            Caption = 'Discount Percentage';
            MinValue = 0;
            MaxValue = 100;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(Key2; "Minimum Sales Amount")
        {
            Clustered = false;
        }
    }
}