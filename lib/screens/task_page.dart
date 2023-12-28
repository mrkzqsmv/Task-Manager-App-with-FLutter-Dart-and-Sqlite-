import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
  ];
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[400],
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Text(
            'To Do List',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 26,
            ),
          ),
          centerTitle: true,
          actions: [
            deleteAllTasksMethod(),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              textFormFieldMethod(context),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print('tiklandi');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailPage(
                              task: tasks[index],
                              index: index,
                              color: colors[index % colors.length],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color:
                                colors[index % colors.length].withAlpha(230),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Hero(
                                  tag: index,
                                  child: Text(
                                    '${index + 1}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                tasks[index].length > 20
                                    ? '${tasks[index].substring(0, 25)}...'
                                    : tasks[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              deleteTaskMethod(index),
                            ],
                          ),
                        ),
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

  Padding textFormFieldMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: taskController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          labelText: 'Task',
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
          hintText: 'Enter your task',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: addTaskMethod(context),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  IconButton deleteAllTasksMethod() {
    return IconButton(
      onPressed: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: const Center(
            child: Text(
              'Are you sure you want to remove all tasks?',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelOnPress: () {
            debugPrint('canceled');
            taskController.clear();
          },
          btnOkOnPress: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              tasks.clear();
              prefs.clear();
            });
          },
        ).show();
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      tooltip: 'Delete all tasks',
    );
  }

  IconButton addTaskMethod(BuildContext context) {
    return IconButton(
      onPressed: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.question,
          body: const Center(
            child: Text(
              'Are you sure you want to add this task?',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelOnPress: () {
            debugPrint('canceled');
            taskController.clear();
          },
          btnOkOnPress: () async{
            final SharedPreferences prefs =
                await  SharedPreferences.getInstance();
            if (_formKey.currentState!.validate()) {
              setState(() {
                tasks.add(taskController.text);
                prefs.setStringList('tasks', tasks);
                taskController.clear();
              });
            }
          },
        ).show();
      },
      icon: const CircleAvatar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.done),
      ),
    );
  }

  IconButton deleteTaskMethod(int index) {
    return IconButton(
      onPressed: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.info,
          body: const Center(
            child: Text(
              'Are you sure you want to remove this task?',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelOnPress: () {
            debugPrint('canceled');
            taskController.clear();
          },
          btnOkOnPress: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              tasks.removeAt(index);
              prefs.setStringList('tasks', tasks);  
            });
          },
        ).show();
      },
      icon: const CircleAvatar(
        radius: 20,
        foregroundColor: Colors.red,
        child: Icon(
          Icons.delete,
        ),
      ),
      tooltip: 'Delete task',
    );
  }
}
