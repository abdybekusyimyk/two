// import 'dart:math';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherlogiv/components/cutom_button.dart';
import 'package:weatherlogiv/constans/api.dart';
import 'package:weatherlogiv/constans/app_text_style.dart';
import 'package:weatherlogiv/models/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> weatherLoction() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await fetchData();
      }
    } else {
      Position position = await Geolocator.getCurrentPosition();
      print(position.latitude);
      print(position.longitude);
    }
  }

  Future<Weather?>? fetchData() async {
    final dio = Dio();
    final response = await dio.get(ApiConst.api);
    print(response);
    if (response.statusCode == 200) {
      final Weather weather = Weather(
          temp: response.data['main']['temp'],
          description: response.data['weather'][0]['description'],
          icon: response.data['weather'][0]['icon'],
          name: response.data['name']);

      return weather;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Weather',
          style: AppTextStyle.appBartitle,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Weather?>(
        future: fetchData(),
        builder: (cnt, sn) {
          if (sn.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (sn.connectionState == ConnectionState.none) {
            return Text("iternete bir katabar kaira kirip kor");
          } else if (sn.connectionState == ConnectionState.done) {
            if (sn.hasError) {
              return Text("${sn.error}");
            } else if (sn.hasData) {
              final weather = sn.data!;

              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/weather.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () async {
                            await weatherLoction();
                          },
                          icon: Icons.near_me,
                        ),
                        CustomButton(
                            onPressed: () {}, icon: Icons.location_city),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          "${(weather.temp - 273.15).truncate()}",
                          style: AppTextStyle.temp,
                        ),
                        Image.network(ApiConst.getIcon(weather.icon, 4))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        child: Text(
                          weather.description.replaceAll(' ', '\n'),
                          // "You'all need and ".replaceAll(' ', '\n'),
                          style: AppTextStyle.centertitle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: Text(
                          weather.name,
                          style: AppTextStyle.centertitle,
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Text("Belgisiz kata");
            }
          } else {
            return Text("Belgisiz kata");
          }
        },
      ),
    );
  }
}
