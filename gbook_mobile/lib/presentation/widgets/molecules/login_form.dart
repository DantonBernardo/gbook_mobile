import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login_bloc.dart';
import '../atoms/custom_text_field.dart';
import '../atoms/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login realizado!')));
          
          Navigator.pushReplacementNamed(context, '/all-books');
        }
      },
      builder: (context, state) {
        final loading = state is LoginLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              key: const Key('emailField'),
              hint: 'E-mail',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              key: const Key('passwordField'),
              hint: 'Senha',
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 24),
            CustomButton(
              key: const Key('loginButton'),
              text: 'Entrar',
              loading: loading,
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                context.read<LoginBloc>().add(
                      LoginSubmitted(email: email, password: password),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
