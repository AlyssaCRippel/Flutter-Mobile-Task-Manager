import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/loginState_model.dart';
import '../repositories/auth_repository.dart';
import '../cubits/user_cubit.dart';
import '../models/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _auth;
  final UserCubit _userCubit;

  LoginCubit(this._auth, this._userCubit) : super(LoginState());

  /// Logs in a user with the provided email and password.
  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await _auth.login(email, password); // User returned
      _userCubit.setUser(user); // Store globally
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Logs out the current user.
  Future<void> logout() async {
    await _auth.logout(); // In real app this would clear tokens
    _userCubit.clearUser(); // Clear local user
    emit(state.copyWith(status: LoginStatus.initial));
  }

  /// Signs up a user, creates the user via UserRepository, and logs them in
  Future<void> signUp(String email, String password, String confirmPassword) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      _validateInputs(email, password, confirmPassword);

      final user = await _auth.signUp(email, password); // returns new User
      await _userCubit.createUser(user); // Simulate backend insert
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _validateInputs(String email, String password, String confirmPassword) {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }

    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(email)) {
      throw Exception("Invalid email format");
    }

    if (password.length < 6) {
      throw Exception("Password must be at least 6 characters");
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$').hasMatch(password)) {
      throw Exception("Password must contain uppercase, lowercase, and a number");
    }

    if (password != confirmPassword) {
      throw Exception("Passwords do not match");
    }
  }
}
