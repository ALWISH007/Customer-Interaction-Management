codeunit 50101 "Interaction Management"
{
    procedure CreateInteraction(CustomerNo: Code[20]; InteractionType: Option; Description: Text[250]; FollowUpDate: Date)
    var
        CustomerInteraction: Record "Customer Interaction";
        Customer: Record Customer;
    begin
        if not Customer.Get(CustomerNo) then
            Error('Customer %1 does not exist.', CustomerNo);

        CustomerInteraction.Init();
        CustomerInteraction."Customer No." := CustomerNo;
        CustomerInteraction."Interaction Date" := Today;
        CustomerInteraction."Interaction Type" := InteractionType;
        CustomerInteraction.Description := CopyStr(Description, 1, MaxStrLen(CustomerInteraction.Description));
        CustomerInteraction."Follow-up Date" := FollowUpDate;
        CustomerInteraction.Insert(true);

        // Update customer's last interaction date
        UpdateCustomerLastInteraction(CustomerNo);
    end;

    procedure SendFollowUpReminders()
    var
        CustomerInteraction: Record "Customer Interaction";
        Customer: Record Customer;
        EmailSent: Integer;
    begin
        CustomerInteraction.SetRange("Follow-up Completed", false);
        CustomerInteraction.SetFilter("Follow-up Date", '<=%1', Today);

        if CustomerInteraction.FindSet() then
            repeat
                if SendFollowUpReminder(CustomerInteraction) then
                    EmailSent += 1;
            until CustomerInteraction.Next() = 0;

        if EmailSent > 0 then
            Message('%1 follow-up reminders sent.', EmailSent);
    end;

    local procedure SendFollowUpReminder(CustomerInteraction: Record "Customer Interaction"): Boolean
    var
        Customer: Record Customer;
    begin
        if not Customer.Get(CustomerInteraction."Customer No.") then
            exit(false);

        // In a real implementation, you would send email here
        // For now, we'll just log it
        LogFollowUpReminder(CustomerInteraction, Customer);

        exit(true);
    end;

    local procedure LogFollowUpReminder(CustomerInteraction: Record "Customer Interaction"; Customer: Record Customer)
    var
        LogMessage: Text;
    begin
        LogMessage := StrSubstNo('Follow-up reminder for customer %1 (%2). Interaction: %3',
            Customer.Name, Customer."No.", CustomerInteraction.Description);

        // In production, you'd log to a proper logging system
        Message(LogMessage);
    end;

    local procedure UpdateCustomerLastInteraction(CustomerNo: Code[20])
    var
        Customer: Record Customer;
        LatestInteraction: Record "Customer Interaction";
    begin
        LatestInteraction.SetRange("Customer No.", CustomerNo);
        if LatestInteraction.FindLast() then begin
            if Customer.Get(CustomerNo) then begin
                Customer."Last Interaction Date" := LatestInteraction."Interaction Date";
                Customer.Modify();
            end;
        end;
    end;
}