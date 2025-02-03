import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/bloc/task_event.dart';
import 'package:task_management/presentation/bloc/task_state.dart';

import '../../data/model/task_model.dart';
import '../../data/repositories/task_repository.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

 // TaskBloc({required this.taskRepository}) : super(TaskInitial());

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      await mapLoadTasksToState().listen((state) => emit(state)).asFuture();
    });
    on<AddTask>((event, emit) async{
      await  mapAddTaskToState(event).listen((state) => emit(state)).
      asFuture();
    });
    on<UpdateTask>((event, emit)async {
      await mapUpdateTaskToState(event).listen((state) => emit(state))
          .asFuture();
    });
    on<DeleteTask>((event, emit) async{
      await  mapDeleteTaskToState(event).listen((state) => emit(state))
          .asFuture();
    });
  }

  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is LoadTasks) {
      yield* mapLoadTasksToState();
    } else if (event is AddTask) {
      yield* mapAddTaskToState(event);
    } else if (event is UpdateTask) {
      yield* mapUpdateTaskToState(event);
    } else if (event is DeleteTask) {
      yield* mapDeleteTaskToState(event);
    }
  }

  Stream<TaskState> mapLoadTasksToState() async* {
    yield TaskLoading();
    try {
      final tasks = await taskRepository.getTasks();
      yield TaskLoadSuccess(tasks);
    } catch (e) {
      yield TaskLoadFailure();
    }
  }

  Stream<TaskState> mapAddTaskToState(AddTask event) async* {
    if (state is TaskLoadSuccess) {
      final currentState = state as TaskLoadSuccess;
      final task = await taskRepository.addTask(event.task);
      final updatedTasks = List<Task>.from(currentState.tasks)..add(task);
      yield TaskLoadSuccess(updatedTasks);
    }
  }

  Stream<TaskState> mapUpdateTaskToState(UpdateTask event) async* {
    if (state is TaskLoadSuccess) {
      final currentState = state as TaskLoadSuccess;
      await taskRepository.updateTask(event.task);
      final updatedTasks = currentState.tasks.map((t) {
        return t.id == event.task.id ? event.task : t;
      }).toList();
      yield TaskLoadSuccess(updatedTasks);
    }
  }

  Stream<TaskState> mapDeleteTaskToState(DeleteTask event) async* {
    if (state is TaskLoadSuccess) {
      final currentState = state as TaskLoadSuccess;
      await taskRepository.deleteTask(event.taskId);
      final updatedTasks =
      currentState.tasks.where((t) => t.id != event.taskId).toList();
      yield TaskLoadSuccess(updatedTasks);
    }
  }
}
