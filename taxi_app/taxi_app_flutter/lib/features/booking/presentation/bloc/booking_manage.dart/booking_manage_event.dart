part of 'booking_manage_bloc.dart';

@immutable
sealed class BookingManageEvent {}

class FetchCurrentOrdersUserEvent implements BookingManageEvent {}

class DeleteOrderEvent implements BookingManageEvent {
  final int orderId;

  DeleteOrderEvent(this.orderId);
}