<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

class MetricsController extends Controller
{
    /**
     * Get application metrics in Prometheus format
     */
    public function prometheus(): string
    {
        $metrics = $this->collectMetrics();
        
        $output = "";
        
        // Todo metrics
        $output .= "# HELP todos_total Total number of todos\n";
        $output .= "# TYPE todos_total counter\n";
        $output .= "todos_total " . $metrics['todos']['total'] . "\n";
        
        $output .= "# HELP todos_completed_total Total number of completed todos\n";
        $output .= "# TYPE todos_completed_total counter\n";
        $output .= "todos_completed_total " . $metrics['todos']['completed'] . "\n";
        
        $output .= "# HELP todos_pending_total Total number of pending todos\n";
        $output .= "# TYPE todos_pending_total counter\n";
        $output .= "todos_pending_total " . $metrics['todos']['pending'] . "\n";
        
        // Database metrics
        $output .= "# HELP database_connections_active Active database connections\n";
        $output .= "# TYPE database_connections_active gauge\n";
        $output .= "database_connections_active " . $metrics['database']['connections'] . "\n";
        
        // Application metrics
        $output .= "# HELP app_uptime_seconds Application uptime in seconds\n";
        $output .= "# TYPE app_uptime_seconds counter\n";
        $output .= "app_uptime_seconds " . $metrics['app']['uptime'] . "\n";
        
        $output .= "# HELP cache_hits_total Total cache hits\n";
        $output .= "# TYPE cache_hits_total counter\n";
        $output .= "cache_hits_total " . $metrics['cache']['hits'] . "\n";
        
        return response($output, 200, ['Content-Type' => 'text/plain']);
    }
    
    /**
     * Get metrics in JSON format
     */
    public function json(): JsonResponse
    {
        return response()->json([
            'metrics' => $this->collectMetrics(),
            'timestamp' => now()->toISOString()
        ]);
    }
    
    /**
     * Collect application metrics
     */
    private function collectMetrics(): array
    {
        $startTime = microtime(true);
        
        // Get todo statistics
        $totalTodos = Todo::count();
        $completedTodos = Todo::where('completed', true)->count();
        $pendingTodos = $totalTodos - $completedTodos;
        
        // Get database info
        $connections = 1; // Simplified - in real app, you'd get actual connection count
        
        // Get application info
        $uptime = time() - filectime(base_path('bootstrap/app.php'));
        
        // Cache metrics (simplified)
        $cacheHits = Cache::get('cache_hits', 0);
        
        $queryTime = microtime(true) - $startTime;
        
        return [
            'todos' => [
                'total' => $totalTodos,
                'completed' => $completedTodos,
                'pending' => $pendingTodos
            ],
            'database' => [
                'connections' => $connections,
                'query_time' => $queryTime
            ],
            'app' => [
                'uptime' => $uptime,
                'version' => app()->version(),
                'environment' => app()->environment()
            ],
            'cache' => [
                'hits' => $cacheHits
            ],
            'system' => [
                'memory_usage' => memory_get_usage(true),
                'memory_peak' => memory_get_peak_usage(true)
            ]
        ];
    }
}
