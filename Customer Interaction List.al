page 50103 "Customer Interaction List"
{
    PageType = ListPart;
    SourceTable = "Customer Interaction";
    Caption = 'Customer Interaction';
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Interactions)
            {
                field("customerNo"; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    TableRelation = Customer;
                }
                field("interactionDate"; Rec."Interaction Date")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        CustomerInteraction.SetCurrentKey("Entry No.");
                        CustomerInteraction.SetRange("Entry No.", Rec."Entry No.");
                        if CustomerInteraction.FindSet() then
                            PAGE.Run(Page::"Customer Interaction Card", CustomerInteraction);
                    end;
                }
                field("interactionType"; Rec."Interaction Type")
                {
                    ApplicationArea = All;

                }
                field(description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("followUpDate"; Rec."Follow-up Date")
                {
                    ApplicationArea = All;

                }
                field("followUpCompleted"; Rec."Follow-up Completed")
                {
                    ApplicationArea = All;

                }
                field("estimatedValue"; Rec."Estimated Value")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // actions section removed because ListPart pages do not support actions
    var
        CustomerInteraction: Record "Customer Interaction";
}