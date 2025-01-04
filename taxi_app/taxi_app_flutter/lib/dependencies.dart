import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app_client/taxi_app_client.dart';
import 'package:taxi_app_flutter/features/auth/data/datasources/auth_datasource.dart';
import 'package:taxi_app_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taxi_app_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_register.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_confirm_registration.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taxi_app_flutter/features/booking/data/datasources/distance_datasource.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/retrieve_cities.dart';
import 'package:taxi_app_flutter/features/booking/domain/usecases/calculating_price.dart';
import 'package:taxi_app_flutter/features/booking/presentation/bloc/booking_detail/booking_detail_block.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  serviceLocator.registerLazySingleton<Client>(
    () => Client(
      "http://localhost:8080/",
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor(),
  );

  serviceLocator.registerLazySingleton<SessionManager>(
    () => SessionManager(
      caller: serviceLocator<Client>().modules.auth,
    ),
  );

  await serviceLocator<SessionManager>().initialize();

  _initAuthFeature();
  _initBookingFeature();
}

void _initAuthFeature() {
  // Data Source
  serviceLocator.registerFactory<AuthDatasource>(() => AuthDatasourceImpl(
    client: serviceLocator<Client>(),
    sessionManager: serviceLocator<SessionManager>(),
  ));

  // Repositories
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
    serviceLocator<AuthDatasource>(),
  ));

  // Use Cases
  serviceLocator.registerFactory<UserLoginUseCase>(() => UserLoginUseCase(
    serviceLocator<AuthRepository>(),
  ));

  serviceLocator.registerFactory<UserRegisterUseCase>(() => UserRegisterUseCase(
    serviceLocator<AuthRepository>(),
  ));

  serviceLocator.registerFactory<UserConfirmRegistrationUseCase>(() => UserConfirmRegistrationUseCase(
    serviceLocator<AuthRepository>(),
  ));

  // Blocs
  serviceLocator.registerFactory<AuthBloc>(() => AuthBloc(
    userLogin: serviceLocator<UserLoginUseCase>(),
    userRegister: serviceLocator<UserRegisterUseCase>(),
    userConfirmRegistration: serviceLocator<UserConfirmRegistrationUseCase>(),
  ));
}

void _initBookingFeature() {
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