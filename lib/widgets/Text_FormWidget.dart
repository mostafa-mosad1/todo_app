
import 'dart:io';

import 'package:database/CUBIT_BLOC/cubit.dart';
import 'package:flutter/material.dart';

Widget defultForm ({
  required  Controller,
   validator,
  labelText,
   ontap,
  hintText,
  prefixIcon,
  double circular=10,

})

=>TextFormField(

  keyboardType: TextInputType.emailAddress,
  controller: Controller ,
  validator: validator,
  onTap: ontap,
  decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circular),
          borderSide: BorderSide(color: Colors.redAccent))),
);

Widget activty (Map ali,context) => Dismissible(
  key: Key(ali["id"].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(8.0),
  
    child: Column(children: [Row(children: [CircleAvatar(radius: 35,child: Text("${ali["id"]}"),),
  
        Padding(
  
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
  
          child: Container(width:280 ,
  
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Row(children: [
  
              Expanded(child: Text("${ali["title"]}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
  
              IconButton(onPressed: (){
  
                appcubit.get(context).upDataToDataBase(status: "archive", id: ali["id"]);
  
              },color: Colors.teal ,icon: Icon(Icons.cloud_done)),
  
              IconButton(onPressed: (){
  
                appcubit.get(context).upDataToDataBase(status: "Done", id: ali["id"]);
  
              },color: Colors.green, icon: Icon(Icons.archive)),
  
  
  
            ],),
  
              SizedBox(height: 5,)
  
            ,Row(children: [
  
                Container(width: 8,height:8,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.cyan),),
  
                SizedBox(width: 9,),
  
              Expanded(child:Text("${ali["date"]}",style: TextStyle(fontSize: 20,color: Colors.grey),)),
  
            SizedBox(width: 9,),
  
                Container(width: 8,height:8,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.cyan),),
  
                SizedBox(width: 9,),
  
               Expanded(child:  Text("${ali["time"]}",style: TextStyle(fontSize: 20,color: Colors.grey)))])
  
            ],),
  
          ),
  
        )
  
      ],),
  
  
  
      SizedBox(height: 5,),Container(height: 1,width: 270,color: Colors.cyan,)],),
  
  ),
  onDismissed: (direction){
    appcubit.get(context).deleteToDataBase(id: (ali["id"]));
  },
);