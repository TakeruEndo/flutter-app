import 'package:flutter/material.dart';

class CustomScreen extends StatefulWidget {

  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }  

  List<Widget> _widgetOptions = <Widget>[
    todayCardList(),

    Text(
      'Index 2: School',
    ),
  ];

  static Widget todayCardList(){
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text("2019/01/23"),
            subtitle: Text("今日の最大のタスク"),
            trailing: Icon(Icons.arrow_right),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text("Today's_work"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            title: Text('Past_Work'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/create_task');
        },
        label: Text("Get Today's Task!"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      )
    );
  }
}