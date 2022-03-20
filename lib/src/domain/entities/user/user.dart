import 'package:equatable/equatable.dart';

const mockedUser = User(
  email: '',
  name: '',
  image: '',
  todoIds: [],
  completedTodos: 0,
);

class User extends Equatable {
  const User({
    required this.email,
    required this.name,
    required this.image,
    required this.todoIds,
    required this.completedTodos,
  });

  final String email;
  final String name;
  final String image;
  final List<dynamic> todoIds;
  final int completedTodos;

  @override
  List<Object?> get props => [
        email,
        name,
        image,
        todoIds,
        completedTodos,
      ];

  User copyWith({
    String? email,
    String? name,
    String? image,
    List<String>? todoIds,
    int? completedTodos,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      todoIds: todoIds ?? this.todoIds,
      completedTodos: completedTodos ?? this.completedTodos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'image': image,
      'todoIds': todoIds,
      'completedTodos': completedTodos,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : email = map['email'] as String,
        name = map['name'] as String,
        image = map['image'] as String,
        todoIds = map['todosIds'] as List<String>,
        completedTodos = map['completedTodos'] as int;
}
