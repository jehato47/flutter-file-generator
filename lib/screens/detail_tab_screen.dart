import 'package:flutter/material.dart';

class DetailTabScreen extends StatelessWidget {
  static const url = "detail-tab";
  const DetailTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // floatingActionButton: const FloatingButtons(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Sgs Düzenleyici"),
          bottom: TabBar(
            onTap: (index) {},
            tabs: const [
              Tab(text: "Pdf"),
              Tab(text: "Excel"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // DogsList(),
            Scaffold(),
            Scaffold(),
            // BreedsList(),
          ],
        ),
      ),
    );
  }
}
