import 'package:flutter/material.dart';
import 'package:the_attendence_manager_app/thirdscreen/editDatabase.dart';
import 'package:the_attendence_manager_app/thirdscreen/takeAttendence.dart';
import 'package:the_attendence_manager_app/thirdscreen/viewDatabase.dart';

class OptionSelector extends StatefulWidget {
  @override
  _OptionSelectorState createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/classroom.jpg',
              height: 1200.0,
              width: 1200.0,
              fit: BoxFit.fill,),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 100, 50, 10),

              child: GridView.count(crossAxisCount: 2,
              mainAxisSpacing: 50,
              crossAxisSpacing: 100,
              children: <Widget>[
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: (){
                    var router = new MaterialPageRoute(builder: (BuildContext context){
                      return  new ViewDatabse();
                    });
                    Navigator.of(context).push(router);},child: Text("View Database",
                style: TextStyle(color: Colors.white),),
                ),
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: (){
                    var router = new MaterialPageRoute(builder: (BuildContext context){
                      return  new EditDatabase();
                    });
                    Navigator.of(context).push(router);},child: Text("Edit Database",
                  style: TextStyle(color: Colors.white),),
                ),
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: (){
                    var router = new MaterialPageRoute(builder: (BuildContext context){
                      return  new AttendenceTaker();
                    });
                    Navigator.of(context).push(router);},child: Text("Take Attendence",
                  style: TextStyle(color: Colors.white),),
                ),


              ],))
        ],
      ),
    );
  }
}


