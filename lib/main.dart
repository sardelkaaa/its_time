import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BucketListHomePage(),
    );
  }
}

class BucketListHomePage extends StatelessWidget {
  const BucketListHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Действие при нажатии на значок уведомлений
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
              color: Colors.grey[200],
            ),
            child: const Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar( // Маркер в виде оранжевого круга
                    radius: 12.0,
                    backgroundColor: Colors.orange,
                  ),
                  title: Text('Lorem ipsum'),
                ),
                ListTile(
                  leading: CircleAvatar( // Маркер в виде оранжевого круга
                    radius: 12.0,
                    backgroundColor: Colors.orange,
                  ),
                  title: Text('Lorem ipsum'),
                ),
                ListTile(
                  leading: CircleAvatar( // Маркер в виде оранжевого круга
                    radius: 12.0,
                    backgroundColor: Colors.orange,
                  ),
                  title: Text('Lorem ipsum'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Действие при нажатии на кружок с иконкой истории
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Действия при нажатии на иконку настроек
              },
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                // Действия при нажатии на иконку истории
              },
            ),
          ],
        ),
      ),
    );
  }
}