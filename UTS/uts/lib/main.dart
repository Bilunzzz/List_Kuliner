import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransactionPage(),
    );
  }
}

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Map<String, dynamic>> items = [
    {
      'name': 'Laptop',
      'price': 25000000,
      'quantity': 0,
      'controller': TextEditingController()
    },
    {
      'name': 'Mouse',
      'price': 1250000,
      'quantity': 0,
      'controller': TextEditingController()
    },
    {
      'name': 'Keyboard',
      'price': 1500000,
      'quantity': 0,
      'controller': TextEditingController()
    },
    {
      'name': 'Monitor',
      'price': 5000000,
      'quantity': 0,
      'controller': TextEditingController()
    },
    {
      'name': 'Printer',
      'price': 2200000,
      'quantity': 0,
      'controller': TextEditingController()
    },
  ];

  int totalPayment = 0;

  void reset() {
    setState(() {
      for (var item in items) {
        item['quantity'] = 0;
        item['controller'].text = '0'; // Atur TextField menjadi "0"
      }
      totalPayment = 0;
    });
  }

  void printReceipt() {
    int total = 0;
    if (items != null) {
      for (var item in items) {
        if (item != null &&
            item.containsKey('price') &&
            item.containsKey('quantity')) {
          total += (item['price'] as num).toInt() *
              (item['quantity'] as num).toInt();
        }
      }
    }
    setState(() {
      totalPayment = total;
    });
  }

  @override
  void dispose() {
    for (var item in items) {
      item['controller'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Center(child: Text('Toko Komputer', textAlign: TextAlign.center)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Harga: ${item['price']}'),
                    trailing: SizedBox(
                      width: 50,
                      child: TextField(
                        controller: item['controller'],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            item['quantity'] = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '0',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          isDense: true,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: reset,
            child: Text('Reset'),
          ),
          ElevatedButton(
            onPressed: printReceipt,
            child: Text('Cetak Struk'),
          ),
          Divider(),
          ...items
              .where((item) => item['quantity'] > 0)
              .map((item) => ListTile(
                    leading: Icon(Icons.computer),
                    title: Text(
                      item['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        'Kuantitas: ${item['quantity']} - Subtotal: ${item['quantity'] * item['price']}'),
                  ))
              .toList(),
          Container(
            width: 380,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 15, 178, 228),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Total Bayar: $totalPayment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
