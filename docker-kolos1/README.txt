1. Struktura projektu:
docker-kolos1/
│
├── db/
│   └── Dockerfile
│
├── rest-api/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js
│   ├── tests/
│   │   └── app.test.js
│   └── (inne pliki aplikacji REST)
│
├── console-app/
│   ├── Main.java
│   └── Dockerfile
│
└── docker-compose.yaml



2. Dockerfile dla bazy danych (db/Dockerfile):
FROM mysql:latest

VOLUME /var/lib/mysql

ENV MYSQL_ROOT_PASSWORD=my-secret-pw


3. Dockerfile dla aplikacji REST (rest-api/Dockerfile):
FROM node:latest

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "server.js"]


4. Plik konfiguracyjny dla aplikacji REST (rest-api/package.json):
{
  "name": "moja-aplikacja",
  "version": "1.0.0",
  "description": "Przykładowa aplikacja Node.js",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "author": "Twoje Imię",
  "license": "MIT",
  "dependencies": {
    "express": "^4.17.1",
    "mongoose": "^6.2.2"
  }
}

5. Kod serwera dla aplikacji REST (rest-api/server.js):
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});


6. Kod źródłowy dla aplikacji konsolowej w Javie (console-app/Main.java):
public class Main {
    public static void main(String[] args) {
        while (true) {
            System.out.println(System.getenv("MESSAGE"));
            try {
                Thread.sleep(5000); // Odstęp czasowy 5 sekund
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}


7. Dockerfile dla aplikacji konsolowej w Javie (console-app/Dockerfile):
FROM openjdk:11-jdk AS builder

WORKDIR /app
COPY . .
RUN javac Main.java

ARG MESSAGE="Hello, world!"

CMD ["java", "Main"]


8. Użycie Docker Compose do konfiguracji systemu:
Plik docker-compose.yaml:

version: '3'

services:
  db:
    image: my-db
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw
    volumes:
      - db_data:/var/lib/mysql

  rest-api:
    build: ./rest-api
    ports:
      - "8080:8080"
    depends_on:
      - db

  console-app:
    build: ./console-app
    environment:
      MESSAGE: "Hello from Docker!"
    depends_on:
      - rest-api

volumes:
  db_data:



9. Plik (test/app.test.js):
const request = require('supertest');
const app = require('../server');

describe('Test serwera REST', () => {
  it('Powinien zwrócić "Hello, World!"', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, World!');
  });
});


10. Odpalanie programu:
a)Upewnij się, że jesteś w głównym katalogu projektu, gdzie znajduje się plik docker-compose.yaml.
b)Uruchom polecenie docker-compose up, które spowoduje uruchomienie wszystkich usług zdefiniowanych w pliku docker-compose.yaml. Dodaj opcję -d, aby uruchomić usługi w tle.

docker-compose up -d

c)Uruchomienie testów dla aplikacji REST:
Teraz, gdy kontenery są uruchomione, możemy uruchomić testy dla aplikacji REST. Przejdź do katalogu rest-api:
cd rest-api

d)Następnie możemy uruchomić testy za pomocą narzędzia do testowania, np. Jest:
npx jest

e)Po uruchomieniu wszystkich kontenerów, możesz sprawdzić ich status, wykonując polecenie docker-compose ps:

docker-compose ps

f)Aby zatrzymać wszystkie uruchomione kontenery, wykonaj polecenie docker-compose down:

docker-compose down

11.Na http://localhost:8080/	powinien być napis:
"Hello, World"









-----------------------------------------------------------------------

12. Odpalanie (na 3 osobnych konsolach):

a) Aplikacja konsolowa w Javie:
--Budowanie obrazu Docker:
Przejdź do katalogu console-app, gdzie znajduje się plik Dockerfile dla aplikacji konsolowej w Javie, a następnie wykonaj polecenie budowania obrazu Docker:

docker build -t console-app .

--Uruchomienie kontenera:

docker run -e MESSAGE="Hello from Docker!" console-app

b)Aplikacja typu REST:
--Budowanie obrazu Docker:
Przejdź do katalogu rest-api, gdzie znajduje się plik Dockerfile dla aplikacji typu REST, a następnie wykonaj polecenie budowania obrazu Docker:


docker build -t rest-api .


--Uruchomienie kontenera:
Po zbudowaniu obrazu, możemy uruchomić kontener:

docker run -p 8080:8080 rest-api


c)Baza danych:
--Budowanie obrazu Docker:
Jeśli masz plik Dockerfile dla bazy danych w katalogu db, możesz zbudować obraz:

docker build -t my-db .

--Uruchomienie kontenera:
A następnie uruchom kontener bazy danych:

docker run -d --name my-database -e MYSQL_ROOT_PASSWORD=my-secret-pw my-db




