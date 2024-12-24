import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking_block.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';

class BookingDetail extends StatelessWidget {
  static String route() => "/booking_detail";

  const BookingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingDetailBloc()..add(FetchBookingDetailsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Booking Detail"),
        ),
        body: BlocBuilder<BookingDetailBloc, BookingDetailState>(
          builder: (context, state) {
            if (state is BookingDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingDetailSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Select City:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...state.cities.map(
                    (city) => ListTile(
                      title: Text(city),
                      onTap: () {
                        // Обработка выбора города
                      },
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Select Payment Option:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...state.paymentOptions.map(
                    (payment) => ListTile(
                      title: Text(payment),
                      onTap: () {
                        // Обработка выбора оплаты
                      },
                    ),
                  ),
                ],
              );
            } else if (state is BookingDetailFailure) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }
}
