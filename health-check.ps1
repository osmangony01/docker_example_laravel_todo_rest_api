# Laravel Todo API Health Check Script (PowerShell)

Write-Host "🏥 Checking Laravel Todo API Health Status..." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green

# Function to check HTTP endpoint
function Test-HttpEndpoint {
    param(
        [string]$Url,
        [string]$ServiceName
    )
    
    try {
        $response = Invoke-WebRequest -Uri $Url -Method GET -TimeoutSec 10 -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ $ServiceName`: Healthy" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Host "❌ $ServiceName`: Unhealthy" -ForegroundColor Red
        return $false
    }
}

# Function to check container health
function Test-ContainerHealth {
    param([string]$ContainerName)
    
    try {
        $status = docker inspect --format='{{.State.Health.Status}}' $ContainerName 2>$null
        switch ($status) {
            "healthy" { 
                Write-Host "✅ $ContainerName`: Healthy" -ForegroundColor Green
                return $true
            }
            "unhealthy" { 
                Write-Host "❌ $ContainerName`: Unhealthy" -ForegroundColor Red
                return $false
            }
            "starting" { 
                Write-Host "🟡 $ContainerName`: Starting" -ForegroundColor Yellow
                return $false
            }
            default { 
                Write-Host "❓ $ContainerName`: Unknown status ($status)" -ForegroundColor Gray
                return $false
            }
        }
    }
    catch {
        Write-Host "❌ $ContainerName`: Container not found or Docker not running" -ForegroundColor Red
        return $false
    }
}

Write-Host ""
Write-Host "📋 Container Health Status:" -ForegroundColor Cyan
Write-Host "----------------------------" -ForegroundColor Cyan
Test-ContainerHealth "laravel_todo_db"
Test-ContainerHealth "laravel_todo_app"
Test-ContainerHealth "laravel_todo_nginx"
Test-ContainerHealth "laravel_todo_phpmyadmin"

Write-Host ""
Write-Host "🌐 Service Health Status:" -ForegroundColor Cyan
Write-Host "-------------------------" -ForegroundColor Cyan
Test-HttpEndpoint "http://localhost:8000/api/ping" "Laravel API (Ping)"
Test-HttpEndpoint "http://localhost:8000/api/health" "Laravel API (Health)"
Test-HttpEndpoint "http://localhost:8080" "phpMyAdmin"

Write-Host ""
Write-Host "📊 Detailed Health Information:" -ForegroundColor Cyan
Write-Host "-------------------------------" -ForegroundColor Cyan
Write-Host "Laravel Health Check:" -ForegroundColor White
try {
    $healthResponse = Invoke-RestMethod -Uri "http://localhost:8000/api/health" -Method GET -TimeoutSec 10
    $healthResponse | ConvertTo-Json -Depth 3
}
catch {
    Write-Host "Failed to retrieve detailed health information" -ForegroundColor Red
}

Write-Host ""
Write-Host "🐳 Docker Compose Status:" -ForegroundColor Cyan
Write-Host "-------------------------" -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "Health check completed!" -ForegroundColor Green
