part of 'todo_cubit.dart';

@immutable
class TodoState extends Equatable {
  TodoState({
    this.id = '',
    this.title = '',
    this.description = '',
    this.todoType = 'default',
    DateTime? dateTime,
    this.completed = false,
    this.todoInfoUpdating = false,
    this.showDeleteDialog = false,
    this.allFieldsFilled = false,
    this.progress = false,
  }) : dateTime = dateTime ?? DateTime.now();

  final String id;
  final String title;
  final String description;
  final String todoType;
  final DateTime dateTime;
  final bool completed;

  final bool todoInfoUpdating;
  final bool showDeleteDialog;

  final bool allFieldsFilled;
  final bool progress;

  TodoState copyWith({
    String? id,
    String? title,
    String? description,
    String? todoType,
    DateTime? dateTime,
    bool? todoInfoUpdating,
    bool? allFieldsFilled,
    bool? completeTapped,
    bool? showDeleteDialog,
    bool? progress,
    bool? completed,
  }) {
    return TodoState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      todoType: todoType ?? this.todoType,
      dateTime: dateTime ?? this.dateTime,
      todoInfoUpdating: todoInfoUpdating ?? this.todoInfoUpdating,
      allFieldsFilled: allFieldsFilled ?? this.allFieldsFilled,
      showDeleteDialog: showDeleteDialog ?? this.showDeleteDialog,
      progress: progress ?? this.progress,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        todoType,
        dateTime,
        completed,
        todoInfoUpdating,
        showDeleteDialog,
        allFieldsFilled,
        progress,
      ];
}
