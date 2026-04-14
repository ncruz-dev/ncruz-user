# 📘 Guía del Proyecto: Spring Boot Contract-First

---

## 🔑 Lo importante de esta solución

* ✅ CRUD completo de usuarios (crear, listar, actualizar, eliminar)
* ✅ Base de datos en memoria **H2**
* ✅ Arquitectura limpia (Controller → Service → Repository)
* ✅ **Contrato OpenAPI (********`openapi.yaml`********) como fuente de verdad**
* ✅ Generación automática de interfaces en `target` con OpenAPI Generator
* ✅ Swagger UI disponible para probar endpoints

---

## 🚀 Cómo usarlo paso a paso

### 1. Compilar el proyecto

```bash
mvn clean install
```

### 2. Verificar generación de código

Se generarán automáticamente las clases en:

```
target/generated-sources/openapi
```

### 3. Levantar la aplicación

```bash
mvn spring-boot:run
```

### 4. Acceder a Swagger UI

```
http://localhost:8080/swagger-ui.html
```

### 5. Acceder a consola H2

```
http://localhost:8080/h2-console
```

---

## 🧠 Concepto clave (muy importante)

Este proyecto utiliza el enfoque **Contract First**, lo que significa:

* Primero se define el API en `openapi.yaml`
* Luego Maven genera automáticamente:

    * Interfaces (por ejemplo: `UsersApi`)
    * Modelos (`User`)
* Finalmente, el desarrollador implementa esa interfaz en el controlador

### 🎯 Beneficios

* Consistencia entre contrato y código
* Mayor mantenibilidad
* Escalabilidad en equipos grandes
* Enfoque profesional usado en entornos enterprise

---

## ⚠️ Recomendaciones futuras

Para mejorar el proyecto a nivel profesional:

* Separar DTOs de entidades
* Usar MapStruct para mapeos
* Implementar manejo de errores global (`@ControllerAdvice`)
* Agregar validaciones (`@Valid`)
* Implementar paginación en endpoints GET

---

💡 Este enfoque es ampliamente utilizado en arquitecturas modernas y facilita la integración con equipos frontend y otros servicios.

