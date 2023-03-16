import 'package:bloc/bloc.dart';
import 'package:database/CUBIT_BLOC/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../bottonNavigation/archived.dart';
import '../bottonNavigation/done.dart';
import '../bottonNavigation/news.dart';
import '../constant/constant.dart';

class appcubit extends Cubit<appStates>{
  appcubit():super(initalState());

  static appcubit get(context) => BlocProvider.of(context);
  int currentIndex= 0;



  List pages =[news(),archived(),done()];
  List<String> titlePages =["NEW TASKS","Done TASKS","Archived TASKS"];

  void changeIndex (int index)
  {
    currentIndex = index;
    emit(changeNavigtionBar());
  }
  late Database database;

  void createDatabase() async {
    database = await openDatabase(
      'mansoura.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
         getFormDataBase (database);
        print('database opened');

      },
    ).then((value) =>
      database = value
     // emit(createDataBaseState());


    );
  }


  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn)  =>

        txn
            .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")',
        )
            .then((value) {
          print('$value inserted successfully');
          getFormDataBase (database);
          emit(insertDataBaseState());
        }).catchError((error) {
          print('Error When Inserting New Record ${error.toString()}');
        })


    );
  }

  void getFormDataBase (database)  {
     database.rawQuery('SELECT * FROM tasks').then((value)
    {

      newTasks=[];
      doneTasks=[];
      archivedTasks=[];
      value.forEach((element) {

        if(element["status"] == 'new'){newTasks.add(element);}
        else if(element["status"] == 'Done'){doneTasks.add(element);}
        else archivedTasks.add(element);


      });
      emit(getDataBaseState());
    }) ;
  }






  void upDataToDataBase({
    required String status,
    required int id})  async {
     await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id ]);
     getFormDataBase(database);
     emit( upDataDataBaseState());
  }

  void deleteToDataBase({
    required int id})  async {
    await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);

    getFormDataBase(database);
    emit(deleteDataBaseState());
  }

  bool isShowBottomSheet = false;
  bool iconShow = false;
  IconData show = Icons.edit_outlined;

  void changeIcons({required ShowBottomSheet,required iconBool,required icon})
  {
    isShowBottomSheet=ShowBottomSheet;
    iconShow=iconBool;
    show=icon;
    emit(changeIconSheet());

  }
}