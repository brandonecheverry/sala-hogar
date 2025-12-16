#!/bin/bash

# Script de despliegue Docker para Sala Hogar E-commerce
# Uso: ./docker-deploy.sh [build|start|stop|restart|logs|status]

set -e

COMPOSE_FILE="docker-compose.yml"
SERVICE_NAME="salahogar-app"

case "$1" in
  build)
    echo "🔨 Construyendo la imagen Docker..."
    docker-compose -f $COMPOSE_FILE build --no-cache
    echo "✅ Construcción completada"
    ;;
  start)
    echo "🚀 Iniciando la aplicación..."
    docker-compose -f $COMPOSE_FILE up -d
    echo "✅ Aplicación iniciada"
    echo "📍 Disponible en: http://localhost:3000"
    ;;
  stop)
    echo "🛑 Deteniendo la aplicación..."
    docker-compose -f $COMPOSE_FILE down
    echo "✅ Aplicación detenida"
    ;;
  restart)
    echo "🔄 Reiniciando la aplicación..."
    docker-compose -f $COMPOSE_FILE restart $SERVICE_NAME
    echo "✅ Aplicación reiniciada"
    ;;
  logs)
    echo "📋 Mostrando logs..."
    docker-compose -f $COMPOSE_FILE logs -f $SERVICE_NAME
    ;;
  status)
    echo "📊 Estado de los contenedores:"
    docker-compose -f $COMPOSE_FILE ps
    ;;
  rebuild)
    echo "🔨 Reconstruyendo y reiniciando..."
    docker-compose -f $COMPOSE_FILE up -d --build
    echo "✅ Reconstrucción completada"
    ;;
  clean)
    echo "🧹 Limpiando contenedores e imágenes..."
    docker-compose -f $COMPOSE_FILE down -v
    docker system prune -f
    echo "✅ Limpieza completada"
    ;;
  *)
    echo "Uso: $0 {build|start|stop|restart|logs|status|rebuild|clean}"
    echo ""
    echo "Comandos disponibles:"
    echo "  build    - Construir la imagen Docker"
    echo "  start    - Iniciar la aplicación"
    echo "  stop     - Detener la aplicación"
    echo "  restart  - Reiniciar la aplicación"
    echo "  logs     - Ver logs en tiempo real"
    echo "  status   - Ver estado de los contenedores"
    echo "  rebuild  - Reconstruir y reiniciar"
    echo "  clean    - Limpiar contenedores e imágenes"
    exit 1
    ;;
esac

