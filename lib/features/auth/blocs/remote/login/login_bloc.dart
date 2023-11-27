import "dart:async";

import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/features/auth/data/models/models.dart";
import "package:keracars_app/features/auth/data/repositories/repositories.dart";

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(const LoginInitial()) {
    on<CheckBoxChanged>(_onCheckBoxChanged);
    on<RequestOTP>(_onRequestOTP);
  }

  final AuthRepository _authRepository;

  void _onCheckBoxChanged(CheckBoxChanged event, Emitter<LoginState> emit) {
    final requestOtp = RequestOTPModel(
      receiveUpdate: event.receiveInstantUpdate,
      credential: state.requestOTPModel.credential,
    );

    return emit(LoginInitial(requestOTPModel: requestOtp));
  }

  Future<void> _onRequestOTP(RequestOTP event, Emitter<LoginState> emit) async {
    emit(OTPRequestLoading(requestOTPModel: state.requestOTPModel));

    final RequestOTPModel requestOTP = RequestOTPModel(
      credential: event.credential,
      receiveUpdate: event.receiveInstantUpdate,
    );

    final dataState = await _authRepository.requestOTP(requestOTP);

    if (dataState is DataFailed) {
      return emit(OTPRequestError(requestOTPModel: requestOTP, exception: dataState.error));
    }
    return emit(OTPRequestSuccess(
      otpId: dataState.data!,
      requestOTPModel: requestOTP,
      resending: event.resending ?? false,
    ));
  }
}
