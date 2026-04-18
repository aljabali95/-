
import 'dart:io';
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../utils/invoice.dart';

class HomePage extends StatefulWidget {
  final String role;
  HomePage({required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cars = [];
  List filtered = [];

  load() async {
    cars = await DBHelper().getCars();
    filtered = cars;
    setState(() {});
  }

  search(String v) {
    filtered = cars.where((c) =>
      c['plate'].toString().contains(v)
    ).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مغسلة الباب الحديثة')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: 'بحث برقم اللوحة'
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (c,i){
                return ListTile(
                  title: Text(filtered[i]['plate']),
                  subtitle: Text(filtered[i]['price']),
                  trailing: IconButton(
                    icon: Icon(Icons.print),
                    onPressed: () => printInvoice(filtered[i]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
