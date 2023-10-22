import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/core/usecases/usecase.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';
import 'package:keracars_app/features/auth/domain/repositories/auth_repository.dart';

class LoginOTPUseCase extends UseCase<DataState<NewAuthEntity>, OTPLoginEntity> {
  final AuthRepository _authRepository;

  LoginOTPUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<DataState<NewAuthEntity>> execute({required params}) async {
    return await _authRepository.loginOTP(params);
  }
}
