import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:keracars_app/core/widgets/widgets.dart';
import 'package:keracars_app/features/app_start/presentation/cubit/app_start_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<AppStartCubit>(),
      child: const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      AppStartState state = context.read<AppStartCubit>().state;

      if (state is AppStartOnboardingFinished) {
        context.go('/root');
        return;
      }

      context.go('/onboarding');
    });

    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  'assets/svg/splash_image.svg',
                  semanticsLabel: 'KeraCars Logo',
                  width: MediaQuery.of(context).size.width * .35,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Your Certified Car Companion,\nFrom TeamTech',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: Center(child: CustomCircularProgress()),
        )
      ],
    );
  }
}
