import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/store_hive/operetions.dart';
import 'package:todo_app/model/model.dart';
import 'package:todo_app/view/presentetion/home_page/widgets/diolog_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, Key? ke});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('Todo'),
      ),
      body: Consumer<CrudOpretion>(
        builder: (context, value, child) => Container(
          decoration: const BoxDecoration(),
          child: FutureBuilder<List<Note>>(
            future: value.getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final notes = snapshot.data ?? [];
                // final currentDate =
                //     DateFormat('yyyy/MM/dd ').format(DateTime.now());

                if (notes.isEmpty) {
                  return Center(
                    child: Text(
                      'No notes available',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final note = snapshot.data![index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slidable(
                              direction: Axis.horizontal,
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        value.deleteNote(index);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ]),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.pink[200],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          note.content,
                                          // Add your content inside the container
                                        ),
                                      ),
                                    ),
                                    Checkbox(
                                      value: note.taskCompleted ?? false,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          // Provider.of<CrudOpretion>(context,listen: false).updateTaskCompletion(index, !note.isCompleted);
                                          
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.pink[200],
        onPressed: () {
          DialogBox.show(context);
        },
        label: Text(
          'Create Todo',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
