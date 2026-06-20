enum UserStatus {
  pending,
  approved,
  rejected
}

class User {
  final String id;
  final String name;
  final String email;
  final UserStatus status;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.status = UserStatus.pending,
  });

  User copyWith({UserStatus? status}) {
    return User(
      id: id,
      name: name,
      email: email,
      status: status ?? this.status,
    );
  }
}
