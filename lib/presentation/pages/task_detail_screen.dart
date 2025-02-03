import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/pages/task_form_screen.dart';

import '../../data/model/task_model.dart';
import '../../utils/date_time_converter.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';


class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(task.title),
            SizedBox(height: 16.0),
            Text(
              'Description',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(task.description,maxLines: 4),
            SizedBox(height: 16.0),
            const Text(
              'Date',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(DateTimeConverter().convertDateTimeDisplay(task.date)),
            const SizedBox(height: 16.0),
           Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               ElevatedButton(
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                 ),
                 onPressed: () {
                   Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(builder: (context) =>
                         TaskFormScreen(task: task,)),
                   );

                 },
                 child: const Text('Edit Task',style: TextStyle(
                   color: Colors.white
                 ),),
               ),
               ElevatedButton(
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                 ),
                 onPressed: () {

                   BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                   Navigator.pop(context);
                 },
                 child: const Text('Delete Task',style: TextStyle(
                     color: Colors.white
                 ),),
               ),
             ],
           )
          ],
        ),
      ),
    );
  }
}
