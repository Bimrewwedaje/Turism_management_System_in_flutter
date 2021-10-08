//monde for user data
class User{
  int id;
  final String username;
  final String User_Fname;
  final String User_Lname;
  final String User_Gender;
  final String User_Email;
  final String User_Phone;
  final String User_Role;

//intialization of model data
  User ({this.id,this.username,this.User_Fname,this.User_Lname,
  this.User_Gender,this.User_Email,this.User_Phone,
  this.User_Role});


  //method that used to map josn/server data with local data
  factory User.fromJson(Map<String,dynamic>json){

    return User(
      id: json['id'],
        username: json['username'],
        User_Fname:json['user_fname'],
        User_Lname: json['user_lname'],
        User_Gender:json['user_gender'],
        User_Email: json['user_email'],
        User_Phone:json['user_phone'],
        User_Role: json['user_role'],
    );
  }
  dynamic toJson()=>{
    "id":id,
    "username":username,
    "user_fname":User_Fname,
    "user_lname":User_Lname,
    "user_gender":User_Gender,
    "user_email":User_Email,
    "user_phone":User_Phone,
    "user_role":User_Role,
  };

}