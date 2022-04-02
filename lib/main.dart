import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery_app/screens/home.dart';
import 'package:gallery_app/typeadapter/imagelist.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(imagehiveAdapter());
  await Hive.openBox<imagehive>('image');
  runApp(const MyApp());
}

// /storage/emulated/0/GalleryTsk

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const screenhome());
  }
}
