## Requirements

- [Apache Maven](https://maven.apache.org/download.cgi)

## Instructions

### Compile the server code

- run `mvn -f signal-server/pom.xml install -DskipTests`

### Update configuration

#### Set unidentifiedDelivery

- run `java -jar service/target/TextSecureServer-3.21.jar certificate -ca`

- run `java -jar service/target/TextSecureServer-3.21.jar certificate --key <private_key_from_step_above> --id <any_id>`

- Place the generated `certificate` and `private key` under `unidentifiedDelivery` on `./config/signal.yml`

#### Create SSL certificates
##### Located under `./signal-server/ssl`

#### Create private key for root CA certificate
`openssl genrsa -out rootCA.key 4096`

#### Create a self-signed root CA certificate
`openssl req -x509 -new -nodes  -days 3650 -out rootCA.crt -key rootCA.key`

#### Create server certificate key
`openssl genrsa -out whisper.key 4096`

#### Create Certificate Signing Request
`openssl req -new -key whisper.key -out whisper.csr`

#### Sign the certificate with the root CA

`openssl x509 -req -in whisper.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -days 365 -out whisper.crt`

#### Export to host key and certificate to PKCS12 format which is recognized by Java keytool
`openssl pkcs12 -export -password pass:example -in whisper.crt -inkey whisper.key -out keystore.p12 -name example -CAfile rootCA.crt`

#### Import the host key and certificate to Java keystore format, so it can be used by dropwizard
`keytool -importkeystore -srcstoretype PKCS12 -srckeystore keystore.p12 -srcstorepass example -destkeystore example.keystore -deststorepass example`

#### Create whisper.store for IOS Client
`keytool -importcert -v -trustcacerts -file whisper.crt -alias IntermediateCA -keystore whisper.store -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath ./bcprov-jdk15on-154.jar -storetype BKS -storepass whisper`

#### Create whisper.cer for IOS Client
`openssl x509 -in whisper.crt -out whisper.cer -outform DER`

- Update the `keyStorePath` and `keyStorePassword` with the keystore produced and the password under `server` on `./config/signal.yml`

## Docker Compose

run `docker-compose up`
