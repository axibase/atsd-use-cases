# Send cAdvisor data into ATSD using HTTP

To send cAdvisor metrics into a remote ATSD server over HTTP or HTTPS protocol, create a
[collector account](https://axibase.com/docs/atsd/administration/collector-account.html) with restricted permissions in ATSD.

HTTPS requires either installation of a [trusted SSL certificate](https://axibase.com/docs/atsd/administration/ssl-ca-signed.html) by a certificate authority such as [`Let's Encrypt`](https://axibase.com/docs/atsd/administration/ssl-lets-encrypt.html) into ATSD or setting `storage_driver_atsd_skip_verify` option to `true`.

Replace `{ATSD_HOSTNAME}` placeholder with the hostname or IP address of the target ATSD server and specify collector account credentials in the command below.

```bash
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  axibase/cadvisor:latest \
  --storage_driver=atsd \
  --storage_driver_atsd_protocol=https \
  --storage_driver_host={ATSD_HOSTNAME}:8443 \
  --storage_driver_user={USERNAME} \
  --storage_driver_password={PASSWORD} \
  --storage_driver_buffer_duration=15s \
  --storage_driver_atsd_skip_verify=true \
  --housekeeping_interval=15s
```
