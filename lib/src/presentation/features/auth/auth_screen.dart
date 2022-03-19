import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_state.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/auth/auth_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/submit_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/user_data_input_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const screenName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends CubitState<AuthScreen, AuthState, AuthCubit> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();

  final ValueKey _emailTextFieldKey = const ValueKey('emailTextFieldKey');
  final ValueKey _nameTextFieldKey = const ValueKey('usernameTextFieldKey');
  final ValueKey _passwordTextFieldKey = const ValueKey('passwordTextFieldKey');
  final ValueKey _confirmedPasswordTextFieldKey =
      const ValueKey('passwordRepeatedTextFieldKey');

  @override
  void initParams(BuildContext context) {
    final state = cubit(context).state;

    _emailController
      ..text = state.email
      ..addListener(() {
        cubit(context).onEmailChanged(_emailController.text);
      });

    _nameController
      ..text = state.name
      ..addListener(() {
        cubit(context).onNameChanged(_nameController.text);
      });

    _passwordController
      ..text = state.password
      ..addListener(() {
        cubit(context).onPasswordChanged(_passwordController.text);
      });

    _confirmedPasswordController
      ..text = state.confirmedPassword
      ..addListener(() {
        cubit(context)
            .onRepeatedPasswordChanged(_confirmedPasswordController.text);
      });
  }

  @override
  void onStateChanged(BuildContext context, AuthState state) {
    if (state.allIsValid) {
      Beamer.of(context).beamToNamed(HomeScreen.screenName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  String? emailErrorText(AuthState state) {
    if (state.emailAlreadyUsed) {
      return LocaleKeys.email_already_used.tr();
    } else if (state.invalidEmail) {
      return LocaleKeys.incorrect_email.tr();
    } else if (state.incorrectEmailOrPassword) {
      return LocaleKeys.incorrect_email_or_password.tr();
    } else {
      return null;
    }
  }

  String? usernameErrorText(AuthState state) {
    if (state.invalidUsername) {
      return LocaleKeys.incorrect_username.tr();
    } else {
      return null;
    }
  }

  String? passwordErrorText(AuthState state) {
    if (state.invalidPassword) {
      return LocaleKeys.incorrect_password.tr();
    } else if (state.incorrectEmailOrPassword) {
      return LocaleKeys.incorrect_email_or_password.tr();
    } else {
      return null;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: observeState(
            builder: (context, state) {
              if (state.loginStatus) {
                return _buildLoginBody(context, state);
              } else {
                return _buildRegisterBody(context, state);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBody(
    BuildContext context,
    AuthState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        _buildLogo(),
        const SizedBox(height: 30),
        _buildTextFields(state),
        const SizedBox(height: 40),
        SubmitButtonWidget(
          title: LocaleKeys.log_in.tr(),
          onPressed: () async {
            await cubit(context).onLogIn();
          },
          disabled: !state.allFieldsFilled,
          progress: state.progress,
        ),
        const SizedBox(height: 20),
        _buildChangeScreenStateText(isLogIn: state.loginStatus),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRegisterBody(
    BuildContext context,
    AuthState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        _buildLogo(),
        const SizedBox(height: 60),
        _buildTextFields(state),
        const SizedBox(height: 40),
        SubmitButtonWidget(
          title: LocaleKeys.register.tr(),
          onPressed: () async {
            await cubit(context).onRegister();
          },
          disabled: !state.allFieldsFilled,
          progress: state.progress,
        ),
        const SizedBox(height: 20),
        _buildChangeScreenStateText(isLogIn: state.loginStatus),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLogo() {
    return Stack(
      children: [
        const Image(
          width: 200,
          height: 200,
          image: AssetImage('assets/images/logo.png'),
        ),
        Positioned(
          left: 25,
          top: 25,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(-10 / 360),
            child: Text(
              LocaleKeys.todo_app.tr().toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChangeScreenStateText({required bool isLogIn}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogIn
              ? LocaleKeys.dont_have_account.tr()
              : LocaleKeys.do_you_have_account.tr(),
        ),
        GestureDetector(
          onTap: () => cubit(context).onChangeAuthState(),
          child: Text(
            isLogIn ? LocaleKeys.register_now.tr() : LocaleKeys.log_in.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFields(AuthState state) {
    return state.loginStatus
        ? Column(
            children: [
              const SizedBox(height: 20),
              _emailTextField(state),
              const SizedBox(height: 30),
              _passwordTextField(state),
            ],
          )
        : Column(
            children: [
              _emailTextField(state),
              const SizedBox(height: 10),
              _usernameTextField(state),
              const SizedBox(height: 30),
              _passwordTextField(state),
              const SizedBox(height: 10),
              _confirmedPasswordTextField(state),
            ],
          );
  }

  Widget _emailTextField(AuthState state) {
    return UserDataInputWidget(
      key: _emailTextFieldKey,
      hintText: LocaleKeys.email.tr().toLowerCase(),
      isPasswordField: false,
      errorText: emailErrorText(state),
      controller: _emailController,
    );
  }

  Widget _usernameTextField(AuthState state) {
    return UserDataInputWidget(
      key: _nameTextFieldKey,
      hintText: LocaleKeys.name.tr().toLowerCase(),
      isPasswordField: false,
      errorText: usernameErrorText(state),
      controller: _nameController,
    );
  }

  Widget _passwordTextField(AuthState state) {
    return UserDataInputWidget(
      key: _passwordTextFieldKey,
      hintText: LocaleKeys.password.tr().toLowerCase(),
      isPasswordField: true,
      errorText: passwordErrorText(state),
      controller: _passwordController,
    );
  }

  Widget _confirmedPasswordTextField(AuthState state) {
    return UserDataInputWidget(
      key: _confirmedPasswordTextFieldKey,
      hintText: LocaleKeys.repeat_password.tr().toLowerCase(),
      isPasswordField: true,
      errorText: state.invalidConfirmedPassword
          ? LocaleKeys.password_mismatch.tr()
          : null,
      controller: _confirmedPasswordController,
    );
  }
}
