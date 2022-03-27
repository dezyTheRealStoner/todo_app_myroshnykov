import 'package:equatable/equatable.dart';

enum AllTodoScreenStateToBack {
  all,
  completed,
  uncompleted,
}

class AllTodoScreenStateParams extends Equatable {
  const AllTodoScreenStateParams({
    required this.allTodoScreenStateToBack,
    required this.dateTime,
  });

  final AllTodoScreenStateToBack allTodoScreenStateToBack;
  final DateTime dateTime;

  Map<String, dynamic> toMap() {
    return {
      'allTodoScreenState': allTodoScreenStateToBack,
      'dateTime': dateTime,
    };
  }

  factory AllTodoScreenStateParams.fromMap(Map<String, dynamic> map) {
    return AllTodoScreenStateParams(
      allTodoScreenStateToBack:
          map['allTodoScreenState'] as AllTodoScreenStateToBack,
      dateTime: map['dateTime'] as DateTime,
    );
  }

  AllTodoScreenStateParams copyWith({
    AllTodoScreenStateToBack? allTodoScreenStateToBack,
    DateTime? dateTime,
  }) {
    return AllTodoScreenStateParams(
      allTodoScreenStateToBack:
          allTodoScreenStateToBack ?? this.allTodoScreenStateToBack,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  List<Object?> get props => [
        allTodoScreenStateToBack,
        dateTime,
      ];
}
