import 'package:flutter/material.dart';
import 'sgs_form.dart';
import 'xlsx_form.dart';
import 'file_list_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  @override
  _BottomNavbarScreenState createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int index = 0;
  List bodies = [
    FileListScreen(),
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
        selectedItemColor: index == 1
            ? Colors.red
            : index == 2
                ? Colors.green
                : Colors.blue,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Colors.green,
            ),
            label: "home",
          ),
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