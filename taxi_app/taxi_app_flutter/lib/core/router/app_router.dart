import 'package:go_router/go_router.dart';
import 'package:taxi_app_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:taxi_app_flutter/features/auth/presentation/pages/register_confirmation_page.dart';
import 'package:taxi_app_flutter/features/auth/presentation/pages/register_page.dart';

import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_button.dart';
import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_detail.dart';


class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: LoginPage.route,
    routes: [
      GoRoute(
        path: LoginPage.route,
        builder: (context, _) => const LoginPage(),
      ),
      GoRoute(
        path: RegisterPage.route(),
        builder: (context, _) => const RegisterPage(),
      ),
      GoRoute(
        path: RegisterConfirmationPage.route(),
        builder: (context, _) => const RegisterConfirmationPage(),
      ),
      GoRoute(
        path: BookingButton.route(),
        builder: (context, _) => const BookingButton(),
      ),
      GoRoute(
        path: BookingDetail.route(),
        builder: (context, _) => BookingDetail(),
      ),
    ],
  );
}