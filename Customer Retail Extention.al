tableextension 50104 "Customer Retail Extension" extends Customer
{
    fields
    {
        field(50100; "Customer Tier"; Code[10])
        {
            Caption = 'Customer Tier';
            TableRelation = "Customer Tier";
        }
        field(50101; "Total Lifetime Sales"; Decimal)
        {
            Caption = 'Total Lifetime Sales';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line".Amount where("Sell-to Customer No." = field("No.")));
            Editable = false;
        }
        field(50102; "Last Interaction Date"; Date)
        {
            Caption = 'Last Interaction Date';
            FieldClass = FlowField;
            CalcFormula = max("Customer Interaction"."Interaction Date" where("Customer No." = field("No.")));
            Editable = false;
        }
        field(50103; "Pending Follow-ups"; Integer)
        {
            Caption = 'Pending Follow-ups';
            FieldClass = FlowField;
            CalcFormula = count("Customer Interaction" where("Customer No." = field("No."), "Follow-up Completed" = const(false)));
            Editable = false;
        }
    }
}