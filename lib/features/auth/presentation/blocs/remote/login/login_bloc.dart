import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';
import 'package:keracars_app/features/auth/domain/usecases/usecases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._getOTPUseCase, this._loginOTPUseCase) : super(const LoginInitial()) {
    on<EditNumber>(_onEditNumber);
    on<CheckBoxChanged>(_onCheckBoxChanged);
    on<RequestOTP>(_onRequestOTP);
    on<RequestSignIn>(_onRequestSignIn);
  }

  final GetOTPUseCase _getOTPUseCase;
  final LoginOTPUseCase _loginOTPUseCase;

  void _onEditNumber(EditNumber event, Emitter<LoginState> emit) {
    final requestOtp = RequestOTPEntity(
      receiveUpdate: event.receiveInstantUpdate,
      credential: event.credential,
    );

    return emit(LoginInitial(requestOTP: requestOtp));
  }

  void _onCheckBoxChanged(CheckBoxChanged event, Emitter<LoginState> emit) {
    final requestOtp = RequestOTPEntity(receiveUpdate: event.receiveInstantUpdate, credential: '');

    if (state is LoginInitial) {
      return emit(LoginInitial(
        exception: (state as LoginInitial).exception,
        requestOTP: requestOtp,
      ));
    }
    return emit(LoginInitial(requestOTP: requestOtp));
  }

  Future<void> _onRequestOTP(RequestOTP event, Emitter<LoginState> emit) async {
    emit(OTPRequestLoading());

    final RequestOTPEntity requestOTP = RequestOTPEntity(
      credential: event.credential,
      receiveUpdate: event.receiveInstantUpdate,
    );

    final dataState = await _getOTPUseCase.execute(params: requestOTP);

    if (dataState is DataFailed) {
      return emit(LoginInitial(exception: dataState.error!));
    }
    return emit(OTPRequestSuccess(otpId: dataState.data!, requestOTP: requestOTP));
  }

  Future<void> _onRequestSignIn(RequestSignIn event, Emitter<LoginState> emit) async {
    final RequestOTPEntity requestOTP = (state as OTPRequestSuccess).requestOTP;

    emit(SignInRequestLoading());

    final dataState = await _loginOTPUseCase.execute(params: event.otpLogin);

    if (dataState is DataFailed) {
      return emit(OTPRequestSuccess(
        exception: dataState.error!,
        otpId: event.otpLogin.id,
        requestOTP: requestOTP,
      ));
    }
    return emit(SignInRequestSuccess(dataState.data!));
  }
}
