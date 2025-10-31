page 50113 "Customer Tier Setup"
{
    PageType = List;
    SourceTable = "Customer Tier";
    Caption = 'Customer Tier Setup';
    //CardPageId = "Customer Tier Card";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Tiers)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Minimum Sales Amount"; Rec."Minimum Sales Amount")
                {
                    ApplicationArea = All;
                }
                field("Discount Percentage"; Rec."Discount Percentage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RecalculateAllTiers)
            {
                Caption = 'Recalculate All Customer Tiers';
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                begin
                    CustomerTierMgmt.CalculateAllCustomerTiers();
                    Message('Customer tiers recalculated successfully.');
                end;
            }
        }
    }

    var
        CustomerTierMgmt: Codeunit "Customer Tier Management";
}