import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';
import 'package:todo/network/local/cashe_helper.dart';

import '../config/themes/app_theme.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(intialState());

  late Database database;
  // deleteAll() async {
  //   await deleteDatabase('todo.db').then((value) => print('deleted'));
  // }

  createDataBase() async {
    //openDatabase(path,on create ,on open ) function that within it , we create db and create table an open db
    await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print(
          'db is created and given me object of it is called db and version $version ');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, isCompleted INTEGER ,isFavourite INTEGER  ,date TEXT, startTime TEXT, endTime TEXT ,color TEXT ,remind INTEGER ,repeat TEXT )')
          .then((value) => print('table is created'))
          .catchError((onError) {
        print('error is ${onError.toString()}');
      }); //create table
    }, onOpen: (db) {
      getDataFromDataBase(db);
      print('db is opened');
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String date,
      required String startTime,
      required String endTime,
      required String? color,
      required int? remind,
      required String? repeat,
      required int? isFavourit,
      required int? isCompleted}) {
    Task task = Task(
        title: title,
        date: date,
        startTime: startTime,
        endTime: endTime,
        color: color,
        remind: remind,
        repeat: repeat,
        isCompleted: isCompleted,
        isFavourite: isFavourit);

    database.transaction((txn) {
      // return txn.rawInsert(
      //     'INSERT INTO tasks(title, date, time , status) VALUES("$title", "$date" , "$time" , "new")');
      return txn.insert('tasks', task.toMap());
    }).then((value) {
      print('data inserted $value ');
      //emit(InsertDataBaseState());

      getDataFromDataBase(database);
    });
  }

  //TaskModel? allTasksModel;
  List<Task> allTasks = [];
  List<Task> completedTasks = [];
  List<Task> uncompletedTasks = [];
  List<Task> favouritesTasks = [];
  getDataFromDataBase(Database database) async {
    allTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favouritesTasks = [];

    await database.rawQuery("SELECT * FROM tasks").then((value) {
      //allTasksModel = TaskModel.fromMap(value);
      //  print(allTasksModel!.tasks![0].title);
      print(value);

      value.forEach((element) {
        allTasks.add(Task.fromMap(element));
        if (element['isCompleted'] == 1) {
          completedTasks.add(Task.fromMap(element));
        } else if (element['isCompleted'] == 0) {
          uncompletedTasks.add(Task.fromMap(element));
        }
        if (element['isFavourite'] == 1)
          favouritesTasks.add(Task.fromMap(element));
      });

      emit(GetFromDataBaseState());
    });
  }

  Future updateCompleted({required int isCompleted, required int id}) async {
    // Update some record
    await database.rawUpdate('UPDATE tasks SET isCompleted = ? WHERE id = ?',
        [isCompleted, id]).then((value) {
      getDataFromDataBase(database);
    });
  }

  Future updateFavourite({required int isFavourite, required int id}) async {
    // Update some record
    await database.rawUpdate('UPDATE tasks SET isFavourite = ? WHERE id = ?',
        [isFavourite, id]).then((value) {
      getDataFromDataBase(database);
    });
  }

  deleteTask({required int id}) async {
    // Update some record
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      //emit(DeleteDataBaseState());
      getDataFromDataBase(database);
    });
  }

  DateTime selectedDate = DateTime.now();
  getselectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    emit(GetselectedDateState());
  }

  ///TODO:this function that make filtration for tasks and Set tasks for each day , it is called when  state is GetFromDataBaseState or state is GetSelectedDate

  List<Task> filteredTasks = [];
  getTasksAfterFiltration() {
    filteredTasks = [];

    allTasks.forEach((element) {
      if (
          //Daily Condition
          (element.repeat == 'Daily' &&
                  (selectedDate.isAtSameMomentAs(DateFormat('yyyy-MM-dd')
                          .parse(element.date.toString())) ||
                      selectedDate.isAfter(DateFormat('yyyy-MM-dd')
                          .parse(element.date.toString())))) ||
              // if selected date equal task date
              element.date == DateFormat('yyyy-MM-dd').format(selectedDate) ||
              // wweekly condtion
              (element.repeat == 'Weekly' &&
                  selectedDate
                              .difference(DateFormat('yyyy-MM-dd')
                                  .parse(element.date.toString()))
                              .inDays %
                          7 ==
                      0) ||
              //monthly condtion
              (element.repeat == 'Monthly' &&
                  DateFormat('yyyy-MM-dd').parse(element.date.toString()).day ==
                      selectedDate.day)) {
        filteredTasks.add(element);
        emit(GetTasksAfterFiltrationState());
      }
    });
  }

//change themMode
  bool? isDark;
  changeThemeMode() {
    if (isDark == false || isDark == null) {
      isDark = true;
      setIsDarkToSharedPred(true);
    } else {
      isDark = false;
      setIsDarkToSharedPred(false);
    }
    emit(ChangeThemeModeState());
  }

  setIsDarkToSharedPred(bool isDark) {
    CashHelper.setData('isDark', isDark);
  }

  getIsDarkFromSharedPred() {
    isDark = CashHelper.getData('isDark');
    emit(GetIsDarkFromSharedPredState());
  }

  ThemeMode get themeMode => isDark == true ? ThemeMode.dark : ThemeMode.light;
}
