
import 'package:flutter/material.dart';

import '../pages/user_screen.dart';


class updateAdherants extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return updateAdherantsState();

  }
}

 class updateAdherantsState extends State<updateAdherants>{

   @override
   Widget build(BuildContext context) {

     return Scaffold(
       appBar: AppBar(
         title: const Text('Update Adherants'),
         leading: IconButton(
           icon: const Icon(
               Icons.arrow_back
           ), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
         },
         ),
       ),
     );
   }
 }

