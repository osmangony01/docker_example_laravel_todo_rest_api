Write-Host "🐳 Building Laravel Todo API with Docker (Nginx + PHP-FPM)..." -ForegroundColor Green

# Build and start containers
Write-Host "📦 Building containers..." -ForegroundColor Yellow
docker-compose up -d --build

# Wait for containers to be ready
Write-Host "⏳ Waiting for containers to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Check if containers are running
Write-Host "✅ Checking container status..." -ForegroundColor Yellow
docker-compose ps

Write-Host ""
Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📱 Application is available at: http://localhost:8000" -ForegroundColor Cyan
Write-Host "🗄️  phpMyAdmin is available at: http://localhost:8080" -ForegroundColor Cyan
Write-Host "🧪 Test the API with: curl http://localhost:8000/api/todos" -ForegroundColor Cyan
Write-Host ""
Write-Host "📚 Check the README.md for API examples and usage instructions." -ForegroundColor White
