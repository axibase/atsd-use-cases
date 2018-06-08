# Incoming Webhook Troubleshooting

Correct common problems with incoming [webhooks](https://axibase.com/docs/atsd/api/data/messages/webhook.html).

## Confirm Connectivity

Log in to ATSD, open the **Settings** tab in the main menu, navigate to **Diagnostics** and click **Webhook Requests**.

The page contains a list of recently received webhook requests.

![](./images/webhook-diag.png)

Under the **Details** column, click the **View** link to see webhook request parameters, the payload, and the generated ATSD message.

![](./images/webhook-confirm.png)

If the page does not contain the expected request, check the webhook URL manually:

```sh
curl -v "https://usr:pwd@atsd_hostname:8443/api/v1/messages/webhook/github?ping=true&debug=true"
```

The ATSD should respond with the following message:

```txt
< HTTP/1.1 200 OK
< Date: Thu, 10 May 2018 07:27:03 GMT
< Set-Cookie: ATSD_SESSION_ID=node0j2puvmezgcl139j90e95iqwf493012.node0;Path=/;Secure
< Expires: Thu, 01 Jan 1970 00:00:00 GMT
< Access-Control-Allow-Origin: *
< Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, Authorization
< Access-Control-Allow-Methods: HEAD, GET, POST, PUT, PATCH, DELETE
< Content-Type: application/json;charset=utf-8
< Vary: Accept-Encoding, User-Agent
< Transfer-Encoding: chunked
< Server: Jetty(9.4.z-SNAPSHOT)
<
* Connection #0 to host atsd.company.com left intact
```

```json
{"entity":"github","type":"webhook","source":"github","severity":null,"tags":{"ping":"true","request_ip":"10.10.10.10"},"date":"2018-05-10T07:27:03.819Z"}
```
