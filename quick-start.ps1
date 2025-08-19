# Laravel Todo API - Quick Build and Start
# This script rebuilds the containers and starts the full monitoring stack

Write-Host "🧹 Cleaning up existing containers..." -ForegroundColor Yellow
docker-compose down -v

Write-Host "🔨 Rebuilding Laravel app container..." -ForegroundColor Yellow  
docker-compose build --no-cache app

Write-Host "🚀 Starting all services..." -ForegroundColor Green
docker-compose up -d

Write-Host "⏳ Waiting for services to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 45

Write-Host ""
Write-Host "🎉 Services are starting up!" -ForegroundColor Green
Write-Host "📋 Checking container status..." -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "🌐 Access Points:" -ForegroundColor Cyan
Write-Host "Laravel API:      http://localhost:8000/api/health" -ForegroundColor White
Write-Host "Health Monitor:   http://localhost:8090" -ForegroundColor White
Write-Host "Grafana:          http://localhost:3000 (admin/admin)" -ForegroundColor White
Write-Host ""
Write-Host "🧪 Test the API:" -ForegroundColor Cyan
Write-Host "curl http://localhost:8000/api/ping" -ForegroundColor Gray
