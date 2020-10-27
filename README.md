### Requirements

- [Apache Maven](https://maven.apache.org/download.cgi)

### Instructions

- run `cd Signal-Server`

- run `mvn install -DskipTests`

- run `java -jar service/target/TextSecureServer-3.21.jar certificate -ca`

- run `java -jar service/target/TextSecureServer-3.21.jar certificate --key <private_key_from_step_above> --id <any_id>`

- Place the generated `certificate` and `private key` on the `config.yml` under `unidentifiedDelivery`

- run `cd ..`

- run `docker-compose up`
