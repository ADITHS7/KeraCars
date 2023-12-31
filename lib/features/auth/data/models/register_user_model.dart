import "package:freezed_annotation/freezed_annotation.dart";

part "register_user_model.freezed.dart";
part "register_user_model.g.dart";

@freezed
class RegisterUserModel with _$RegisterUserModel {
  const factory RegisterUserModel({required String phone}) = _RegisterUserModel;

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserModelFromJson(json);

  String get phone => phone;
}
