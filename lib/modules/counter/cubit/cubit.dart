import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_project/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  int counter = 1;

  CounterCubit(): super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  void Mines(){
    counter--;
    emit(CounterMinesState());
  }

  void Plus(){
    counter++;
    emit(CounterPlusState());
  }

}