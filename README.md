# self-signed-san

Easy self-signed certificate with IP or DNS Subject-Alternative-Names
(SANs) for testing or development.

It will automatically include IP SAN `127.0.0.1` and DNS SAN `localhost`
and prompt you for additional SANs.  Once finished, it will print the
detail of the key and cert on the screen for copying and pasting into
your final application.

`docker run -it --rm jnovack/self-signed-san`

## Environment Variables

* `C`  = country
* `ST` = state or province name
* `L`  = locality or city name
* `O`  = organization
* `OU` = department
* `EMAIL` = email addressed assigned to
* `CN` = default domain name on the certificate