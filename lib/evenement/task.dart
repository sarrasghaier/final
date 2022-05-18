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
    final Map<String, dynamic>data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['event_name'] = event_name;
    data['budget'] = budget;
    data['adressevent'] = adressevent;
    data['date'] = date;
    data['descriptionEvent'] = descriptionEvent;
    data['isCompleted'] = isCompleted;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }

}

