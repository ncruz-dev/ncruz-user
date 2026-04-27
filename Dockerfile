# Stage 1: build
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /api-ncruz-user
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /api-ncruz-user
COPY --from=build /api-ncruz-user/target/*.jar api-ncruz-user.jar

ENTRYPOINT ["java", "-jar", "api-ncruz-user.jar"]

# healthcheck es importante para verificar si la aplicación está funcionando correctamente.
# En este caso, se utiliza el comando `curl` para hacer una solicitud HTTP
# a la ruta `/actuator/health` de la aplicación. Si la respuesta es exitosa
#(código de estado 200), el contenedor se considera saludable.
#Si no, el contenedor se marcará como no saludable.
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:8087/actuator/health || exit 1
