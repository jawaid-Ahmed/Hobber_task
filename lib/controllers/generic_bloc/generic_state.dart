import 'package:equatable/equatable.dart';

abstract class MyState extends Equatable {
  const MyState();

  @override
  List<Object> get props => [];
}

class MyInitialState<T> extends MyState {}

class MyLoadingState<T> extends MyState {}

class MySuccessState<T> extends MyState {
  final List<T> data;

  const MySuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class MyErrorState<T> extends MyState {
  final String errorMessage;

  const MyErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
