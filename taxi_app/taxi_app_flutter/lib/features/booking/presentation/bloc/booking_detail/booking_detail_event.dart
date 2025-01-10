import 'package:taxi_app_client/taxi_app_client.dart';

abstract class BookingDetailEvent {}

class FetchBookingDetailsEvent extends BookingDetailEvent {}

class CalculatePriceEvent extends BookingDetailEvent {
  Map<String, dynamic> user_choice_cities;

  CalculatePriceEvent(this.user_choice_cities);
}

class CreateOrderEvent extends BookingDetailEvent {
  Orders order;

  CreateOrderEvent(this.order);
}
