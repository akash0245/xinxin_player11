import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prediction/Controller/Login/authentication_controller.dart';
import 'package:get/get.dart';
import '../../Utils/auth_service.dart';

class AuthScreen extends StatelessWidget {

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Auth")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: authController.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: authController.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                authController.signInWithEmail();
                },
              child: Text("Login with Email"),
            ),
            ElevatedButton(
              onPressed: () async {
                authController.signUpWithEmail();
              },
              child: Text("Sign Up"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                authController.signInWithGoogle();
              },
              child: Text("Login with Google"),
            ),
          ],
        ),
      ),
    );
  }
}