import 'package:flutter/material.dart';
import 'package:todo_list_app/models/todo_model.dart';

class TodosOverview extends StatelessWidget {
  final List<Todo> todos;

  const TodosOverview({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedTodosCount = todos
        .where((e) => e.completed)
        .length; //creates todos of only completed todos because we are checking if todos is completed
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Todos',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '$completedTodosCount of ${todos.length} completed',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
