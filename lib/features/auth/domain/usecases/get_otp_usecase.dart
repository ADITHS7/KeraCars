import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/core/usecases/usecase.dart';
import 'package:keracars_app/features/auth/domain/repositories/repositories.dart';

class GetOTPUseCase implements UseCase<DataState<String>, String> {
  final AuthRepository _authRepository;

  const GetOTPUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<DataState<String>> execute({required String params}) async {
    return await _authRepository.requestOTP(credential: params);
  }
}
