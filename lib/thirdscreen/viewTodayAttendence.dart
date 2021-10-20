
// import 'package:attendence_taker_complete/regisDatabase/regisHelper.dart';
// import 'package:attendence_taker_complete/regisDatabase/regis_client.dart';
// import 'package:flutter/material.dart';
// import 'package:attendence_taker_complete/DatabaseDetails/databaseHelper.dart';
// import 'package:attendence_taker_complete/DatabaseDetails/database_client.dart';




// class TodayAttendence extends StatefulWidget {
//   @override
//   _TodayAttendenceState createState() => _TodayAttendenceState();
// }

// class _TodayAttendenceState extends State<TodayAttendence> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Database"),
//       ),
//       body: new EditBodyScreen(),
//     );
//   }
// }

// class EditBodyScreen extends StatefulWidget {
//   @override
//   _EditBodyScreenState createState() => _EditBodyScreenState();
// }

// class _EditBodyScreenState extends State<EditBodyScreen> {


//   var db = new RegisHelper();
//   var db2 = new DatabaseHelper();

//   final List<RegisItem> _itemList2 = <RegisItem>[];
//   final List<NoDoItem> _itemList = <NoDoItem>[];

//   @override
//   void initState() {
//     super.initState();

//     _readNoDoList();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Colors.black87,
//       body: new Row(

//         children: <Widget>[
//           new Flexible(
//             child: new ListView.builder(
//                 padding: new EdgeInsets.all(8.0),


//                 itemCount: _itemList2.length,
//                 itemBuilder: (_, int index) {
//                   return new Card(
//                     color: Colors.white10,
//                     child: new ListTile(
//                       title: infoList(context,index),

//                       trailing: new Text("${_itemList2[index].Haha(DateTime.now().day)}"),
//                     ),
//                   );

//                 }),
//           ),

//           new Divider(
//             height: 1.0,
//           )
//         ],
//       ),



//     );

//   }


//   _readNoDoList() async {
//     List items = await db.getItems();
//     List items2 = await db2.getItems();
//     items2.forEach((items2) {
//       _itemList.add(NoDoItem.map(items2));
//     } );

//     items.forEach((item) {
//       // NoDoItem noDoItem = NoDoItem.fromMap(item);
//       setState(() {
//    //
//         _itemList2.add(RegisItem.map(item));
//       });
//       // print("Db items: ${noDoItem.itemName}");
//     });

//   }




//   Widget infoList(BuildContext context, int index) {
//     return new Container(
//       margin: const EdgeInsets.all(8.0),
//       child: new Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           new Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               new Text(_itemList[index].itemName,
//                 style: new TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16.9
//                 ),),

//             /*  new Container(
//                 margin: const EdgeInsets.only(top: 5.0),
//                 child: new Text("Registration no.: ${_itemList2[index].id} DP: ${_itemList2[index].id} DA: ${_itemList2[index].id} TD: ${_itemList2[index].id}" ,
//                   style: new TextStyle(
//                       color:  Colors.white70,
//                       fontSize: 10.0,
//                       fontStyle:  FontStyle.italic
//                   ),),

//               )*/


//             ],
//           ),



//         ],
//       ),
//     );
//   }
// }


