import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilities/constants.dart';
import 'package:weather_example/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForcast(
      {String? cityName, bool? isCity}) async {
    Map<String, String> parameters;

    if (isCity == true) {
      var queryParameters = {
        "appid": Constants.WEATHER_APP_ID,
        "q": cityName!,
        "units": 'metric'
      };
      parameters = queryParameters;
    } else {
      Location location = Location();
      await location.getCurrentLocation();
      var queryParameters = {
        "appid": Constants.WEATHER_APP_ID,
        "units": 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
      parameters = queryParameters;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_DOMEN_URL,
        Constants.WEATHER_FORECAST_PATH, parameters);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error Weather');
    }
  }
}
