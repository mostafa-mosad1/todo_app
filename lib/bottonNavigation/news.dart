import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CUBIT_BLOC/cubit.dart';
import '../CUBIT_BLOC/states.dart';
import '../constant/constant.dart';
import '../widgets/Text_FormWidget.dart';

class news extends StatefulWidget {



  @override
  State<news> createState() => _newsState();
}

class _newsState extends State<news> {
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<appcubit,appStates>(
          listener:(BuildContext context,appStates state){},
    builder: (BuildContext context,appStates statee) {

   return ListView.separated(itemBuilder: (context, index) => activty( newTasks[index],context),
       separatorBuilder: (context, index) =>
           SizedBox(width: double.infinity,),
       itemCount: newTasks.length);
      });}
  }

