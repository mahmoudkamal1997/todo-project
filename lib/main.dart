import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/layouts/home_layout.dart';
import 'file:///F:/All%20Projects/flutter%20project%20review/todo_project/lib/modules/counter/counter.dart';
import 'package:todo_project/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:HomeLayout(),
    );
  }
}


