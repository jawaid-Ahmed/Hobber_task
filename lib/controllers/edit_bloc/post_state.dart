import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EditEmailState extends Equatable {}

class EditEmailInitialState extends EditEmailState {
  @override
  List<Object?> get props => [];
}

class EditEmailsStateLoading extends EditEmailState {
  @override
  List<Object?> get props => [];
}

class EditEmailsStateSuccess extends EditEmailState {
  @override
  List<Object?> get props => [];
}

class EditEmailsStateError extends EditEmailState {
  final String error;

  EditEmailsStateError(this.error);
  @override
  List<Object?> get props => [error];
}
