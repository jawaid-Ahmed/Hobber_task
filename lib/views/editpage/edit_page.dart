import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/models/emailmodel.dart';
import 'package:hobbertask/repositories/emails_repository.dart';
import 'package:hobbertask/views/editpage/edit_bloc/edit_bloc.dart';
import 'package:hobbertask/views/editpage/edit_bloc/edit_event.dart';
import 'package:hobbertask/views/editpage/edit_bloc/post_state.dart';
import 'package:hobbertask/views/getpage/getlist.dart';

class EditPage extends StatefulWidget {
  final EmailModel emailModel;
  const EditPage({super.key, required this.emailModel});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // text fields' controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _imageLinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.emailModel.email;
    _descriptionController.text = widget.emailModel.description;
    _titleController.text = widget.emailModel.title;
    _imageLinkController.text = widget.emailModel.img_link;
  }

  void _postEditData(context) {
    BlocProvider.of<EditEmailBloc>(context).add(Edit(
        widget.emailModel.id,
        _emailController.text,
        _descriptionController.text,
        _titleController.text,
        _imageLinkController.text));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<EditEmailBloc>(
            create: (BuildContext context) =>
                EditEmailBloc(emailRepository: EmailRepository()),
          ),
        ],
        child: Scaffold(
          // key: scaffoldKey,
          body: BlocListener<EditEmailBloc, EditEmailState>(
              listener: (context, state) {
            if (state is EditEmailsStateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Data updated"),
                duration: Duration(seconds: 2),
              ));

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => const GetEmailsPage()));
            }
          }, child: BlocBuilder<EditEmailBloc, EditEmailState>(
            builder: (context, state) {
              if (state is EditEmailsStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EditEmailsStateError) {
                return const Center(child: Text("Error"));
              }
              return MainWidget(context);
            },
          )),
        ));
  }

  Widget MainWidget(BuildContext context) {
    return BlocProvider(
        create: (context) => EditEmailBloc(
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
                      "update data Request",
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
                        _postEditData(context);

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
