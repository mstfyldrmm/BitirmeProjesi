enum UserType { teacher, student }

extension UserTypeExtension on UserType {
  String get value {
    switch (this) {
      case UserType.teacher:
        return "teacher";
      case UserType.student:
        return "student";
    }
  }

  static UserType fromString(String value) {
    switch (value) {
      case "teacher":
        return UserType.teacher;
      case "student":
        return UserType.student;
      default:
        throw ArgumentError("Invalid user type");
    }
  }
}
