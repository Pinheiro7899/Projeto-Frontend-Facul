FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app
COPY produtos-frontend/ ./

RUN chmod +x mvnw && ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT:-10000} --server.address=0.0.0.0"]
