#!/bin/bash

# Laravel Todo API Health Check Script

echo "🏥 Checking Laravel Todo API Health Status..."
echo "================================================"

# Function to check HTTP endpoint
check_http() {
    local url=$1
    local service_name=$2
    
    if curl -s -f "$url" > /dev/null; then
        echo "✅ $service_name: Healthy"
        return 0
    else
        echo "❌ $service_name: Unhealthy"
        return 1
    fi
}

# Function to check container health
check_container() {
    local container_name=$1
    local status=$(docker inspect --format='{{.State.Health.Status}}' "$container_name" 2>/dev/null)
    
    if [ "$status" = "healthy" ]; then
        echo "✅ $container_name: Healthy"
        return 0
    elif [ "$status" = "unhealthy" ]; then
        echo "❌ $container_name: Unhealthy"
        return 1
    elif [ "$status" = "starting" ]; then
        echo "🟡 $container_name: Starting"
        return 1
    else
        echo "❓ $container_name: Unknown status ($status)"
        return 1
    fi
}

echo ""
echo "📋 Container Health Status:"
echo "----------------------------"
check_container "laravel_todo_db"
check_container "laravel_todo_app"
check_container "laravel_todo_nginx"
check_container "laravel_todo_phpmyadmin"

echo ""
echo "🌐 Service Health Status:"
echo "-------------------------"
check_http "http://localhost:8000/api/ping" "Laravel API (Ping)"
check_http "http://localhost:8000/api/health" "Laravel API (Health)"
check_http "http://localhost:8080" "phpMyAdmin"

echo ""
echo "📊 Detailed Health Information:"
echo "-------------------------------"
echo "Laravel Health Check:"
curl -s "http://localhost:8000/api/health" | jq . 2>/dev/null || curl -s "http://localhost:8000/api/health"

echo ""
echo "🐳 Docker Compose Status:"
echo "-------------------------"
docker-compose ps

echo ""
echo "Health check completed!"
