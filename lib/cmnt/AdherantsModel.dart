// import 'dart:convert';
//
// AdherantsModel adherantsModelJson(String str)=>
//     AdherantsModel.fromJson(json.decode(str));
//
// String adherantsModelToJson(AdherantsModel data)=> json.encode(data.toJson());
//
//
// class AdherantsModel{
//   int? id;
//   String firstName;
//   String lastName;
//
//   AdherantsModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName
//   });
//
//     factory AdherantsModel.fromJson(Map<String,dynamic> json)=> AdherantsModel(
//       firstName: json["firstName"],
//       lastName: json["lastName"],
//       id: json["id"]
//     );
//       Map<String,dynamic> toJson() =>{
//           "firstName":firstName,
//           "lastName":lastName,
//           "id":id
//       };
//     String get firstname => firstName;
//     String get lastname => lastName;
//
// }
