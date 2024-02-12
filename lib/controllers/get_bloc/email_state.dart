import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hobbertask/models/emailmodel.dart';

@immutable
abstract class EmailState extends Equatable {}

class EmailLoadingState extends EmailState {
  @override
  List<Object?> get props => [];
}

class EmailLoadedState extends EmailState {
  final List<EmailModel> emails;
  EmailLoadedState(this.emails);
  @override
  List<Object?> get props => [emails];
}

class UserErrorState extends EmailState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
