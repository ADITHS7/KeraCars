import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';

part 'request_otp_model.freezed.dart';
part 'request_otp_model.g.dart';

@freezed
class RequestOTPModel extends RequestOTPEntity with _$RequestOTPModel {
  const factory RequestOTPModel({
    required String credential,
    required bool receiveUpdate,
  }) = _RequestOTPModel;

  factory RequestOTPModel.fromJson(Map<String, dynamic> json) => _$RequestOTPModelFromJson(json);
}
