import 'package:async_awaitdart/async_awaitdart.dart' as async_awaitdart;

// async
// awaid
// Future
// <>    Map phons = <int, String>{1: 'efwef', 2: "23", 3: "1", 4: 'true'};

void main() async {
  // await getName();
  await salam();
  // koshtoshu();
}

Future<void> salam() async {
  await Future.delayed(Duration(seconds: 3))
      .then((value) => print('S!!!!!!!!!!!'));
  print("Salam Alaikum");
}

void koshtoshu() {
  print('Koshbol');
}

// Future<String> getName() async {
//   // await Future.delayed(Duration(seconds: 4));
//   // print('Bekturgan');

 
//  await return 'Bekturgan';
// }
