enum UserRole { guest, staff, security, admin }

class UserModel {
  final String uid;
  final String email;
  final String name;
  final UserRole role;
  final String? profilePic;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.profilePic,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: _parseRole(map['role']),
      profilePic: map['profilePic'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'role': role.name,
      'profilePic': profilePic,
    };
  }

  static UserRole _parseRole(String? role) {
    switch (role) {
      case 'staff': return UserRole.staff;
      case 'security': return UserRole.security;
      case 'admin': return UserRole.admin;
      default: return UserRole.guest;
    }
  }
}
