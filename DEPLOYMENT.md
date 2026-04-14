# ncruz-user - Microservicio de Usuarios

## Descripción

Microservicio Spring Boot 4 para gestión de usuarios con API REST generada desde OpenAPI 3.0.1, containerizado con Docker y desplegable en Kubernetes con CI/CD mediante GitHub Actions.

## Requisitos

- Java 21+
- Maven 3.9.6+
- Docker 24+
- Docker Compose (opcional, para desarrollo local)
- Kubernetes 1.28+ (para producción)

## Instalación Local

### Con Maven

```bash
# Compilar y empaquetar
mvn clean package

# Ejecutar
java -jar target/ncruz-user-0.0.1-SNAPSHOT.jar
```

### Con Docker Compose

```bash
# Construir y ejecutar
docker-compose up --build

# Detener
docker-compose down
```

La aplicación estará disponible en `http://localhost:8087`

## Estructura del Proyecto

```
ncruz-user/
├── src/
│   ├── main/
│   │   ├── java/com/ncruz/ncruzuser/
│   │   │   ├── controller/       # Controladores REST
│   │   │   ├── service/          # Lógica de negocio
│   │   │   ├── entity/           # Entidades JPA
│   │   │   └── repository/       # Repositorios Spring Data
│   │   └── resources/
│   │       ├── application.yaml  # Configuración Spring
│   │       └── openapi.yaml      # Contrato OpenAPI 3.0.1
│   └── test/                     # Tests unitarios
├── Dockerfile                     # Imagen Docker multi-stage
├── docker-compose.yml             # Composición para desarrollo
├── .github/
│   └── workflows/
│       └── ci-cd.yml             # Pipeline GitHub Actions
├── k8s/
│   ├── deployment.yaml           # Deployment Kubernetes
│   └── ingress.yaml              # Ingress Kubernetes
└── pom.xml                       # Dependencias Maven
```

## API REST

### Base URL
```
http://localhost:8087/api
```

### Endpoints

#### Listar usuarios
```
GET /users
```

#### Crear usuario
```
POST /users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### Obtener usuario
```
GET /users/{id}
```

#### Actualizar usuario
```
PUT /users/{id}
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Eliminar usuario
```
DELETE /users/{id}
```

## Documentación OpenAPI

La documentación interactiva está disponible en:
```
http://localhost:8087/swagger-ui.html
```

## CI/CD con GitHub Actions

El repositorio incluye un workflow automatizado que:

1. **Build & Test**: Compila y ejecuta tests en cada push y pull request
2. **Security Scan**: Ejecuta análisis de seguridad con Trivy
3. **Docker Build**: Construye la imagen Docker y la sube a GitHub Container Registry
4. **Deploy Dev**: Despliegue automático a desarrollo (rama `develop`)
5. **Deploy Prod**: Despliegue a producción (rama `main`) con tests de humo

### Configurar el Pipeline

1. Crear ramas en GitHub:
   ```bash
   git branch main
   git branch develop
   ```

2. Configurar secrets en GitHub (Settings → Secrets):
   - `SONAR_TOKEN`: Token de SonarQube (opcional)
   - `SONAR_HOST_URL`: URL de SonarQube (opcional)

3. El workflow se ejecutará automáticamente en:
   - Commits a `main` o `develop`
   - Pull requests a `main` o `develop`

## Despliegue en Kubernetes

### Prerequisitos

```bash
# Instalar cert-manager (para SSL)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Instalar NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.3/deploy/static/provider/cloud/deploy.yaml
```

### Desplegar

```bash
# Aplicar manifiestos
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/ingress.yaml

# Verificar
kubectl get deployments
kubectl get svc ncruz-user
kubectl get ingress ncruz-user-ingress

# Logs
kubectl logs -f deployment/ncruz-user
```

### Configuración de Ingress

Editar `k8s/ingress.yaml` y actualizar:
- `spec.tls[0].hosts[0]`: Tu dominio
- `spec.rules[0].host`: Tu dominio

## Monitoreo

### Health Checks

```bash
# Liveness
curl http://localhost:8087/actuator/health

# Readiness  
curl http://localhost:8087/actuator/health/readiness
```

### Métricas (Prometheus)

```bash
curl http://localhost:8087/actuator/prometheus
```

## Desarrollo

### Variables de Entorno

```bash
SPRING_DATASOURCE_URL=jdbc:h2:mem:testdb
SPRING_DATASOURCE_DRIVERCLASSNAME=org.h2.Driver
SPRING_DATASOURCE_USERNAME=sa
SPRING_DATASOURCE_PASSWORD=
SPRING_JPA_HIBERNATE_DDL_AUTO=update
SPRING_H2_CONSOLE_ENABLED=true
```

### Regenerar código desde OpenAPI

```bash
mvn clean generate-sources
```

## Troubleshooting

### Puerto ya en uso
```bash
# Cambiar puerto en application.yaml
server:
  port: 8088
```

### Base de datos no se crea
```bash
# Verificar configuración en application.yaml
spring.jpa.hibernate.ddl-auto: create-drop  # Para desarrollo
```

### Docker build falla
```bash
# Limpiar
docker system prune -a

# Reconstruir
docker-compose build --no-cache
```

## Licencia

MIT

## Contacto

Para preguntas o reportar problemas, crear un issue en GitHub.

