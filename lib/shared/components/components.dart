import 'package:flutter/material.dart';
import 'package:todo_project/shared/cubit/cubit.dart';

Widget buildTasksItem(Map task,context)=> Dismissible(
  key: Key(task['id'].toString()),
  child:   Card(

    elevation: 10,

    child: Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),

      child: Row(

        children: [

          CircleAvatar(

            radius: 35.0,

            child: Text('${task['time']}'),

          ),

          SizedBox(width: 15,),

          Expanded(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text('${task['title']}',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

                Text('${task['date']}',style: TextStyle(color: Colors.grey),),

              ],

            ),

          ),

          SizedBox(width: 15,),

          IconButton(

              icon: Icon(Icons.check_box,color: Colors.green,),

              onPressed: (){

                AppCubit.get(context).updateTask(status: 'done', id: task['id']);

              }

          ),

          IconButton(

              icon: Icon(Icons.archive,color: Colors.black45,),

              onPressed: (){

                AppCubit.get(context).updateTask(status: 'archive', id: task['id']);

              }

          ),

        ],

      ),

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteTask(id: task['id']);
  },
);


 Widget BuildEmptyScreen() => Center(
child: Text('No Tasks Yet, Please add some Tasks !',style: TextStyle(fontSize: 16,color: Colors.black45),),);