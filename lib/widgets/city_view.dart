import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilities/constants.dart';
import 'package:weather_example/utilities/forecast_util.dart';
import 'package:icons_plus/icons_plus.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var city = snapshot.data!.city!.name;
    var country = snapshot.data!.city!.country;
    var _formattedDate =
        DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
    return Container(
      child: Column(
        children: [
          _cityDetail(city: city, country: country, date: _formattedDate),
          const SizedBox(height: 50),
          _temperatureDetail(list: forecastList),
          const SizedBox(height: 50),
          _extraWeatherDetail(forecastList[0]),
          const SizedBox(height: 50),
          _horizontalListViewDetail(list: forecastList),
        ],
      ),
    );
  }

  Column _cityDetail({city, country, date}) {
    return Column(
      children: [
        Text(
          "$city, $country",
          style: const TextStyle(
            fontSize: 40,
            fontFamily: 'TitanOne',
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          Util.getFormattedBaseDate(date),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }

  Row _temperatureDetail({list}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          Constants.WEATHER_IMAGES_URL + list[0].weather[0].icon + '.png',
          scale: .4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${(list[0].temp.day).toInt()} °C',
                style: const TextStyle(fontSize: 60, color: Colors.white)),
            Text(
                '${list[0].weather[0].main}, ${list[0].weather[0].description}',
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ],
        ),
      ],
    );
  }

  Widget _extraWeatherDetail(weather) {
    var pressure = (weather.pressure * 0.750062).round();
    var humidity = weather.humidity;
    var wind = weather.speed.toInt();
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Util.getItem(LineAwesome.temperature_high_solid, pressure, 'mm Hg'),
          Util.getItem(LineAwesome.cloud_rain_solid, humidity, '%'),
          Util.getItem(LineAwesome.wind_solid, wind, 'm/s'),
        ],
      ),
    );
  }

  Widget _horizontalListViewDetail({list}) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemExtent: 260,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var dateTime =
              DateTime.fromMillisecondsSinceEpoch(list[index]!.dt! * 1000);
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    Util.getFormattedDate(dateTime),
                    style: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'TitanOne',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(list[index].temp.day).toInt()} °C",
                        style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'TitanOne',
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Image.network(
                        Constants.WEATHER_IMAGES_URL +
                            list[index].weather[0].icon +
                            '.png',
                        scale: .8,
                      ),
                    ],
                  ),
                  Text(
                    list[index].weather[0].description,
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'TitanOne',
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
