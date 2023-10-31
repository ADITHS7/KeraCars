import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:equatable/equatable.dart";

part "app_start_state.dart";

class AppStartCubit extends HydratedCubit<AppStartState> {
  AppStartCubit() : super(AppStartInitial());

  void finishOnboarding() => emit(AppStartOnboardingFinished());

  void goToPage(int pageNumber) => emit(AppStartOnboarding(currentPage: pageNumber));

  @override
  AppStartState? fromJson(Map<String, dynamic> json) {
    bool onboardingFinished = json["onboardingFinished"] ?? false;
    return onboardingFinished ? AppStartOnboardingFinished() : const AppStartOnboarding(currentPage: 0);
  }

  @override
  Map<String, dynamic>? toJson(AppStartState state) {
    return {
      "onboardingFinished": state is AppStartOnboardingFinished,
    };
  }
}
