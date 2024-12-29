import 'package:get_it/get_it.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  // Use Cases
  serviceLocator.registerLazySingleton<RetrieveCitiesUseCase>(() => RetrieveCitiesUseCase());

  // Blocs
  serviceLocator.registerFactory<BookingDetailBloc>(
    () => BookingDetailBloc(retrieveCitiesUseCase: serviceLocator<RetrieveCitiesUseCase>()),
  );
}