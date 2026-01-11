class AppUser {
  final String id;
  final String name;
  final String role;
  final String? classId;

  AppUser({
    required this.id,
    required this.name,
    required this.role,
    this.classId,
  });

  factory AppUser.fromMap(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'],
      role: data['role'],
      classId: data['classId'],
    );
  }
}
