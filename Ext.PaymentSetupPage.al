page 50100 "Ext. Payment Setup"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Ext. Payment Setup";
    Caption = 'External Payment Setup';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Provider"; Rec."Provider") { ApplicationArea = All; }
                field("Base URL"; Rec."Base URL") { ApplicationArea = All; }
                field("Secret Hint"; Rec."Secret Hint") { ApplicationArea = All; }
            }
        }
    }

    /* actions
    {
        area(processing)
        {
            action("Set Secret Key")
            {
                ApplicationArea = All;
                Image = Setup;

                trigger OnAction()
                var
                    Input: Text;
                    SecretStorage: Codeunit "Secret Storage";
                begin
                    // Ensure at least one record exists
                    if StrLen(Rec."Primary Key") = 0 then begin
                        Rec."Primary Key" := 'SETUP'; // fixed primary key
                        Rec.Insert(true);//to execute OnInsert trigger or event subscribers.
                    end;

                    // Prompt user for secret (like sk_test_1234)
                    if Dialog('Enter Stripe Secret Key (sk_...):', Input) then begin

                        if StrLen(Input) > 0 then begin
                            SecretStorage.SetSecret('StripeSecret', Input);
                            // Save only last 4 chars to table (for display)
                            if StrLen(Input) > 4 then
                                Rec."Secret Hint (Last4)" := CopyStr(Input, StrLen(Input) - 3, 4)
                            else
                                Rec."Secret Hint (Last4)" := Input;
                            Rec.Modify(true);
                            Message('Secret saved securely.');
                        end;
                    end;
                end;
            }
        }
    } */
}
