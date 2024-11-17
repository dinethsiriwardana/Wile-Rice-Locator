import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Image(image: AssetImage('assets/img/icon.png')),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  "Please Enter the OTP sent to your phone",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  obscureText: true,
                  style: const TextStyle(fontSize: 16.0),
                  cursorHeight: 30,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 16.0),
                    labelStyle: const TextStyle(fontSize: 16.0),
                    hintText: 'Enter your OTP',
                    labelText: 'Enter your OTP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: 90.w,
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                final cred = PhoneAuthProvider.credential(
                                    verificationId: widget.verificationId,
                                    smsCode: otpController.text);

                                await FirebaseAuth.instance
                                    .signInWithCredential(cred);

                                // pust to landing page
                                Navigator.pushNamed(context, '/landing');
                              } catch (e) {
                                log(e.toString());
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: const Text(
                              "Verify",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                      ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
