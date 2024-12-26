import 'package:go_router/go_router.dart';

import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_button.dart';
import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_detail.dart';


class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: BookingButton.route(),
        builder: (context, _) => const BookingButton(),
      ),
      GoRoute(
        path: BookingDetail.route(),
        builder: (context, _) => const BookingDetail(),
      ),
    ],
  );
}