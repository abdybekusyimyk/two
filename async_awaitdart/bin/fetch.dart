import 'package:dio/dio.dart';

void main() async {
  dynamic dio = Dio();
  final res = await dio.get('https://jsonplaceholder.typicode.com/posts');

  print(res.data);
}
