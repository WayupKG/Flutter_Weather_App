import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_example/api/weather_api.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/screens/city_search_screen.dart';
import 'package:weather_example/widgets/city_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final WeatherForecast locationWeather;

  const WeatherForecastScreen({Key? key, required this.locationWeather})
      : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  var _cityName;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('openwreathermap.kg'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForcast();
            });
          },
          icon: const Icon(Icons.my_location),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var tapped_name = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CitySearchScreen();
                  },
                ),
              );
              if (tapped_name != null) {
                setState(() {
                  _cityName = tapped_name;
                  forecastObject = WeatherApi()
                      .fetchWeatherForcast(cityName: _cityName, isCity: true);
                });
              }
            },
            icon: const Icon(Icons.location_city),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(3),
          alignment: Alignment.center,
          child: FutureBuilder<WeatherForecast>(
            future: forecastObject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(height: 50.0),
                    CityView(snapshot: snapshot)
                  ],
                );
              } else {
                return const Center(
                  child: SpinKitSpinningLines(
                    color: Colors.white,
                    size: 100,
                    lineWidth: 4.0,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
