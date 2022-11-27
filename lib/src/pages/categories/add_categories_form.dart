import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../config/api/manage_food_api.dart';
import '../../widgets/atoms/button.dart';
import '../../widgets/atoms/input_field.dart';
import '../../widgets/molecules/header.dart';
import '../../widgets/atoms/text_input.dart' as field;
import '../manage_table/add_table.dart';


class AddCategoires extends StatefulWidget {
  static const String pageUrl = "/categoryform";
  final EditFormValue editFormValue;

  const AddCategoires({Key? key, required this.editFormValue})
      : super(key: key);

  @override
  State<AddCategoires> createState() => _AddCategoiresState();
}

class _AddCategoiresState extends State<AddCategoires> {
  ValueNotifier<bool> isSuccess = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormBuilderState>();

  String? categoryid = "";
  String? categoryname = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: widget.editFormValue.isEdit ? "Edit Table" : "Add Category",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
      ),
      body: FormBuilder(
        initialValue: widget.editFormValue.isEdit
            ? widget.editFormValue.initialvalue
            : {},
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
                  label: "Category ID",
                  child: field.TextInput(
                      keyboardType: TextInputType.number,
                      name: "categoryid",
                      hintText: "1",
                      enabled: widget.editFormValue.isEdit ? false : true,
                      prefixIcon: const Icon(Icons.table_bar),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (value) {
                        categoryid = value;
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Category Name",
                  child: field.TextInput(
                    name: "categoryname",
                    hintText: "Buff",
                    prefixIcon: const Icon(Icons.person),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      categoryname = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
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
                        child: widget.editFormValue.isEdit
                            ? const Text("Edit Table")
                            : const Text("Add Category"),
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
      Map<String, dynamic> tableData = {
        "categoryid": categoryid,
        "categoryname": categoryname,
      };
      ManageFoodApi manageFoodApi = ManageFoodApi();
      if (widget.editFormValue.isEdit) {
        manageFoodApi.editCategory(
          data: tableData,
          isSuccess: isSuccess,
          cateUid: widget.editFormValue.tableuid,
          formKey: _formKey,
        );
      } else {
        manageFoodApi.addCategory(
          cred: tableData,
          isSuccess: isSuccess,
          formKey: _formKey,
        );
      }
    }
  }

}
