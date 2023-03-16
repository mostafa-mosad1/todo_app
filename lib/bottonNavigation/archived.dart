import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CUBIT_BLOC/cubit.dart';
import '../CUBIT_BLOC/states.dart';
import '../constant/constant.dart';
import '../widgets/Text_FormWidget.dart';

class archived extends StatefulWidget {
  const archived({Key? key}) : super(key: key);

  @override
  State<archived> createState() => _archivedState();
}

class _archivedState extends State<archived> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit,appStates>(
        listener:(BuildContext context,appStates state){},
        builder: (BuildContext context,appStates statee) {

          return ListView.separated(itemBuilder: (context, index) => activty( archivedTasks[index],context),
              separatorBuilder: (context, index) =>
                  SizedBox(width: double.infinity,),
              itemCount: archivedTasks.length);
        });
  }
}
