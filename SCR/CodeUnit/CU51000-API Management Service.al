codeunit 51000 "PSC API Management Service"
{
    procedure TestConnect(): Text
    var
        JObject: JsonObject;
        OrderBody: JsonObject;

        TxtResponse: Text;
    begin
        JObject.Add('Status', 'Connect success');
        JObject.Add('Today', Today());
        OrderBody.Add('Order', JObject.AsToken());
        JObject.WriteTo(TxtResponse);
        exit(TxtResponse);
    end;

    procedure Ping(JsonTxt: Text)
    var
        JObj: JsonObject;
        JToken: JsonToken;
        JPurchOrder: JsonObject;
    begin
        if JObj.ReadFrom(JsonTxt) then begin
            Message(Format(JObj));
            JPurchOrder := JToken.AsObject();
        end;
    end;

    procedure SalesOrderService(pRequest: Text) Response: Text
    var
        salesOrderService: Codeunit "PSC Sales order service";
    begin
        Response := salesOrderService.RunService(pRequest);
    end;


}