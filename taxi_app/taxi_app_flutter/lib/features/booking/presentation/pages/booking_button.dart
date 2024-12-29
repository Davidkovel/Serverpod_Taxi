import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/core/router/app_router.dart';
import 'package:taxi_app_flutter/dependencies.dart';

import '../bloc/booking_detail/booking_detail_block.dart';
import '../bloc/booking_detail/booking_detail_event.dart';
import './booking_detail.dart';

class BookingButton extends StatelessWidget {
  // static String route() => "/booking_button";

  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Taxi App"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed : ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => serviceLocator<BookingDetailBloc>()
                    ..add(FetchBookingDetailsEvent()),
                  child: const BookingDetail(),
                ),
              ),
            );
          } 
          , child: Text("Click To book Taxi")),
      ),
    );
  }
}

// ПЛАНИ: 1. Украшать главное меню, 2. Добавить api запрос + БД 3. Добавить карту
