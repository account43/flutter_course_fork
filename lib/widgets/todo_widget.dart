import 'package:flutter/material.dart';
import 'package:flutter_course/models/todo_model.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    super.key,
    required this.todo,
    required this.removeTodo,
    required this.onTodoChange,
  });

  final TodoModel todo;
  final void Function(TodoModel todo) removeTodo;
  final void Function(TodoModel todo) onTodoChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (value) {
              onTodoChange(todo);
            },
          ),
          title: Text(todo.text),
          trailing: IconButton(
            onPressed: () {
              removeTodo(todo);
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
