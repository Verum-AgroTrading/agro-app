import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verum_agro_trading/bloc/iam/iam_bloc.dart';
import 'package:verum_agro_trading/routing/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: BlocListener<IamBloc, IamState>(
          listener: (context, state) {
            log(state.toString());
            if (state.navigateTo != null) {
              while (router.canPop()) {
                router.pop();
              }
              router.pushNamed(RoutingPaths.login);
            }
          },
          child: TextButton(
            onPressed: () {
              context.read<IamBloc>().add(IamSignOutEvent());
            },
            child: const Text("logout"),
          ),
        ),
      )),
    );
  }
}
