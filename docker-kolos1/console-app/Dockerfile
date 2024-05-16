FROM openjdk:11-jdk AS builder

WORKDIR /app
COPY . .
RUN javac Main.java

ARG MESSAGE="Hello, world!"

CMD ["java", "Main"]
