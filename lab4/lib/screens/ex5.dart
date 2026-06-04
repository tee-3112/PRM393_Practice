import 'package:flutter/material.dart';

class Ex5 extends StatefulWidget {
  const Ex5({super.key});

  @override
  State<Ex5> createState() => _Ex5State();
}

class _Ex5State extends State<Ex5> {
  int counter = 0;
  DateTime? selectedDate;

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = List.generate(
      20,
          (index) => "Item ${index + 1}",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 5 - Fix UI Errors"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Common Flutter Fixes",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "Counter: $counter",
                style: const TextStyle(fontSize: 20),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
                child: const Text("Increase Counter"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: selectDate,
                child: const Text("Pick Date"),
              ),

              const SizedBox(height: 10),

              Text(
                selectedDate == null
                    ? "No date selected"
                    : "Selected: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),

              const SizedBox(height: 20),

              const Text(
                "ListView inside Column Fixed",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.list),
                        title: Text(items[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}