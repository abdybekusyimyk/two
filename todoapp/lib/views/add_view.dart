import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final formKey = GlobalKey<FormState>();
  bool isselect = false;
  final title = TextEditingController();
  final decription = TextEditingController();
  final author = TextEditingController();

  Future<void> addTodo() async {
    final db = FirebaseFirestore.instance;
    final todo = Todo(
      title: title.text,
      decription: decription.text,
      isselect: isselect,
      author: author.text,
    );
    await db.collection('todoes').add(todo.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AddView')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bul Jerlerdi toltur';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: decription,
              maxLines: 7,
              decoration: const InputDecoration(
                hintText: 'Decription',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 60),
            CheckboxListTile(
                title: const Text('Belgile'),
                value: isselect,
                onChanged: (v) {
                  setState(() {
                    isselect = v ?? false;
                  });
                }),
            const SizedBox(height: 20),
            TextFormField(
              controller: author,
              decoration: const InputDecoration(
                hintText: 'Author',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bul Jerlerdi toltur';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const CupertinoAlertDialog(
                            title: Text('Kutuu'),
                            content: Padding(
                              padding: EdgeInsets.all(40.0),
                              child: CupertinoActivityIndicator(
                                radius: 30,
                                color: Colors.teal,
                              ),
                            ),
                          );
                        });
                    await addTodo();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
                icon: const Icon(Icons.publish),
                label: const Text('Add Todo'))
          ]),
        ),
      ),
    );
  }
}
