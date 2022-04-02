import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_view/photo_view.dart';

import '../typeadapter/imagelist.dart';

class screenimage extends StatefulWidget {
  final String? img;
  late int index;
  screenimage({
    Key? key,
    required this.img,
    required this.index,
  }) : super(key: key);

  @override
  State<screenimage> createState() => _screenimageState();
}

class _screenimageState extends State<screenimage> {
  @override
  Widget build(BuildContext context) {
    final imagebox = Hive.box<imagehive>('image');
    final imagehive? fordel = imagebox.getAt(widget.index);
    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
          PhotoView(
            filterQuality: FilterQuality.high,
            imageProvider: FileImage(File(widget.img!)),
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
          IconButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await fordel!.delete();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ]),
      ),
    );
  }

  // gotoDelete(imagehive delete, BuildContext ctx) async {}
}
