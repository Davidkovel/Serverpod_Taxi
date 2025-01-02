import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/calculating_price.dart';

import 'booking_detail_event.dart';
import 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  final RetrieveCitiesUseCase retrieveCitiesUseCase;
  final CalculatingPriceUseCase calculatingPriceUseCase;

  BookingDetailBloc({required this.retrieveCitiesUseCase, required this.calculatingPriceUseCase}) : super(BookingDetailStateInitial()) {
    on<BookingDetailEvent>((event, emit) => emit(BookingDetailStateLoading()));
    on<FetchBookingDetailsEvent>(_onFetchBookingDetails);
    on<CalculatePriceEvent>(_onCalculatePrice);
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
    print(result);
    result.fold(
      (failure) => emit(BookingDetailStateFailure(failure.message)),
      (price) => emit(BookingDetailStateSuccess(price: price)),
    );
  }
}
