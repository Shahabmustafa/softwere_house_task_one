class UserModel {
  String? userName;
  String? email;
  String? phoneNumber;
  String? profileImage;
  String? payment;
  String? type;

  UserModel(
      {this.userName,
        this.email,
        this.phoneNumber,
        this.profileImage,
        this.payment,
        this.type});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
    payment = json['payment'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['profileImage'] = this.profileImage;
    data['payment'] = this.payment;
    data['type'] = this.type;
    return data;
  }
}