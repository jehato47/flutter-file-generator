import 'package:flutter/material.dart';
import 'sgs_form.dart';
import 'xlsx_form.dart';

class BottomNavbarScreen extends StatefulWidget {
  @override
  _BottomNavbarScreenState createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int index = 0;
  List bodies = [
    SgsForm(),
    XlsxForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Sgs Generator"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: index == 0 ? Colors.red : Colors.green,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              // color: Colors.red,
            ),
            label: "pdf",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              // color: Colors.green,
            ),
            label: "xlsx",
          ),
        ],
      ),
      body: bodies[index],
    );
  }
}
