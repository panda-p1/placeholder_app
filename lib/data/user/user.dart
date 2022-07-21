import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String catchPhrase;
  const User({
    this.id = 0,
    this.name = '',
    this.username = '',
    this.email = '',
    this.phone = '',
    this.website = '',
    this.catchPhrase = '',
  });

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    phone,
    website,
    catchPhrase,
  ];
}