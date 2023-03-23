import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqflite/db/db_provider.dart';
import 'package:flutter_sqflite/ui/bottom_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FutureBuilder<List<Todo?>> _getData(BuildContext context) {
    final db = TodoProvider();
    return FutureBuilder<List<Todo?>>(
      future: db.getAllTodo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Todo?> todos = snapshot.data!;
          return _buildNotes(context, todos);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildNotes(BuildContext context, List<Todo?> todo) {
    if (todo.isEmpty) {
      return Center(child: Text("No notes"));
    }
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: todo.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo[index]?.title ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    callSetState() {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: _getData(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottom(context, callSetState);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
