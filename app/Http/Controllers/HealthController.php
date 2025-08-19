<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Exception;

class HealthController extends Controller
{
    /**
     * Check application health
     */
    public function check(): JsonResponse
    {
        $health = [
            'status' => 'healthy',
            'timestamp' => now()->toISOString(),
            'checks' => []
        ];

        try {
            // Database connectivity check
            DB::connection()->getPdo();
            $health['checks']['database'] = [
                'status' => 'healthy',
                'message' => 'Database connection successful'
            ];
        } catch (Exception $e) {
            $health['status'] = 'unhealthy';
            $health['checks']['database'] = [
                'status' => 'unhealthy',
                'message' => 'Database connection failed: ' . $e->getMessage()
            ];
        }

        // Application check
        $health['checks']['application'] = [
            'status' => 'healthy',
            'message' => 'Laravel application is running',
            'version' => app()->version()
        ];

        // Storage check
        try {
            $storageWritable = is_writable(storage_path());
            $health['checks']['storage'] = [
                'status' => $storageWritable ? 'healthy' : 'unhealthy',
                'message' => $storageWritable ? 'Storage is writable' : 'Storage is not writable'
            ];
            
            if (!$storageWritable) {
                $health['status'] = 'unhealthy';
            }
        } catch (Exception $e) {
            $health['status'] = 'unhealthy';
            $health['checks']['storage'] = [
                'status' => 'unhealthy',
                'message' => 'Storage check failed: ' . $e->getMessage()
            ];
        }

        $statusCode = $health['status'] === 'healthy' ? 200 : 503;
        
        return response()->json($health, $statusCode);
    }

    /**
     * Simple ping check
     */
    public function ping(): JsonResponse
    {
        return response()->json([
            'status' => 'ok',
            'timestamp' => now()->toISOString()
        ]);
    }
}
