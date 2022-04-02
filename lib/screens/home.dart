import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/screens/showimage.dart';
import 'package:gallery_app/typeadapter/imagelist.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:gallery_app/functions/functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class screenhome extends StatefulWidget {
  const screenhome({Key? key}) : super(key: key);

  @override
  State<screenhome> createState() => _screenhomeState();
}

class _screenhomeState extends State<screenhome> {
  // Directory? dir;
  final Dio dio = Dio();
  XFile? picked;

  String? imagefile;
  String? imageok;
  int count = 001;

  // Box<imagehive>? box2;

  @override
  void initState() {
    createpath();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Hive.box<imagehive>('image').add(imagehive(image: imagefile, id: "fa"));

    // imagehive img = imagehive();
    // String imagepath;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text("Gallery"),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<imagehive>('image').listenable(),
              builder: (context, Box<imagehive> box1, widget) {
                List<imagehive> imageh = box1.values.toList();
                // box2 = box1;

                if (imageh.isEmpty) {
                  return const Center(
                      child: Text(
                    "No image found.",
                    style: TextStyle(color: Colors.white),
                  ));
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      imageok = imageh[index].image;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => screenimage(
                                    img: imageh[index].image,
                                    index: index,
                                  )));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        FileImage(File(imageh[index].image!))))
                            // : BoxDecoration(color: Colors.amber),
                            ),
                      );
                    },
                    itemCount: box1.length,
                  );
                }
              },
            ),
          ),

          // backgroundColor: const Color.fromARGB(44, 80, 80, 80),

          // camera on button
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            child: const Icon(
              Icons.camera,
              color: Colors.black,
            ),
            onPressed: () {
              gotoCam();
              // savefile();
            },
          )),
    );
  }

  Future<void> gotoCam() async {
    var temp;
    setState(() {
      temp = Random().nextInt(1000);
    });
    // var id2 = box2!.values.toList();
    XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    // final Directory pathDir = await getApplicationDocumentsDirectory();
    // print(pathDir.path);

    if (pickedimage == null) {
      return;
    } else {
      // picked = pickedimage;
      setState(() {
        imagefile = pickedimage.path;
        Hive.box<imagehive>('image').add(imagehive(image: imagefile));
      });
      File(imagefile!).copy('${dir!.path}/00$temp.jpg');
    }
  }
}
