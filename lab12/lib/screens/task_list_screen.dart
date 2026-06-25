import 'package:flutter/material.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../widget/task_tile.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {

  const TaskListScreen({
    super.key,
  });

  @override
  State<TaskListScreen> createState() =>
      _TaskListScreenState();
}

class _TaskListScreenState
    extends State<TaskListScreen> {

  final TaskRepository repo =
  TaskRepository();

  final TextEditingController controller =
  TextEditingController();

  void addTask() {

    if (controller.text.trim().isEmpty) {
      return;
    }

    repo.addTask(
      Task(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        title: controller.text.trim(),
      ),
    );

    controller.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Taskly",
        ),
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
                hintText: "Enter task",
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: addTask,
                child:
                const Text("Add Task"),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

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

                  final task =
                  repo.tasks[index];

                  return TaskTile(

                    key: ValueKey(
                      task.id,
                    ),

                    task: task,

                    onToggle: () {

                      setState(() {
                        task.toggle();
                      });
                    },

                    onTap: () async {

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