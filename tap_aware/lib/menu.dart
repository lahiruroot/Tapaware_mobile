import 'package:flutter/material.dart';

Widget menu(context) {
  Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.arrow_drop_down_circle),
          title: const Text('Card title 1'),
          subtitle: Text(
            'Secondary Text',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              // textColor: const Color(0xFF6200EE),
              onPressed: () {
                // Perform some action
              },
              child: const Text('ACTION 1'),
            ),
            ElevatedButton(
              // textColor: const Color(0xFF6200EE),
              onPressed: () {
                // Perform some action
              },
              child: const Text('ACTION 2'),
            ),
          ],
        ),
        // Image.asset('assets/card-sample-image.jpg'),
        // Image.asset('assets/card-sample-image-2.jpg'),
      ],
    ),
  );
}
