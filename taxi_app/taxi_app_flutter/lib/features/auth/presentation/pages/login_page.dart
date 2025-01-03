import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app_flutter/core/utils/show_snackbar.dart';
import 'package:taxi_app_flutter/core/widgets/loader.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_event.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_button.dart';


class LoginPage extends StatefulWidget {
  static String route = '/login';
  
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); 


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateFailure) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } 
            if (state is AuthStateSucess) {
              print('object');
              const BookingButton();
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // TODO: validate email
                      return null;
                    } ,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      // TODO: validate password
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthLoginEvent(email: emailController.text.trim(), password: passwordController.text));
                    }
                  }, child: const Text("Login")),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      // TODO go to register page
                    },
                    child: RichText(
                      text: TextSpan(text: "You Don\'t have an account? Register", style: const TextStyle(color: Colors.blue, fontSize: 16)),
                    ),
                  )
        
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}