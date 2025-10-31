pageextension 50100 "Customer PageExtention" extends "Customer List"
{
    actions
    {
        // Add changes to page actions here
        addlast(navigation)
        {
            action("Customer 360 Interaction View")
            {
                ApplicationArea = All;
                Caption = 'Customer 360 Interaction View';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Interaction;

                trigger OnAction()
                begin
                    PAGE.Run(Page::"Customer 360 View", Rec);
                end;
            }
        }
    }

}