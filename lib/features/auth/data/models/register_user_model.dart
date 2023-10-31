import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';

part 'register_user_model.freezed.dart';
part 'register_user_model.g.dart';

@freezed
class RegisterUserModel extends RegisterUserEntity with _$RegisterUserModel {
  const factory RegisterUserModel({required String phone}) = _RegisterUserModel;

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) => _$RegisterUserModelFromJson(json);
}
