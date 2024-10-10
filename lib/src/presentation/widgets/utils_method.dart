import 'dart:io';


import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';




class UtilsMethod {
  static DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");




  static  profileRoute(BuildContext context,String  userId) async{
    try {
      if(userId!=null)
      {
        final userIdLocal=await SharedPrefUtils.getUserId();
        if(userIdLocal!=userId)
        {
        //  context.push(MyRoutes.OTHER_PROFILE_SCREEN,extra: userId);
        }
        else{
        //  context.push(MyRoutes.MYPROFILLE);
        }


      }
    } on Exception catch (e) {
      return e.toString();
    }
  }





 static Stream<int> counterStream() async* {
   int count =1;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 10));
      count=count+2;
      yield count;
    }
  }






}
