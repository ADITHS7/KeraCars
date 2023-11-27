import "package:freezed_annotation/freezed_annotation.dart";

part "request_otp_model.freezed.dart";
part "request_otp_model.g.dart";

@freezed
class RequestOTPModel with _$RequestOTPModel {
  const factory RequestOTPModel({
    required String credential,
    required bool receiveUpdate,
  }) = _RequestOTPModel;

  factory RequestOTPModel.fromJson(Map<String, dynamic> json) => _$RequestOTPModelFromJson(json);
}
