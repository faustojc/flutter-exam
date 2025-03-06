import 'package:flutter/material.dart';

class PersonInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PersonInfoCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    ),
  );
}
