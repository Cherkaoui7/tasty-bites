enum UserStatus {
  pending,
  approved,
  rejected
}

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserStatus status;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.status = UserStatus.pending,
  });

  User copyWith({UserStatus? status}) {
    return User(
      id: id,
      name: name,
      email: email,
      password: password,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'status': status.name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      status: UserStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => UserStatus.pending,
      ),
    );
  }
}
