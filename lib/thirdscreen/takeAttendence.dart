

import 'package:flutter/material.dart';
import 'package:the_attendence_manager_app/DatabaseDetails/databaseHelper.dart';
import 'package:the_attendence_manager_app/DatabaseDetails/database_client.dart';




class AttendenceTaker extends StatefulWidget {
  @override
  _AttendenceTakerState createState() => _AttendenceTakerState();
}

class _AttendenceTakerState extends State<AttendenceTaker> {



  var noe = DateTime.now();
  var db = new DatabaseHelper();
 // var db2 = new RegisHelper();
 
  final List<NoDoItem> _itemList = <NoDoItem>[];
  List<bool> cVal = [false];
  final List<int> idList = <int>[];

  @override
  void initState() {
    super.initState();

    _readNoDoList();
    _createList();

  }

  void _handleSubmitted(List val) async {
    for(int i =0; i<_itemList.length; i++){
      idList.add(_itemList[i].id);
    }
   // db2.saveItemChange(idList);


    for(int i =0 ; i < _itemList.length; i++){
      int f = 0;
      for(int j = 0; j < selectedList.length; j++){
        if(_itemList[i].id == selectedList[j]){
          await db.upDP(_itemList[i].id);
        //  await db2.upDP(_itemList[i].id, "day"+noe.day.toString() );
          f=1;
          break;
        }
      }
      if(f != 1){
        await db.upAP(_itemList[i].id);
      //  await db2.upDA(_itemList[i].id,"day"+noe.day.toString());
      }
    }




    Navigator.pop(context);
    Navigator.pop(context);


    setState(() {


    });



  }
  int k = 0;


  List<int> selectedList = [];



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Row(

        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),


                itemCount: _itemList.length,
                itemBuilder: (_, int index) {
                  return new Card(
                    color: Colors.white10,
                    child: new ListTile(
                        title: infoList(context, index),

                        trailing: new Checkbox(value: cVal[index], onChanged: (bool value) {
                          setState(() {
                            cVal[index] = value;
                            if(value == true){
                              selectedList.add(_itemList[index].id);
                            }
                            else{
                              selectedList.remove(_itemList[index].id);
                            }
                            print(selectedList);
                          });
                        },)
                    ),
                  );

                }),
          ),

          new Divider(
            height: 1.0,
          )
        ],
      ),


      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.redAccent,
          child: new ListTile(
            title: new Icon(Icons.subdirectory_arrow_left),
          ),
          onPressed: _showFormDialog),
    );

  }
  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Text("Do you want to submit?"),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmitted(cVal);


            },
            child: Text("Yes")),
        new FlatButton(onPressed: () => Navigator.pop(context),
            child: Text("Cancel"))

      ],
    );
    showDialog(context: context,
        builder:(_) {
          return alert;

        });
  }

  _readNoDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      // NoDoItem noDoItem = NoDoItem.fromMap(item);
      setState(() {
        _itemList.add(NoDoItem.map(item));
      });
      // print("Db items: ${noDoItem.itemName}");
    });

  }







  void _createList() {
    for(int i = 0; i < 100; i++){
      cVal.add(false);
    }
  }


  Widget infoList(BuildContext context, int index) {
    return new Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_itemList[index].itemName,
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.9
                ),),

              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text("Registration no.: ${_itemList[index].registrationNo} DP: ${_itemList[index].daysPresent} DA: ${_itemList[index].daysAbsent} TD: ${_itemList[index].totalDays}" ,
                  style: new TextStyle(
                      color:  Colors.white70,
                      fontSize: 10.0,
                      fontStyle:  FontStyle.italic
                  ),),

              )


            ],
          ),



        ],
      ),
    );
  }
}
