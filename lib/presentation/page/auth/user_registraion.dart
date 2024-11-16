import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wild_rice_locator/bloc/auth/auth_bloc.dart';
import 'package:wild_rice_locator/data/firebase_service/user.dart';
import 'package:wild_rice_locator/domain/model/firebase/user_model.dart';

class UserRegistration extends StatefulWidget {
  final String uid;
  const UserRegistration({super.key, required this.uid});

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _town = '';
  String? _district = null; // Explicitly set to null
  int _age = 0;

  // Add an empty option to the districts list
  final List<String> _districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Moneragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya'
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userData = UserDataModel(
        name: _name,
        town: _town,
        district: _district!,
        age: _age,
        uid: widget.uid,
        mobile: 0,
      );

      bool formsubmit = await UserData().saveUserData(userData);
      if (formsubmit) {
        final bloc = context.read<AuthBloc>();
        bloc.add(CheckAuthEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Image(image: AssetImage('assets/img/icon.png')),
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 16.0),

                  cursorHeight: 30, // you can put your ideal height here
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 16.0),
                    labelStyle: const TextStyle(fontSize: 16.0),
                    hintText: 'Enter your name',
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  style: const TextStyle(fontSize: 16.0),
                  cursorHeight: 30, // you can put your ideal height here
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 16.0),
                    labelStyle: const TextStyle(fontSize: 16.0),
                    hintText: 'Enter your town',
                    labelText: 'Enter your town',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your town';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _town = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'District',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16.0),
                  ),
                  isExpanded: true,
                  hint: const Text('Select a district'),
                  value: _district, // This is now explicitly null at start
                  items: _districts.map((String district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a district';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _district = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  style: const TextStyle(fontSize: 16.0),

                  keyboardType: TextInputType.number,
                  cursorHeight: 30, // you can put your ideal height here
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 16.0),
                    labelStyle: const TextStyle(fontSize: 16.0),
                    hintText: 'Enter your age',
                    labelText: 'Enter your age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    if (int.tryParse(value) == null || int.parse(value) < 0) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.parse(value!);
                  },
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _submitForm();
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
