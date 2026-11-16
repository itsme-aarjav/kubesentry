# --- Stage 1: Build with Maven ---
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .

# Download dependencies separately: leverages Docker layer caching
# to accelerate subsequent builds when pom.xml is unchanged.
RUN mvn -B dependency:go-offline

COPY src ./src

RUN mvn -B package -DskipTests


# --- Stage 2: Minimal runtime image without Maven or source code ---
FROM eclipse-temurin:21-jre-alpine

# Update Alpine packages to apply the latest security patches
RUN apk update && apk upgrade

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Security best practice: do not run as root inside the container.
# Explicit numeric UID/GID (1001) required for Kubernetes runAsNonRoot policy validation.
RUN addgroup -g 1001 -S spring && adduser -u 1001 -S spring -G spring
USER 1001

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
