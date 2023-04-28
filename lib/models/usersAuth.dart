/// status : "success"
/// data : [{"notes_id":55,"notes_title":"zewin","notes_content":"zewin","notes_image":"zewin","notes_users":41}]

class UserData {
  UserData({ this.id, required this.email, required this.password, required this.username});

  UserData.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    // status = json['status'];
  }

  String? id;
  String? username;
  String? email;
  String? password;
  // String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    // map['status'] = status;

    return map;
  }
}
