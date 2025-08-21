import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void handleLogin() {
    setState(() {
      isLoading = true; // mostra "Carregando…" 
    });

    // simula login
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // volta ao normal
      });

      // navega pra HomePage
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(140),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppLogo(size: 100),
              const SizedBox(height: 32),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white), // texto digitado branco
                decoration: InputDecoration(
                  hintText: 'Digite seu email',                 // placeholder
                  hintStyle: const TextStyle(color: Colors.white70), // cor do placeholder
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white),  // label branca
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white), // borda branca quando não focado
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2), // borda branca quando focado
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Digite sua senha',
                  hintStyle: const TextStyle(color: Colors.white70),
                  labelText: 'Senha',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : handleLogin,
                  child: Text(isLoading ? 'Carregando…' : 'Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
