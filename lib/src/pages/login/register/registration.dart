import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/colors.dart';
import '../../../providers/email_auth_provider.dart';
import '../../../widgets/atoms/button.dart';
import '../../../widgets/atoms/drop_down.dart';
import '../../../widgets/atoms/input_field.dart';
import '../../../widgets/atoms/text_input.dart' as field;
import '../../../widgets/molecules/costume_header.dart';

class RegistrationPage extends StatefulWidget {
  static const pageUrl = "/registration";

  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  ValueNotifier<bool> isSuccess = ValueNotifier<bool>(false);
  String? username = "";
  String? email = "";
  String? phone = "";
  String? password = "";
  String? confrimpassword = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        // autovalidate: state is LoginblocLoading ? true : false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CostumHeader(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Username",
                  child: field.TextInput(
                    name: "username",
                    hintText: "Username",
                    prefixIcon: const Icon(Icons.email),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      username = value;
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
                  key: _emailFieldKey,
                  label: "Email",
                  child: field.TextInput(
                      name: "Email",
                      hintText: "abc@gmail.com",
                      prefixIcon: const Icon(Icons.email),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      onChanged: (value) {
                        email = value;
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Phone",
                  child: field.TextInput(
                      keyboardType: TextInputType.phone,
                      name: "Phone",
                      hintText: "+977",
                      prefixIcon: const Icon(Icons.phone),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        (value) {
                          if (value!.length < 10) {
                            return "Invalid phone number";
                          }
                          return null;
                        }
                      ]),
                      onChanged: (value) {
                        phone = value;
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Password",
                  child: field.TextInput(
                    name: "Password",
                    hintText: "password",
                    prefixIcon: const Icon(Icons.security),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      password = value;
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
                  label: "Confirm-Password",
                  child: field.TextInput(
                    name: "Confirm-Password",
                    hintText: "password",
                    prefixIcon: const Icon(Icons.security),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (value) {
                        if (value != password) {
                          return "Password doesnot matched";
                        }
                        return null;
                      }
                    ]),
                    onChanged: (value) {
                      confrimpassword = value;
                    },
                  ),
                ),
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

                        child: const Text("Register"),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.chevron_left,
                          color: AppColors.black,
                        ),
                        Text(
                          " Go Back",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
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
      Map<String, dynamic> cred = {
        "email": email,
        "username": username,
        "phone": phone,
        "password": confrimpassword,
      };

      Provider.of<EmailAuthentication>(context, listen: false).signUp(
        credential: cred,
        isSuccess: isSuccess,
        formKey: _formKey,
        context: context
      );
    }
  }
}

extension VerifyString on String {
  bool get validUsername {
    return contains(RegExp(r'[a-zA-Z]'));
  }
}
