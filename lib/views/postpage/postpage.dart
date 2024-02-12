import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/repositories/emails_repository.dart';
import 'package:hobbertask/views/getpage/getlist.dart';
import 'package:hobbertask/controllers/post_bloc/post_bloc.dart';
import 'package:hobbertask/controllers/post_bloc/post_event.dart';
import 'package:hobbertask/controllers/post_bloc/post_state.dart';

class PostPage extends StatelessWidget {
  PostPage({super.key});

  // text fields' controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageLinkController = TextEditingController();

  void _postData(context) {
    BlocProvider.of<PostEmailBloc>(context).add(Create(
        _emailController.text,
        _descriptionController.text,
        _titleController.text,
        _imageLinkController.text));
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiBlocProvider(
        providers: [
          BlocProvider<PostEmailBloc>(
            create: (BuildContext context) =>
                PostEmailBloc(emailRepository: EmailRepository()),
          ),
        ],
        child: Scaffold(
          // key: scaffoldKey,
          body: BlocListener<PostEmailBloc, PostEmailsState>(
              listener: (context, state) {
            if (state is PostEmailsStateAdded) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Email added"),
                duration: Duration(seconds: 2),
              ));

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (c) => const GetEmailsPage()));
            }
          }, child: BlocBuilder<PostEmailBloc, PostEmailsState>(
            builder: (context, state) {
              if (state is PostEmailsStateAding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PostEmailsStateError) {
                return const Center(child: Text("Error"));
              }
              return MainWidget(context);
            },
          )),
        ));
  }

  Widget MainWidget(BuildContext context) {
    return BlocProvider(
        create: (context) => PostEmailBloc(
            emailRepository: RepositoryProvider.of<EmailRepository>(context)),
        child: Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('Post Api')),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _imageLinkController,
                    decoration: const InputDecoration(labelText: 'Image Link'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    child: const Text(
                      "Post Request",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      String? email = _emailController.text ?? "";
                      String? desc = _descriptionController.text ?? "";
                      String? title = _titleController.text ?? "";
                      String? image = _imageLinkController.text ?? "";

                      if (email.isNotEmpty &&
                          desc.isNotEmpty &&
                          title.isNotEmpty &&
                          image.isNotEmpty) {
                        _postData(context);

                        _emailController.text = '';
                        _descriptionController.text = '';
                        _titleController.text = '';
                        _imageLinkController.text = '';
                        // Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please provide all fields")));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )));
  }
}
