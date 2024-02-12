import 'dart:convert';
import 'dart:math';
import 'package:hobbertask/models/constants/paths.dart';
import 'package:hobbertask/models/emailmodel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmailRepository {
  Future<List<EmailModel>> getEmails() async {
    Response response = await get(Uri.parse(ApiPaths.baseURl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map((e) => EmailModel.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //post request
  Future<void> postRequest({email, description, title, image_link}) async {
    Map<String, dynamic> postData = {
      'email': email,
      'description': description,
      'title': title,
      'img_link': image_link,
    };

    try {
      final response = await http.post(
        Uri.parse(ApiPaths.createURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Add any additional headers as needed
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        // String message = jsonDecode(response.body)[0]["message"];

        // Request successful, you can handle the response here
        print('Response: ${response.body}');
      } else {
        // Request failed, handle the error
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      print('Error: $error');
    }
  }

  //post request
  Future<String> deleteRequest(String email, int id) async {
    try {
      print('delete request');
      print(email);
      print(id);
      print("${ApiPaths.deleteUrl}email=?$email&id=$id");
      final response = await http.delete(
        Uri.parse("${ApiPaths.deleteUrl}email=?$email&id=$id"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Add any additional headers as needed
        },
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)[0]["message"];

        // Request successful, you can handle the response here
        print('Response: ${response.body}');
        return message;
      } else {
        // Request failed, handle the error
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return "failed";
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      print('Error: $error');
      return "failed";
    }
  }

  //update request
  Future<void> editRequest({id, email, description, title, image_link}) async {
    // Map<String, dynamic> postData = {
    //   'id': id,
    //   'email': email,
    //   'description': description,
    //   'title': title,
    //   'img_link': image_link,
    // };

    String url =
        "${ApiPaths.editUrl}email=$email&id=$id&description=$description&title=$title&img_link=$image_link";

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Add any additional headers as needed
        },
        // body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        // String message = jsonDecode(response.body)[0]["message"];

        // Request successful, you can handle the response here
        print('Response: ${response.body}');
      } else {
        // Request failed, handle the error
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      print('Error: $error');
    }
  }
}

EmailRepository emailRepository = EmailRepository();
