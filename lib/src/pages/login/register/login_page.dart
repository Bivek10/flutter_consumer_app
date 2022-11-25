import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../config/routes/routesname.dart';
import '../../../config/themes/colors.dart';
import '../../../providers/email_auth_provider.dart';
import '../../../widgets/atoms/button.dart';

import '../../../widgets/atoms/input_field.dart';
import '../../../widgets/atoms/text_input.dart' as field;
import '../../../widgets/molecules/costume_header.dart';

class LoginPage extends StatefulWidget {
  static const pageUrl = "/Login";

  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  ValueNotifier<bool> isLoginSuccess = ValueNotifier<bool>(false);

  String? email = "";

  String? password = "";

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
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  //shadowColor: Colors.grey.shade200,
                  shadowColor: Colors.transparent,
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  child: ValueListenableBuilder(
                    valueListenable: isLoginSuccess,
                    builder: (BuildContext context, value, Widget? child) {
                      return Button(
                        //start loading,
                        loader: isLoginSuccess.value,
                        fillColor: Colors.orangeAccent,
                        size: ButtonSize.medium,
                        onPressed: () {
                          if (!isLoginSuccess.value) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            validdateLoginForm();
                          }
                        },
                        child: const Text("Login"),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteName.registrationpage,
                      );
                    },
                    child: Text(
                      "New user? Create account",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromARGB(255, 243, 8, 8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
      isLoginSuccess.value = true;
      Map<String, dynamic> loginData = {
        "email": email,
        "password": password,
      };

      Provider.of<EmailAuthentication>(context, listen: false).isLogin(
        cred: loginData,
        isSuccess: isLoginSuccess,
        formKey: _formKey,
      );
    }
  }
}

extension VerifyString on String {
  bool get validUsername {
    return contains(RegExp(r'[a-zA-Z]'));
  }
}
