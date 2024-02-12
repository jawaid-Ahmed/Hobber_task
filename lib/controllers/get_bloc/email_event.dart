import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EmailEvent extends Equatable {
  const EmailEvent();
}

class LoadEmailEvent extends EmailEvent {
  @override
  List<Object?> get props => [];
}
