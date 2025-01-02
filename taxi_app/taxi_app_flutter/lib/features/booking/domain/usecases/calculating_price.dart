import 'package:fpdart/fpdart.dart';
import 'package:taxi_app_flutter/core/error/failure.dart';

import 'package:taxi_app_flutter/core/usecases/usecase.dart';
import 'package:taxi_app_flutter/features/booking/data/datasources/distance_datasource.dart';

class CalculatingPriceUseCase implements Usecase<double, CalculatingPriceParams> {
  DistanceDataSource distanceDataSource;

  CalculatingPriceUseCase(this.distanceDataSource);

  @override
  Future<Either<Failure, double>> call(CalculatingPriceParams params) async {
      var calculatingObj = CalculatingPrice(distanceDataSource, fromCity: params.user_choice_cities['To'], toCity: params.user_choice_cities['From']);
      Either<Failure, double> price = await calculatingObj.calculate();
      return price;
  }

}

class CalculatingPrice {
  final DistanceDataSource distanceDataSource;
  double pricePerKm = 1.5;
  double distance = 0.0;
  String fromCity;
  String toCity;

  CalculatingPrice(this.distanceDataSource, {required this.fromCity, required this.toCity});

  Future<Either<Failure, double>> calculate() async {
    try {
      distance = await distanceDataSource.getDistance(fromCity, toCity);
      return Right(distance * pricePerKm);
    } 
    catch (error) {
      return Left(Failure('Failed to get price: $error'));
    }
  }
}

class CalculatingPriceParams {
  Map<String, dynamic> user_choice_cities;

  CalculatingPriceParams(this.user_choice_cities);
}