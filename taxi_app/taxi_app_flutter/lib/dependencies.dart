import 'package:get_it/get_it.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_block.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  // Blocs
  serviceLocator.registerFactory<BookingDetailBloc>(() => BookingDetailBloc());
}