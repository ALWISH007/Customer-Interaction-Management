table 50102 "Customer Interaction"
{
    DataClassification = CustomerContent;
    Caption = 'Customer Interaction';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(3; "Interaction Date"; Date)
        {
            Caption = 'Interaction Date';
        }
        field(4; "Interaction Type"; Option)
        {
            Caption = 'Interaction Type';
            OptionMembers = "Meeting","Phone Call","Email","Demo","Support";
            OptionCaption = 'Meeting,Phone Call,Email,Demo,Support';
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "Follow-up Date"; Date)
        {
            Caption = 'Follow-up Date';
        }
        field(7; "Follow-up Completed"; Boolean)
        {
            Caption = 'Follow-up Completed';
        }
        field(8; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(9; "Estimated Value"; Decimal)
        {
            Caption = 'Estimated Value';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.", "Interaction Date") { }
        //key(FollowUp; "Follow-up Date", "Follow-up Completed") { }
    }
}
