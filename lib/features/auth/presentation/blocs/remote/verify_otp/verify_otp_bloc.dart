import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/features/auth/domain/entities/entities.dart";
import "package:keracars_app/features/auth/domain/usecases/usecases.dart";

part "verify_otp_event.dart";
part "verify_otp_state.dart";

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc(this._loginOTPUseCase) : super(const VerifyOtpInitial()) {
    on<VerifyOtpInit>((event, emit) => emit(VerifyOtpInitial(otpId: event.otpId)));
    on<RequestSignIn>(_onRequestSignIn);
  }

  final LoginOTPUseCase _loginOTPUseCase;

  Future<void> _onRequestSignIn(RequestSignIn event, Emitter<VerifyOtpState> emit) async {
    emit(const SignInRequestLoading());

    final dataState = await _loginOTPUseCase.execute(params: event.otpLogin);

    if (dataState is DataFailed) {
      return emit(SignInRequestError(dataState.error, otpId: event.otpLogin.id));
    }
    return emit(SignInRequestSuccess(dataState.data!, otpId: event.otpLogin.id));
  }
}
