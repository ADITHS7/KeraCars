import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';
import 'package:keracars_app/features/auth/domain/usecases/usecases.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase _registerUserUseCase;

  RegisterBloc(this._registerUserUseCase) : super(RegisterInitial()) {
    on<RegisteringUser>((event, emit) async {
      emit(RegisterInitial());
      final dataState = await _registerUserUseCase.execute(params: event.registerUser);

      if (dataState is DataSuccess) {
        return emit(RegisterSuccess(event.registerUser));
      }
      return emit(RegisterError(dataState.error!));
    });
  }
}
