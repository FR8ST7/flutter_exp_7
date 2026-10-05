import 'dart:convert';
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management & JSON Serialization - Experiment 7',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const StateDemo(),
    );
  }
}

class StateDemo extends StatefulWidget {
  const StateDemo({super.key});

  @override
  State<StateDemo> createState() => _StateDemoState();
}

class _StateDemoState extends State<StateDemo> {
  // Step 6 - Create a list state for students
  final List<Student> _students = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  String _lastJsonOutput = '';
  String _deserializedName = '';
  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    // Step 3 - Create initial student object (Raj, CSE)
    _addStudent('Raj', 'CSE');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  // Step 6 - Add student and update state
  void _addStudent(String name, String course) {
    if (name.trim().isEmpty || course.trim().isEmpty) return;

    final newStudent = Student(
      id: _nextId++,
      name: name.trim(),
      course: course.trim(),
    );

    // Step 4 & 5 - Demonstrate JSON Serialization and Deserialization
    final Map<String, dynamic> jsonData = newStudent.toJson();
    final Student restoredStudent = Student.fromJson(jsonData);

    setState(() {
      _students.add(newStudent);
      _lastJsonOutput = jsonEncode(jsonData);
      _deserializedName = restoredStudent.name;
    });

    _nameController.clear();
    _courseController.clear();
  }

  void _removeStudent(int index) {
    setState(() {
      _students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'State & Serialization',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Experiment 7 Info',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Flutter Experiment 7',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.data_object, size: 40, color: Colors.teal),
                children: const [
                  Text('Aim: State Management and JSON Serialization'),
                  Text('Models Student data, converts toJson()/fromJson(), and updates state via setState().'),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Form Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.person_add, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Add Student Entry (State Change)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Student Name',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _courseController,
                            decoration: const InputDecoration(
                              labelText: 'Course Name',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        _addStudent(
                          _nameController.text.isNotEmpty ? _nameController.text : 'Raj',
                          _courseController.text.isNotEmpty ? _courseController.text : 'CSE',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Student to List (setState)', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Step 4 & 5 - JSON Serialization Inspector Card
            Card(
              elevation: 2,
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.code, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'JSON Serialization Log (Steps 4 & 5)',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'toJson() Map: $_lastJsonOutput',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'fromJson() Object Name: $_deserializedName',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Student State List (${_students.length})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                if (_students.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _students.clear();
                      });
                    },
                    icon: const Icon(Icons.clear_all, size: 18),
                    label: const Text('Clear All'),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Step 7 - Display list using ListView.builder inside height constraint
            _students.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: Text('No students in state. Click "Add Student" above!'),
                    ),
                  )
                : Container(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        final student = _students[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal,
                              child: Text(
                                '${student.id}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              student.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Course: ${student.course}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _removeStudent(index),
                            ),
                          ),
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
