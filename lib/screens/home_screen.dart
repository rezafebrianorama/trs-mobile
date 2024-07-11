import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_trs/bloc/home_bloc.dart';
import 'package:flutter_mobile_trs/event_states/home_event.dart';
import 'package:flutter_mobile_trs/event_states/home_state.dart';
import 'package:flutter_mobile_trs/screens/add_employe_screen.dart';
import 'package:flutter_mobile_trs/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List employee = [];
  List searchEmployee = [];
  bool isLoad = true;
  bool isSearch = false;
  late FocusNode searchFocus;
  final _search = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    searchFocus = FocusNode();
    super.initState();
  }

  void _autoFilterSearch(String enteredKeyword) {
    List res = [];
    if (enteredKeyword.isEmpty) {
      res = searchEmployee;
    } else {
      res = employee
          .where((val) =>
              val["first_name"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              val["last_name"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              val["alamat"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      searchEmployee = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(ApiService())..add(LoadData()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded) {
            setState(() {
              employee = state.data;
              isLoad = false;
            });
          } else if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: isSearch
                ? TextField(
                    focusNode: searchFocus,
                    onChanged: (value) => _autoFilterSearch(value),
                    cursorColor: Colors.white,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                        hintText: 'search...',
                        hintStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontFamily: 'Poppins'),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.8),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.8),
                        ),
                        suffixIcon: IconButton(
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                _search.clear();
                                searchEmployee = [];
                                isSearch = false;
                              });
                              searchFocus.unfocus();
                            },
                            icon: const Icon(
                              Icons.cancel,
                            ))),
                    controller: _search,
                  )
                : Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Employee',
                          style: TextStyle(
                              letterSpacing: 1.5, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                          width: 25,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSearch = true;
                                  searchEmployee = employee;
                                });
                                searchFocus.requestFocus();
                              },
                              child: const Icon(
                                Icons.search,
                                size: 23,
                              ))),
                    ],
                  ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          body: isLoad
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.green,
                ))
              : RefreshIndicator(
                  key: _refreshIndicatorKey,
                  color: Colors.white,
                  backgroundColor: Colors.green,
                  strokeWidth: 4.0,
                  onRefresh: () async {
                    var getEmployee = await _apiService.fetchData();
                    setState(() {
                      employee = getEmployee;
                    });
                  },
                  child: ListView.separated(
                    itemCount:
                        isSearch ? searchEmployee.length : employee.length,
                    padding: const EdgeInsets.only(bottom: 30, top: 20),
                    itemBuilder: (context, index) {
                      List emp = isSearch ? searchEmployee : employee;
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.grey[200]),
                          child: Center(
                            child: Text(
                              emp[index]['first_name'].toString() == '' ||
                                      emp[index]['first_name'].toString() ==
                                          'null'
                                  ? 'U'
                                  : emp[index]['first_name']
                                      .toString()
                                      .toUpperCase()
                                      .substring(0, 1),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        trailing: Text(
                          emp[index]['aktif'] ? 'Aktif' : 'Nonaktif',
                          style: TextStyle(
                              color: emp[index]['aktif']
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 15),
                        ),
                        title: Text(
                            '${emp[index]['first_name']} ${emp[index]['last_name']}'),
                        subtitle: Text(
                          '${emp[index]['alamat']}',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      );
                    },
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
                ).then((value) async {
                  setState(() {
                    isLoad = true;
                  });
                  var getEmployee = await _apiService.fetchData();
                  if (getEmployee.isNotEmpty) {
                    // print(getEmployee);
                    setState(() {
                      employee = getEmployee;
                      isLoad = false;
                    });
                  } else {
                    setState(() {
                      isLoad = false;
                    });
                  }
                });
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90)),
              label: const Row(
                children: [
                  Icon(Icons.add),
                  Text(' Add'),
                ],
              )),
        ),
      ),
    );
  }
}
