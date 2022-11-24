import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../config/routes/routesname.dart';
import '../config/themes/colors.dart';
import '../providers/email_auth_provider.dart';
import '../widgets/atoms/button.dart';
import '../widgets/atoms/input_field.dart';
import '../widgets/atoms/text_input.dart' as field;
import '../widgets/molecules/costume_header.dart';

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
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  String username = "";
  String email = "";
  String phone = "";
  String password = "";
  String confrimpassword = "";

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
              widget.entryType == EntryType.register
                  ? Padding(
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
                        ),
                      ),
                    )
                  : const SizedBox(),
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
                        email = value!;
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              widget.entryType == EntryType.register
                  ? Padding(
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
                              phone = value!;
                            }),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputField(
                  label: "Password",
                  child: field.TextInput(
                    keyboardType: TextInputType.phone,
                    name: "Password",
                    hintText: "password",
                    prefixIcon: const Icon(Icons.security),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (value) {
                      password = value!;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              widget.entryType == EntryType.register
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: InputField(
                        label: "Confirm-Password",
                        child: field.TextInput(
                          keyboardType: TextInputType.phone,
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
                            confrimpassword = value!;
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),

              /*
              widget.entryType == EntryType.register
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Material(
                        shadowColor: Colors.grey.shade200,
                        elevation: 1.0,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: usernameController,
                          cursorColor: AppColors.black,
                          style: CostumTextBorder.textfieldstyle,
                          decoration: CostumTextBorder.textfieldDecoration(
                            context: context,
                            hintText: "Username",
                            lableText: "Username",
                            iconData: Icons.person,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              userError = "Username is required!";
                              return "";
                            }
                            if (value.validUsername == false) {
                              userError = "Invalid username. [A-Z, a-z]";
                              return "";
                            }
                            userError = "";
                            return null;
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
              widget.entryType == EntryType.register
                  ? ErrorContainer(error: userError)
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  shadowColor: Colors.grey.shade200,
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
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
              ErrorContainer(error: emailError),
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
              ErrorContainer(error: passwordError),
              widget.entryType == EntryType.register
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: showpassword,
                        builder: (context, child, state) {
                          return Material(
                            shadowColor: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                            elevation: 1,
                            child: TextFormField(
                              cursorColor: AppColors.black,
                              obscureText: showpassword.value,
                              controller: passwordController1,
                              style: CostumTextBorder.textfieldstyle,
                              decoration: CostumTextBorder.textfieldDecoration(
                                context: context,
                                hintText: "Confirm-Password",
                                lableText: "Confirm-Password",
                                iconData: Icons.security,
                                suffixIcon: IconButton(
                                  icon: showpassword1.value == false
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                  onPressed: () {
                                    if (showpassword1.value) {
                                      showpassword1.value = false;
                                    } else {
                                      showpassword1.value = true;
                                    }
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  paswordError1 = "Password is required";
                                  return "";
                                }

                                if (value.trim() !=
                                    passwordController.text.trim()) {
                                  paswordError1 = "Password doesnot matched";
                                  return "";
                                }

                                paswordError1 = "";
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              widget.entryType == EntryType.register
                  ? ErrorContainer(error: paswordError1)
                  : const SizedBox(),
               */
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
      Map<String, dynamic> loginData = {
        "email": email,
        "username": username,
        "phone": phone,
        "password":
            widget.entryType == EntryType.register ? confrimpassword : password,
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
}

extension VerifyString on String {
  bool get validUsername {
    return contains(RegExp(r'[a-zA-Z]'));
  }
}
