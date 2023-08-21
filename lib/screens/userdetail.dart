import 'package:flutter/material.dart';
import 'package:listdemo/model.dart/listmodel.dart';

class UserDetailScreen extends StatefulWidget {
  final List<Userlistmodel> userslist;
  final Function deleteFunction;
  final int index;

  UserDetailScreen({
    required this.userslist,
    required this.deleteFunction,
    required this.index,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Declare the GlobalKey

  @override
  Widget build(BuildContext context) {
    int index = 0; // Replace with the actual index you want to display

    Userlistmodel user = widget.userslist[widget.index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text('User Details'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.userslist);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Name: ${user.name}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Phone: ${user.phone}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Address: ${user.address}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showEditDialog(context, user, index);
                          },
                          child: Text('Edit'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.deleteFunction(index);
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Userlistmodel user, int index) {
    nameController.text = user.name;
    phoneController.text = user.phone;
    addressController.text = user.address;

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Edit User'),
            content: Form(
              key: _formKey, // Attach the _formKey to the Form
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Enter name'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Enter phone'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(labelText: 'Enter address'),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validate the form
                    setState(() {
                      widget.userslist[index] = Userlistmodel(
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                      );
                    });
                    Navigator.pop(context, widget.userslist);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
