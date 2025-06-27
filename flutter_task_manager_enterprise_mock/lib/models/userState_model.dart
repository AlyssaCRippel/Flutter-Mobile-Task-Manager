import '../models/user_model.dart';

enum UserStatus { initial, loading, success, error }

class UserState {
  final User? user;
  final UserStatus status;
  final String? error;

  const UserState({
    this.user,
    this.status = UserStatus.initial,
    this.error,
  });
}
