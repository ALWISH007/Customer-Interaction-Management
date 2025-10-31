page 50112 "Customer Interaction Card"
{
    PageType = Card;
    SourceTable = "Customer Interaction";
    Caption = 'Customer Interaction';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Interaction Date"; Rec."Interaction Date")
                {
                    ApplicationArea = All;
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
            group(FollowUp)
            {
                Caption = 'Follow-up';
                field("Follow-up Date"; Rec."Follow-up Date")
                {
                    ApplicationArea = All;
                }
                field("Follow-up Completed"; Rec."Follow-up Completed")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Value)
            {
                Caption = 'Value Tracking';
                field("Estimated Value"; Rec."Estimated Value")
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
            action(MarkComplete)
            {
                Caption = 'Mark Follow-up Complete';
                ApplicationArea = All;
                Image = Complete;

                trigger OnAction()
                begin
                    Rec."Follow-up Completed" := true;
                    Rec.Modify(true);
                    Message('Follow-up marked as completed.');
                end;
            }
        }
    }

    var
        Customer: Record Customer;

    trigger OnAfterGetRecord()
    begin
        if Customer.Get(Rec."Customer No.") then;
    end;
}