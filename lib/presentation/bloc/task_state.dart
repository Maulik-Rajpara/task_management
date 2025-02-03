import 'package:equatable/equatable.dart';

import '../../data/model/task_model.dart';


abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  const TaskLoadSuccess(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskLoadFailure extends TaskState {}
