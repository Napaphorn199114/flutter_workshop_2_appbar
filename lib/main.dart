import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Choice {
  final String title;
  final IconData icon;

  const Choice({required this.title, required this.icon});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String appTitle = "AppBar";
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(
        title: appTitle,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Choice _selectedChoice = choices[0]; //สร้างตัวแปรรับค่า ตั้งค่า default
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 50,  //shadow
        //titleSpacing: 150,  // title ขยับมาอยู่ตรงกลาง
        //centerTitle: true,
        //titleTextStyle: TextStyle(color: Colors.red,fontSize: 50),
        //iconTheme: IconThemeData(color: Colors.red, size: 50),
        leading: Icon(Icons.school),
        title: Text(widget.title),
        actions: [
          _buildActionButton(choices[0]),
          _buildActionButton(choices[1]),
          _buildPopupMenu(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _selectedChoice.icon,
              size: 120,
            ),
            Text(_selectedChoice.title),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(Choice item) {
    return IconButton(
      icon: Icon(item.icon),
      // iconSize: 50,
      // color: Colors.green,
      // highlightColor: Colors.red,
      // splashColor: Colors.cyan,
      //alignment: Alignment(0,0),  //ปรับตำแหน่ง Icon
      tooltip: item.title, //รับมาจาก choices[]
      onPressed: () {
        _select(item);
      },
    );
  }

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<Choice>(
      onSelected: _select,
      tooltip: "Menu",
      //คลิกปุ่มเมนูค้าง
      onCanceled: () => print("onCanceled"),
      //คลิก popup แต่ไม่เลือกอะไร
      icon: Icon(Icons.menu),
      itemBuilder: (context) {
        return choices.skip(2).map((Choice choice) {
          return PopupMenuItem<Choice>(
            //height: 150,
            //enabled: false,  //จะคลิกไม่ได้
            value: choice, //todo
            child: Text(choice.title),
            //child:Icon(choice.icon),
          );
        }).toList();
      },
    );
  }
}
