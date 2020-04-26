

import 'package:flutter/material.dart';
import 'package:the_attendence_manager_app/DatabaseDetails/databaseHelper.dart';
import 'package:the_attendence_manager_app/DatabaseDetails/database_client.dart';



class ViewDatabse extends StatefulWidget {
  @override
  _ViewDatabseState createState() => _ViewDatabseState();
}

class _ViewDatabseState extends State<ViewDatabse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Database"),
      ),
      body: new EditBodyScreen(),
    );
  }
}

class EditBodyScreen extends StatefulWidget {
  @override
  _EditBodyScreenState createState() => _EditBodyScreenState();
}

class _EditBodyScreenState extends State<EditBodyScreen> {

  final TextEditingController _textEditingController = new TextEditingController();
  final TextEditingController _textEditingController2 = new TextEditingController();
  var db = new DatabaseHelper();

  final List<NoDoItem> _itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();

    _readNoDoList();
  }

  void _handleSubmitted(String text) async {
    String text2 = _textEditingController2.text.toString();
    _textEditingController.clear();
    _textEditingController2.clear();

    NoDoItem noDoItem = new NoDoItem(text,text2,0,0,0);
    int savedItemId = await db.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(savedItemId);




    setState(() {
      _itemList.insert(0, addedItem);

    });


    print("Item saved id: $savedItemId");
    var now = DateTime.now();

    print(now.month);
  }

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
                      title: infoList(context,index),
                      onTap: (){
                       /* var router = new MaterialPageRoute(builder: (BuildContext context){
                          return  new ViewByID(id:_itemList[index].id);
                        });
                        Navigator.of(context).push(router);*/
                      },
                      trailing: new Text(((_itemList[index].daysPresent/_itemList[index].totalDays)*100).toStringAsFixed(2)+"%",
                        style: TextStyle(
                            color: Colors.greenAccent
                        ),),
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
            title: new Icon(Icons.add),
          ),
          onPressed: _showFormDialog),
    );

  }
  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Column(
        children: <Widget>[
          new TextField(
            controller: _textEditingController,
            autofocus: true,

            decoration: new InputDecoration(
                labelText:  "Name",
                hintText: "eg. Shashank Singh",
                icon: new Icon(Icons.person)),
          ),


          new TextField(
            controller: _textEditingController2,
            autofocus: true,

            decoration: new InputDecoration(
                labelText:  "Reg. No.",
                hintText: "eg. 3500011D",
                icon: new Icon(Icons.update)),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text("Save")),
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


