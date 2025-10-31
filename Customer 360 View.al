page 50102 "Customer 360 View"
{
    PageType = Card;
    SourceTable = Customer;
    Caption = 'Customer 360';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Customer Tier"; Rec."Customer Tier")
                {
                    ApplicationArea = All;
                }
                field("Total Lifetime Sales"; Rec."Total Lifetime Sales")
                {
                    ApplicationArea = All;
                }
            }

            group(InteractionInfo)
            {
                Caption = 'Interaction Information';
                field("Last Interaction Date"; Rec."Last Interaction Date")
                {
                    ApplicationArea = All;
                }
                field("Pending Follow-ups"; Rec."Pending Follow-ups")
                {
                    ApplicationArea = All;
                }
            }

            part(Interactions; "Customer Interaction List")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AddInteraction)
            {
                Caption = 'Add Interaction';
                ApplicationArea = All;
                Image = Interaction;

                trigger OnAction()
                var
                    CustomerInteraction: Record "Customer Interaction";
                begin
                    CustomerInteraction.Init();
                    CustomerInteraction."Customer No." := Rec."No.";
                    CustomerInteraction."Interaction Date" := Today;
                    CustomerInteraction.Insert();
                    CustomerInteraction.SetFilter("Customer No.", '%1', Rec."No.");
                    CustomerInteraction.SetFilter("Interaction Date", '%1', Today);
                    if CustomerInteraction.FindLast() then
                        Page.Run(Page::"Customer Interaction Card", CustomerInteraction);
                end;
            }

            action(CalculateTier)
            {
                Caption = 'Calculate Customer Tier';
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                begin
                    CustTierMgmt.CalculateCustomerTier(Rec);
                end;
            }
            action(SendReminders)
            {
                Caption = 'Send Follow-up Reminders';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                var
                    InteractionMgmt: Codeunit "Interaction Management";
                begin
                    InteractionMgmt.SendFollowUpReminders();
                end;
            }
        }

        area(Navigation)
        {
            action("View Customer Interactions")
            {
                Caption = 'View All Customer Interactions';
                ApplicationArea = All;
                Image = Interaction;

                trigger OnAction()
                begin
                    //customerInteraction.SetFilter("Customer No.", '%1', Rec."No.");
                    if customerInteraction.FindSet() then
                        PAGE.Run(Page::"Customer Interaction List", customerInteraction);
                end;
            }

        }

    }
    var
        customerInteraction: Record "Customer Interaction";
        CustTierMgmt: Codeunit "Customer Tier Management";
}

