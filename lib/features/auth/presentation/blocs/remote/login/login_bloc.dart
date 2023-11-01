import "dart:async";

import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/features/auth/domain/entities/entities.dart";
import "package:keracars_app/features/auth/domain/usecases/usecases.dart";

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._getOTPUseCase) : super(const LoginInitial()) {
    on<CheckBoxChanged>(_onCheckBoxChanged);
    on<RequestOTP>(_onRequestOTP);
  }

  final GetOTPUseCase _getOTPUseCase;

  void _onCheckBoxChanged(CheckBoxChanged event, Emitter<LoginState> emit) {
    final requestOtp = RequestOTPEntity(
      receiveUpdate: event.receiveInstantUpdate,
      credential: state.requestOTP.credential,
    );

    return emit(LoginInitial(requestOTPEntity: requestOtp));
  }

  Future<void> _onRequestOTP(RequestOTP event, Emitter<LoginState> emit) async {
    emit(OTPRequestLoading(requestOTPEntity: state.requestOTP));

    final RequestOTPEntity requestOTP = RequestOTPEntity(
      credential: event.credential,
      receiveUpdate: event.receiveInstantUpdate,
    );

    final dataState = await _getOTPUseCase.execute(params: requestOTP);

    if (dataState is DataFailed) {
      return emit(OTPRequestError(requestOTPEntity: requestOTP, exception: dataState.error));
    }
    return emit(OTPRequestSuccess(
      otpId: dataState.data!,
      requestOTPEntity: requestOTP,
      resending: event.resending ?? false,
    ));
  }
}
