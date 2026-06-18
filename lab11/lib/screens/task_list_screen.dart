import 'package:flutter/material.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';
import 'task_detail_screen.dart';

class TaskListScreen
    extends StatefulWidget {

  const TaskListScreen({
    super.key,
  });

  @override
  State<TaskListScreen>
  createState() =>
      _TaskListScreenState();
}

class _TaskListScreenState
    extends State<TaskListScreen> {

  final TaskRepository repo =
  TaskRepository();

  final TextEditingController
  controller =
  TextEditingController();

  void addTask() {

    if (controller.text.isEmpty) {
      return;
    }

    repo.addTask(
      Task(title: controller.text),
    );

    controller.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Taskly"),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(
              controller: controller,
              decoration:
              const InputDecoration(
                hintText:
                "Enter task",
              ),
            ),

            const SizedBox(
                height: 10),

            ElevatedButton(
              onPressed: addTask,
              child:
              const Text("Add"),
            ),

            const SizedBox(
                height: 20),

            Expanded(

              child:
              repo.tasks.isEmpty

                  ? const Center(
                child: Text(
                  "No tasks yet. Add one!",
                ),
              )

                  : ListView.builder(

                itemCount:
                repo.tasks.length,

                itemBuilder:
                    (context, index) {

                  Task task =
                  repo.tasks[index];

                  return ListTile(

                    title:
                    Text(task.title),

                    onTap:
                        () async {

                      await Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              TaskDetailScreen(
                                task: task,
                              ),
                        ),
                      );

                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}