import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/repositories/emails_repository.dart';
import 'package:hobbertask/controllers/edit_bloc/edit_event.dart';
import 'package:hobbertask/controllers/edit_bloc/post_state.dart';

class EditEmailBloc extends Bloc<EditEmailEvent, EditEmailState> {
  final EmailRepository emailRepository;
  EditEmailBloc({required this.emailRepository})
      : super(EditEmailInitialState()) {
    on<Edit>((event, emit) async {
      emit(EditEmailsStateLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await emailRepository.editRequest(
          id: event.id,
          email: event.email,
          description: event.description,
          title: event.title,
          image_link: event.img_link,
        );
        emit(EditEmailsStateSuccess());
      } catch (e) {
        emit(EditEmailsStateError(e.toString()));
      }
    });
  }
}
