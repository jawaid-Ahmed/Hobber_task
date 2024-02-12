import 'package:equatable/equatable.dart';

abstract class EditEmailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Edit extends EditEmailEvent {
  final int id;
  final String email;
  final String description;
  final String title;
  final String img_link;

  Edit(this.id, this.email, this.description, this.title, this.img_link);
}
