import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  String type;
  EditProfile({@required this.type});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontSize: 20)),
        backgroundColor: Color(0xFFf7418c),
      ),
      body: Container(),
    );
  }
}
