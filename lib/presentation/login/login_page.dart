import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:verum_agro_trading/bloc/iam/iam_bloc.dart';
import 'package:verum_agro_trading/presentation/widgets/primary_button.dart';
import 'package:verum_agro_trading/routing/routes.dart';
import 'package:verum_agro_trading/theme/theme.dart';
import 'package:verum_agro_trading/utils/svg_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final _validationKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(child: SvgPicture.asset(SvgConstants.verumAgroLogin)),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "You're welcome!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ).tr(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Start by entering your mobile phone number",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: ThemeColors.offWhite2),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                    ).tr(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // phone number field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _validationKey,
                      child: TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        cursorColor: ThemeColors.offWhite3,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          prefix: Text(
                            "+373 ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          fillColor: ThemeColors.inputFillColor,
                          filled: true,
                          counter: null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        showCursor: true,
                        maxLength: 10,
                        validator: (value) {
                          if (value?.length != 10) {
                            return "Please enter a valid number";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 20.0),
                  child: BlocConsumer<IamBloc, IamState>(
                    listener: (context, state) {
                      log(state.toString());

                      // navigate to verify otp page
                      if (mounted &&
                          state.state == IamStateValue.success &&
                          state.navigateTo == RoutingPaths.verifyOtp) {
                        //TODO: change the country code to match client requirements
                        context.pushNamed(state.navigateTo!,
                            pathParameters: {
                              "phoneNumber": "+91${textEditingController.text}"
                            },
                            extra: context.read<IamBloc>());
                      }

                      // shows error message
                      if (state.state == IamStateValue.failure &&
                          state.message.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      return PrimaryButton(
                        height: 55.0,
                        width: MediaQuery.sizeOf(context).width,
                        text: "Login".tr(),
                        onTap: () {
                          //TODO: change the country code and length comparison to match client requirements
                          String phoneNumber =
                              "+91${textEditingController.text}";
                          log(_validationKey.currentState
                                  ?.validate()
                                  .toString() ??
                              "");
                          if (phoneNumber.length == 13) {
                            context
                                .read<IamBloc>()
                                .add(IamLoginEvent(phoneNumber: phoneNumber));
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
