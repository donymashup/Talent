class UserDetailsModel {
  String? type;
  User? user;
  String? message;

  UserDetailsModel({this.type, this.user, this.message});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? country;
  String? phone;
  String? email;
  String? password;
  String? dob;
  String? gender;
  String? address;
  String? image;
  String? school;
  String? qualification;
  String? firebaseId;
  String? onesignalId;
  Null secondaryPhone;
  String? instituteid;
  String? created;
  String? status;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.country,
      this.phone,
      this.email,
      this.password,
      this.dob,
      this.gender,
      this.address,
      this.image,
      this.school,
      this.qualification,
      this.firebaseId,
      this.onesignalId,
      this.secondaryPhone,
      this.instituteid,
      this.created,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    image = json['image'];
    school = json['school'];
    qualification = json['qualification'];
    firebaseId = json['firebase_id'];
    onesignalId = json['onesignal_id'];
    secondaryPhone = json['secondary_phone'];
    instituteid = json['instituteid'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['image'] = this.image;
    data['school'] = this.school;
    data['qualification'] = this.qualification;
    data['firebase_id'] = this.firebaseId;
    data['onesignal_id'] = this.onesignalId;
    data['secondary_phone'] = this.secondaryPhone;
    data['instituteid'] = this.instituteid;
    data['created'] = this.created;
    data['status'] = this.status;
    return data;
  }
}