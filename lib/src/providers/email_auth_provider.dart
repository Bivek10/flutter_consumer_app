import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';

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
  User? _userDetail;

  void signIn({required Map<String, dynamic> credential}) async {
    //emit loading state.
    try {
      emailAuthenticaitonState(AuthState.loading);

      UserCredential usercred = await firebaseAuth.signInWithEmailAndPassword(
          email: credential["email"], password: credential["password"]);

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (usercred.user!.uid.isNotEmpty) {
        //caching the userid

        sharedPreferences.setString("uid", usercred.user!.uid);
        sharedPreferences.setString('name', usercred.user!.displayName ?? "");
        sharedPreferences.setString('email', usercred.user!.email ?? "");
        _userDetail = usercred.user!;
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
        const Duration(seconds: 2),
      );
      if (usercred.user!.uid.isNotEmpty) {
        //caching the userid
        sharedPreferences.setString("uid", usercred.user!.uid);
        sharedPreferences.setString('name', usercred.user!.displayName ?? "");
        sharedPreferences.setString('email', usercred.user!.email ?? "");

        emailAuthenticaitonState(AuthState.loaded);
        _userDetail = usercred.user!;
      } else {
        _errorMessage = "Authentication Failed";
        showError(message: _errorMessage);
        //reset state.
        emailAuthenticaitonState(AuthState.init);
      }
    } on FirebaseAuthException catch (e) {
      showError(message: e.message.toString());
      // reset the state.
      emailAuthenticaitonState(AuthState.init);

      _errorMessage = e.message!;
    }
  }

  //sign out

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();

      sharedPreferences.setString("uid", "");
      sharedPreferences.setString('name', "");
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
  User? get getuserCredential => _userDetail;
}
