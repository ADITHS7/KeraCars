import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:keracars_app/features/app_start/presentation/cubit/app_start_cubit.dart';
import 'package:keracars_app/features/app_start/presentation/pages/splash_page.dart';

class AppStartPage extends StatelessWidget {
  const AppStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<AppStartCubit>(),
      child: const SplashPage(),
    );
  }
}
