import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/core/network/service/services.dart';
import 'package:keracars_app/core/usecases/usecase.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';

class AddAuthenticationUseCase extends UseCase<DataState<bool>, NewAuthEntity> {
  final TokenService _tokenService;

  AddAuthenticationUseCase({
    required TokenService tokenService,
  }) : _tokenService = tokenService;

  @override
  Future<DataState<bool>> execute({required params}) async {
    try {
      await _tokenService.setAccessToken(params.accessToken);
      await _tokenService.setRefreshToken(params.refreshToken);
      return const DataSuccess(true);
    } on Exception catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(Exception('unknown error'));
    }
  }
}
