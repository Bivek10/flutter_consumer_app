// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/image_picked_function.dart';

class ImageButtomMenu extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  ImageButtomMenu({Key? key, required this.isLoading}) : super(key: key);
  final PickedLocalImage pickedLocalImage = PickedLocalImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0.sp,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Select Menu Picture",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    pickedLocalImage.uploadImage(
                        ImagePickerType.camera, context, isLoading);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("camera")),
              FlatButton.icon(
                onPressed: () {
                  pickedLocalImage.uploadImage(
                      ImagePickerType.gallery, context, isLoading);
                },
                icon: const Icon(Icons.image),
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
