codeunit 50120 "Stripe Client"
{
    procedure ChargeInvoice(var SalesInv: Record "Sales Invoice Header"): Text
    var
        Setup: Record "Ext. Payment Setup";
        Secret: Text[100];
        Client: HttpClient;
        Req: HttpRequestMessage;
        Res: HttpResponseMessage;
        Header: HttpHeaders;
        Content: HttpContent;
        Body, RespTxt : Text;
        Json: JsonObject;
        AmountInMinor: Integer;
        CorrId: Guid;
    begin
        // 1) Load config + secret
        if not Setup.Get('DEFAULT') then
            Error('Payment setup not found.');
        if Setup."Secret Hint" <> '' then
            Secret := Setup."Secret Hint"
        else
            Error('Stripe secret not configured.');

        // 2) Convert invoice amount → minor units (e.g., cents)
        AmountInMinor := Round(SalesInv."Amount Including VAT" * 100, 1);

        // 3) Ensure idempotency key exists
        if SalesInv."Idempotency Key" = '' then begin
            SalesInv."Idempotency Key" := CreateGuid();
            SalesInv.Modify(true);
        end;
        CorrId := SalesInv."Idempotency Key";

        // 4) Build HTTP POST request
        Req.SetRequestUri(Setup."Base URL" + '/v1/payment_intents');//'https://api.stripe.com/v1/payment_intents'
        Req.Method := 'POST';
        Header := Client.DefaultRequestHeaders();
        Header.Add('Authorization', StrSubstNo('Bearer %1', Secret));
        Header.Add('Idempotency-Key', Format(CorrId));
        Header.Add('Content-Type', 'application/x-www-form-urlencoded');

        // Stripe expects form-data, not JSON
        Body := StrSubstNo(
            'amount=%1&currency=%2&confirmation_method=automatic&confirm=true&metadata[invoiceNo]=%3',
            Format(AmountInMinor), LowerCase(SalesInv."Currency Code"), SalesInv."No.");

        Content.WriteFrom(Body);
        Req.Content := Content;

        // 5) Send request
        Client.Send(Req, Res);

        // 6) Log request + response
        LogCall('POST', Req.GetRequestUri(), Res, Body, RespTxt, CorrId);

        // 7) Handle response
        if not Res.IsSuccessStatusCode() then begin
            SalesInv."External Payment Status" := SalesInv."External Payment Status"::Failed;
            SalesInv.Modify(true);
            Error('Stripe error: %1', CopyStr(RespTxt, 1, 250));
        end;

        // 8) Parse JSON response
        Json.ReadFrom(RespTxt);
        SalesInv."External Payment Id" := GetJsonText(Json, 'id');
        SalesInv."External Payment Status" := SalesInv."External Payment Status"::Succeeded;
        SalesInv.Modify(true);

        exit(SalesInv."External Payment Id");
    end;

    // Helper: log API call
    local procedure LogCall(Method: Text; Uri: Text; Res: HttpResponseMessage; RequestBody: Text; var RespTxt: Text; CorrId: Guid)
    var
        Log: Record "API Call Log";
        Out: OutStream;
        RespContent: HttpContent;
        Status: Integer;
    begin
        Log.Init();
        Log."xTimestamp" := CurrentDateTime();
        Log."HTTP Method" := Method;
        Log."Request Uri" := Uri;
        Log."Correlation Id" := CorrId;

        // Read response body into text
        RespContent := Res.Content;
        RespContent.ReadAs(RespTxt);
        Status := Res.HttpStatusCode();

        Log."Status Code" := Status;
        Log."Success" := (Status >= 200) and (Status < 300);

        Log."Request Body".CreateOutStream(Out);
        Out.WriteText(RequestBody);

        Log."Response Body".CreateOutStream(Out);
        Out.WriteText(RespTxt);

        Log.Insert(true);
    end;

    // Helper: safely extract JSON value
    local procedure GetJsonText(var Obj: JsonObject; Name: Text): Text
    var
        Token: JsonToken;
    begin
        if Obj.Get(Name, Token) then
            exit(Token.AsValue().AsText());
        exit('');
    end;

}
