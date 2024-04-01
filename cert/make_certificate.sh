#!/bin/bash

# rootca
#openssl ecparam -out rootca.key -name prime256v1 -genkey
#openssl req -new -sha256 -key rootca.key -out rootca.csr
#openssl x509 -req -sha256 -days 365 -in rootca.csr -signkey rootca.key -out rootca.crt

# server
openssl ecparam -out server.key -name prime256v1 -genkey
openssl req -new -sha256 -key server.key -out server.csr
echo "subjectAltName=DNS:*.test.com,DNS:test.com,DNS:*.test2.com,DNS:test2.com" > server.cnf
openssl x509 -days 365 -req -in server.csr -CA rootca.crt -CAkey rootca.key -CAcreateserial -out server.crt -sha256 -extfile server.cnf
cat server.crt rootca.crt > server.pem
openssl x509 -text -noout -in server.crt
