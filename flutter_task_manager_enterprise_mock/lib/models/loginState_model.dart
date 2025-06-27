import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginStatus{
  initial,
  loading,
  success,
  failure,
}

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage,
  });


  /// Creates a copy of the current LoginState with the given parameters.
  /// @param status The new status for the login state.
  /// @param errorMessage The new error message for the login state.
  LoginState copyWith({LoginStatus? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  
}