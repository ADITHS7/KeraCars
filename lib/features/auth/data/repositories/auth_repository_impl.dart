import 'package:dio/dio.dart';
import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/features/auth/data/datasources/datasources.dart';
import 'package:keracars_app/features/auth/data/models/models.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';
import 'package:keracars_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  const AuthRepositoryImpl({
    required AuthService authService,
  }) : _authService = authService;

  @override
  Future<DataState<String>> requestOTP(RequestOTPEntity requestOTP) async {
    try {
      final httpResponse = await _authService.getOTP(RequestOTPModel(
        credential: requestOTP.credential,
        receiveUpdate: requestOTP.receiveUpdate,
      ));
      return DataSuccess(httpResponse.data['otpId']!);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<NewAuthModel>> loginOTP(OTPLoginEntity otpLogin) async {
    try {
      final httpResponse = await _authService.postOTP(otpLogin as OTPLoginModel);
      return DataSuccess(httpResponse.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> registerUser(RegisterUserEntity registerUserEntity) async {
    try {
      final httpResponse = await _authService.registerUser(RegisterUserModel(
        phone: registerUserEntity.phone,
      ));
      return DataSuccess(httpResponse.data['addedUser'] != null);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
