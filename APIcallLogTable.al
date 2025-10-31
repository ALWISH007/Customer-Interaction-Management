table 50101 "API Call Log"
{
    Caption = 'API Call Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(10; "xTimestamp"; DateTime) { }
        field(20; "HTTP Method"; Text[10]) { }
        field(30; "Request Uri"; Text[250]) { }
        field(40; "Status Code"; Integer) { }
        field(50; "Success"; Boolean) { }
        field(60; "Correlation Id"; Guid)
        {
            DataClassification = SystemMetadata;
            Editable = false;

        } // Used for idempotency / trace
        field(70; "Request Body"; Blob) { SubType = Memo; }
        field(80; "Response Body"; Blob) { SubType = Memo; }
    }

    keys { key(PK; "Entry No.") { Clustered = true; } }
}
