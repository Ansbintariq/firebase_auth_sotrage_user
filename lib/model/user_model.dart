import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  String? url;
  String? email;
  String? name;
  String? phone;
  String? uid;

  userModel({this.url, this.email, this.name, this.phone, this.uid});

  userModel.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    return data;
  }
}
