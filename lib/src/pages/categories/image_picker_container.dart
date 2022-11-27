import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/widgets/atoms/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/atoms/loader.dart';

class ImageContainer extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final File? imagefile;
  final Function onPickedTab;
  const ImageContainer(
      {Key? key,
      this.imagefile,
      required this.onPickedTab,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
                //start loading,
                borderRadius: BorderRadius.circular(8),
                loader: false,
                fillColor: Colors.blue,
                size: ButtonSize.medium,
                onPressed: () {
                  if (isLoading.value == false) {
                    onPickedTab();
                  }
                },
                trailingIcon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 15,
                ),
                child: const Text("Upload Image")),
            isLoading.value
                ? const Loader()
                : Container(
                    height: 60.sp,
                    width: 60.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromARGB(177, 219, 225, 219),
                      ),
                      image: DecorationImage(
                        image: imagefile == null
                            ? const AssetImage('assets/images/logo.png')
                            : FileImage(imagefile!) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
