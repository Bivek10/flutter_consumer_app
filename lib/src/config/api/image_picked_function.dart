import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../core/utils/snack_bar.dart';
import '../../injector.dart';
import '../../providers/image_file_provider.dart';
import '../firebase/auth.dart';
import '../permission_checker/permission_handler.dart';

class PickedLocalImage {
  void uploadImage(ImagePickerType imagePickerType, context,
      ValueNotifier<bool> isLoading) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedfile;
    late bool? isGranted;

    isGranted = await imagePickerType.permissionType(context);

    if (isGranted!) {
      pickedfile =
          (await picker.pickImage(source: imagePickerType.sourceType()!));
      if (pickedfile != null) {
        isLoading.value = true;
        var file = File(pickedfile.path);

        String fileName = file.path.split('/').last;
        firebaseStorage.ref().child(fileName).putFile(file).then((p0) {
          isLoading.value = false;
          Provider.of<ImageFileReciver>(context, listen: false)
              .receivedImagePath(file);
          // Navigator.pop(context);
          showSuccess(message: "Image uploaded succesfully");
        }).onError((error, stackTrace) {
          isLoading.value = false;
          // Navigator.pop(context);
          showError(message: error.toString());
        });
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}

enum ImagePickerType {
  camera,
  gallery,
}

extension ImagePickerExt on ImagePickerType {
  ImageSource? sourceType() {
    switch (this) {
      case ImagePickerType.camera:
        return ImageSource.camera;

      case ImagePickerType.gallery:
        return ImageSource.gallery;
    }
  }

  Future<bool>? permissionType(context) {
    switch (this) {
      case ImagePickerType.camera:
        return permissionHandler.handleCameraPermission(context);

      case ImagePickerType.gallery:
        return permissionHandler.handlePhotosPermission(context);
    }
  }
}
