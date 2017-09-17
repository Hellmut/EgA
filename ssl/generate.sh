#!/bin/sh

if [ -z "$1" ]; then
    echo "Usage: $0 PASSPHASE"
    exit 1
fi

#Generate CA
openssl req -config ./openssl.cnf -newkey rsa:2048 -nodes -keyform PEM -keyout ca.key -x509 -days 3650 -outform PEM -out ca.cer -subj "/C=GB/L=United Kingdom/O=rpiCA/CN=www.rpiCA.com"

#Generate SERVER serial=200
openssl genrsa -out server.key 2048
echo -en "\n\n\n\n" | openssl req -config ./openssl.cnf -new -key server.key -out server.csr
openssl x509 -req -in server.csr -CA ca.cer -CAkey ca.key -set_serial 200 -extfile ./openssl.cnf -days 3650 -outform PEM -out server.cer

#Generate CLIENT serial=201
openssl genrsa -out client.key 2048
echo -en "\n\n\n\n" | openssl req -config ./openssl.cnf -new -key client.key -out client.csr
openssl x509 -req -in client.csr -CA ca.cer -CAkey ca.key -set_serial 201 -extfile ./openssl.cnf -days 3650 -outform PEM -out client.cer

#Generate p12 and jks KeyStore
openssl pkcs12 -export -inkey client.key -in client.cer -out client.p12 -password pass:$1
keytool -importkeystore -srckeystore client.p12 -srcstoretype PKCS12 -srcstorepass $1 -keystore client.jks -storepass $1
echo "Import client.p12 and ca.cer into your web browser."

mkdir ssl
mkdir ssl/ssl_ca
mv ca.* ssl/ssl_ca

mkdir ssl/ssl_server
mv server.* ssl/ssl_server

mkdir ssl/ssl_client
mv client.* ssl/ssl_client

