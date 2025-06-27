class User{
  final String id;
  final String email;
  final String password;

  User({
    required this.id,
    required this.email,
    required this.password,
  });

  /// Creates a copy of the current User with the given parameters.
  /// @param id The new ID for the user.
  /// @param email The new email for the user.
  /// @param password The new password for the user.
  User copyWith({String? id, String? email, String? password}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

}