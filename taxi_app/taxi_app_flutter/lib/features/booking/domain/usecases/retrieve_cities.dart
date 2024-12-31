import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:taxi_app_flutter/core/error/failure.dart';
import 'package:taxi_app_flutter/core/usecases/usecase.dart';



class RetrieveCitiesUseCase implements Usecase<List<String>, NoParams> {
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    var retrieveCitiesJson = RetrieveCitiesJson();
    Either<Failure, List<String>> result = await retrieveCitiesJson.getCityNames();
    return result;
  }
}

class RetrieveCitiesJson {
  final String json_path = 'assets/persistence/cities.json';
  
  Future<Either<Failure, List<String>>> getCityNames() async {
    try {
        var file = await rootBundle.loadString(json_path);
        var json = jsonDecode(file);

        final List<dynamic> features_json = json["features"];
        List<String> lst_cities = [];
        
        for (var feature in features_json) {
          lst_cities.add(feature["properties"]["name"].toString());
        }

        return Right(lst_cities);
    } catch (error) {
      return Left(Failure('Failed to load city names: $error'));
    }
  }


}