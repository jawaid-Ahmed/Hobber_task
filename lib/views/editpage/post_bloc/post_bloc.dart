import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/repositories/emails_repository.dart';
import 'package:hobbertask/controllers/post_bloc/post_event.dart';
import 'package:hobbertask/controllers/post_bloc/post_state.dart';

class PostEmailBloc extends Bloc<PostEmailEvent, PostEmailsState> {
  final EmailRepository emailRepository;
  PostEmailBloc({required this.emailRepository})
      : super(PostEmailInitialState()) {
    on<Create>((event, emit) async {
      emit(PostEmailsStateAding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await emailRepository.postRequest(
          email: event.email,
          description: event.description,
          title: event.title,
          image_link: event.img_link,
        );
        emit(PostEmailsStateAdded());
      } catch (e) {
        emit(PostEmailsStateError(e.toString()));
      }
    });
  }
}
