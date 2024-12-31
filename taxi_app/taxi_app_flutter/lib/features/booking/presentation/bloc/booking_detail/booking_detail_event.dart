abstract class BookingDetailEvent {}

class FetchBookingDetailsEvent extends BookingDetailEvent {}

class CalculatePriceEvent extends BookingDetailEvent {
  Map<String, dynamic> user_choice_cities;

  CalculatePriceEvent(this.user_choice_cities);
}