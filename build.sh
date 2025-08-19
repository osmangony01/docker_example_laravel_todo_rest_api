#!/bin/bash

echo "🐳 Building Laravel Todo API with Docker..."

# Build and start containers
echo "📦 Building containers..."
docker-compose up -d --build

# Wait for containers to be ready
echo "⏳ Waiting for containers to start..."
sleep 10

# Check if containers are running
echo "✅ Checking container status..."
docker-compose ps

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📱 Application is available at: http://localhost:8000"
echo "🗄️  phpMyAdmin is available at: http://localhost:8080"
echo "🧪 Test the API with: curl http://localhost:8000/api/todos"
echo ""
echo "📚 Check the README.md for API examples and usage instructions."
