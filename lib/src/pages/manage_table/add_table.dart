import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';

import '../../config/api/manage_table_api.dart';
import '../../widgets/atoms/button.dart';
import '../../widgets/atoms/input_field.dart';
import '../../widgets/atoms/text_input.dart' as field;
import '../../widgets/molecules/header.dart';

class AddTable extends StatefulWidget {
  static const pageUrl = "/addtable";

  const AddTable({Key? key}) : super(key: key);

  @override
  State<AddTable> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  ValueNotifier<bool> isSuccess = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormBuilderState>();
  String? tableid = "";
  String? tablecapacity = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          title: "Add Table",
          showMenu: false,
          showAction: false,
          onPressedLeading: () {},
          onPressedAction: () {}),
      body: FormBuilder(
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
                  label: "Table ID",
                  child: field.TextInput(
                      keyboardType: TextInputType.number,
                      name: "Table ID",
                      hintText: "1",
                      prefixIcon: const Icon(Icons.table_bar),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (value) {
                        tableid = value;
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Table Capacity",
                  child: field.TextInput(
                    keyboardType: TextInputType.number,
                    name: "capacity",
                    hintText: "4",
                    prefixIcon: const Icon(Icons.person),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      tablecapacity = value;
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
                        child: const Text("Add Table"),
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
        "tableid": tableid,
        "capacity": tablecapacity,
        "isRunning": false,
      };

      ManageTableApi manageTableApi = ManageTableApi();
      manageTableApi.addTable(
        cred: tableData,
        isSuccess: isSuccess,
        formKey: _formKey,
      );
    }
  }
}
