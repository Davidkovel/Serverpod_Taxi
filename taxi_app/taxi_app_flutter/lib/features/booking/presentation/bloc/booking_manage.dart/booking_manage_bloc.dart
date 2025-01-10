import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/delete_order.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/list_available_orders.dart';

part 'booking_manage_event.dart';
part 'booking_manage_state.dart';

class BookingManageBloc extends Bloc<BookingManageEvent, BookingManageState> {
  final ListAvailableOrdersUseCase listAvailableOrdersUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;

  BookingManageBloc({required this.listAvailableOrdersUseCase, required this.deleteOrderUseCase}) : super(BookingManageStateInitial()) {
    on<BookingManageEvent>((event, emit) => emit(BookingManageStateLoading()));
    on<FetchCurrentOrdersUserEvent>(_onFetchOrders);
    on<DeleteOrderEvent>(_onDeleteOrder);

  }

  FutureOr<void> _onFetchOrders(FetchCurrentOrdersUserEvent event, Emitter<BookingManageState> emit) async {
    emit(BookingManageStateLoading());
    final result = await listAvailableOrdersUseCase(NoParams());

    result.fold(
      (failure) => emit(BookingManageStateFailure(failure.message)),
      (orders) => emit(BookingManageStateSuccess(orders)),
    );
  }

  FutureOr<void> _onDeleteOrder(DeleteOrderEvent event, Emitter<BookingManageState> emit) async {
    emit(BookingManageStateLoading());
    final result = await deleteOrderUseCase(DeleteOrderParams(event.orderId));

    result.fold(
      (failure) => emit(BookingManageStateFailure(failure.message)),
      (_) => emit(BookingManageStateDeleteSuccess()),
    );
  }
}
