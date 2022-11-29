import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../config/firebase/auth.dart';
import '../config/routes/routesname.dart';
import '../core/utils/app_secrets.skeleton.dart';
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

  void signIn({
    required Map<String, dynamic> credential,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
    required BuildContext context,
  }) async {
    //emit loading state.
    try {
      UserCredential usercred = await firebaseAuth.signInWithEmailAndPassword(
          email: credential["email"], password: credential["password"]);

      if (usercred.user!.uid.isNotEmpty) {
        firebaseFirestore
            .collection(AppSecrets.consumerinfo)
            .get()
            .then((values) {
          for (var x in values.docs) {
            if (x["email"] == credential["email"] &&
                x["password"] == credential["password"]) {
              isSuccess.value = false;
              showSuccess(message: "Login Successful");
              sharedPreferences.setString("uid", usercred.user!.uid);
              sharedPreferences.setString('email', usercred.user!.email ?? "");
              sharedPreferences.setString('name', x["username"] ?? "");

              formKey.currentState!.reset();

              emailAuthenticaitonState(AuthState.loaded);
            }
          }
        });
        //caching the userid

      } else {
        _errorMessage = "Authentication Failed";
        isSuccess.value = false;
        showError(message: _errorMessage);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message!;
      showError(message: errorMessage);
      isSuccess.value = false;
    }
  }

  //SIGN UP METHOD
  void signUp({
    required Map<String, dynamic> credential,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
    required BuildContext context,
  }) async {
    try {
      UserCredential usercred =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: credential["email"],
        password: credential["password"],
      );
      if (usercred.user!.uid.isNotEmpty) {
        credential.addAll({"uid": firebaseAuth.currentUser!.uid});
        //store data in firestore..
        await firebaseFirestore
            .collection(AppSecrets.consumerinfo)
            .add(credential)
            .then((value) {
          isSuccess.value = false;
          formKey.currentState!.reset();
          sharedPreferences.setString("uid", usercred.user!.uid);

          sharedPreferences.setString('email', usercred.user!.email ?? "");
          sharedPreferences.setString('name', credential["username"] ?? "");

          emailAuthenticaitonState(AuthState.loaded);
          Navigator.pop(context);
        });
      } else {
        isSuccess.value = false;
        _errorMessage = "Authentication Failed";
        showError(message: _errorMessage);
      }
    } on FirebaseAuthException catch (e) {
      showError(message: e.message.toString());
      // reseIt the state.
      isSuccess.value = false;

      _errorMessage = e.message!;
    }
  }

  //sign out

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();

      sharedPreferences.remove("uid");

      sharedPreferences.remove("email");
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
