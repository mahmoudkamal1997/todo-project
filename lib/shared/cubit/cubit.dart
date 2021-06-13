import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_project/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_project/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_project/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_project/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  bool isBottomSheetOpen = false;
  int PageIndex = 0;
  Database MyDatabase;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  List<Widget> Screens=[
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  void changeIndex(int index){
    PageIndex = index;
    emit(AppchangeBottomNavBarState());
  }

  void changeBottomsheetState(bool value)
  {
    isBottomSheetOpen =value;
    emit(AppChangeBottomSheetState());
  }


  void CreateDataBase() {

    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database,version){
        print('database Created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT )').then((value) => {
          print ('table Created')
        }).catchError((error){
          print('Error when Create table');
        });

      },
      onOpen: (database){
        print('opened database');
        getDataFromDatabase(database);
      },
    ).then((value){
      MyDatabase = value;
      emit(AppCreateDatabase());
    });
  }

  InsertToDatabase({@required String title,@required String time,@required String date,})async{
   await MyDatabase.transaction((txn)
    {
      txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")'
      ).then((value)
      {
        print('$value Row added success!!');
        emit(AppInsertInDatabase());
        getDataFromDatabase(MyDatabase);

      }).catchError((error){
        print('Error when add Row');
      });
      return null;
    });
  }

  void getDataFromDatabase(database)
  {
    emit(AppOnLoadingDataFromDatabase());
    database.rawQuery("SELECT * FROM tasks").then((value){
      newTasks = [];
      doneTasks = [];
      archiveTasks = [];
      value.forEach((element){
        if(element['status'] == 'new'){
          newTasks.add(element);
        }
        else if(element['status'] == 'done'){
          doneTasks.add(element);
        }
        else {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDataFromDatabase());
    });
  }

 updateTask({@required String status,@required int id})async{
    MyDatabase.rawUpdate("UPDATE tasks SET status = ? where id = ?",['$status', id])
    .then((value){
      emit(AppUpdateDataFromDatabase());
      getDataFromDatabase(MyDatabase);
    });
  }

  deleteTask({@required int id})async{
    MyDatabase.rawUpdate("DELETE FROM tasks where id = ?",[id])
        .then((value){
      emit(AppDeleteDataFromDatabase());
      getDataFromDatabase(MyDatabase);
    });
  }
}
