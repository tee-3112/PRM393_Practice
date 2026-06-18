import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDetailScreen
    extends StatefulWidget {

  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailScreen>
  createState() =>
      _TaskDetailScreenState();
}

class _TaskDetailScreenState
    extends State<TaskDetailScreen> {

  late TextEditingController
  titleController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
          text: widget.task.title,
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Task Detail"),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              key: const Key(
                  "detailTitleField"),
              controller:
              titleController,
            ),

            const SizedBox(
                height: 20),

            ElevatedButton(

              onPressed: () {

                widget.task.title =
                    titleController.text;

                Navigator.pop(
                  context,
                  widget.task,
                );
              },

              child:
              const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}