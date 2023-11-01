import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/core/usecases/usecase.dart";
import "package:keracars_app/features/auth/domain/entities/entities.dart";
import "package:keracars_app/features/auth/domain/repositories/auth_repository.dart";

class RegisterUserUseCase extends UseCase<DataState<bool>, RegisterUserEntity> {
  final AuthRepository _authRepository;

  RegisterUserUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<DataState<bool>> execute({required params}) async {
    return await _authRepository.registerUser(params);
  }
}
