

class NoDoItem  {
  String _itemName;

  int _id;
  String _registrationNO;
  int _daysPresent;
  int _daysAbsent;
  int _totalDays;



  NoDoItem(this._itemName,this._registrationNO,this._daysPresent,this._daysAbsent,this._totalDays);

  NoDoItem.map(dynamic obj) {
    this._itemName = obj["itemName"];

    this._registrationNO = obj["registrationNO"];
    this._id = obj["id"];
    this._daysPresent = obj["daysPresent"];
    this._daysAbsent= obj["daysAbsent"];
    this._totalDays = obj["totalDays"];
  }

  String get itemName => _itemName;

  int get id => _id;
  String get registrationNo => _registrationNO;
  int get daysPresent => _daysPresent;
  int get daysAbsent => _daysAbsent;
  int get totalDays => _totalDays;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = _itemName;

    map["registrationNO"] = _registrationNO;
    map["daysPresent"] = _daysPresent;
    map["daysAbsent"] = _daysAbsent;
    map["totalDays"] = _totalDays;
    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  NoDoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];

    this._registrationNO = map["registrationNO"];
    this._id = map["id"];
    this._daysPresent = map["daysPresent"]  ;
    this._daysAbsent = map["daysAbsent"]  ;
    this._totalDays = map["totalDays"] ;


  }




}
