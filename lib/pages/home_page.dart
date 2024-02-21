import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:testing_reaction/controller/user_controller.dart';
import 'package:testing_reaction/data/user_data.dart';
import 'package:testing_reaction/pages/testing_page.dart';
import 'package:testing_reaction/widgets/custom_snackBar.dart';
import 'package:testing_reaction/widgets/custom_text_form_filed.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData? data;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    data = UserController.getUser();
    print('user name ${data?.name}' );
    nameController.text = data?.name??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200,),
          CustomTextFormField(label: 'Enter your nick name', controller: nameController),
          const SizedBox(height: 100,),
          Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent
            ),
            child: TextButton(
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  if (nameController.text.isEmpty) {
                    showSnackBar(context, 'Please enter your nick name', Colors.red);
                  } else {
                    data!.name = nameController.text;
                    UserController.setUser(data!);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const TestingPage()));
                  }
                },
                child: const Text('Start Test', style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
}
