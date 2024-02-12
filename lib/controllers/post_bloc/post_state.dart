import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostEmailsState extends Equatable {}

class PostEmailInitialState extends PostEmailsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostEmailsStateAding extends PostEmailsState {
  @override
  List<Object?> get props => [];
}

class PostEmailsStateAdded extends PostEmailsState {
  @override
  List<Object?> get props => [];
}

class PostEmailsStateError extends PostEmailsState {
  final String error;

  PostEmailsStateError(this.error);
  @override
  List<Object?> get props => [error];
}
