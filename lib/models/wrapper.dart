import 'package:flutter/material.dart';
import 'package:project1/admin/admin_dashboard.dart';
import 'package:project1/admin/admin_login.dart';
import 'package:project1/donor/donor_dashboard.dart';
import 'package:project1/donor/donor_login.dart';
import 'package:project1/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  String type;
  Wrapper({@required this.type});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    // Return either home or authenticate widget
    print("From wrapper.dart");
    print(user);
    if (user == null) {
      if (type == "Donor") {
        return Donorlogin();
      } else if (type == "Admin") {
        return AdminLogin();
      }
    } else {
      print("Going to Dashboard");
      print(user.uid);
      if (type == "Donor") {
        return DonorDashboard();
      } else if (type == "Admin") {
        return AdminDashboard();
      }
    }
  }
}
