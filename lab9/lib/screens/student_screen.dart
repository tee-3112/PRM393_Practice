import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/storage_service.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() =>
      _StudentScreenState();
}

class _StudentScreenState
    extends State<StudentScreen> {

  final StorageService storageService =
  StorageService();

  List<Student> students = [];
  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {

    final data =
    await storageService.loadData();

    students = data
        .map<Student>(
          (e) => Student.fromJson(e),
    )
        .toList();

    filteredStudents =
        List.from(students);

    setState(() {});
  }

  Future<void> autoSave() async {

    await storageService.saveData(
      students
          .map((e) => e.toJson())
          .toList(),
    );
  }

  void search(String keyword) {

    setState(() {

      filteredStudents = students
          .where(
            (student) => student.name
            .toLowerCase()
            .contains(
          keyword.toLowerCase(),
        ),
      )
          .toList();
    });
  }

  void addStudent() {

    TextEditingController nameController =
    TextEditingController();

    TextEditingController ageController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Student"),

        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            TextField(
              controller:
              nameController,
              decoration:
              const InputDecoration(
                labelText: "Name",
              ),
            ),

            TextField(
              controller:
              ageController,
              decoration:
              const InputDecoration(
                labelText: "Age",
              ),
            ),
          ],
        ),

        actions: [

          TextButton(
            onPressed: () async {

              students.add(
                Student(
                  id:
                  students.length + 1,
                  name:
                  nameController.text,
                  age: int.parse(
                    ageController.text,
                  ),
                ),
              );

              filteredStudents =
                  List.from(students);

              await autoSave();

              setState(() {});

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void editStudent(Student student) {

    TextEditingController nameController =
    TextEditingController(
      text: student.name,
    );

    TextEditingController ageController =
    TextEditingController(
      text: student.age.toString(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Student"),

        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            TextField(
              controller:
              nameController,
            ),

            TextField(
              controller:
              ageController,
            ),
          ],
        ),

        actions: [

          TextButton(
            onPressed: () async {

              student.name =
                  nameController.text;

              student.age =
                  int.parse(
                    ageController.text,
                  );

              await autoSave();

              setState(() {});

              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void deleteStudent(Student student) async {

    students.remove(student);

    filteredStudents =
        List.from(students);

    await autoSave();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Student Manager"),
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: addStudent,
        child: const Icon(Icons.add),
      ),

      body: Column(

        children: [

          Padding(
            padding:
            const EdgeInsets.all(8),

            child: TextField(
              onChanged: search,

              decoration:
              const InputDecoration(
                hintText:
                "Search Student",
                prefixIcon:
                Icon(Icons.search),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(

              itemCount:
              filteredStudents.length,

              itemBuilder:
                  (context, index) {

                Student student =
                filteredStudents[
                index];

                return Card(

                  child: ListTile(

                    title:
                    Text(student.name),

                    subtitle: Text(
                      "Age: ${student.age}",
                    ),

                    trailing: Row(
                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                          ),
                          onPressed: () =>
                              editStudent(
                                student,
                              ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          onPressed: () =>
                              deleteStudent(
                                student,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}