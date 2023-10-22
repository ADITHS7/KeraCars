import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<DataState<String>> requestOTP({required String credential});
  Future<DataState<NewAuthEntity>> loginOTP(OTPLoginEntity otpLogin);
}
