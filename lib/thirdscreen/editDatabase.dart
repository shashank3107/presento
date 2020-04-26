
import 'package:flutter/material.dart';
import 'package:the_attendence_manager_app/DatabaseDetails/databaseHelper.dart';
import 'package:the_attendence_manager_app/DatabaseDetails/database_client.dart';



class EditDatabase extends StatefulWidget {
  @override
  _EditDatabaseState createState() => _EditDatabaseState();
}

class _EditDatabaseState extends State<EditDatabase> {
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
//  var db2 = new RegisHelper();

  final List<NoDoItem> _itemList = <NoDoItem>[];
//  final List<RegisItem> _itemList2 = <RegisItem>[];

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
   // RegisItem regisItem = new RegisItem(savedItemId,'N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N');
  //  int lol = await db2.saveItem(savedItemId);
    NoDoItem addedItem = await db.getItem(savedItemId);
    //RegisItem addoItem = await db2.getItem(savedItemId);




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
                      onLongPress: () => _udateItem(_itemList[index], index),
                      trailing: new Listener(
                        key: new Key(_itemList[index].itemName),
                        child:  new Icon(Icons.remove_circle,
                          color: Colors.redAccent,),
                        onPointerDown: (pointerEvent) =>
                            _deleteNoDo(_itemList[index].id, index),
                      ),
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
        //_itemList2.add(RegisItem.map(item));
      });
      // print("Db items: ${noDoItem.itemName}");
    });

  }

  _deleteNoDo(int id, int index) async {
    debugPrint("Deleted Item!");

    await db.deleteItem(id);
   // await db2.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
      //_itemList2.removeAt(index);

    });


  }

  _udateItem(NoDoItem item, int index) {
    var alert = new AlertDialog(
      title: new Text("Update Item"),
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
            onPressed: () async {
              NoDoItem newItemUpdated = NoDoItem.fromMap(
                  {"itemName": _textEditingController.text,
                   /* "dateCreated" : dateFormatted(),*/
                    "registrationNO" : _textEditingController2.text,
                    "id" : item.id
                  });

              _handleSubmittedUpdate(index, item);//redrawing the screen
              await db.updateItem(newItemUpdated); //updating the item
              setState(() {
                _readNoDoList(); // redrawing the screen with all items saved in the db
              });

              Navigator.pop(context);

            },
            child: new Text("Update")),
        new FlatButton(onPressed: () => Navigator.pop(context),
            child: new Text("Cancel"))
      ],
    );
    showDialog(context:
    context ,builder: (_) {
      return alert;
    });



  }

  void _handleSubmittedUpdate(int index, NoDoItem item) {
    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemName == item.itemName;

      });

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


