import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app_flutter/core/utils/show_snackbar.dart';
import 'package:taxi_app_flutter/core/widgets/loader.dart';
import 'package:taxi_app_flutter/core/widgets/style.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_event.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_button.dart';

class RegisterConfirmationPage extends StatefulWidget {
  static String route() => "/email";

  const RegisterConfirmationPage({super.key});

  @override
  State<RegisterConfirmationPage> createState() =>
      _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState extends State<RegisterConfirmationPage> {
  final verificationCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateFailure) {
              showSnackbar(context, state.message);
            } else if (state is AuthStateSucess) {
              context.go(BookingButton.route());
            }
          },
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const Loader();
            }

            if (state is AuthStateSucess) {
              return const SizedBox.shrink();
            }

            if (state is AuthStateConfirmationRequired) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Confirm Email',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Check your email for a verification code!',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: verificationCodeController,
                      decoration: const InputDecoration(
                        hintText: 'Verification Code',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthConfirmRegistrationEvent(
                                  email: state.email,
                                  verificationCode:
                                      verificationCodeController.text,
                                  password: state.password,
                                ),
                              );
                        }
                      },
                      child: const Text("Verify"),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        print("TODO");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive a code? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Resend',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: pink),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text("Error please report to support team"),
            );
          },
        ),
      ),
    );
  }
}
