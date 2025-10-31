/* codeunit 50110 "Secret Storage"
{
    SingleInstance = true; // one shared instance for the tenant

    procedure SetSecret(Key: Text; Value: Text)
    var
        Iso: Codeunit "Isolated Storage";
        Storage: IsolatedStorage;

    begin
        Iso.Set('ExtPayments', Key, Value);
        // Namespace = 'ExtPayments', key = 'StripeSecret'
        // Data is encrypted per-tenant
    end;

    procedure GetSecret(Key: Text; var Value: Text): Boolean
    var
        Iso: Codeunit "Isolated Storage";
    begin
        exit(Iso.Get('ExtPayments', Key, Value));
    end;
}
 */