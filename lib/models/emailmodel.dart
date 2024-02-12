// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmailModel {
  final int id;
  final String email;
  final String description;
  final String title;
  final String img_link;
  EmailModel({
    required this.id,
    required this.email,
    required this.description,
    required this.title,
    required this.img_link,
  });

  EmailModel copyWith({
    int? id,
    String? email,
    String? description,
    String? title,
    String? img_link,
  }) {
    return EmailModel(
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

  factory EmailModel.fromMap(Map<String, dynamic> map) {
    return EmailModel(
      id: map['id'] as int,
      email: map['email'] as String,
      description: map['description'] as String,
      title: map['title'] as String,
      img_link: map['img_link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailModel.fromJson(String source) =>
      EmailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmailModel(id: $id, email: $email, description: $description, title: $title, img_link: $img_link)';
  }

  @override
  bool operator ==(covariant EmailModel other) {
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
