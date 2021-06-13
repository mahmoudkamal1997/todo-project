import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/shared/cubit/cubit.dart';
import 'package:todo_project/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener:(context,state){},
          builder:(context,state){
            AppCubit cubit = AppCubit.get(context);
             return  Scaffold(
              key: scaffoldKey,
              appBar: AppBar(title: Text(cubit.titles[cubit.PageIndex]),),
              body: state is AppOnLoadingDataFromDatabase? Center(child: CircularProgressIndicator(),):cubit.Screens[cubit.PageIndex],
              floatingActionButton: FloatingActionButton(
                child: cubit.isBottomSheetOpen ? Icon(Icons.add):Icon(Icons.edit),
                onPressed: (){
                  if(cubit.isBottomSheetOpen) {
                    if (formKey.currentState.validate()) {
                      cubit.InsertToDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text)
                          .then((value) {
                        Navigator.pop(context);
                      });

                    }
                  }
                  else{
                    scaffoldKey.currentState.showBottomSheet(
                            (context) {return Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(

                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator: (value){
                                    if(value.isEmpty)
                                      return 'Title must not be empty !';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Title',
                                    prefixIcon: Icon(Icons.title_outlined),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,

                                  onTap: (){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value){
                                      timeController.text = value.format(context).toString();
                                    });
                                  },
                                  validator: (value){
                                    if(value.isEmpty)
                                      return 'Time must not be empty !';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Time',
                                    prefixIcon: Icon(Icons.watch_later_outlined),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,

                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2021-07-01')
                                    ).then((value) {
                                      dateController.text = DateFormat.yMMMd().format(value);
                                    });

                                  },
                                  validator: (value){
                                    if(value.isEmpty)
                                      return 'Date must not be empty !';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Date',
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );},
                        elevation: 20.0
            ).closed.then((value) => cubit.changeBottomsheetState(false));

            cubit.changeBottomsheetState(true) ;

                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.PageIndex,
                onTap: (index){
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
                ],
              ),
            );
          },
      ),
    );
  }


}

