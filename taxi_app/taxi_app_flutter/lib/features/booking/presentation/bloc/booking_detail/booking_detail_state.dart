abstract class BookingDetailState {}

class BookingDetailStateInitial extends BookingDetailState {}

class BookingDetailStateLoading extends BookingDetailState {}

class BookingDetailStateSuccess extends BookingDetailState {
  final List<String>? cities;
  final double? price;

  BookingDetailStateSuccess({this.cities, this.price});
}

class BookingDetailStateFailure extends BookingDetailState {
  final String message;

  BookingDetailStateFailure(this.message);
}


class CalculatePriceStateSuccess extends BookingDetailState {
  final double price;

  CalculatePriceStateSuccess({required this.price});
}