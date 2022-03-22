import 'package:equatable/equatable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_language.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_theme.dart';

const mockedUser = User(
  email: '',
  name: '',
  image: '',
  todoIds: [],
  completedTodos: 0,
  theme: UserTheme.dark,
  language: UserLanguage.en,
);

class User extends Equatable {
  const User({
    required this.email,
    required this.name,
    required this.image,
    required this.todoIds,
    required this.completedTodos,
    required this.theme,
    required this.language,
  });

  final String email;
  final String name;
  final String image;
  final List<dynamic> todoIds;
  final int completedTodos;
  final UserTheme theme;
  final UserLanguage language;

  @override
  List<Object?> get props => [
        email,
        name,
        image,
        todoIds,
        completedTodos,
        theme,
        language,
      ];

  User copyWith({
    String? email,
    String? name,
    String? image,
    List<String>? todoIds,
    int? completedTodos,
    UserTheme? theme,
    UserLanguage? language,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      todoIds: todoIds ?? this.todoIds,
      completedTodos: completedTodos ?? this.completedTodos,
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'image': image,
      'todoIds': todoIds,
      'completedTodos': completedTodos,
      'theme': theme,
      'language': language,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : email = map['email'] as String,
        name = map['name'] as String,
        image = map['image'] as String,
        todoIds = map['todosIds'] as List<String>,
        completedTodos = map['completedTodos'] as int,
        theme = map['theme'] as UserTheme,
        language = map['language'] as UserLanguage;
}
