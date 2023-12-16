import 'package:flutter/material.dart';
import 'package:flutter_hive/doc_example/data/person.dart';
import 'package:flutter_hive/doc_example/screen/doc_example.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  mybox = await Hive.openBox<Person>('personBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const DocumentExample(),
    );
  }
}
