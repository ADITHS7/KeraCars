import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';
import 'package:keracars_app/features/auth/domain/usecases/usecases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._getOTPUseCase, this._loginOTPUseCase) : super(LoginInitial()) {
    on<RequestOTP>(_onRequestOTP);
    on<RequestSignIn>(_onRequestSignIn);
  }

  final GetOTPUseCase _getOTPUseCase;
  final LoginOTPUseCase _loginOTPUseCase;

  Future<void> _onRequestOTP(RequestOTP event, Emitter<LoginState> emit) async {
    final dataState = await _getOTPUseCase.execute(params: event.credential);

    if (dataState is DataFailed) {
      return emit(OTPRequestError(dataState.error!));
    }
    return emit(OTPRequestSuccess(otpId: dataState.data!));
  }

  Future<void> _onRequestSignIn(RequestSignIn event, Emitter<LoginState> emit) async {
    final dataState = await _loginOTPUseCase.execute(params: event.otpLogin);

    if (dataState is DataFailed) {
      return emit(SignInRequestError(dataState.error!, otpId: event.otpLogin.id));
    }
    return emit(SignInRequestSuccess(dataState.data!));
  }
}
