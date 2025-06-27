import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserCubit extends Cubit<User?> {
  
  final UserRepository _repo;

  UserCubit(this._repo) : super(null);

  /// Loads a user by their ID.
  Future<void> loadUser(String id) async {
    try {
      final user = await _repo.getUser(id);
      emit(user);
    } catch (e) {
      emit(null); // Handle error by emitting null
    }
  }

  /// Creates a new user.
  Future<void> createUser(User user) async {
    try {
      await _repo.createUser(user);
      emit(user); // Emit the created user
    } catch (e) {
      emit(null); // Handle error by emitting null
    }
  }

  /// Updates an existing user.
  Future<void> updateUser(User user) async {
    try {
      await _repo.updateUser(user);
      emit(user); // Emit the updated user
    } catch (e) {
      emit(null); // Handle error by emitting null
    }
  }

  /// Deletes a user by their ID.
  Future<void> deleteUser(String id) async {
    try {
      await _repo.deleteUser(id);
      emit(null); // Emit null after deletion
    } catch (e) {
      emit(null); // Handle error by emitting null
    }
  }

  /// Sets the current user in the cubit.
  void setUser(User user) {
    emit(user);
  }

  /// Clears the current user in the cubit.
  void clearUser() {
    emit(null);
  }

 
}
