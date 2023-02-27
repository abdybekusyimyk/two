import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/views/add_view.dart';

//=============================//
// CRUD

// Create
// Read
// Ubdate
// Delete

// try catch 
//============================//

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    readTodoes();
  }

  // Future<void> readTodoes() async {
  //   final db = FirebaseFirestore.instance;
  //   await db.collection("todoes").get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }

  Stream<QuerySnapshot> readTodoes() {
    final db = FirebaseFirestore.instance;
    return db.collection('todoes').snapshots();
  }

  Future<void> ubdateTodo(Todo todo) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection('todoes')
        .doc(todo.id)
        .update({'isselect': !todo.isselect});
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = FirebaseFirestore.instance;
    await db.collection('todoes').doc(todo.id).delete();
  }

  // Future<void> ubdateTodo(bool isselect) async {
  //   final db = FirebaseFirestore.instance;
  //   await db
  //       .collection('todoes')
  //       .doc('RAVknBRlBrRhnkG06uWz')
  //       .update({'isselect': false});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("widget.title"),
      ),
      body: StreamBuilder(
          stream: readTodoes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final List<Todo> todoes = snapshot.data!.docs
                  .map(
                    (e) => Todo.fromJson(
                      e.data() as Map<String, dynamic>,
                    )..id = e.id,
                  )
                  .toList();
              return ListView.builder(
                  itemCount: todoes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final todo = todoes[index];
                    return Card(
                      child: ListTile(
                        title: Text(todo.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: todo.isselect,
                              onChanged: (value) async {
                                await ubdateTodo(todo);
                              },
                            ),
                            IconButton(
                                onPressed: () async {
                                  await deleteTodo(todo);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(todo.decription ?? ""),
                              Text(todo.author)
                            ]),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text('Belgisiz kat'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddView()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
