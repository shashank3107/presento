import 'package:the_attendence_manager_app/ui/option selector.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[

            new Center(
              child: new Image.asset('images/start.gif',
                height: 1200.0,
                width: 1200.0,
                fit: BoxFit.fill,),
            ),

            Positioned(
             right: 0,
              top:50,
              height: 100,
              width: 300 ,

              child:new Image.asset('images/tittle.png',
              )
            ),

            Positioned(
              left: 140,
              bottom:50,

              child: Container(

                child: FlatButton(onPressed: (){
                  var router = new MaterialPageRoute(builder: (BuildContext context){
                    return  new OptionSelector();
                  });
                  Navigator.of(context).push(router);
                },color: Colors.greenAccent,
                    autofocus: true,
                    child: Text("Tap to continue"),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white)
                  ),),
              ),
            )
          ],
        )

    );
  }
}
