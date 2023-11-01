import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/features/auth/domain/entities/entities.dart";

abstract class AuthRepository {
  Future<DataState<String>> requestOTP(RequestOTPEntity requestOTP);
  Future<DataState<NewAuthEntity>> loginOTP(OTPLoginEntity otpLogin);

  Future<DataState<bool>> registerUser(RegisterUserEntity registerUserEntity);
}
