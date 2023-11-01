import "package:dio/dio.dart";
import "package:keracars_app/core/error/network_exception.dart";
import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/core/security/token_service.dart";
import "package:keracars_app/core/usecases/usecase.dart";

class CheckAuthenticationUseCase extends UseCase<DataState<bool>, void> {
  final TokenService _tokenService;

  CheckAuthenticationUseCase({
    required TokenService tokenService,
  }) : _tokenService = tokenService;

  @override
  Future<DataState<bool>> execute({required params}) async {
    try {
      await _tokenService.getNewAccessToken();
      return const DataSuccess(true);
    } on DioException catch (e) {
      switch (e.runtimeType) {
        case BadRequestException:
        case UnauthorizedException:
          return DataFailed(e);
        default:
          final rToken = await _tokenService.getRefreshToken();
          if (rToken != null) return const DataSuccess(false);
          return DataFailed(e);
      }
    }
  }
}
