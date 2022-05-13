class Task {
  int? id;
  String? image;
  String? event_name;
  String? descriptionEvent;
  String? adressevent;
  String? budget;
  int? isCompleted;
  String? date;
  String? startTime;
  String?  endTime;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.image,
    this.event_name,
    this.descriptionEvent,
    this.adressevent,
    this.budget,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,



});
  Task.fromJson(Map<String, dynamic> json){
    id= json['id'];
    event_name=json['title'];
    image=json['image'];
    descriptionEvent=json['descriptionEvent'];
    budget=json['budget'];
    adressevent=json['adressevent'];
    isCompleted=json['isCompleted'];
    date=json['date'];
    startTime=json['startTime'];
    endTime=json['endTime'];
    remind=json['remind'];
    repeat=json['repeat'];
  }
  Map<String, dynamic>toJson() {
    final Map<String, dynamic>data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['event_name'] = this.event_name;
    data['budget'] = this.budget;
    data['adressevent'] = this.adressevent;
    data['date'] = this.date;
    data['descriptionEvent'] = this.descriptionEvent;
    data['isCompleted'] = this.isCompleted;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    return data;
  }

}

