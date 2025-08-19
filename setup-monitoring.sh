#!/bin/bash

echo "🚀 Setting up Laravel Todo API Monitoring Stack..."
echo "================================================="

# Build and start all services
echo "📦 Building containers..."
docker-compose up -d --build

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 30

# Check if services are running
echo "✅ Checking service status..."
docker-compose ps

echo ""
echo "🎉 Monitoring Stack is ready!"
echo ""
echo "📱 Application & Monitoring URLs:"
echo "=================================="
echo "🌐 Laravel API:      http://localhost:8000"
echo "🏥 Health Monitor:   http://localhost:8090"
echo "📊 Grafana:          http://localhost:3000 (admin/admin)"
echo "🔍 Prometheus:       http://localhost:9090"
echo "🚨 Alertmanager:     http://localhost:9093"
echo "🗄️  phpMyAdmin:      http://localhost:8080"
echo ""
echo "📋 Quick Health Checks:"
echo "======================="
echo "curl http://localhost:8000/api/health"
echo "curl http://localhost:8000/api/metrics"
echo "curl http://localhost:8090/api/health"
echo ""
echo "🔧 Useful Commands:"
echo "=================="
echo "docker-compose logs -f app        # View Laravel logs"
echo "docker-compose logs -f nginx      # View Nginx logs"
echo "docker-compose logs -f prometheus # View Prometheus logs"
echo "./health-check.sh                 # Run comprehensive health check"
echo ""
echo "Happy monitoring! 🚀"
