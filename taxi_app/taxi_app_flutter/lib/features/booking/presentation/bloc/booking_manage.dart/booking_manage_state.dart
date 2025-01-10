part of 'booking_manage_bloc.dart';

@immutable
sealed class BookingManageState {}


class BookingManageStateInitial extends BookingManageState {}

class BookingManageStateLoading extends BookingManageState {}

class BookingManageStateSuccess extends BookingManageState {
  final List<Orders> orders;

  BookingManageStateSuccess(this.orders);

}

class BookingManageStateFailure extends BookingManageState {
  final String message;

  BookingManageStateFailure(this.message);
}

class BookingManageStateDeleteSuccess extends BookingManageState {}