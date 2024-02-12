import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/views/editpage/edit_bloc/edit_bloc.dart';
import 'package:hobbertask/views/editpage/edit_page.dart';
import 'package:hobbertask/views/getpage/get_bloc/email_event.dart';
import 'package:hobbertask/views/getpage/get_bloc/email_state.dart';
import 'package:hobbertask/views/getpage/get_bloc/emails_bloc.dart';
import 'package:hobbertask/models/emailmodel.dart';
import 'package:hobbertask/repositories/emails_repository.dart';
import 'package:hobbertask/views/postpage/post_bloc/post_bloc.dart';
import 'package:hobbertask/views/postpage/postpage.dart';

class GetEmailsPage extends StatefulWidget {
  const GetEmailsPage({super.key});

  @override
  State<GetEmailsPage> createState() => _GetEmailsPageState();
}

class _GetEmailsPageState extends State<GetEmailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmailBloc>(
          create: (BuildContext context) => EmailBloc(EmailRepository()),
        ),
        BlocProvider<PostEmailBloc>(
          create: (BuildContext context) =>
              PostEmailBloc(emailRepository: EmailRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Get Emails Page')),
        body: blocBody(size),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => PostPage()));
            }),
      ),
    );
  }

  Widget blocBody(Size size) {
    return BlocProvider(
      create: (context) => EmailBloc(
        EmailRepository(),
      )..add(LoadEmailEvent()),
      child: BlocBuilder<EmailBloc, EmailState>(
        builder: (context, state) {
          if (state is EmailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is EmailLoadedState) {
            List<EmailModel> emailsList = state.emails;

            return ListView.builder(
                itemCount: emailsList.length,
                itemBuilder: (_, index) {
                  EmailModel item = emailsList[index];
                  return Container(
                    width: size.width,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 32,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emailsList[index].email,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  emailsList[index].description,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await deleteRequest(item);
                                  },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (c) => EditPage(
                                                  emailModel: item,
                                                )));
                                  },
                                  icon: const Icon(Icons.edit)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }

  deleteRequest(EmailModel item) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () async {
        String res = await emailRepository.deleteRequest(item.email, item.id);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (c) => const GetEmailsPage()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure you want to delete this user?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
