class UserModel {
  String? userId;
  String? userName;
  String? email;
  String? phoneNumber;
  String? payment;
  String? profileImage;
  String? type;
  bool? stats;
  DateTime? dateTime;

  UserModel(
      {
        this.userId,
        this.userName,
        this.email,
        this.phoneNumber,
        this.payment,
        this.profileImage,
        this.type,
        this.stats,
        this.dateTime});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    payment = json['payment'];
    profileImage = json['profileImage'];
    type = json['type'];
    stats = json['stats'];
    dateTime = json['dateTime'].toDate();
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['payment'] = this.payment;
    data['profileImage'] = this.profileImage;
    data['type'] = this.type;
    data['stats'] = this.stats;
    data['dateTime'] = this.dateTime;
    data['userId'] = this.userId;
    return data;
  }
}