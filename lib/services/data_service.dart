import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wheater_app/models/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParams = {
      'q': city,
      'appid': '6b0cfbc226925954cf4ff6577cc7ecbe',
      'units': 'metric'
    };
    final uri =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParams);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJSON(json);
  }
}
