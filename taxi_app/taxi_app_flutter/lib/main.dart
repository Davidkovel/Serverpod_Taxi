import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_event.dart';
import 'package:taxi_app_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:taxi_app_flutter/features/booking/presentation/pages/booking_button.dart';

import './dependencies.dart';
import 'features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<BookingDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}