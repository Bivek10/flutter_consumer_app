import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_skeleton/src/widgets/atoms/button.dart';
import 'package:provider/provider.dart';
import '../../config/api/manage_food_api.dart';
import '../../providers/image_file_provider.dart';
import '../../widgets/atoms/input_field.dart';
import '../../widgets/molecules/header.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../widgets/atoms/text_input.dart' as field;
import 'image_picker_container.dart';
import 'image_upload_option.dart';

class AddFoodMenu extends StatefulWidget {
  final String categoryID;
  static const String pageUrl = "/addmenu";
  const AddFoodMenu({Key? key, required this.categoryID}) : super(key: key);

  @override
  State<AddFoodMenu> createState() => _AddFoodMenuState();
}

class _AddFoodMenuState extends State<AddFoodMenu> {
  ValueNotifier<bool> isSuccess = ValueNotifier<bool>(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final _formKey = GlobalKey<FormBuilderState>();

  String? foodid = "";
  String? foodname = "";
  String? price = "";
  String? rating = "";
  String? discount = "";
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Add Menu",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
      ),
      body: FormBuilder(
        // initialValue: widget.editFormValue.isEdit
        //     ? widget.editFormValue.initialvalue
        //     : {},
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        // autovalidate: state is LoginblocLoading ? true : false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Menu ID",
                  child: field.TextInput(
                      keyboardType: TextInputType.number,
                      name: "menuid",
                      hintText: "1",
                      enabled: true,
                      prefixIcon: const Icon(Icons.table_bar),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (value) {
                        foodid = value;
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Menu Name",
                  child: field.TextInput(
                    name: "Menu Name",
                    hintText: "Buff",
                    prefixIcon: const Icon(Icons.person),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      foodname = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Price",
                  child: field.TextInput(
                    name: "rice",
                    hintText: "Price amt",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.person),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Rating",
                  child: field.TextInput(
                    name: "rating",
                    hintText: "5",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.person),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      rating = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Discount",
                  child: field.TextInput(
                    name: "Discount",
                    hintText: "Discount amt",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.person),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      discount = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<ImageFileReciver>(
                builder: (context, value, child) {
                  file = value.getFile;
                  return ImageContainer(
                    isLoading: isLoading,
                    onPickedTab: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => ImageButtomMenu(
                              isLoading: isLoading,
                            )),
                      );
                    },
                    imagefile: value.getFile,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  //shadowColor: Colors.grey.shade200,
                  shadowColor: Colors.transparent,
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  child: ValueListenableBuilder(
                    valueListenable: isSuccess,
                    builder: (BuildContext context, value, Widget? child) {
                      return Button(
                        //start loading,
                        loader: isSuccess.value,
                        fillColor: Colors.orangeAccent,
                        size: ButtonSize.medium,
                        onPressed: () {
                          if (!isSuccess.value) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            validdateLoginForm();
                          }
                        },

                        child: const Text("Add Food"),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validdateLoginForm() async {
    if (_formKey.currentState!.validate()) {
      isSuccess.value = true;
      ManageFoodApi manageFoodApi = ManageFoodApi();
      Map<String, dynamic> menuData = {
        "foodid": foodid,
        "foodname": foodname,
        "price": price,
        "rating": rating,
        "discount": discount
      };

      if (file != null) {
        String filename = file!.path.split("/").last;
        String imageurl = await manageFoodApi.getDownloadURL(filename);
        if (imageurl != "") {
          menuData.addAll({"imageurl": imageurl});
          manageFoodApi.addFoodMenu(
              context: context,
              catID: widget.categoryID,
              cred: menuData,
              isSuccess: isSuccess,
              formKey: _formKey);
        }
      } else {
        manageFoodApi.addFoodMenu(
            context: context,
            catID: widget.categoryID,
            cred: menuData,
            isSuccess: isSuccess,
            formKey: _formKey);
      }
    }
  }
}
