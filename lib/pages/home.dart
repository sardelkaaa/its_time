import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  BucketListHomePage createState() => BucketListHomePage();
}

class BucketListHomePage extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x202857FF),
      appBar: AppBar(
        backgroundColor: const Color(0x2857FF),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // Действие при нажатии на значок уведомлений
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            width: 400,
            height: 100,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4376DE),Color(0xFF0C508F)]
              ),
              borderRadius: BorderRadius.circular(35.0),
              color: Colors.grey[200],
            ),
            child: const Column(
              children: <Widget>[
                Text('Lorem ipsum')
              ],
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/allTasks'); // Действие при нажатии на список заданий
            },
            child: Container(
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
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');// Действие при нажатии на кружок с плюсом
        },
        backgroundColor: const Color(0x7DAFF5FF),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0x80AFF5FF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings'); // Действия при нажатии на иконку настроек
              },
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.pushNamed(context, '/history'); // Действия при нажатии на иконку истории
              },
            ),
          ],
        ),
      ),
    );
  }
}