import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_trs/bloc/add_employe_bloc.dart';
import 'package:flutter_mobile_trs/event_states/add_employe_state.dart';
import 'package:flutter_mobile_trs/services/api_service.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  bool isActive = true;
  final _nik = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _address = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _submitData() async {
    final data = [
      {
        'nik': _nik.text,
        'first_name': _firstName.text,
        'last_name': _lastName.text,
        'alamat': _address.text,
        'aktif': isActive,
      }
    ];

    try {
      var postEmployee = await _apiService.postData(data);
      if (postEmployee == '204') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text('Data posted successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text('Saved failed!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to post data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDataBloc(ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Employee'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AddDataBloc, AddDataState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                      ),
                      label: RichText(
                        text: const TextSpan(
                          text: 'NIK',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: ' *', style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _nik.text = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                      ),
                      label: RichText(
                        text: const TextSpan(
                          text: 'First Name',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: ' *', style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _firstName.text = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                      ),
                      label: RichText(
                        text: const TextSpan(
                          text: 'Last Name',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: ' *', style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _lastName.text = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                      ),
                      label: RichText(
                        text: const TextSpan(
                          text: 'Address',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: ' *', style: TextStyle(color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _address.text = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Expanded(child: Text('Active')),
                        Switch(
                          value: isActive,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              isActive = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _submitData,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: Size(100, 50)),
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
