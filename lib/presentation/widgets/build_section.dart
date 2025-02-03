import 'package:flutter/material.dart';

import '../../data/model/task_model.dart';
import '../pages/task_detail_screen.dart';

class BuildSection extends StatelessWidget {
  final String? title;
 final List<Task>? tasks;
 const BuildSection({Key? key,this.title,this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasks!.isEmpty
        ? const SizedBox.shrink()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title!??'',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks!.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return ListTile(

              leading: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Container(
                  height: 50,width: 50,
                  color: Colors.grey.withOpacity(0.2),
                  child: Image.network(tasks![index].imageUrl,
                  height: 50,width: 50,fit: BoxFit.cover,
                   errorBuilder: (e,c,s){
                    return Container();
                 },),
                ),
              ),
              title: Text(tasks![index].title,style: const TextStyle(
                fontSize: 16
              )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TaskDetailScreen(task: tasks![index]),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

}
