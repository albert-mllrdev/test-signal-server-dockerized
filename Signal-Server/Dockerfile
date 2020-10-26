FROM openjdk:latest

COPY ./service/target /usr/src/signal-server

WORKDIR /usr/src/signal-server

EXPOSE 8080
EXPOSE 8081

CMD ["java", "-jar", "TextSecureServer-3.21.jar", "server", "/config/config.yml"]