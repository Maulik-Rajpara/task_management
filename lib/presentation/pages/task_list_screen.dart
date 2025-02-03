import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/data/repositories/task_repository.dart';
import 'package:task_management/presentation/pages/task_detail_screen.dart';
import 'package:task_management/presentation/pages/task_form_screen.dart';
import 'package:task_management/utils/date_time_converter.dart';

import '../../data/model/task_model.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/build_section.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TaskBloc>(context,
        listen: false).add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadSuccess) {
            final todayTasks =
            state.tasks.where((task) => DateTimeConverter().isToday(task.date)).toList();
            final tomorrowTasks =
            state.tasks.where((task) => DateTimeConverter().isTomorrow(task.date)).toList();
            final upcomingTasks =
            state.tasks.where((task) => DateTimeConverter().isAfterTomorrow(task.date)).toList();

            return ListView(
              children: [
                BuildSection(title: 'Today', tasks: todayTasks),
                BuildSection(title: 'Tomorrow', tasks: tomorrowTasks),
                BuildSection(title: 'Upcoming', tasks: upcomingTasks),
              ],
            );
          } else if (state is TaskLoadFailure) {
            return const Center(child: Text('Failed to load tasks'));
          }
          return const Text("No Data found!");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen(
              task: null,
            )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}



