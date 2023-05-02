/// status : "success"
/// data : [{"notes_id":5,"notes_title":"dsfdsf","notes_content":"dfsf","notes_image":"dsfsdf","notes_users":38},{"notes_id":6,"notes_title":"sdsad","notes_content":"sdsad","notes_image":"","notes_users":38},{"notes_id":17,"notes_title":"الحمد لله","notes_content":"بسم الله الرحمن الرحيم","notes_image":"","notes_users":38},{"notes_id":18,"notes_title":"الحمد لله رب العالمين","notes_content":"بسم الله الرحمن الرحيم","notes_image":"","notes_users":38}]

class ViewNotes {
  ViewNotes({
    this.status,
    this.data,
  });

  ViewNotes.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// notes_id : 5
/// notes_title : "dsfdsf"
/// notes_content : "dfsf"
/// notes_image : "dsfsdf"
/// notes_users : 38

class Data {
  Data({
    this.notesId,
    this.notesTitle,
    this.notesContent,
    this.notesImage,
    this.notesUsers,
  });

  Data.inti(this.notesId, this.notesTitle, this.notesContent,this.notesImage);

  Data.fromJson(dynamic json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'];
  }

  num? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  num? notesUsers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notes_id'] = notesId;
    map['notes_title'] = notesTitle;
    map['notes_content'] = notesContent;
    map['notes_image'] = notesImage;
    map['notes_users'] = notesUsers;
    return map;
  }
}
