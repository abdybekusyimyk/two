import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic res;

  fetchData() async {
    final dio = Dio();
    await Future.delayed(Duration(seconds: 3));
    res = await dio.get('https://jsonplaceholder.typicode.com/posts');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePasge')),
      body: Center(
          child: res == null
              ? const CircularProgressIndicator()
              : Text('${res.data[0]["body"]}')),
    );
  }
}
