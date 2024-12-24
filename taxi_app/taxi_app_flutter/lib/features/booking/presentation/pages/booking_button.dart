import 'package:flutter/material.dart';

import './booking_detail.dart';

class BookingButton extends StatelessWidget {
  static String route() => "/booking_button";

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
            Navigator.pushNamed(context, BookingDetail.route());
          } 
          , child: Text("Click To book Taxi")),
      ),
    );
  }
}