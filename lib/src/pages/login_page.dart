import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../config/routes/routesname.dart';
import '../config/themes/colors.dart';
import '../providers/email_auth_provider.dart';
import '../widgets/atoms/button.dart';
import '../widgets/atoms/input_decoration.dart';
import '../widgets/atoms/text_form_error.dart';
import '../widgets/molecules/costume_header.dart';
import 'home_page.dart';

enum EntryType {
  login,
  register,
}

class LoginPage extends StatefulWidget {
  static const pageUrl = "/Login";

  final EntryType entryType;
  const LoginPage({
    Key? key,
    required this.entryType,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailError = "";
  String passwordError = "";
  ValueNotifier<bool> showpassword = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  shadowColor: Colors.grey.shade200,
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameController,
                    cursorColor: AppColors.black,
                    style: CostumTextBorder.textfieldstyle,
                    decoration: CostumTextBorder.textfieldDecoration(
                        context: context,
                        hintText: "E-mail Address",
                        lableText: "E-mail Address",
                        iconData: Icons.email),
                    validator: (value) {
                      if (value!.isEmpty) {
                        emailError = "E-mail address is required.";
                        return "";
                      }
                      final RegExp emailExp = RegExp(
                          r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                      if (!emailExp.hasMatch(value.trim())) {
                        emailError = "Invalid E-mail address";
                        return "";
                      }
                      emailError = "";
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: emailError.isNotEmpty ? 35 : 30,
                child: emailError.isNotEmpty
                    ? TextFormError(
                        errorMessage: emailError,
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ValueListenableBuilder(
                  valueListenable: showpassword,
                  builder: (context, child, state) {
                    return Material(
                      shadowColor: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 1,
                      child: TextFormField(
                        //keyboardType: TextInputType.visiblePassword,
                        cursorColor: AppColors.black,
                        obscureText: showpassword.value,
                        controller: passwordController,
                        style: CostumTextBorder.textfieldstyle,
                        decoration: CostumTextBorder.textfieldDecoration(
                          context: context,
                          hintText: "Password",
                          lableText: "Password",
                          iconData: Icons.security,
                          suffixIcon: IconButton(
                            icon: showpassword.value == false
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                            onPressed: () {
                              if (showpassword.value) {
                                showpassword.value = false;
                              } else {
                                showpassword.value = true;
                              }
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            passwordError = "Password is required";
                            return "";
                          }

                          passwordError = "";
                          return null;
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: passwordError.isNotEmpty ? 35 : 30,
                child: passwordError.isNotEmpty
                    ? TextFormError(
                        errorMessage: passwordError,
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  //shadowColor: Colors.grey.shade200,
                  shadowColor: Colors.transparent,
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Consumer<EmailAuthentication>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Button(
                        //start loading,
                        loader: value.authenticationState == AuthState.loading,
                        fillColor: Colors.orangeAccent,
                        size: ButtonSize.medium,
                        onPressed: () {
                          if (value.authenticationState != AuthState.loading) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            validdateLoginForm();
                          }
                        },
                        child: widget.entryType == EntryType.login
                            ? const Text("Login")
                            : const Text("Register"),
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
                      Navigator.of(context).pushNamed(RouteName.loginpage,
                          arguments: EntryType.register);

                      // widget.isForgot.value = true;
                      // widget.isresizeForm.value = true;
                    },
                    child: widget.entryType == EntryType.login
                        ? Text(
                            "New user? Create account",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : TextButton(
                            child: Text(
                              "< Go Back",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
    setState(() {});
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> loginData = {
        "email": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      };
      if (widget.entryType == EntryType.login) {
        Provider.of<EmailAuthentication>(context, listen: false)
            .signIn(credential: loginData);
      } else {
        Provider.of<EmailAuthentication>(context, listen: false)
            .signUp(credential: loginData);
      }
    }
  }

  void disposeController() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
