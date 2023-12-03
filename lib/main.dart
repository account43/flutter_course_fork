import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/models/todo_model.dart';
import 'package:flutter_course/widgets/todo_bottom_sheet.dart';
import 'package:flutter_course/widgets/todo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<TodoModel> todos = [];
  int todoNumber = 0;
  late SharedPreferences pref;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
    loadTodo();
  }

  Future<void> saveTodo() async {
    List<String> todoStringList = todos
        .map(
          (e) => json.encode(
            e.toJason(),
          ),
        )
        .toList();

    await pref.setStringList("todo", todoStringList);
  }

  Future<void> loadTodo() async {
    List<String>? todoStringList = pref.getStringList("todo");
    print(todoStringList);
    if (todoStringList == null) return;

    setState(() {
      todos = todoStringList
          .map(
            (e) => TodoModel.fromJson(
              json.decode(e),
            ),
          )
          .toList();
    });
  }

  void addTodoItem() async {
    showModalBottomSheet(
        context: context, builder: (contet) => TodoBottomSheet()).then(
      (value) async {
        setState(
          () {
            todos.add(TodoModel(text: value));
          },
        );
        await saveTodo();
      },
    );
  }

  void removeTodo(TodoModel todo) {
    setState(() {
      todos.removeWhere((element) => element.text == todo.text);
    });
  }

  void onTodoChange(TodoModel todo) async {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    await saveTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("To dO"),
        centerTitle: true,
        actions: [
          MaterialButton(
            color: Theme.of(context).primaryColor,
            shape: CircleBorder(),
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          IconButton(
            onPressed: addTodoItem,
            icon: Icon(
              Icons.add,
              color: Colors.amber,
              size: 25,
            ),
          ),
        ],
      ),
      body: todos.isEmpty
          ? Center(
              child: Text("Dodaj pierwsze todo"),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => TodoWidget(
                todo: todos[index],
                removeTodo: (TodoModel todo) {
                  removeTodo(todo);
                },
                onTodoChange: (TodoModel todo) {
                  onTodoChange(todo);
                },
              ),
            ),
    );
  }
}
