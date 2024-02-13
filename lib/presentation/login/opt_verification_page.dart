import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:verum_agro_trading/bloc/iam/iam_bloc.dart';
import 'package:verum_agro_trading/presentation/login/widgets/otp_field.dart';
import 'package:verum_agro_trading/routing/routes.dart';
import 'package:verum_agro_trading/theme/theme.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final int fieldCount = 6;
  List<TextEditingController> textControllers = [];
  List<FocusNode> focusNodes = [];
  bool isResendOtpActive = true;
  int secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    textControllers =
        List.generate(fieldCount, (index) => TextEditingController());
    focusNodes = List.generate(fieldCount, (index) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (TextEditingController textEditingController in textControllers) {
      textEditingController.dispose();
    }
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleOtpFilled(BuildContext context) {
    String otp = "";
    for (TextEditingController textEditingController in textControllers) {
      otp += textEditingController.text;
    }

    if (otp.length == 6) {
      context.read<IamBloc>().add(IamVerifyOtpEvent(otp: otp));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFFFFFFF),
            size: 32.0,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Înapoi",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: BlocConsumer<IamBloc, IamState>(
          listener: (context, state) {
            log(state.toString());

            // navigate to home page
            if (mounted &&
                state.state == IamStateValue.success &&
                state.navigateTo == RoutingPaths.home) {
              context.pushNamed(state.navigateTo!,
                  extra: context.read<IamBloc>(), pathParameters: {});
            }

            if (state.state == IamStateValue.failure &&
                state.message.isNotEmpty) {
              // clear text controllers
              for (TextEditingController textEditingController
                  in textControllers) {
                textEditingController.clear();
                focusNodes[0].requestFocus();
              }
              // shows error message
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            for (TextEditingController textEditingController
                in textControllers) {
              textEditingController
                  .addListener(() => _handleOtpFilled(context));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Parola de verificare",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: RichText(
                      text: TextSpan(
                          text:
                              "Am transmis o parolă de verificare pe acest număr: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: ThemeColors.offWhite),
                          children: [
                        //TODO: fix the substring index after the country code is fixed
                        TextSpan(
                            text: "+373 ${widget.phoneNumber.substring(3)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500))
                      ])),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildOtpFields(
                      fieldCount: 6,
                      isError: state.state == IamStateValue.failure),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextButton(
                      onPressed: isResendOtpActive
                          ? () {
                              setState(() {
                                isResendOtpActive = false;
                              });
                              _timer = Timer.periodic(
                                  const Duration(seconds: 1), (_) {
                                if (secondsRemaining != 0) {
                                  setState(() {
                                    secondsRemaining--;
                                  });
                                } else {
                                  setState(() {
                                    isResendOtpActive = true;
                                    secondsRemaining = 60;
                                  });
                                }
                              });
                            }
                          : null,
                      child: Text(
                        isResendOtpActive
                            ? "Retrimite parola"
                            : "Retrimite parola (0:$secondsRemaining secs)",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: isResendOtpActive
                                ? ThemeColors.primaryColor
                                : ThemeColors.secondaryColor,
                            fontWeight: FontWeight.w500),
                      )),
                )
              ],
            );
          },
        ),
      )),
    );
  }

  List<OtpField> _buildOtpFields(
      {required int fieldCount, bool isError = false}) {
    return List.generate(fieldCount, (index) {
      return OtpField(
        otpFieldController: textControllers[index],
        focusNode: focusNodes[index],
        height: 75,
        width: 60,
        borderColor: isError ? Colors.red : ThemeColors.secondaryColor,
      );
    });
  }
}
