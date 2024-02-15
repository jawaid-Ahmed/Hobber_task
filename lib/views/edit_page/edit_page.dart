import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_event.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_state.dart';
import 'package:hobbertask/controllers/repositories/my_repo.dart';
import 'package:hobbertask/models/my_model.dart';
import 'package:hobbertask/utils/data_parser_service.dart';
import 'package:hobbertask/widgets/custom_button.dart';
import 'package:hobbertask/widgets/custom_textfield.dart';

class EditPage extends StatefulWidget {
  final MyModel emailModel;
  const EditPage({super.key, required this.emailModel});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // text fields' controllers
  late TextEditingController _emailController;

  late TextEditingController _descriptionController;

  late TextEditingController _titleController;

  late TextEditingController _imageLinkController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
        text: dataParser.getString(widget.emailModel.email));
    _descriptionController = TextEditingController(
        text: dataParser.getString(widget.emailModel.description));
    _titleController = TextEditingController(
        text: dataParser.getString(widget.emailModel.title));
    _imageLinkController = TextEditingController(
        text: dataParser.getString(widget.emailModel.img_link));
  }

  void _postEditData(context) {
    BlocProvider.of<MyBloc>(context).add(UpdateDataEvent(MyModel(
            id: widget.emailModel.id,
            email: _emailController.text,
            description: _descriptionController.text,
            title: _titleController.text,
            img_link: _imageLinkController.text)
        .toMap()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MyBloc>(
            create: (BuildContext context) => MyBloc(MyRepository()),
          ),
        ],
        child: Scaffold(
            body: BlocListener<MyBloc, MyState>(
          listener: (context, state) {
            if (state is MySuccessState<String>) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Data updated"),
                duration: Duration(seconds: 2),
              ));

              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<MyBloc, MyState>(
            builder: (context, state) {
              if (state is MyLoadingState<String>) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MyErrorState<String>) {
                return const Center(child: Text("Error"));
              }
              return mainWidget(context);
            },
          ),
        )));
  }

  Widget mainWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Update Info Page')),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
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
                CustomTextField(
                  padding: const EdgeInsets.all(2),
                  editingController: _emailController,
                  hintText: "Email",
                  textColor: Colors.black,
                  onChange: (val) {
                    _emailController.text = val;
                  },
                ),
                CustomTextField(
                  padding: const EdgeInsets.all(2),
                  editingController: _descriptionController,
                  hintText: "Description",
                  textColor: Colors.black,
                  onChange: (val) {
                    _descriptionController.text = val;
                  },
                ),
                CustomTextField(
                  padding: const EdgeInsets.all(2),
                  editingController: _titleController,
                  hintText: "Title",
                  textColor: Colors.black,
                  onChange: (val) {
                    _titleController.text = val;
                  },
                ),
                CustomTextField(
                  padding: const EdgeInsets.all(2),
                  editingController: _imageLinkController,
                  hintText: "Image Link",
                  textColor: Colors.black,
                  onChange: (val) {
                    _imageLinkController.text = val;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: "Update Data",
                  radius: 8,
                  onPressed: () {
                    String? email = _emailController.text;
                    String? desc = _descriptionController.text;
                    String? title = _titleController.text;
                    String? image = _imageLinkController.text;

                    if (email.isNotEmpty &&
                        desc.isNotEmpty &&
                        title.isNotEmpty &&
                        image.isNotEmpty) {
                      _postEditData(context);

                      _emailController.text = '';
                      _descriptionController.text = '';
                      _titleController.text = '';
                      _imageLinkController.text = '';
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please provide all fields")));
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            )));
  }
}
