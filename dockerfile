FROM openjdk:18 AS build
WORKDIR /src .
COPY . .
RUN javac -d target/classes/org/example src/main/java/org/example/*.java
ENV CLASSPATH=target/classes
ENV MESSAGE="Hello from docker"
CMD ["java", "-cp", "target/classes/org/example", "org.example.Main"]