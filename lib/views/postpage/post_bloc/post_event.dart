import 'package:equatable/equatable.dart';

abstract class PostEmailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends PostEmailEvent {
  final String email;
  final String description;
  final String title;
  final String img_link;

  Create(this.email, this.description, this.title, this.img_link);
}
