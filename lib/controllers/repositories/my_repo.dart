import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:hobbertask/models/constants/api_constants.dart';
import 'package:hobbertask/models/my_model.dart';
import 'package:http/http.dart' as http;

class MyRepository {
  Future<List<T>> fetchData<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((data) => fromJson(data)).toList().cast<T>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> postRequest(Map<String, dynamic> postData) async {
    try {
      final response = await http.post(
        Uri.parse(ApiPaths.createURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)[0]["message"];

        // Request successful, you can handle the response here
        return message;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      debugPrint('Error: $error');
      return "Something went wrong!";
    }
  }

  //update request
  Future<String> editRequest(Map<String, dynamic> postData) async {
    MyModel model = MyModel.fromMap(postData);

    String url =
        "${ApiPaths.editUrl}email=${model.email}&id=${model.id}&description=${model.description}&title=${model.title}&img_link=${model.img_link}";

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)[0]["message"];

        return message;
      } else {
        // Request failed, handle the error
        debugPrint('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      debugPrint('Error: $error');
      return "Something went wrong!";
    }
  }

  // on delete api called

  //post request
  Future<String> deleteRequest(String email, int id) async {
    try {
      final response = await http.delete(
        Uri.parse("${ApiPaths.deleteUrl}email=?$email&id=$id"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)[0]["message"];
        return message;
      } else {
        // Request failed, handle the error
        debugPrint('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return "failed";
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      debugPrint('Error: $error');
      return "failed";
    }
  }
}

MyRepository repository = MyRepository();
