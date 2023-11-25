import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/core/widgets/widgets.dart";
import "package:keracars_app/features/app_start/cubit/app_start_cubit.dart";

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

  void splashing(BuildContext context) {
    AppStartState state = context.read<AppStartCubit>().state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () async {
        if (state is AppStartOnboardingFinished) {
          return context.goNamed(RouteName.auth);
        }

        context.goNamed(RouteName.onboarding);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    splashing(context);
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
                  "assets/svg/splash_image.svg",
                  semanticsLabel: "KeraCars Logo",
                  width: MediaQuery.of(context).size.width * .35,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Your Certified Car Companion,\nFrom TeamTech",
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
