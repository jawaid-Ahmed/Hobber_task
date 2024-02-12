import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/views/getpage/get_bloc/email_event.dart';
import 'package:hobbertask/views/getpage/get_bloc/email_state.dart';
import 'package:hobbertask/repositories/emails_repository.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final EmailRepository _userRepository;

  EmailBloc(this._userRepository) : super(EmailLoadingState()) {
    on<LoadEmailEvent>((event, emit) async {
      emit(EmailLoadingState());
      try {
        final emails = await _userRepository.getEmails();
        emit(EmailLoadedState(emails));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
