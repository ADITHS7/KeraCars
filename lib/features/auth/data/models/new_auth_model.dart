import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';

part 'new_auth_model.freezed.dart';
part 'new_auth_model.g.dart';

@freezed
class NewAuthModel extends NewAuthEntity with _$NewAuthModel {
  const factory NewAuthModel({
    required String accessToken,
    required String refreshToken,
  }) = _NewAuthModel;

  factory NewAuthModel.fromJson(Map<String, dynamic> json) => _$NewAuthModelFromJson(json);
}
