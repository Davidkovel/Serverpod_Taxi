import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_event.dart';
import 'booking_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  BookingDetailBloc() : super(BookingDetailInitial()) {
    on<FetchBookingDetailsEvent>(_onFetchBookingDetails);
  }

  Future<void> _onFetchBookingDetails(
    FetchBookingDetailsEvent event,
    Emitter<BookingDetailState> emit,
  ) async {
    emit(BookingDetailLoading());

    try {
      // Имитация API-запроса или другой логики для получения данных
      await Future.delayed(const Duration(seconds: 2));
      final cities = ["New York", "Los Angeles", "Chicago"];
      final paymentOptions = ["Credit Card", "PayPal", "Cash"];

      emit(BookingDetailSuccess(cities: cities, paymentOptions: paymentOptions));
    } catch (e) {
      emit(BookingDetailFailure("Failed to load booking details."));
    }
  }
}
