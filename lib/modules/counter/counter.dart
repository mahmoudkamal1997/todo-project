import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_project/modules/counter/cubit/cubit.dart';
import 'package:todo_project/modules/counter/cubit/states.dart';


class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state){},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Counter'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){CounterCubit.get(context).Mines();}, child: Text('MINES')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('${CounterCubit.get(context).counter}',style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold),),
                ),
                TextButton(onPressed: (){CounterCubit.get(context).Plus(); }, child: Text('PLUS')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
