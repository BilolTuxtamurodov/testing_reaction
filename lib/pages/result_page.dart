import 'package:flutter/cupertino.dart';
import 'package:testing_reaction/controller/user_controller.dart';
import 'package:testing_reaction/data/user_data.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late UserData data;
  @override
  void initState() {
    data = UserController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        child: Column(
          children: [
            const Text('Your results'),
            const SizedBox(
              height: 10,
            ),
            Text('Maximum is : ${Duration(milliseconds: data.maximum??0)}'),
            const SizedBox(
              height: 10,
            ),
            Text('Minimum is : ${Duration(milliseconds: data.minimum??0)}'),
            const SizedBox(
              height: 10,
            ),
            Text('Average is : ${Duration(milliseconds: data.average??0)}'),
          ],
        ),
      ),
    );
  }
}
