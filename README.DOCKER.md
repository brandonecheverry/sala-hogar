# Guía de Despliegue con Docker

Esta guía explica cómo desplegar la aplicación Sala Hogar E-commerce usando Docker.

## Requisitos Previos

- Docker instalado (versión 20.10 o superior)
- Docker Compose instalado (versión 2.0 o superior)

## Configuración

### 1. Variables de Entorno

Si tu aplicación requiere variables de entorno, crea un archivo `.env` en la raíz del proyecto o configúralas en el archivo `docker-compose.yml`.

### 2. Construcción de la Imagen

Para construir la imagen Docker:

```bash
docker-compose build
```

O usando Docker directamente:

```bash
docker build -t salahogar-ecommerce .
```

## Despliegue

### Opción 1: Usando Docker Compose (Recomendado)

Para iniciar la aplicación:

```bash
docker-compose up -d
```

Para ver los logs:

```bash
docker-compose logs -f
```

Para detener la aplicación:

```bash
docker-compose down
```

### Opción 2: Usando Docker directamente

Para ejecutar el contenedor:

```bash
docker run -d \
  --name salahogar-ecommerce \
  -p 3000:3000 \
  --restart unless-stopped \
  salahogar-ecommerce
```

## Verificación

Una vez desplegada, la aplicación estará disponible en:

- **URL Local**: http://localhost:3000
- **URL Red**: http://[IP_DE_LA_MAQUINA_VIRTUAL]:3000

## Comandos Útiles

### Ver logs en tiempo real
```bash
docker-compose logs -f salahogar-app
```

### Reiniciar el contenedor
```bash
docker-compose restart salahogar-app
```

### Detener y eliminar contenedores
```bash
docker-compose down
```

### Reconstruir después de cambios
```bash
docker-compose up -d --build
```

### Ver estado de los contenedores
```bash
docker-compose ps
```

### Acceder al contenedor (debugging)
```bash
docker exec -it salahogar-ecommerce sh
```

## Estructura de Archivos Docker

- `Dockerfile`: Define la construcción de la imagen en múltiples etapas
- `docker-compose.yml`: Configuración para desarrollo/producción
- `.dockerignore`: Archivos excluidos del contexto de construcción

## Optimizaciones

El Dockerfile utiliza un build multi-etapa que:
1. **Etapa deps**: Instala solo las dependencias
2. **Etapa builder**: Construye la aplicación Next.js
3. **Etapa runner**: Crea una imagen mínima para producción

Esto resulta en una imagen final más pequeña y eficiente.

## Troubleshooting

### El contenedor no inicia
- Verifica los logs: `docker-compose logs salahogar-app`
- Verifica que el puerto 3000 no esté en uso
- Verifica que todas las variables de entorno estén configuradas

### Problemas de permisos
- Asegúrate de que Docker tenga permisos suficientes
- En Linux, puede ser necesario usar `sudo` o agregar tu usuario al grupo docker

### La aplicación no responde
- Verifica el healthcheck: `docker-compose ps`
- Verifica la conectividad de red
- Revisa los logs para errores específicos

