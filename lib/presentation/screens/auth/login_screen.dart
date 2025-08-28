// presentation/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/auth_cubit/auth_cubit.dart';
import '../../../cubit/auth_cubit/auth_state.dart';
import '../../../cubit/theme_cubit/theme_cubit.dart';
import '../../widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ✅ Header with Dark/Light Mode Icon
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isLoginMode ? "Welcome Back 👋" : "Create Account ✨",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.brightness_6, color: Colors.white),
                      onPressed: () {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    )
                  ],
                ),
              ),

              // ✅ Responsive Form
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide =
                        constraints.maxWidth > 600; // موبايل ولا تابلت/ويب

                    return Center(
                      child: Container(
                        width: isWide
                            ? 500
                            : double.infinity, // 👈 عرض أصغر في التابلت/ويب
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                    validator: (val) => val!.isEmpty
                                        ? "Please enter email"
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                    validator: (val) => val!.isEmpty
                                        ? "Please enter password"
                                        : null,
                                  ),
                                  const SizedBox(height: 30),
                                  BlocConsumer<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(state.message)),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is AuthLoading) {
                                        return const CircularProgressIndicator();
                                      }
                                      return Column(
                                        children: [
                                          GradientButton(
                                            text: _isLoginMode
                                                ? "Sign In"
                                                : "Register",
                                            onPressed: _submit,
                                          ),
                                          const SizedBox(height: 16),
                                          GradientButton(
                                            text: _isLoginMode
                                                ? "Create Account"
                                                : "Already have an account? Sign In",
                                            isOutlined: true,
                                            onPressed: () {
                                              setState(() {
                                                _isLoginMode = !_isLoginMode;
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_isLoginMode) {
      context.read<AuthCubit>().signIn(email, password);
    } else {
      context.read<AuthCubit>().signUp(email, password);
    }
  }
}
