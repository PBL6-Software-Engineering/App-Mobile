import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/http_provider.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future googleLogin(BuildContext context) async {
    try {
      setLoading(true);
      final googleUser = await googleSignIn.signIn();
      print('googleUser: $googleUser');

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
      if (_user != null) {
        final response = await HttpProvider().postData(
          {
            'id': _user!.id,
            'email': _user!.email,
            'name': _user!.displayName,
            'avatar': _user!.photoUrl,
          },
          'api/infor-user/login-google',
        );

        var body = json.decode(response.body);

        if (response.statusCode == 200) {
          var responseData = body['data'];
          // User userData = User.fromJson(responseData);
          print('ủedata: $responseData');

          var token = responseData['access_token'];

          AuthManager.setToken(token);
          // AuthManager.setUser(userData);
          AuthManager.setUser(await AuthManager.fetchUser());

          MessageDialog.showSuccess(context, body['message']);
          Navigator.of(context).pushNamed('main');
        } else {
          MessageDialog.showError(context, body['message']);
        }

        notifyListeners();
      }
      // }
    } catch (error) {
      print('Google sign-in error: $error');
    } finally {
      setLoading(false);
    }
  }

  Future googleLogout() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (error) {
      print('Google sign-out error: $error');
      // Handle the error
    }
  }
}
