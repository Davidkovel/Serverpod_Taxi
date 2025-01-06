import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/create_order.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/calculating_price.dart';

import 'booking_detail_event.dart';
import 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  final RetrieveCitiesUseCase retrieveCitiesUseCase;
  final CalculatingPriceUseCase calculatingPriceUseCase;
  final CreateOrderUseCase createOrderUseCase;

  BookingDetailBloc({required this.retrieveCitiesUseCase, required this.calculatingPriceUseCase, required this.createOrderUseCase}) : super(BookingDetailStateInitial()) {
    on<BookingDetailEvent>((event, emit) => emit(BookingDetailStateLoading()));
    on<FetchBookingDetailsEvent>(_onFetchBookingDetails);
    on<CalculatePriceEvent>(_onCalculatePrice);
    on<CreateOrderEvent>(_onCreateOrder);
  }

  Future<void> _onFetchBookingDetails(FetchBookingDetailsEvent event, Emitter<BookingDetailState> emit) async {
    emit(BookingDetailStateLoading());
    final result = await retrieveCitiesUseCase(NoParams());

    result.fold(
      (failure) => emit(BookingDetailStateFailure(failure.message)),
      (cities) => emit(BookingDetailStateSuccess(cities: cities)),
    );
  }

  Future<void> _onCalculatePrice(CalculatePriceEvent event, Emitter<BookingDetailState> emit) async {
    emit(BookingDetailStateLoading());
    final result = await calculatingPriceUseCase(CalculatingPriceParams(event.user_choice_cities));

    result.fold(
      (failure) => emit(BookingDetailStateFailure(failure.message)),
      (price) => emit(CalculatePriceStateSuccess(price: price)),
    );
  }

  FutureOr<void> _onCreateOrder(CreateOrderEvent event, Emitter<BookingDetailState> emit) async {
    emit(BookingDetailStateLoading());
    final result = await createOrderUseCase(OrderCreateParams(event.order));

    result.fold(
      (failure) => emit(BookingDetailStateFailure(failure.message)),
      (_) => emit(CreateOrderStateSuccess()),
    );
    
  }
}
