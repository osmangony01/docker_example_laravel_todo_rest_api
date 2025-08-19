# Laravel Todo CRUD REST API with Docker (Nginx + PHP-FPM)

This is a Laravel 12 application providing a complete CRUD REST API for managing todos, containerized with Docker, Nginx, PHP-FPM, and MySQL.

## Features

- Complete CRUD operations for todos
- RESTful API endpoints
- Nginx web server with PHP-FPM
- MySQL database
- Docker containerization
- phpMyAdmin for database management
- **Advanced Monitoring Stack**:
  - Prometheus metrics collection
  - Grafana dashboards
  - Custom health monitoring
  - Real-time alerting
  - System metrics tracking

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/todos` | Get all todos |
| GET | `/api/todos/{id}` | Get a specific todo |
| POST | `/api/todos` | Create a new todo |
| PUT/PATCH | `/api/todos/{id}` | Update a todo |
| DELETE | `/api/todos/{id}` | Delete a todo |
| GET | `/api/health` | Application health check |
| GET | `/api/ping` | Simple ping endpoint |
| GET | `/api/metrics` | Prometheus metrics |
| GET | `/api/metrics/json` | JSON metrics |

## Todo Schema

```json
{
  "id": "integer",
  "title": "string (required)",
  "description": "string (nullable)",
  "completed": "boolean (default: false)",
  "due_date": "datetime (nullable)",
  "created_at": "datetime",
  "updated_at": "datetime"
}
```

## Docker Setup

### Prerequisites

- Docker
- Docker Compose

### Getting Started

1. Clone the repository
2. Navigate to the project directory
3. Build and start the containers:

```bash
docker-compose up -d --build
```

This will start:
- **Nginx Web Server**: Available at http://localhost:8000
- **Laravel App (PHP-FPM)**: Backend processing
- **MySQL Database**: Available at localhost:3307
- **phpMyAdmin**: Available at http://localhost:8080

### Database Setup

The database will be automatically set up when the containers start. If you need to run migrations manually:

```bash
docker-compose exec app php artisan migrate
```

### API Testing Examples

#### Create a Todo
```bash
curl -X POST http://localhost:8000/api/todos \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Complete Laravel project",
    "description": "Finish the todo API with Docker setup",
    "due_date": "2025-08-20 10:00:00"
  }'
```

#### Get All Todos
```bash
curl http://localhost:8000/api/todos
```

#### Get a Specific Todo
```bash
curl http://localhost:8000/api/todos/1
```

#### Update a Todo
```bash
curl -X PUT http://localhost:8000/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated todo title",
    "completed": true
  }'
```

#### Delete a Todo
```bash
curl -X DELETE http://localhost:8000/api/todos/1
```


### MySQL Database (db)
- **Port**: 3306
- **Database**: `todo_db`
- **User**: `todo_user`
- **Password**: `todo_password`

### phpMyAdmin (phpmyadmin)
- **Port**: 8080
- **Access**: Use database credentials above


## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
