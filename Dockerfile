FROM eclipse-temurin:21-jre-alpine
EXPOSE 8080
ADD target/api-ncruzdev-user.jar api-ncruzdev-user.jar
ENTRYPOINT ["java", "-jar", "/api-ncruzdev-user.jar"]
