import 'package:flutter/material.dart';
import 'package:flutter_parse/controller/back4app.dart';
import 'package:flutter_parse/widgets/input_field.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final _searchQueryController = TextEditingController();
  late Future<List<ParseUser>> _usersFuture;
  ParseUser? _user;

void _searchUser() async {
    setState(() {
      _user = null;
    });
    
    String searchTerm = _searchQueryController.text.trim();
    if (searchTerm.isNotEmpty) {
      var user = await Back4App().searchUser(searchTerm);
      setState(() {
        _user = user;
      });
    }
  }

@override
  void initState() {
    super.initState();
    _usersFuture = Back4App().getAllUsers();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Stack(
          children: [
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 12),
              width: double.infinity,
              
              child: Row(
                children: [
                  Expanded(flex: 4, child: InputField(controller: _searchQueryController, hintText: 'Search a user')),
                   Expanded(flex:1,child:  IconButton(onPressed: _searchUser, icon: const Icon(Icons.search))),
                ],
              ),
            ),
            _user != null? Expanded(
              child: Container(
              margin: const EdgeInsets.only(top: 80),
                child: 
                ListTile(
                        title: Text('Name: ${_user!.username}'),
                        subtitle: Text('Age: ${_user!['age']}'),
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image(image: NetworkImage('${_user!['image']['url']}'),)),
                      ),
              ),
            ) :
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              child: FutureBuilder<List<ParseUser>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<ParseUser> users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      ParseUser user = users[index];
                      return ListTile(
                        title: Text(user.username ?? 'No Username'),
                      );
                    },
                  );
                }
              },
                      ),
            ),
          ),
          ],
        )
      
      
        
      ),
    );
  }
}





