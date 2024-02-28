import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => DashboardState();

}

class DashboardState extends State<DashboardPage>{



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('My admin page', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
     ),
     body: Center(
       child: GridView.count(
         crossAxisCount: 2,
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
         shrinkWrap: true,
         children: [
           GestureDetector(
             onTap: (){},
             child: const Card(
               color: Colors.orangeAccent,
               elevation: 10,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.category,size: 50.0,),
                     Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                   ],
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: (){},
             child: const Card(
               color: Colors.orangeAccent,
               elevation: 10,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.set_meal,size: 50.0,),
                     Text('Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                   ],
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: (){},
             child: const Card(
               color: Colors.orangeAccent,
               elevation: 10,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.person,size: 50.0,),
                     Text('Delivery Men', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                   ],
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: (){},
             child: const Card(
               color: Colors.orangeAccent,
               elevation: 10,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.discount,size: 50.0,),
                     Text('Discount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                   ],
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: (){},
             child: const Card(
               color: Colors.orangeAccent,
               elevation: 10,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.verified_user,size: 50.0,),
                     Text('User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                   ],
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: (){},
             child: const Card(
               color: Colors.orangeAccent,
               elevation: 10,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.menu_book_outlined,size: 50.0,),
                     Text('Bills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                   ],
                 ),
               ),
             ),
           ),
         ]
       )
     ),
   );
  }

}