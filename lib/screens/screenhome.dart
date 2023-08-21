import 'package:flutter/material.dart';
import 'package:listdemo/model.dart/listmodel.dart';
import 'package:listdemo/screens/userdetail.dart';
import 'adduser.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Userlistmodel> userslist = [];
  List<Userlistmodel> filteredUsersList = [];
  TextEditingController searchcontroller = TextEditingController();
  bool searchPressed = false;

  @override
  void initState() {
    super.initState();
    filteredUsersList = userslist; // Initialize filtered list with all users
    searchcontroller.addListener(_searchListener);
  }

  void _searchListener() {
    String query = searchcontroller.text.toLowerCase();
    setState(() {
      filteredUsersList = userslist
          .where((user) =>
              user.name.toLowerCase().contains(query) ||
              user.phone.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Unfocus the text field and dismiss the keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple[300],
            title: Text('Customer Card')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4, // Card elevation
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Card corner radius
                ),
                shadowColor: Colors.grey, // Card shadow color
                child: TextFormField(
                  controller: searchcontroller,
                  style: TextStyle(
                    // Style to match ListTile title style
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'search',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Input border radius
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          searchPressed = true;
                        });
                        // Add the action you want to perform when the icon is tapped
                      },
                      child: Icon(Icons
                          .search_outlined), // Replace with the desired icon
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredUsersList.isEmpty
                  ? Center(child: Text('No users found'))
                  : ListView.builder(
                      itemCount: searchPressed
                          ? filteredUsersList.length
                          : userslist.length,
                      itemBuilder: (context, index) {
                        final user = searchPressed
                            ? filteredUsersList[index]
                            : userslist[index];
                        return GestureDetector(
                          onTap: () {
                            navigateToUserDetailScreen(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 4, // Adjust the elevation as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Adjust corner radius as needed
                              ),
                              shadowColor:
                                  Colors.grey, // Adjust shadow color as needed
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Name : ${user.name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight
                                          .bold, // Make the title bold
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, left: 8, right: 8),
                                  child: Text('Phone : +91 ${user.phone}'),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: Text('add user'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Adduser(
                    addUserFunction: addUser,
                  );
                },
              ));
            }),
      ),
    );
  }

  void addUser(String name, String phone, String address) {
    Userlistmodel newUser = Userlistmodel(
      name: name,
      phone: phone,
      address: address,
    );
    setState(() {
      userslist.add(newUser);
    });
    // Clear the text fields after adding a user
    searchcontroller.clear();
  }

  void deleteUser(int index) {
    setState(() {
      userslist.removeAt(index);
    });
  }

  void navigateToUserDetailScreen(int index) async {
    List<Userlistmodel>? updatedList = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(
          userslist: userslist,
          deleteFunction: (int index) {
            deleteUser(index);
          },
          index: index,
        ),
      ),
    );

    if (updatedList != null) {
      setState(() {
        userslist = updatedList;
      });
    }
  }
}
