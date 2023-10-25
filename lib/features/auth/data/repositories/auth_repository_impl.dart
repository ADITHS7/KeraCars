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
  Future<DataState<String>> requestOTP({required String credential}) async {
    try {
      final httpResponse = await _authService.getOTP(credential);
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
}
