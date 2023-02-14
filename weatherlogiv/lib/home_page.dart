// import 'dart:math';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  Future<Weather?> fetchData() async {
    final dio = Dio();
    final response = await dio.get(ApiConst.api);
    print(response);
    if (response.statusCode == 200) {
      final Weather weather = Weather(
          main: response.data['weather'][0]['main'],
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/weather.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  icon: Icons.near_me,
                ),
                CustomButton(icon: Icons.location_city),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  '8',
                  style: AppTextStyle.temp,
                ),
                Image.network(ApiConst.getIcon('11n', 4))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "You'all need and ".replaceAll(' ', '\n'),
                  style: AppTextStyle.centertitle,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Text(
              "Bishkek",
              style: AppTextStyle.centertitle,
            )
          ],
        ),
      ),
      // body: Center(
      //   child: FutureBuilder(
      //     future: fetchData(),
      //     builder: (ctx, sn) {
      //       if (sn.hasData) {
      //         return Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               sn.data!.main,
      //               style: TextStyle(fontSize: 30),
      //             ),
      //             Text(sn.data!.description),
      //             Text(sn.data!.icon),
      //             Text(sn.data!.name),
      //           ],
      //         );
      //       } else if (sn.hasError) {
      //         return Text(sn.error.toString());
      //       } else {
      //         return const CircularProgressIndicator();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
