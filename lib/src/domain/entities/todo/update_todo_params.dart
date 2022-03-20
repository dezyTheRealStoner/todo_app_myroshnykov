import 'package:equatable/equatable.dart';

class UpdateTodoParams extends Equatable {
  const UpdateTodoParams({
    required this.id,
    required this.updatedTitle,
    required this.updatedDescription,
    required this.updatedTodoType,
    required this.updateDateTime,
    required this.updatedCompleteStatus,
  });

  final String id;
  final String updatedTitle;
  final String updatedDescription;
  final String updatedTodoType;
  final DateTime updateDateTime;
  final bool updatedCompleteStatus;

  UpdateTodoParams copyWith(
    String? id,
    String? updatedTitle,
    String? updatedDescription,
    String? updatedTodoType,
    DateTime? updateDateTime,
    bool? updatedCompleteStatus,
  ) {
    return UpdateTodoParams(
      id: id ?? this.id,
      updatedTitle: updatedTitle ?? this.updatedTitle,
      updatedDescription: updatedDescription ?? this.updatedDescription,
      updatedTodoType: updatedTodoType ?? this.updatedTodoType,
      updateDateTime: updateDateTime ?? this.updateDateTime,
      updatedCompleteStatus:
          updatedCompleteStatus ?? this.updatedCompleteStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        updatedTitle,
        updatedDescription,
        updatedTodoType,
        updateDateTime,
        updatedCompleteStatus,
      ];
}
