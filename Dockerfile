FROM eclipse-temurin:21-jre-alpine
EXPOSE 8080
ADD target/api-ncruzdev-user.jar api-ncruzdev-user.jar
ENTRYPOINT ["java", "-jar", "/api-ncruzdev-user.jar"]

# Stage 1: Build
#FROM maven:3.9.6-eclipse-temurin-21 AS build

#WORKDIR /build

# Copiar archivos de configuración
#COPY pom.xml .
#COPY mvnw .
#COPY mvnw.cmd .
#COPY .mvn .mvn

# Descargar dependencias (capa cacheable)
#RUN mvn dependency:go-offline -B

# Copiar código fuente
#COPY src src

# Compilar y empaquetar
#RUN mvn clean package -DskipTests

# Stage 2: Runtime
#FROM eclipse-temurin:21-jre-alpine

#WORKDIR /app

# Copiar el JAR del stage anterior
#COPY --from=build /build/target/ncruz-user-*.jar app.jar

# Crear usuario no-root
#RUN addgroup -g 1000 appuser && adduser -D -u 1000 -G appuser appuser
#USER appuser

# Exponer puerto
#EXPOSE 8087

# Health check
#HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
#    CMD wget --no-verbose --tries=1 --spider http://localhost:8087/actuator/health || exit 1

# Ejecutar la aplicación
#ENTRYPOINT ["java", "-jar", "app.jar"]
