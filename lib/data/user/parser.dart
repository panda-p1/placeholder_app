import 'package:placeholder_app/data/user/user.dart';

class UserParser {
  const UserParser._();

  static User parse(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      catchPhrase: (json['company'] as Map)['catchPhrase'],
    );
  }
}