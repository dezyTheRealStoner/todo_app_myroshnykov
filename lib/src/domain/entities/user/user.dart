import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

const mockedUser = User(
  email: '',
  name: '',
  image: '',
  todoIds: [],
);

class User extends Equatable {
  const User({
    required this.email,
    required this.name,
    required this.image,
    required this.todoIds,
  });

  final String email;
  final String name;
  final String image;
  final List<dynamic> todoIds;

  @override
  List<Object?> get props => [
        email,
        name,
        image,
        todoIds,
      ];

  User copyWith({
    String? email,
    String? name,
    String? image,
    List<String>? todoIds,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      todoIds: todoIds ?? this.todoIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'image': image,
      'todoIds': todoIds,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : email = map['email'] as String,
        name = map['name'] as String,
        image = map['image'] as String,
        todoIds = map['todosIds'] as List<String>;
}
