import 'package:flutter/material.dart';
import 'package:hobbertask/views/getpage/getlist.dart';
import 'package:hobbertask/views/postpage/postpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(size,
              title: "Get Emails",
              onTap: () => () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => const GetEmailsPage()));
                  }),
          CustomButton(size,
              title: "Post Email",
              onTap: () => () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => PostPage()));
                  }),
        ],
      ),
    );
  }

  CustomButton(Size size, {title, onTap}) {
    return InkWell(
      onTap: onTap!.call(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              height: 70,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      ),
    );
  }
}
