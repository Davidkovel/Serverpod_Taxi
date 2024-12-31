import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app_flutter/features/booking/data/datasources/distance_datasource.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/calculating_price.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  // Register Dio
  serviceLocator.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  serviceLocator.registerFactory<DistanceDataSource>(() => DistanceDataSource(serviceLocator<Dio>()));

  // Use Cases
  serviceLocator.registerLazySingleton<RetrieveCitiesUseCase>(() => RetrieveCitiesUseCase());
  serviceLocator.registerLazySingleton<CalculatingPriceUseCase>(() => CalculatingPriceUseCase(serviceLocator<DistanceDataSource>()));
  
  // Blocs
  serviceLocator.registerFactory<BookingDetailBloc>(
    () => BookingDetailBloc(retrieveCitiesUseCase: serviceLocator<RetrieveCitiesUseCase>(), calculatingPriceUseCase: serviceLocator<CalculatingPriceUseCase>()),
  );
}