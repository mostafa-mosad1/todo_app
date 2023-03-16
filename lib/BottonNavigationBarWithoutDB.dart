import 'package:database/bottonNavigation/archived.dart';
import 'package:database/bottonNavigation/done.dart';
import 'package:database/widgets/Text_FormWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'bottonNavigation/news.dart';

class home2 extends StatefulWidget {
  const home2({Key? key}) : super(key: key);

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  int currentIndex= 0;
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var scafflodKey = GlobalKey<ScaffoldState>();
  bool isShowBottomSheet = false;
  bool iconShow = false;
  IconData show = Icons.edit_outlined;


  List pages =[news(),archived(),done()];
  List<String> titlePages =["NEW TASKS","Done TASKS","Archived TASKS"];
  @override
  void initState() {
    //createDatebase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafflodKey ,

      appBar: AppBar(
        title: Text(
            titlePages[currentIndex]
        ),
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(onPressed: ()  {
        if(iconShow){setState(() {
          show=show;      });}else{
          setState(() {
            show = Icons.add;
          });
          if(isShowBottomSheet){ Navigator.pop(context); isShowBottomSheet= false;}
          else{scafflodKey.currentState!.showBottomSheet((context) => Column(mainAxisSize:MainAxisSize.min,children: [
            defultForm(Controller:titleController,labelText: "NEW TASKS",prefixIcon: Icons.task_alt_outlined,circular: 25),
            SizedBox(height: 8,),
            defultForm(Controller:timeController,labelText: "Time",prefixIcon: Icons.watch_later_outlined,circular: 25,ontap: (){showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) { timeController.text = value!.format(context);});}),
            SizedBox(height: 8,),
            defultForm(Controller:dateController,labelText: "Date TASKS",prefixIcon: Icons.date_range_outlined,circular: 25,ontap: (){showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate:DateTime(2023) ).then((value) {dateController.text = DateFormat().add_yMMMEd().format(value!);});})

          ],));isShowBottomSheet= true;
          print(titleController.text);print(timeController.text);print(dateController.text);}
        }



      },child: Icon(show),),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex ,
        onTap: (index){setState(() {
          currentIndex =index;
        });},


        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),
    );
  }
  void createDatebase (){
    var datebase = openDatabase(
        "todi.db",version: 1,
        onCreate: (datebase,version) async {
          print("database create");
          await datebase.execute(
              'CREATE TABLE tasts (id INTEGER PRIMARY KEY, title TEXT, date TEXT, status TEXT )').then((value)
          {
            print("tabe is create");
          });
        },
        onOpen: (database){print("database open");}
    );


  }
// Column(children: [
//         defultForm(Controller:titleController,labelText: "NEW TASKS",prefixIcon: Icons.task_alt_outlined,circular: 25 )
//       ],)
}


// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7. delete from database
// condition
/*
// Get a location using getDatabasesPath
var databasesPath = await getDatabasesPath();
String path = join(databasesPath, 'demo.db');

// Delete the database
await deleteDatabase(path);

// open the database
Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
  await db.execute(
      'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
});

// Insert some records in a transaction
await database.transaction((txn) async {
  int id1 = await txn.rawInsert(
      'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
  print('inserted1: $id1');
  int id2 = await txn.rawInsert(
      'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
      ['another name', 12345678, 3.1416]);
  print('inserted2: $id2');
});

// Update some record
int count = await database.rawUpdate(
    'UPDATE Test SET name = ?, value = ? WHERE name = ?',
    ['updated name', '9876', 'some name']);
print('updated: $count');

// Get the records
List<Map> list = await database.rawQuery('SELECT * FROM Test');
List<Map> expectedList = [
  {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
  {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
];
print(list);
print(expectedList);
assert(const DeepCollectionEquality().equals(list, expectedList));

// Count the records
count = Sqflite
    .firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
assert(count == 2);

// Delete a record
count = await database
    .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
assert(count == 1);

// Close the database
await database.close();
 */
