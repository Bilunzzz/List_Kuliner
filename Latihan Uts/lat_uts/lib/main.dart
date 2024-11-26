import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController judulCtrl = TextEditingController();
  TextEditingController isiCtrl = TextEditingController();
  List<Catatan> listCatatan = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Catatan pagi'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: judulCtrl,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Judul Catatan"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: isiCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "isi Catatan"),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 154, 89, 84),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        judulCtrl.clear();
                        isiCtrl.clear();
                      },
                      child: Text('Clear'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 85, 187, 224),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          listCatatan.add(Catatan(
                              judul: judulCtrl.text, isi: isiCtrl.text));
                          judulCtrl.clear();
                          isiCtrl.clear();
                        });
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: listCatatan.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text(listCatatan[index].judul),
                        subtitle: Text(listCatatan[index].isi),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                catatan: listCatatan[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Catatan {
  String judul;
  String isi;

  Catatan({required this.judul, required this.isi});
}

class DetailPage extends StatelessWidget {
  final Catatan catatan;

  DetailPage({required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catatan.judul),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catatan.judul,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              catatan.isi,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
