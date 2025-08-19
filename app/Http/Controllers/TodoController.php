<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Validation\ValidationException;
use Exception;

class TodoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $todos = Todo::all();
        
        return response()->json([
            'success' => true,
            'data' => $todos,
            'message' => 'Todos retrieved successfully'
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): JsonResponse
    {
        try {
            $validatedData = $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'completed' => 'nullable|boolean',
                'due_date' => 'nullable|date'
            ]);

            $todo = Todo::create($validatedData);

            return response()->json([
                'success' => true,
                'data' => $todo,
                'message' => 'Todo created successfully'
            ], 201);

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred',
                'errors' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id): JsonResponse
    {
        $todo = Todo::find($id);

        if (!$todo) {
            return response()->json([
                'success' => false,
                'message' => 'Todo not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $todo,
            'message' => 'Todo retrieved successfully'
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id): JsonResponse
    {
        $todo = Todo::find($id);

        if (!$todo) {
            return response()->json([
                'success' => false,
                'message' => 'Todo not found'
            ], 404);
        }

        try {
            $validatedData = $request->validate([
                'title' => 'sometimes|required|string|max:255',
                'description' => 'nullable|string',
                'completed' => 'nullable|boolean',
                'due_date' => 'nullable|date'
            ]);

            $todo->update($validatedData);

            return response()->json([
                'success' => true,
                'data' => $todo->fresh(),
                'message' => 'Todo updated successfully'
            ], 200);

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred',
                'errors' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id): JsonResponse
    {
        $todo = Todo::find($id);

        if (!$todo) {
            return response()->json([
                'success' => false,
                'message' => 'Todo not found'
            ], 404);
        }

        $todo->delete();

        return response()->json([
            'success' => true,
            'message' => 'Todo deleted successfully'
        ], 200);
    }
}
