# Laravel Todo API Monitoring Setup Script (PowerShell)

Write-Host "🚀 Setting up Laravel Todo API Monitoring Stack..." -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green

# Build and start all services
Write-Host "📦 Building containers..." -ForegroundColor Yellow
docker-compose up -d --build

# Wait for services to be ready
Write-Host "⏳ Waiting for services to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Check if services are running
Write-Host "✅ Checking service status..." -ForegroundColor Yellow
docker-compose ps

Write-Host ""
Write-Host "🎉 Monitoring Stack is ready!" -ForegroundColor Green
Write-Host ""
Write-Host "📱 Application & Monitoring URLs:" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "🌐 Laravel API:      http://localhost:8000" -ForegroundColor White
Write-Host "🏥 Health Monitor:   http://localhost:8090" -ForegroundColor White
Write-Host "📊 Grafana:          http://localhost:3000 (admin/admin)" -ForegroundColor White
Write-Host "🔍 Prometheus:       http://localhost:9090" -ForegroundColor White
Write-Host "🚨 Alertmanager:     http://localhost:9093" -ForegroundColor White
Write-Host "🗄️  phpMyAdmin:      http://localhost:8080" -ForegroundColor White
Write-Host ""
Write-Host "📋 Quick Health Checks:" -ForegroundColor Cyan
Write-Host "=======================" -ForegroundColor Cyan
Write-Host "curl http://localhost:8000/api/health" -ForegroundColor Gray
Write-Host "curl http://localhost:8000/api/metrics" -ForegroundColor Gray
Write-Host "curl http://localhost:8090/api/health" -ForegroundColor Gray
Write-Host ""
Write-Host "🔧 Useful Commands:" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host "docker-compose logs -f app        # View Laravel logs" -ForegroundColor Gray
Write-Host "docker-compose logs -f nginx      # View Nginx logs" -ForegroundColor Gray
Write-Host "docker-compose logs -f prometheus # View Prometheus logs" -ForegroundColor Gray
Write-Host ".\health-check.ps1                # Run comprehensive health check" -ForegroundColor Gray
Write-Host ""
Write-Host "Happy monitoring! 🚀" -ForegroundColor Green
