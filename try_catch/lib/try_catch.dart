// import 'dart:math';

import 'dart:developer';

import 'package:flutter/material.dart';

class TryCatch extends StatefulWidget {
  const TryCatch({Key? key}) : super(key: key);

  @override
  _TryCatchState createState() => _TryCatchState();
}

class _TryCatchState extends State<TryCatch> {
  final birinchi = TextEditingController();
  final ekinchi = TextEditingController();

  num summ = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            '$summ',
            style: TextStyle(fontSize: 50),
          ),
          TextFormField(
            controller: birinchi,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: ekinchi,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(
              onPressed: () {
                try {
                  summ = int.parse(birinchi.text) + int.parse(ekinchi.text);
                  setState(() {});
                } catch (e) {
                  showAboutDialog(
                      context: context, applicationName: 'Sanjaz $e');
                  log('========================>$e');
                }
              },
              child: Text('+'))
        ]),
      ),
    );
  }
}
