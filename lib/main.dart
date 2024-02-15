import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_bloc.dart';
import 'package:hobbertask/controllers/generic_bloc/generic_event.dart';
import 'package:hobbertask/models/constants/api_constants.dart';
import 'package:hobbertask/models/my_model.dart';
import 'package:hobbertask/controllers/repositories/my_repo.dart';
import 'package:hobbertask/views/listing_page/listing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider<MyBloc<MyModel>>(
      create: (context) => MyBloc<MyModel>(MyRepository())
        ..add(FetchDataEvent(
            ApiPaths.listingUrl, (json) => MyModel.fromMap(json))),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GetEmailsPage(),
    );
  }
}
