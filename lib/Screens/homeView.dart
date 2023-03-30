import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _nameController = TextEditingController();

  String result = 'none';
  String imageResult = 'none';
  predictGender(String name) async {
    var url = Uri.parse('https://api.genderize.io/?name=$name');
    var response = await http.get(url);
    var body = json.decode(response.body);
    setState(
      () {
        result = 'Gender: ${body['gender']}';
        imageResult = '${body['gender']}';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 16),
                child: Text(
                  'Enter a name to predict Gender',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  maxLength: 15,
                  decoration: const InputDecoration(
                    hintText: 'Enter a name',
                  ),
                ),
              ),
              _nameController.text.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Please Enter a name',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(result,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
              const SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () => predictGender(_nameController.text),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600),
                    child: const Text('PREDICT'),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: imageResult == 'none'
                    ? Container()
                    : Container(
                        child: imageResult == 'male'
                            ? SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.asset('assets/images/male.png'),
                              )
                            : imageResult == 'female'
                                ? SizedBox(
                                    height: 150,
                                    width: 200,
                                    child: Image.asset(
                                        'assets/images/female.png',
                                        fit: BoxFit.fitHeight),
                                  )
                                : Container(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
