import 'package:flutter/material.dart';

class GithubIssueScreen extends StatelessWidget {
  GithubIssueScreen({super.key});

  final List<String> items = List.generate(30, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView with Keyboard Issue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              subtitle: index == 5
                  ? const TextField(
                      decoration: InputDecoration(labelText: 'Enter text'),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
