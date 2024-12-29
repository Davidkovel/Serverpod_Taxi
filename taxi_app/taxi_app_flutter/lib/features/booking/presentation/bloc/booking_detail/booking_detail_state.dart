abstract class BookingDetailState {}

class BookingDetailStateInitial extends BookingDetailState {}

class BookingDetailStateLoading extends BookingDetailState {}

class BookingDetailStateSuccess extends BookingDetailState {
  final List<String> message;

  BookingDetailStateSuccess(this.message);
}

class BookingDetailStateFailure extends BookingDetailState {
  final String message;

  BookingDetailStateFailure(this.message);
}
