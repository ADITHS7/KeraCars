import "package:dio/dio.dart";
import "package:keracars_app/features/auth/data/models/models.dart";
import "package:retrofit/retrofit.dart";

part "auth_service.g.dart";

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String? baseUrl}) = _AuthService;

  @GET("authentications/otp")
  Future<HttpResponse<Map<String, String>>> getOTP(@Queries() RequestOTPModel requestOTP);

  @POST("authentications/otp")
  Future<HttpResponse<NewAuthModel>> postOTP(@Body() OTPLoginModel otpLogin);

  /// [body] {'refreshToken': String}
  @PUT("authentications")
  Future<HttpResponse<Map<String, String>>> refreshAccessToken(@Body() Map<String, String> body);

  /// [body] {'refreshToken': String}
  @DELETE("authentications")
  Future<HttpResponse<Map<String, String>>> logoutUser(@Body() Map<String, String> body);

  @POST("users")
  Future<HttpResponse> registerUser(@Body() RegisterUserModel registerUser);
}
