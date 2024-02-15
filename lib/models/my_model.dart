// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:hobbertask/utils/data_parser_service.dart';

class MyModel {
  final int id;
  final String email;
  final String description;
  final String title;
  final String img_link;
  MyModel({
    required this.id,
    required this.email,
    required this.description,
    required this.title,
    required this.img_link,
  });

  MyModel copyWith({
    int? id,
    String? email,
    String? description,
    String? title,
    String? img_link,
  }) {
    return MyModel(
      id: id ?? this.id,
      email: email ?? this.email,
      description: description ?? this.description,
      title: title ?? this.title,
      img_link: img_link ?? this.img_link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'description': description,
      'title': title,
      'img_link': img_link,
    };
  }

  factory MyModel.fromMap(Map<String, dynamic> map) {
    return MyModel(
      id: dataParser.getInt(map['id']),
      email: dataParser.getString(map['email']),
      description: dataParser.getString(map['description']),
      title: dataParser.getString(map['title']),
      img_link: dataParser.getString(map['img_link']),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'MyModel(id: $id, email: $email, description: $description, title: $title, img_link: $img_link)';
  }

  @override
  bool operator ==(covariant MyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.description == description &&
        other.title == title &&
        other.img_link == img_link;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        description.hashCode ^
        title.hashCode ^
        img_link.hashCode;
  }
}
