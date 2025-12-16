# Script de despliegue Docker para Sala Hogar E-commerce (PowerShell)
# Uso: .\docker-deploy.ps1 [build|start|stop|restart|logs|status]

param(
    [Parameter(Position=0)]
    [ValidateSet("build", "start", "stop", "restart", "logs", "status", "rebuild", "clean")]
    [string]$Action = "help"
)

$ComposeFile = "docker-compose.yml"
$ServiceName = "salahogar-app"

function Show-Help {
    Write-Host "Uso: .\docker-deploy.ps1 [build|start|stop|restart|logs|status|rebuild|clean]" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Comandos disponibles:" -ForegroundColor Yellow
    Write-Host "  build    - Construir la imagen Docker"
    Write-Host "  start    - Iniciar la aplicación"
    Write-Host "  stop     - Detener la aplicación"
    Write-Host "  restart  - Reiniciar la aplicación"
    Write-Host "  logs     - Ver logs en tiempo real"
    Write-Host "  status   - Ver estado de los contenedores"
    Write-Host "  rebuild  - Reconstruir y reiniciar"
    Write-Host "  clean    - Limpiar contenedores e imágenes"
}

switch ($Action) {
    "build" {
        Write-Host "🔨 Construyendo la imagen Docker..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile build --no-cache
        Write-Host "✅ Construcción completada" -ForegroundColor Green
    }
    "start" {
        Write-Host "🚀 Iniciando la aplicación..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile up -d
        Write-Host "✅ Aplicación iniciada" -ForegroundColor Green
        Write-Host "📍 Disponible en: http://localhost:3000" -ForegroundColor Cyan
    }
    "stop" {
        Write-Host "🛑 Deteniendo la aplicación..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile down
        Write-Host "✅ Aplicación detenida" -ForegroundColor Green
    }
    "restart" {
        Write-Host "🔄 Reiniciando la aplicación..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile restart $ServiceName
        Write-Host "✅ Aplicación reiniciada" -ForegroundColor Green
    }
    "logs" {
        Write-Host "📋 Mostrando logs..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile logs -f $ServiceName
    }
    "status" {
        Write-Host "📊 Estado de los contenedores:" -ForegroundColor Yellow
        docker-compose -f $ComposeFile ps
    }
    "rebuild" {
        Write-Host "🔨 Reconstruyendo y reiniciando..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile up -d --build
        Write-Host "✅ Reconstrucción completada" -ForegroundColor Green
    }
    "clean" {
        Write-Host "🧹 Limpiando contenedores e imágenes..." -ForegroundColor Yellow
        docker-compose -f $ComposeFile down -v
        docker system prune -f
        Write-Host "✅ Limpieza completada" -ForegroundColor Green
    }
    default {
        Show-Help
    }
}

