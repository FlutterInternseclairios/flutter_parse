import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_parse/screens/login.dart';
import 'package:flutter_parse/screens/search_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4App {
  static const String baseUrl = 'https://parseapi.back4app.com/classes/';

  Future<void> initParse() async {
    const keyApplicationId = 'xq3BMZvH9NTy7ivdbFwmPJlVTRjGZ7OTB6EaxsoR';
    const keyClientKey = '7x6Vgg2YxQJUyRcq83MLyiiQhQJLIucdPZpa0Zdr';
    const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
  }

  Future<void> registerUser(String userName, String emailId, String password,
      String age, XFile image, BuildContext context) async {
    initParse();
    ParseFileBase? parseUser;
    var registeration = ParseObject('_User');
    registeration.set('username', userName);
    registeration.set('email', emailId);
    registeration.set('password', password);
    registeration.set('age', age);
    parseUser = ParseFile(File(image.path));
    parseUser.save();
    registeration.set('image', parseUser);
    //registeration.set('age', age);
    await registeration.save();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User Created Successfully')));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
   }

  static Future<ParseResponse> signInUserParse(
      username, password, email, BuildContext context) {
    ParseUser user = ParseUser(username, password, email);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Login successfully')));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const SearchUser()));
    return user.login();
  }

  getProfileData(String emailId) async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject(emailId));
    var response = parseQuery..whereContains('email', emailId);
    print('****************************************************************');
    print('****************************************************************');
    print('****************************************************************');
    print(response);
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      final mapss = apiResponse.results;
      print('****************************************************************');
      print('****************************************************************');
      print('****************************************************************');
      print('****************************************************************');
      print('****************************************************************');
      print(mapss);
    }
  }
  Future<List<ParseUser>> getAllUsers() async {
  var query = QueryBuilder(ParseUser.forQuery());
  var result = await query.query();
  if (result.success && result.results != null) {
    List<ParseUser> users = result.results!.cast<ParseUser>();
    return users;
  } else {
    throw Exception('Error fetching users: ${result.error?.message}');
  }
}

Future<ParseUser?> searchUser(String searchTerm, {bool byUsername = true}) async {
  var query = QueryBuilder(ParseUser.forQuery());
  if (byUsername) {
    query.whereContains('username', searchTerm);
  } else {
    query.whereEqualTo('age', int.parse(searchTerm));
  }

  var result = await query.query();
  if (result.success && result.results != null && result.results!.isNotEmpty) {
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    print('${result.results!.first}');
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    return result.results!.first as ParseUser;
  } else {
    return null;
  }
}

   
}
