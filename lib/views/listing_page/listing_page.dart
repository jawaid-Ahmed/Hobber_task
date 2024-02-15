import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_event.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_state.dart';
import 'package:hobbertask/controllers/repositories/my_repo.dart';
import 'package:hobbertask/models/constants/api_constants.dart';
import 'package:hobbertask/views/edit_page/edit_page.dart';
import 'package:hobbertask/models/my_model.dart';
import 'package:hobbertask/views/create_page/create_page.dart';

class GetEmailsPage extends StatelessWidget {
  const GetEmailsPage({super.key});

  void refreshPage(BuildContext context) {
    BlocProvider.of<MyBloc<MyModel>>(context)
        .add(FetchDataEvent(ApiPaths.listingUrl, (p0) => MyModel.fromMap(p0)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Get Emails Page')),
      body: blocBody(size),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => PostPage()));

            if (context.mounted) {
              refreshPage(context);
            }
          }),
    );
  }

  Widget blocBody(Size size) {
    return BlocBuilder<MyBloc<MyModel>, MyState>(
      builder: (context, state) {
        if (state is MyLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MySuccessState<MyModel>) {
          List<MyModel> emailsList = state.data;

          return ListView.builder(
              itemCount: emailsList.length,
              itemBuilder: (_, index) {
                MyModel item = emailsList[index];
                return item.email.isNotEmpty
                    ? Container(
                        width: size.width,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade500,
                                  radius: 32,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
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
                                        await deleteRequest(item, context);
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () async {
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (c) => EditPage(
                                                      emailModel: item,
                                                    )));
                                        if (context.mounted) {
                                          refreshPage(context);
                                        }
                                      },
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox();
              });
        } else if (state is MyErrorState<MyModel>) {
          return const Center(child: Text("No Data found"));
        } else if (state is MyInitialState<MyModel>) {
          return const Center(child: Text('Initial State state'));
        } else {
          return const Center(child: Text('Unhandled state'));
        }
      },
    );
  }

  deleteRequest(MyModel item, BuildContext context) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Delete"),
      onPressed: () async {
        String res = await repository.deleteRequest(item.email, item.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res)));

          BlocProvider.of<MyBloc<MyModel>>(context).add(
              FetchDataEvent(ApiPaths.listingUrl, (p0) => MyModel.fromMap(p0)));

          Navigator.of(context).pop();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("Are you sure you want to delete this data?"),
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
