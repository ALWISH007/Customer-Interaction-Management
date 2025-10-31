codeunit 50102 "Email Service"
{
    procedure SendFollowUpReminder(CustomerInteraction: Record "Customer Interaction")
    begin
        // Placeholder: Implement actual email sending logic here
        Message('Follow-up reminder sent to customer %1 for interaction on %2.',
            CustomerInteraction."Customer No.",
            CustomerInteraction."Interaction Date");
    end;
}