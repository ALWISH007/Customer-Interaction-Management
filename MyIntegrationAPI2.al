page 50104 MyIntegrationAPI2
{

    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'BCPublisher';
    APIGroup = 'Ecomerce';
    EntityName = 'IntegrationEntity';
    EntitySetName = 'IntegrationAPI';

    procedure GetServerDateTime(): Text
    begin
        exit(Format(CurrentDateTime, 0, 9));
    end;


    var
        myInt: Integer;
}