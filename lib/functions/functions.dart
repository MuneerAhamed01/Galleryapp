import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/showimage.dart';

Directory? dir;

Future<bool> requestpermission() async {
  var store = Permission.storage;
  if (await store.isGranted) {
    return true;
  } else {
    var result = await store.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<bool> createpath() async {
  if (await requestpermission()) {
    dir = await getExternalStorageDirectory();
    String newpath = "";
    List<String> folders = dir!.path.split("/");

    print(dir!.path);
    for (var i = 1; i < folders.length; i++) {
      String folder = folders[i];

      if (folder != "Android") {
        newpath += "/" + folder;
      } else {
        break;
      }
    }
    newpath = newpath + "/GalleryTsk";
    dir = (Directory(newpath));
    if (!await dir!.exists()) {
      await dir!.create(recursive: true);
    }
    return true;
  } else {
    return false;
  }
}
