import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/features/auth/data/models/models.dart";
import "package:keracars_app/features/auth/data/repositories/repositories.dart";

part "register_event.dart";
part "register_state.dart";

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc(this._authRepository) : super(RegisterInitial()) {
    on<RegisteringUser>((event, emit) async {
      emit(RegisterInitial());
      final dataState = await _authRepository.registerUser(event.registerUser);

      if (dataState is DataSuccess) {
        return emit(RegisterSuccess(event.registerUser));
      }
      return emit(RegisterError(dataState.error!));
    });
  }
}
