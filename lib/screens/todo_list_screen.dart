import 'package:flutter/material.dart';
import 'package:todo_list_app/models/todo_model.dart';
import 'package:todo_list_app/screens/add_todo_screen.dart';
import 'package:todo_list_app/services/database_services.dart';
import 'package:todo_list_app/widgets/todo_tile.dart';
import 'package:todo_list_app/widgets/todos_overview.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _getTodos() async {
    final todos = await DatabaseService.instance.getAllTodos();
    if (mounted) {
      setState(() => _todos = todos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 1 + _todos.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return TodosOverview(todos: _todos);
              final todo = _todos[index - 1];
              return TodoTile(
                todo: todo,
                updateTodos: _getTodos,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddTodoScreen(
              updateTodos: _getTodos,
            ),
            fullscreenDialog: true,
          ),
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
