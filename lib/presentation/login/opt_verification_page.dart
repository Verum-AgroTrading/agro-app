import 'package:flutter/material.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("Otp verification page"),
      )),
    );
  }
}
