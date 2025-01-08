class User {
  final int id;
  final String email;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.username,
  });
}

int user_id = -1;

int get_user_id() {
  return user_id;
}

void set_user_id(int id) {
  user_id = id;
}