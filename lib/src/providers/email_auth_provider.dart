import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../config/firebase/auth.dart';
import '../core/utils/snack_bar.dart';
import '../injector.dart';

enum AuthState {
  loading,
  loaded,
  init,
}

class EmailAuthentication with ChangeNotifier {
  AuthState? _state;
  late String _errorMessage;
  bool isRegistrationdone = false;

  void isRegister({
    required Map<String, dynamic> cred,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    try {
      if (await isAlreadyRegister(cred["email"])) {
        isSuccess.value = false;
        showError(message: "Already register with this email.");
      } else {
        firebaseFirestore.collection("staffInfo").add(cred).then((value) {
          isSuccess.value = false;
          formKey.currentState!.reset();
          showSuccess(
            message: "Registration completed! Admin verification required.",
          );
        });
      }
    } on FirebaseException catch (e) {
      isSuccess.value = false;
      showError(message: e.toString());
    }
  }

  void isLogin({
    required Map<String, dynamic> cred,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    try {
      if (await authenticateStaff(cred["email"], cred["password"])) {
        isSuccess.value = false;
        showSuccess(message: "Login Successful");
        formKey.currentState!.reset();
        emailAuthenticaitonState(AuthState.loaded);
      } else {
        isSuccess.value = false;
        showError(
          message: "Login Failed! Contact with Admin",
        );
      }
    } on FirebaseException catch (e) {
      isSuccess.value = false;
      showError(message: e.toString());
    }
  }

  Future<bool> authenticateStaff(String email, String password) async {
    bool isAuthenticated = false;
    bool isverificationDone =
        await firebaseFirestore.collection("staffInfo").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()["email"] == email &&
              element.data()["password"] == password &&
              element.data()["isVerify"] == true) {
            sharedPreferences.setString("uid", element.id);
            sharedPreferences.setString("name", element.data()["username"]);
            sharedPreferences.setString("role", element.data()["role"]);

            isAuthenticated = true;
          }
        }
      } else {
        isAuthenticated = false;
      }
      return isAuthenticated;
    });
    return isverificationDone;
  }

  Future<bool> isAlreadyRegister(final String email) async {
    bool isDouble = false;
    bool isChecked =
        await firebaseFirestore.collection("staffInfo").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()["email"] == email) {
            isDouble = true;
          }
        }
      } else {
        isDouble = false;
      }
      return isDouble;
    });
    return isChecked;
  }

  void signIn({required Map<String, dynamic> credential}) async {
    //emit loading state.
    try {
      emailAuthenticaitonState(AuthState.loading);

      UserCredential usercred = await firebaseAuth.signInWithEmailAndPassword(
          email: credential["email"], password: credential["password"]);

      if (usercred.user!.uid.isNotEmpty) {
        //caching the userid
        sharedPreferences.setString("uid", usercred.user!.uid);
        sharedPreferences.setString('email', usercred.user!.email ?? "");
        emailAuthenticaitonState(AuthState.loaded);
      } else {
        _errorMessage = "Authentication Failed";
        emailAuthenticaitonState(AuthState.init);
        showError(message: _errorMessage);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message!;
      showError(message: errorMessage);
      emailAuthenticaitonState(AuthState.init);
    }
  }

  //SIGN UP METHOD
  void signUp({required Map<String, dynamic> credential}) async {
    try {
      emailAuthenticaitonState(AuthState.loading);

      UserCredential usercred =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: credential["email"],
        password: credential["password"],
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );
      if (usercred.user!.uid.isNotEmpty) {
        credential.addAll({"uid": firebaseAuth.currentUser!.uid});
        //store data in firestore..
        var response =
            await firebaseFirestore.collection("userdata").add(credential);

        //caching the userid
        sharedPreferences.setString("uid", usercred.user!.uid);

        sharedPreferences.setString('email', usercred.user!.email ?? "");

        emailAuthenticaitonState(AuthState.loaded);
      } else {
        _errorMessage = "Authentication Failed";
        showError(message: _errorMessage);
        //reset state.
        emailAuthenticaitonState(AuthState.init);
      }
    } on FirebaseAuthException catch (e) {
      showError(message: e.message.toString());
      // reseIt the state.
      emailAuthenticaitonState(AuthState.init);

      _errorMessage = e.message!;
    }
  }

  //sign out

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();

      sharedPreferences.setString("uid", "");

      sharedPreferences.setString('email', "");
      emailAuthenticaitonState(AuthState.init);
    } on FirebaseAuthException catch (e) {
      return false;
    }
    return true;
  }

  void emailAuthenticaitonState(AuthState state) {
    _state = state;

    notifyListeners();
  }

  String get errorMessage => _errorMessage;
  AuthState? get authenticationState => _state;
}
