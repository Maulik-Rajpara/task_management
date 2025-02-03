import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management/data/repositories/task_repository.dart';
import 'package:task_management/utils/date_time_converter.dart';

import '../../data/model/task_model.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';


class TaskFormScreen extends StatefulWidget {
   final Task? task;
   const TaskFormScreen({super.key, this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? randomImage='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.task!=null){
      _titleController.text=widget.task!.title;
      _descriptionController.text=widget.task!.description;
      _selectedDate =  widget.task!.date;
       randomImage =  widget.task!.imageUrl;
    }else{
      getRandomString();
    }

  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.task==null?'Add Task':"Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text:

                  DateTimeConverter().convertDateTimeDisplay(_selectedDate)),
                  decoration: const InputDecoration(labelText: 'Date'),
                  validator: (value) {

                    return null;
                  },onTap: _showDatePicker,
                ),


                const SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          id:  widget.task==null?'':widget.task!.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date:  _selectedDate,
                          imageUrl: randomImage!, // Replace with your image URL logic
                        );
                        BlocProvider.of<TaskBloc>(context,
                            listen: false).add(
                            widget.task==null?AddTask(task):UpdateTask(task));
                           Navigator.pop(context);
                      }
                    },
                    child: Text((widget.task==null?
                    'Add Task':"Edit Task"),
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final currentDate = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: 365)),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  void getRandomString() async{
    await Future.delayed(const Duration(seconds: 1));
    final List<String> stringArray = [
    'https://www.kasandbox.org/programming-images/avatars/marcimus.png',
    'https://www.kasandbox.org/programming-images/avatars/marcimus-purple.png',
    'https://www.kasandbox.org/programming-images/avatars/marcimus-orange.png',
    'https://www.kasandbox.org/programming-images/avatars/duskpin-ultimate.png',
    'https://www.kasandbox.org/programming-images/avatars/duskpin-sapling.png',
    'https://www.kasandbox.org/programming-images/avatars/duskpin-seed.png',
    'https://www.kasandbox.org/programming-images/avatars/duskpin-tree.png',
    'https://www.kasandbox.org/programming-images/avatars/duskpin-seedling.png',
    ];
    Random random = Random();
    int randomNumber = random.nextInt(stringArray.length);

    setState(() {
      randomImage = stringArray[randomNumber];
    });
  }
}
