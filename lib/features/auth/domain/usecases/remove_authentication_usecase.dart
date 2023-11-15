import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/core/security/token_service.dart";
import "package:keracars_app/core/usecases/usecase.dart";
import "package:keracars_app/features/auth/domain/repositories/repositories.dart";

class RemoveAuthenticationUseCase extends UseCase<DataState<bool>, void> {
  final TokenService _tokenService;
  final AuthRepository _authRepository;

  RemoveAuthenticationUseCase({
    required TokenService tokenService,
    required AuthRepository authRepository,
  })  : _tokenService = tokenService,
        _authRepository = authRepository;

  @override
  Future<DataState<bool>> execute({required params}) async {
    final refreshToken = await _tokenService.getRefreshToken();
    if (refreshToken != null) await _authRepository.logoutUser(refreshToken);

    await _tokenService.deleteAccessToken();
    await _tokenService.deleteRefreshToken();
    return const DataSuccess(true);
  }
}
