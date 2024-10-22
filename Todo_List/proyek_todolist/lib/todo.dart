class Todo {
  String nama;
  String deskripsi;
  bool done;

  Todo(this.nama, this.deskripsi, {this.done = false});

  static List<Todo> dummyData = [
    Todo("Membuat Aplikasi Todo List",
        "Membuat aplikasi todo list menggunakan Flutter"),
    Todo("Membuat Aplikasi Chat", "Membuat aplikasi chat menggunakan Flutter",
        done: true),
    Todo("Membuat Aplikasi E-Commerce",
        "Membuat aplikasi e-commerce menggunakan Flutter"),
  ];
}
