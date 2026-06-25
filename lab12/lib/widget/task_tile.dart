import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {

  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(12),
      ),

      child: ListTile(

        leading: Checkbox(
          value: task.completed,
          onChanged: (_) => onToggle(),
        ),

        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
            task.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),

        subtitle: Text(
          task.completed
              ? "Completed"
              : "Pending",
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),

        onTap: onTap,
      ),
    );
  }
}