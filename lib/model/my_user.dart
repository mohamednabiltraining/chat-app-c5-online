class MyUser {
  static const String collectionName = 'users';
  String id;
  String fName;
  String lName;
  String userName;
  String email;
  MyUser({
    required this.id,
    required this.fName,
    required this.lName,
    required this.userName,
    required this.email
  });

  MyUser.fomJson(Map<String,dynamic>json):
      this(
        id: json['id'] as String,
        fName: json['fName'] as String,
        lName: json['lName'] as String,
        userName: json['userName'] as String,
        email: json['email'] as String);

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'fName':fName,
      'lName':lName,
      'userName':userName,
      'email':email
    };
  }

}