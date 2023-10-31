part of 'app_start_cubit.dart';

sealed class AppStartState extends Equatable {
  const AppStartState();

  @override
  List<Object> get props => [];
}

final class AppStartInitial extends AppStartState {}

final class AppStartOnboarding extends AppStartState {
  const AppStartOnboarding({required this.currentPage});

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}

final class AppStartOnboardingFinished extends AppStartState {}
