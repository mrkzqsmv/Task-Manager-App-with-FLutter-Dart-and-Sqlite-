import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetailPage extends StatelessWidget {
  final String task;
  final int index;
  final Color color;
  const TaskDetailPage(
      {super.key,
      required this.task,
      required this.index,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: color.withOpacity(0.8),
          appBar: AppBar(
            backgroundColor: color.withOpacity(0.8),
            elevation: 0,
            title: Text(
              'Task Detail',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  task_number(),
                  const SizedBox(
                    height: 40,
                  ),
                  task_text(),
                  const SizedBox(
                    height: 40,
                  ),
                  go_back_button(context),
                ],
              ),
            ),
          )),
    );
  }

  AvatarGlow task_number() {
    return AvatarGlow(
                  child: Hero(
                    tag: index,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: color,
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
  }

  Text task_text() {
    return Text(
                  task.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
  }

  MaterialButton go_back_button(BuildContext context) {
    return MaterialButton(
                  minWidth: MediaQuery.of(context).size.width - 140,
                  height: 50,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Go Back',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                );
  }
}
