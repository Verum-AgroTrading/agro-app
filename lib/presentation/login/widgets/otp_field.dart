import 'package:flutter/material.dart';

/// [OtpField] lets you enter one digit of the OTP
class OtpField extends StatefulWidget {
  const OtpField(
      {Key? key,
      required this.otpFieldController,
      required this.focusNode,
      this.nextFocusNode,
      required this.height,
      required this.width,
      required this.borderColor,
      this.margin})
      : super(key: key);

  final TextEditingController otpFieldController;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final double height;
  final double width;
  final Color borderColor;
  final EdgeInsets? margin;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: widget.borderColor),
      ),
      child: Center(
        child: TextField(
          controller: widget.otpFieldController,
          focusNode: widget.focusNode,
          onChanged: (value) {
            widget.focusNode.nextFocus();
          },
          style: Theme.of(context).textTheme.titleLarge,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            counter: null,
            counterText: "",
          ),
          maxLength: 1,
          maxLines: 1,
        ),
      ),
    );
  }
}
