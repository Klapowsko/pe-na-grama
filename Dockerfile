# Build stage
FROM gradle:8.14-jdk21 AS builder
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY src ./src
RUN gradle clean build -x test

# Runtime stage
FROM eclipse-temurin:21-jre-noble
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "exec java -jar /app/*.jar"]
