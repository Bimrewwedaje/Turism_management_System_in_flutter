

class Candidates {
  String id;
  String User_Fname;
  String User_Lname;

  Candidates({this.id, this.User_Fname, this.User_Lname});

  factory Candidates.fromJson(Map<String, dynamic> item) {
    return Candidates(
        id: item['id'],
        User_Fname: item['hotel_name'],
        User_Lname: item['hotel_location']);
  }
}