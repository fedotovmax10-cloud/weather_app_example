import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: Colors.blueGrey[800],
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter City Name',
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black87,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.black87,
                    size: 50,
                  ),
                ),
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (cityName.trim().isEmpty || cityName.trim() == '') {
                  final errorSnackBar = SnackBar(
                    backgroundColor: Colors.red[800],
                    padding: const EdgeInsets.all(8),
                    content: const Text(
                      'Enter a city name!',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                } else {
                  Navigator.pop(context, cityName);
                }
              },
              child: Text('Get Weather', style: const TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
