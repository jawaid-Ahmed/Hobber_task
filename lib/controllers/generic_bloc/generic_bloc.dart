import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_event.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_state.dart';
import 'package:hobbertask/controllers/repositories/my_repo.dart';

class MyBloc<T> extends Bloc<MyEvent, MyState> {
  final MyRepository repository;

  MyBloc(this.repository) : super(MyInitialState<T>()) {
    on<FetchDataEvent<T>>((event, emit) async {
      emit(MyLoadingState<T>());
      try {
        List<T> emails =
            await repository.fetchData<T>(event.url, event.fromJson);

        emit(MySuccessState<T>(emails));
      } catch (e) {
        emit(MyErrorState<T>(e.toString()));
      }
    });

    //on post data request event
    on<PostDataEvent>((event, emit) async {
      emit(MyLoadingState<String>());
      await Future.delayed(const Duration(seconds: 1));
      try {
        var data = await repository.postRequest(event.body);
        emit(MySuccessState<String>([data]));
      } catch (e) {
        emit(MyErrorState<String>(e.toString()));
      }
    });

    //on update data request event
    on<UpdateDataEvent>((event, emit) async {
      emit(MyLoadingState<String>());
      await Future.delayed(const Duration(seconds: 1));
      try {
        var data = await repository.editRequest(event.body);
        emit(MySuccessState<String>([data]));
      } catch (e) {
        emit(MyErrorState<String>(e.toString()));
      }
    });
  }
}
