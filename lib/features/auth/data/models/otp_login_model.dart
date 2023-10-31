import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';

part 'otp_login_model.freezed.dart';
part 'otp_login_model.g.dart';

@freezed
class OTPLoginModel extends OTPLoginEntity with _$OTPLoginModel {
  const factory OTPLoginModel({
    required String id,
    required String otp,
  }) = _OTPLoginModel;

  factory OTPLoginModel.fromJson(Map<String, dynamic> json) => _$OTPLoginModelFromJson(json);
}
