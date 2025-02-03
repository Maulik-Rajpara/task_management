import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task_model.dart';


class TaskRepository {
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('tasks');

  Future<List<Task>> getTasks() async {
    final snapshot = await tasksCollection.get();
    return snapshot.docs
        .map((doc) => Task(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
      date: (doc['date'] as Timestamp).toDate(),
      imageUrl: doc['imageUrl'],
    ))
        .toList();
  }

  Future<Task> addTask(Task task) async {
    final doc = await tasksCollection.add({
      'title': task.title,
      'description': task.description,
      'date': task.date,
      'imageUrl': task.imageUrl,
    });
    return task.copyWith(id: doc.id);
  }

  Future<void> updateTask(Task task) async {
    await tasksCollection.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'date': task.date,
      'imageUrl': task.imageUrl,
    });
  }

  Future<void> deleteTask(String taskId) async {
    await tasksCollection.doc(taskId).delete();
  }
}
