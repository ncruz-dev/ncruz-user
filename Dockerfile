# Stage 1: build
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /api-ncruz-user

# 👇 Copia solo pom primero (cachea dependencias)
COPY pom.xml .
RUN mvn -B -q -e -DskipTests dependency:go-offline

# 👇 Luego el código
COPY src ./src

# 👇 Build: Construye el JAR (sin tests para acelerar)
RUN mvn clean package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:21-jre-jammy

WORKDIR /api-ncruz-user

# 👇 Instalar curl para healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 👇 Copiar jar desde la etapa de build
COPY --from=build /api-ncruz-user/target/*.jar api-ncruz-user.jar

EXPOSE 8087

ENTRYPOINT ["java", "-jar", "api-ncruz-user.jar"]

# Verifica si la aplicación está funcionando correctamente con `/actuator/health`
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:8087/actuator/health || exit 1
