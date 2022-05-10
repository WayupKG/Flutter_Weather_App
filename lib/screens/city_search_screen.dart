import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  var cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Search by city',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'TitanOne',
                    color: Colors.white,
                  ),
                ),
              ),
              TextField(
                cursorColor: Colors.black,
                style: const TextStyle(),
                decoration: const InputDecoration(
                  hintText: "Enter City Name",
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 50,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3),
                  ),
                ),
                onChanged: (value) {
                  cityName = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Get Weather',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, cityName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
