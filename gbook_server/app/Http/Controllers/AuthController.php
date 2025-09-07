<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only(['email', 'password']);
        
        if (!$token = JWTAuth::attempt($credentials)) {
            return response()->json([
                'message' => 'Email ou senha incorretos'
            ], 401);
        }

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
        ]);
    }

    public function verifyToken()
    {
        return response()->json([
            'valid' => true,
        ]);
    }

    public function updateName(Request $request) {
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'min:2',
                'max:255',
                'regex:/^[\p{L}\s\'-]+$/u',
                function ($attribute, $value, $fail) {
                    if (strip_tags($value) !== $value) {
                        $fail('O campo '.$attribute.' contém tags HTML não permitidas.');
                    }
                },
            ],
        ]);

        $validated['name'] = trim(strip_tags($validated['name']));

        $user = JWTAuth::user();
        $user->name = $validated['name'];
        $user->save();

        return response()->json([
            'message' => 'Nome atualizado com sucesso!',
            'user' => $user->fresh()
        ]);
    }

    public function updateProfileImage(Request $request)
    {
        $request->validate([
            'profile_image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        $user = JWTAuth::user();

        // Remove a imagem antiga se existir
        if ($user->profile_image) {
            Storage::disk('public')->delete($user->profile_image);
        }

        // Armazena a nova imagem
        $path = $request->file('profile_image')->store('profile_images', 'public');
        
        $user->profile_image = $path;
        $user->save();

        return response()->json([
            'message' => 'Imagem de perfil atualizada com sucesso!',
            'profile_image_url' => $user->profile_image_url,
        ]);
    }

    public function logout(Request $request)
    {
        try {
            $token = JWTAuth::getToken();
            if(!$token){
                return response()->json(['error' => 'Token não encontrado!'], 401);
            }
            
            JWTAuth::invalidate($token);

            return response()->json(['message' => 'Logout realizado com sucesso!']);
        } catch (\Tymon\JWTAuth\Exceptions\TokenExpiredException $e) {
            return response()->json(['error' => 'Token expirado'], 401);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Falha no logout'], 500);
        }
    }
}