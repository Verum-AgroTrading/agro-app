import 'package:flutter/material.dart';

/// [OtpField] lets you enter one digit of the OTP
class OtpField extends StatelessWidget {
  const OtpField(
      {Key? key,
      required this.otpFieldController,
      required this.focusNode,
      this.nextFocusNode,
      required this.height,
      required this.width,
      required this.borderColor})
      : super(key: key);

  final TextEditingController otpFieldController;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final double height;
  final double width;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        controller: otpFieldController,
        focusNode: focusNode,
        onChanged: (value) {
          nextFocusNode?.requestFocus();
        },
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
