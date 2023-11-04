
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/controller/store_hive/operetions.dart';
import 'package:todo_app/model/model.dart';

class DialogBox {
  static void show(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink[200],
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter the tittl';
                      } else {
                        return null;
                      }
                    },
                    controller:
                        Provider.of<CrudOpretion>(context, listen: false)
                            .titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a new task tittl",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please entert the tittle';
                      } else {
                        return null;
                      }
                    },
                    controller:
                        Provider.of<CrudOpretion>(context, listen: false)
                            .contentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a new task",
                    ),
                  ),
                  Consumer<CrudOpretion>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                value.addNote(Note(
                                    title: value.titleController.text.trim(),
                                    content:
                                        value.contentController.text.trim()));
                                value.titleController.text = '';
                                value.contentController.text = '';
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Save')),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}