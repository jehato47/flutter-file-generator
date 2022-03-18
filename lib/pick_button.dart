import 'package:flutter/material.dart';
import 'package:school_responsive/pick_contact_person.dart';

class PickButton extends StatelessWidget {
  const PickButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: PickContactPerson(),
            ),
          ),
        );
      },
      child: Text("pick"),
    );
  }
}
