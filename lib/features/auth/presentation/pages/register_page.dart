import "package:coolicons/coolicons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/core/error/network_exception.dart";
import "package:keracars_app/core/widgets/widgets.dart";
import "package:keracars_app/features/auth/domain/entities/entities.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";
import "package:keracars_app/features/auth/presentation/widgets/widgets.dart";

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required LoginBloc bloc}) : _bloc = bloc;

  final LoginBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<RegisterBloc>()),
        BlocProvider.value(value: _bloc),
      ],
      child: _RegisterScreen(),
    );
  }
}

class _RegisterScreen extends StatelessWidget {
  _RegisterScreen();

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (_, state) async {
        if (state is RegisterSuccess) {
          Fluttertoast.showToast(msg: "Register successful");
          context.go(context.namedLocation("login"));
          context.read<LoginBloc>().add(RequestOTP(state.registerUser.phone, false));
        } else if (state is RegisterError) {
          ErrorAlertDialog.show<String>(
            context,
            contentText: (state.exception as NetworkException).message,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Account",
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Enter details to continue",
                style: theme.textTheme.titleMedium?.copyWith(color: theme.disabledColor),
              ),
              const SizedBox(height: 36),
              CustomTextFormField(
                controller: phoneController,
                prefixText: "+91 ",
                isNumberInput: true,
                autofocus: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: Icon(
                    Coolicons.phone_outline,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Center(
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return CTAButton(
                      text: state is RegisterLoading ? "Processing..." : "Get OTP",
                      onPressed: state is RegisterLoading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<RegisterBloc>().add(
                                      RegisteringUser(
                                        RegisterUserEntity(phone: "+91${phoneController.text}"),
                                      ),
                                    );
                              }
                            },
                    );
                  },
                ),
              ),
              const SizedBox(height: 36),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => context.pop(),
                            child: Text(
                              "Sign in",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                      style: theme.textTheme.bodyMedium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
