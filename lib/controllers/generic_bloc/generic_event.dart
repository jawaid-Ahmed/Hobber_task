import 'package:equatable/equatable.dart';

abstract class MyEvent extends Equatable {
  const MyEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent<T> extends MyEvent {
  final String url;
  final T Function(Map<String, dynamic>) fromJson;

  const FetchDataEvent(this.url, this.fromJson);

  @override
  List<Object> get props => [url];
}

class PostDataEvent extends MyEvent {
  final Map<String, dynamic> body;

  const PostDataEvent(this.body);
}

class UpdateDataEvent extends MyEvent {
  final Map<String, dynamic> body;

  const UpdateDataEvent(this.body);
}
