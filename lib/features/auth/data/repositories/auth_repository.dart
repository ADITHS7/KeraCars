import "package:dio/dio.dart";
import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/features/auth/data/datasources/datasources.dart";
import "package:keracars_app/features/auth/data/models/models.dart";

class AuthRepository {
  final AuthService _authService;

  const AuthRepository({
    required AuthService authService,
  }) : _authService = authService;

  Future<DataState<String>> requestOTP(RequestOTPModel requestOTP) async {
    try {
      final httpResponse = await _authService.getOTP(requestOTP);
      return DataSuccess(httpResponse.data["otpId"]!);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<NewAuthModel>> loginOTP(OTPLoginModel otpLogin) async {
    try {
      final httpResponse = await _authService.postOTP(otpLogin);
      return DataSuccess(httpResponse.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<bool>> registerUser(RegisterUserModel registerUser) async {
    try {
      final httpResponse = await _authService.registerUser(registerUser);
      return DataSuccess(httpResponse.data["addedUser"] != null);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<String>> refreshAccessToken(String refreshToken) async {
    try {
      final httpResponse = await _authService.refreshAccessToken({"refreshToken": refreshToken});
      return DataSuccess(httpResponse.data["accessToken"]!);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<bool>> logoutUser(String refreshToken) async {
    try {
      final httpResponse = await _authService.logoutUser({"refreshToken": refreshToken});
      return DataSuccess(httpResponse.data["status"] == "success");
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
