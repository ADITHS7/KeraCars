import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/features/app_start/presentation/cubit/app_start_cubit.dart";
import "package:keracars_app/features/app_start/presentation/widget/widget.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStartCubit>.value(
      value: AppStartCubit(),
      child: const _OnboardingPage(),
    );
  }
}

class _OnboardingPage extends StatefulWidget {
  const _OnboardingPage();

  @override
  State<_OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<_OnboardingPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  List<Widget> screens = [
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding1.svg",
      header: "High-quality Certified Cars",
      subHeader: "Grow your business ahead with\n100% certified cars",
    ),
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding2.svg",
      header: "Detailed Inspection Reports",
      subHeader: "Explore our verified inspection reports for\nadded peace of mind",
    ),
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding3.svg",
      header: "Bid with Confidence",
      subHeader: "Experience the ease of a transparent and\nuser-friendly bidding process",
    ),
    const OnboardingScreen(
      svgAsset: "assets/svg/onboarding4.svg",
      header: "Support you can Trust",
      subHeader: "Enjoy hassle-free delivery, secure payments,\nand dedicated customer support",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _controller.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.primary,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
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
          Padding(
            padding: EdgeInsets.only(
              top: 16,
              bottom: MediaQuery.of(context).size.height * .1,
            ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: SmoothPageIndicator(
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
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeIn,
              );
            },
          ),
        ),
        BlocBuilder<AppStartCubit, AppStartState>(
          builder: (context, state) {
            if (state is AppStartOnboarding && state.currentPage == screens.length - 1) {
              return FilledButton(
                onPressed: () {
                  context.read<AppStartCubit>().finishOnboarding();

                  context.goNamed(RouteName.auth);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        "Get Started",
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              );
            }

            return FilledButton(
              onPressed: () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Next",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
