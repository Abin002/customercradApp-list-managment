import 'package:flutter/material.dart';
import 'package:listdemo/model.dart/listmodel.dart';
import '../custom_text_feild.dart';

class Adduser extends StatefulWidget {
  final Function addUserFunction;

  Adduser({
    required this.addUserFunction,
    Key? key,
  }) : super(key: key);

  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[300], title: Text('Add users')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFieldStyle(
                keyboardType: TextInputType.name,
                controller: namecontroller,
                labelText: 'Enter name',
                onPressed: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              CustomTextFieldStyle(
                keyboardType: TextInputType.phone,
                controller: phonecontroller,
                labelText: 'Enter phone',
                onPressed: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              CustomTextFieldStyle(
                keyboardType: TextInputType.streetAddress,
                controller: addresscontroller,
                labelText: 'Enter address',
                onPressed: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Userlistmodel newUser = Userlistmodel(
                      name: namecontroller.text,
                      phone: phonecontroller.text,
                      address: addresscontroller.text,
                    );
                    widget.addUserFunction(
                      namecontroller.text,
                      phonecontroller.text,
                      addresscontroller.text,
                    );
                    namecontroller.clear();
                    phonecontroller.clear();
                    addresscontroller.clear();
                    Navigator.pop(context, newUser);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Save user',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
