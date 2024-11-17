import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wild_rice_locator/presentation/page/auth/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    phoneController.text = "+94700000002";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Image(image: AssetImage('assets/img/icon.png')),
              ),
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    style: const TextStyle(fontSize: 16.0),
                    cursorHeight: 30,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 16.0),
                      labelStyle: const TextStyle(fontSize: 16.0),
                      hintText: 'Enter your Phone no',
                      labelText: 'Enter your Phone no',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  isloading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: 90.w,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isloading = true;
                                });

                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: phoneController.text,
                                  verificationCompleted:
                                      (phoneAuthCredential) {},
                                  verificationFailed: (error) {
                                    log(error.toString());
                                  },
                                  codeSent:
                                      (verificationId, forceResendingToken) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OTPScreen(
                                                  verificationId:
                                                      verificationId,
                                                )));
                                  },
                                  codeAutoRetrievalTimeout: (verificationId) {
                                    log("Auto Retireval timeout");
                                  },
                                );
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
