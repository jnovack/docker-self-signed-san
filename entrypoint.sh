#!/bin/sh

# Replace defaults with environment variables
[ ! -z "$C" ]       && sed -i "s/XX/${C}/" openssl.cnf
[ ! -z "$ST" ]      && sed -i "s/My State/${ST}/" openssl.cnf
[ ! -z "$L" ]       && sed -i "s/My City/${L}/" openssl.cnf
[ ! -z "$O" ]       && sed -i "s/My Company/${O}/" openssl.cnf
[ ! -z "$OU" ]      && sed -i "s/My Department/${OU}/" openssl.cnf
[ ! -z "$EMAIL" ]   && sed -i "s/nobody@localhost/${EMAIL}/" openssl.cnf
[ ! -z "$CN" ]      && sed -i "s/localhost.localdomain/${CN}/" openssl.cnf

echo -e "Please list your IP SANs. End with a blank line..."
i=2
while read -p "$(echo IP.${i} = ) "  -r line && [ -n "${line}" ]; do
    echo "IP.${i} = ${line}" >> /openssl.cnf
    i=$((i+1))
done

echo -e "Please list your DNS SANs. End with a blank line..."
i=2
while read -p "$(echo DNS.${i} = ) " -r line && [ -n "${line}" ]; do
    echo "DNS.${i} = ${line}" >> /openssl.cnf
    i=$((i+1))
done

openssl genrsa -out key.pem 4096
openssl req -new -key key.pem -out request.csr -config /openssl.cnf
openssl x509 -req -in request.csr -signkey key.pem -days ${DAYS:=7200} -out certificate.pem  -extensions v3_req -extfile /openssl.cnf

echo

openssl x509 -in certificate.pem -noout -text

md5cert="$(openssl x509 -in certificate.pem -noout -modulus | openssl md5)"
md5key="$(openssl rsa -in key.pem -noout -modulus | openssl md5)"
md5req="$(openssl req -in request.csr -noout -modulus | openssl md5)"

echo

if [ "${md5key}" == "${md5req}" ] && [ "${md5key}" == "${md5cert}" ]; then
    cat key.pem
    cat certificate.pem
else
    echo "ERROR: Keys did not generate properly.  Start crying now."
fi
