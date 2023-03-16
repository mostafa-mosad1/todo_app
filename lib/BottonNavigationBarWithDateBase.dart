

import 'package:database/CUBIT_BLOC/cubit.dart';
import 'package:database/CUBIT_BLOC/states.dart';
import 'package:database/widgets/Text_FormWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'constant/constant.dart';


class home3 extends StatelessWidget

 {
   var titleController = TextEditingController();
   var dateController = TextEditingController();
   var timeController = TextEditingController();
   var scafflodKey = GlobalKey<ScaffoldState>();
   var formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=> appcubit()..createDatabase(),

      child: BlocConsumer<appcubit,appStates>(
        listener:(BuildContext context,appStates state){
          if(state is insertDataBaseState){Navigator.pop(context);}
        },
        builder: (BuildContext context,appStates statee){
          return Scaffold(
            key: scafflodKey ,

            appBar: AppBar(
              title: Text(
                  appcubit.get(context).titlePages[appcubit.get(context).currentIndex]
              ),
            ),
            body: appcubit.get(context).pages[appcubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(onPressed: ()  {
              if(appcubit.get(context).iconShow||appcubit.get(context).isShowBottomSheet){
                if(formKey.currentState!.validate()){

                appcubit.get(context).changeIcons(ShowBottomSheet: false, iconBool:false, icon: Icons.add);

               appcubit.get(context). insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);


                  // insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text).then((value)
                  // {
                  //   getFormDataBase (database).then((value)
                  //   {Navigator.pop(context);
                  //     // setState(() {
                  //     //    isShowBottomSheet= false;
                  //     //   show=Icons.edit_outlined;
                  //     //   tasks = value;
                  //     // });
                  //   });
                  //
                  // });
                }}
              else{
                appcubit.get(context).changeIcons(ShowBottomSheet: false, iconBool:true, icon: Icons.add); //if(formKey.currentState!.validate()){}else{}

                scafflodKey.currentState!.showBottomSheet((context) => Form(key:formKey ,
                  child: Column(mainAxisSize:MainAxisSize.min,children: [
                    defultForm(Controller:titleController,validator:( value)=>value.isEmpty?"please enter name task":null,labelText: "NEW TASKS",prefixIcon: Icons.task_alt_outlined,circular: 25),
                    SizedBox(height: 8,),
                    defultForm(Controller:timeController,validator:( value)=>value.isEmpty?"please enter time":null,labelText: "Time",prefixIcon: Icons.watch_later_outlined,circular: 25,ontap: (){showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) { timeController.text = value!.format(context);});}),
                    SizedBox(height: 8,),
                    defultForm(Controller:dateController,labelText: "Date TASKS",prefixIcon: Icons.date_range_outlined,circular: 25,ontap: (){showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate:DateTime(2023) ).then((value) {dateController.text = DateFormat().add_yMMMEd().format(value!);});})

                  ],),
                )).closed.then((value) {
                appcubit.get(context).changeIcons(ShowBottomSheet: false, iconBool:false, icon: Icons.edit_outlined);
                });
                appcubit.get(context). isShowBottomSheet= true;
                print(titleController.text);print(timeController.text);print(dateController.text);
              }



            },child: Icon(appcubit.get(context).show),),


            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: appcubit.get(context).currentIndex ,
              onTap: (index){
               appcubit.get(context).changeIndex(index);
              },


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
        },

      ),
    );
  }

  Future<List<Map>> getDataBase (database) async {
    return await database.rawQuery(' * FROM tasks') ;
  }

}



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