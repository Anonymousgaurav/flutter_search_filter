import 'package:flutter_search_filter/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_search_filter/Model/User.dart';
import 'package:flutter_search_filter/Utils/Services.dart';

class UserFilterDemo extends StatefulWidget {
  @override
  _UserFilterDemoState createState() => _UserFilterDemoState();
}

class _UserFilterDemoState extends State<UserFilterDemo> {
  List<User> users = List();
  List<User> filteredUsers = List();

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Search Filter'),
      ),



      body: Column(
        children: <Widget>[


          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Filter by name or email',
            ),
            onChanged: (string) {
              setState(() {
                filteredUsers = users
                    .where((u) => (u.name
                    .toLowerCase()
                    .contains(string.toLowerCase()) ||
                    u.email.toLowerCase().contains(string.toLowerCase())))
                    .toList();
              });

            },
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          filteredUsers[index].name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          filteredUsers[index].email.toLowerCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
