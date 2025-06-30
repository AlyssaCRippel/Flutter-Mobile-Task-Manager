// lib/data/auth_repo.dart
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import './user_repo.dart';

class AuthRepo implements AuthRepository {
  final UserRepo _userRepo = UserRepo();

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return _userRepo.getUser(email);
  }

  @override
  Future<User> signUp(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    final newUser = User(
      id: 'new_user_id',
      email: email,
      password: password,
    );
    _userRepo.createUser(newUser);
    return newUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
