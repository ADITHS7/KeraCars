import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/core/network/service/services.dart';
import 'package:keracars_app/core/usecases/usecase.dart';

class RemoveAuthenticationUseCase extends UseCase<DataState<bool>, void> {
  final TokenService _tokenService;

  RemoveAuthenticationUseCase({
    required TokenService tokenService,
  }) : _tokenService = tokenService;

  @override
  Future<DataState<bool>> execute({required params}) async {
    try {
      await _tokenService.deleteAccessToken();
      await _tokenService.deleteRefreshToken();
      return const DataSuccess(true);
    } on Exception catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(Exception('unknown error'));
    }
  }
}
