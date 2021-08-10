import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/models/todo_model.dart';
import 'package:todo_list_app/extensions/string_extension.dart';
import 'package:todo_list_app/screens/add_todo_screen.dart';
import 'package:todo_list_app/services/database_services.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback updateTodos;

  const TodoTile({Key? key, required this.todo, required this.updateTodos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedTextDecoration =
        !todo.completed ? TextDecoration.none : TextDecoration.lineThrough;
    return ListTile(
      key: Key(todo.id.toString()),
      title: Text(
        todo.name,
        style: TextStyle(fontSize: 18.0, decoration: completedTextDecoration),
      ),
      subtitle: Row(
        children: [
          Text(
            '${DateFormat.MMMMEEEEd().format(todo.date)} • ',
            style: TextStyle(height: 1.3, decoration: completedTextDecoration),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 8.0),
            decoration: BoxDecoration(
                color: _getColor(),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  )
                ]),
            child: Text(
              EnumToString.convertToString(todo.priorityLevel).capitalize(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  decoration: completedTextDecoration),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      trailing: Checkbox(
          value: todo.completed,
          activeColor: _getColor(),
          onChanged: (value) {
            DatabaseService.instance.update(todo.copyWith(completed: value));
            updateTodos();
          }),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => AddTodoScreen(updateTodos: updateTodos, todo: todo),
        ),
      ),
    );
  }

  Color _getColor() {
    switch (todo.priorityLevel) {
      case PriorityLevel.low:
        return Colors.green;
      case PriorityLevel.medium:
        return Colors.orange[600]!;
      case PriorityLevel.high:
        return Colors.red[400]!;
    }
  }
}
