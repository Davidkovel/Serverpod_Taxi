import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';

import 'booking_detail_event.dart';
import 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  final RetrieveCitiesUseCase retrieveCitiesUseCase;

  BookingDetailBloc({required this.retrieveCitiesUseCase}) : super(BookingDetailStateInitial()) {
    on<BookingDetailEvent>((event, emit) => emit(BookingDetailStateLoading()));
    on<FetchBookingDetailsEvent>(_onFetchBookingDetails);
  }

  Future<void> _onFetchBookingDetails(FetchBookingDetailsEvent event, Emitter<BookingDetailState> emit) async {
    final result = await retrieveCitiesUseCase(NoParams());

    result.fold(
      (failure) => emit(BookingDetailStateFailure(failure.message)),
      (cities) => emit(BookingDetailStateSuccess(cities)),
    );
  }
}
