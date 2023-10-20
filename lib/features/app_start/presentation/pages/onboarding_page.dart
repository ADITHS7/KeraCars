import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keracars_app/features/app_start/presentation/cubit/app_start_cubit.dart';
import 'package:keracars_app/features/app_start/presentation/widget/onboarding_screen.dart';
import 'package:keracars_app/features/auth/presentation/pages/auth_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) {
          return BlocProvider<AppStartCubit>.value(
            value: AppStartCubit(),
            child: const OnboardingPage(),
          );
        },
      );

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  List<Widget> screens = [
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding1.svg",
      header: 'High-quality Certified Cars',
      subHeader: 'Grow your business ahead with\n100% certified cars',
    ),
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding2.svg",
      header: 'Detailed Inspection Reports',
      subHeader: 'Explore our verified inspection reports for\nadded peace of mind',
    ),
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding3.svg",
      header: 'Bid with Confidence',
      subHeader: 'Experience the ease of a transparent and\nuser-friendly bidding process',
    ),
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding4.svg",
      header: 'Support you can Trust',
      subHeader: 'Enjoy hassle-free delivery, secure payments,\nand dedicated customer support',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 4,
            child: PageView(
              controller: _controller,
              children: screens,
              onPageChanged: (value) => context.read<AppStartCubit>().goToPage(value),
            ),
          ),
          Expanded(
            flex: 2,
            child: _onboardingAction(context),
          ),
        ],
      ),
    );
  }

  Widget _onboardingAction(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: BlocBuilder<AppStartCubit, AppStartState>(
            builder: (context, state) {
              state as AppStartOnboarding;

              return SmoothPageIndicator(
                controller: _controller,
                count: screens.length,
                effect: WormEffect(
                  activeDotColor: theme.colorScheme.primary,
                  dotWidth: 8,
                  dotHeight: 8,
                ),
                onDotClicked: (value) {
                  _controller.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInCirc,
                  );
                  context.read<AppStartCubit>().goToPage(value);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: BlocBuilder<AppStartCubit, AppStartState>(
            builder: (context, state) {
              state as AppStartOnboarding;

              if (state.currentPage == screens.length - 1) {
                return Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          context.read<AppStartCubit>().finishOnboarding();

                          Navigator.of(context).pushReplacement(AuthPage.route());
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Get Started",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        context.read<AppStartCubit>().goToPage(screens.length - 1);

                        _controller.animateToPage(
                          screens.length,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Skip",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context.read<AppStartCubit>().goToPage(state.currentPage + 1);
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
