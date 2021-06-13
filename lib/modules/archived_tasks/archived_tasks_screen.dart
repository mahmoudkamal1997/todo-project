import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_project/shared/components/components.dart';
import 'package:todo_project/shared/cubit/cubit.dart';
import 'package:todo_project/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return  BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){} ,
      builder:(context,state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return tasks.length == 0? BuildEmptyScreen() : ListView.builder(
          itemBuilder: (ctx, index) => buildTasksItem(tasks[index], context),
          itemCount: tasks.length,);
      }
    );
  }
}
