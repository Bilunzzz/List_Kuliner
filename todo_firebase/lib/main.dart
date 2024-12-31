import 'package:flutter/material.dart';
import 'package:todo_firebase/database_helper.dart';
import 'package:todo_firebase/todo.dart';
import 'package:todo_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-ListKu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
    _searchController.addListener(_filterTodos);
  }

  void _loadTodos() async {
    List<Todo> todos = await _dbHelper.getAllTodos();
    setState(() {
      _todos = todos;
      _filteredTodos = todos;
    });
  }

  void _filterTodos() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTodos = [];
      } else {
        _filteredTodos = _todos.where((todo) {
          return todo.title.toLowerCase().contains(query) ||
              todo.description.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _addTodo() async {
    if (_titleController.text.isNotEmpty && _descController.text.isNotEmpty) {
      Todo newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        description: _descController.text,
      );
      await _dbHelper.insertTodo(newTodo);
      _titleController.clear();
      _descController.clear();
      _loadTodos();
      Navigator.pop(context);
    }
  }

  void _deleteTodo(int id) async {
    await _dbHelper.deleteTodo(id);
    _loadTodos();
  }

  void _toggleCompletion(Todo todo) async {
    todo.completed = !todo.completed;
    await _dbHelper.updateTodo(todo);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo-List App'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _filteredTodos.isEmpty
          ? const Center(child: Text('No todos found.'))
          : ListView.builder(
              itemCount: _filteredTodos.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = _filteredTodos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: todo.completed,
                        onChanged: (bool? value) {
                          _toggleCompletion(todo);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTodo(todo.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Tambah Todo'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: 'Judul todo'),
                    ),
                    TextField(
                      controller: _descController,
                      decoration:
                          const InputDecoration(hintText: 'Deskripsi todo'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Batalkan'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Tambah'),
                  onPressed: _addTodo,
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
