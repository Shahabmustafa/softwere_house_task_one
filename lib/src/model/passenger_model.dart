import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerModel {
  String? userId;
  String? userName;
  String? email;
  String? phoneNumber;
  String? payment;
  String? profileImage;
  String? type;
  bool? stats;
  Timestamp? dateTime;
  double? longitude;
  double? latitude;

  PassengerModel(
      {
        this.userId,
        this.userName,
        this.email,
        this.phoneNumber,
        this.payment,
        this.profileImage,
        this.type,
        this.stats,
        this.dateTime,
        required this.longitude,
        required this.latitude
      });

  // PassengerModel.fromJson(Map<String, dynamic> json) {
  //   userName = json['userName'];
  //   email = json['email'];
  //   phoneNumber = json['phoneNumber'];
  //   payment = json['payment'];
  //   profileImage = json['profileImage'];
  //   type = json['type'];
  //   stats = json['stats'];
  //   dateTime = json['dateTime'];
  //   userId = json['userId'];
  //   latitude = json['latitude'];
  //   longitude = json['longitude'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['userName'] = this.userName;
  //   data['email'] = this.email;
  //   data['phoneNumber'] = this.phoneNumber;
  //   data['payment'] = this.payment;
  //   data['profileImage'] = this.profileImage;
  //   data['type'] = this.type;
  //   data['stats'] = this.stats;
  //   data['dateTime'] = this.dateTime;
  //   data['userId'] = this.userId;
  //   data['latitude'] = this.latitude;
  //   data['longitude'] = longitude;
  //   return data;
  // }
}