enum Role {
  user,
  assistant;

  String get name {
    switch (this) {
      case Role.user:
        return "User";
      case Role.assistant:
        return "Assistant";
    }
  }
}
