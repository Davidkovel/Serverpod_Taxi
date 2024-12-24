abstract class BookingDetailState {}

class BookingDetailInitial extends BookingDetailState {}

class BookingDetailLoading extends BookingDetailState {}

class BookingDetailSuccess extends BookingDetailState {
  final List<String> cities;
  final List<String> paymentOptions;

  BookingDetailSuccess({required this.cities, required this.paymentOptions});
}

class BookingDetailFailure extends BookingDetailState {
  final String message;

  BookingDetailFailure(this.message);
}
