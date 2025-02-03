import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String imageUrl;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, date, imageUrl];

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? imageUrl,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

}
