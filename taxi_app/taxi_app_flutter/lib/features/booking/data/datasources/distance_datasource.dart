import 'package:dio/dio.dart';

class DistanceDataSource {
  final Dio dio;
  final String apiKey = 'DSgCrOeTFhTkNsfSgINZjGHoeuuSgzp7TpQBPghNKfx62SavoiLu8SUR4tJnCpBf';

  DistanceDataSource(this.dio);

  Future<double> getDistance(String fromCity, String toCity) async {
    final response = await dio.get(
      'https://api.distancematrix.ai/maps/api/distancematrix/json',
      queryParameters: {
        'origins': fromCity,
        'destinations': toCity,
        'key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final distanceInMeters = data['rows'][0]['elements'][0]['distance']['value'];
      return distanceInMeters / 1000;
    } 
    else {
      throw Exception('Failed to fetch distance');
    }
  }
}