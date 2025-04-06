import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Utils/auth_service.dart';

class AuthController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> signInWithEmail() async {
    User? user = await authService.signInWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (user != null) {
      Get.snackbar("SignIn", "SignIn Successful");
    }
  }

  Future<void> signUpWithEmail() async {
    User? user = await authService.signUpWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (user != null) {
      Get.snackbar("SignUp", "SignUp Successful");
    }
  }

  Future<void> signInWithGoogle() async {
    User? user = await authService.signInWithGoogle();

    if (user != null) {
      debugPrint('uid: ${user.uid}');
      debugPrint('displayName: ${user.displayName}');
      debugPrint('email: ${user.email}');
      debugPrint('photoURL: ${user.photoURL}');
      Get.snackbar("Google SignIn", "Google Sign-In Successful");
    }
  }


  Future<void> sendUserDataToServer(User user) async {
    String serverUrl = "https://your-private-server.com/api/auth/google"; // Your API endpoint

    Map<String, dynamic> userData = {
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "photoUrl": user.photoURL,
      "token": await user.getIdToken(), // Firebase ID token for verification
    };

    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        print("User data stored successfully.");
      } else {
        print("Error storing user data: ${response.body}");
      }
    } catch (e) {
      print("Server Error: $e");
    }
  }

}