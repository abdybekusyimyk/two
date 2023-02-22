// import 'dart:math';

// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherlogiv/components/cutom_button.dart';
import 'package:weatherlogiv/constans/api.dart';
import 'package:weatherlogiv/constans/app_text_style.dart';
import 'package:weatherlogiv/models/weather.dart';

const List cityes = <String>[
  'bishkek',
  'talas',
  'naryn',
  'batken',
  'jalal-abad',
  'kara-suu'
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Weather? weather;

  Future<void> weatherLoction() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always &&
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();

        final dio = Dio();
        final response = await dio
            .get(ApiConst.getLocator(position.latitude, position.longitude));

        if (response.statusCode == 200) {
          weather = Weather(
              temp: response.data['current']['temp'],
              description: response.data['current']['weather'][0]
                  ['description'],
              icon: response.data['current']['weather'][0]['icon'],
              name: response.data['timezone']);
          setState(() {});
        }
      }
    } else {
      Position position = await Geolocator.getCurrentPosition();

      final dio = Dio();
      final response = await dio
          .get(ApiConst.getLocator(position.latitude, position.longitude));

      if (response.statusCode == 200) {
        weather = Weather(
            temp: response.data['current']['temp'],
            description: response.data['current']['weather'][0]['description'],
            icon: response.data['current']['weather'][0]['icon'],
            name: response.data['timezone']);
        setState(() {});
      }
    }
  }

  Future<void> weatherName([String? name]) async {
    final dio = Dio();
    final response = await dio.get(ApiConst.api(name ?? 'osh'));

    if (response.statusCode == 200) {
      weather = Weather(
          temp: response.data['main']['temp'],
          description: response.data['weather'][0]['description'],
          icon: response.data['weather'][0]['icon'],
          name: response.data['name']);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    weatherName();
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
      body: weather == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                          onPressed: () {
                            showBottom();
                          },
                          icon: Icons.location_city),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        "${(weather!.temp - 273.15).truncate()}",
                        style: AppTextStyle.temp,
                      ),
                      Image.network(ApiConst.getIcon(weather!.icon, 4))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      child: Text(
                        weather!.description.replaceAll(' ', '\n'),
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
                        weather!.name,
                        style: AppTextStyle.centertitle,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: Color.fromARGB(255, 140, 174, 118),
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: cityes.length,
            itemBuilder: (BuildContext context, int index) {
              final city = cityes[index];
              return Card(
                child: ListTile(
                  onTap: () async {
                    setState(() {
                      weather = null;
                    });
                    weatherName(city);
                    Navigator.pop(context);
                  },
                  title: Text(city),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
