import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project1/database/auth.dart';
import 'package:project1/models/user.dart';
import 'package:provider/provider.dart';

class User {
  String name, email, bldGrp, location;
  User({this.name, this.email, this.bldGrp, this.location});
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _cuurentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // print(widget.email);
    var _kDefaultTabBarInactiveColor = Colors.grey[700];
    return new MaterialApp(
      home: new CupertinoTabScaffold(
        tabBar: new CupertinoTabBar(
          iconSize: 25,
          activeColor: Colors.red[500],
          inactiveColor: _kDefaultTabBarInactiveColor,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              title: new Text('Home'),
              icon: new Icon(Icons.home),
            ),
            new BottomNavigationBarItem(
              title: new Text('Request'),
              icon: new Icon(
                FontAwesomeIcons.solidHeart,
              ),
            ),
            new BottomNavigationBarItem(
              title: new Text('Blood Data'),
              icon: new Icon(Icons.history),
            ),
            new BottomNavigationBarItem(
              title: new Text('Nearby Members'),
              icon: new Icon(Icons.location_on),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return new CupertinoTabView(
            builder: (BuildContext context) {
              switch (index) {
                case 0:
                  return new UserProfile();
                case 1:
                  return new Request();
                case 2:
                  return new BloodData();
                case 3:
                  return new Member();
                default:
                  return new AdminDashboard();
              }
            },
          );
        },
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService _auth = AuthService();

  User u1 = new User();

  /*Future<dynamic> getdata() async {
    //print(widget.email);
    var url = 'http://192.168.43.75/AdminDashboard/php_files/getdata.php';
    var res = await http.post(url, body: {
      'email': widget.email,
    });
    var data1 = json.decode(res.body);
    print(data1);
    return data1;
  }*/

  void getData(String id, BuildContext context) async {
    final DatabaseReference itemImages =
        FirebaseDatabase.instance.reference().child(id).child("user-info");

    await itemImages.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var values = snapshot.value;

        for (var key in keys) {
          print(values[key]);
          u1.name = values[key]["name"];
          u1.email = values[key]["email"];
          u1.bldGrp = values[key]["bld_grp"];
          u1.location = values[key]["location"];
        }
        print(u1.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    getData(user.uid, context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile", style: TextStyle(fontSize: 20)),
          backgroundColor: Color(0xFFf7418c),
          actions: [
            IconButton(
              icon: Icon(Icons.all_inclusive),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.only(bottom: 20)),
          ListTile(
              leading: Icon(Icons.person, size: 30),
              title: Text(u1.name != null ? u1.name : "name",
                  style: TextStyle(fontSize: 30)),
              trailing: Icon(FontAwesomeIcons.pencilAlt, size: 25)),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          Divider(
            thickness: 0.5,
          ),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          ListTile(
              leading: Icon(FontAwesomeIcons.solidHeart, size: 25),
              title: Text("Blood Group", style: TextStyle(fontSize: 25)),
              subtitle: Text(u1.bldGrp != null ? u1.bldGrp : "blood group",
                  style: TextStyle(fontSize: 15)),
              trailing: Icon(FontAwesomeIcons.pencilAlt, size: 25)),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          Divider(
            thickness: 0.5,
          ),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          ListTile(
              leading: Icon(Icons.location_on, size: 30),
              title: Text("Location", style: TextStyle(fontSize: 25)),
              subtitle: Text(u1.location != null ? u1.location : "location",
                  style: TextStyle(fontSize: 15)),
              trailing: Icon(FontAwesomeIcons.pencilAlt, size: 25)),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          Divider(
            thickness: 0.5,
          ),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          ListTile(
              leading: Icon(Icons.email, size: 30),
              title: Text("Email", style: TextStyle(fontSize: 25)),
              subtitle: Text(u1.email != null ? u1.email : "email",
                  style: TextStyle(fontSize: 15)),
              trailing: Icon(FontAwesomeIcons.pencilAlt, size: 25)),
          Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          Divider(
            thickness: 0.5,
          ),
          Padding(padding: const EdgeInsets.only(bottom: 15)),
          // ListTile(
          //     leading: Icon(Icons.location_on, size: 30),
          //     title: Text("Birth Date", style: TextStyle(fontSize: 25)),
          //     subtitle: Text("Birth Date", style: TextStyle(fontSize: 15)),
          //     trailing: Icon(FontAwesomeIcons.pencilAlt, size: 25)),
          // Padding(padding: const EdgeInsets.only(bottom: 7.5)),
          // Divider(
          //   thickness: 0.5,
          // ),
          Text(
            "Available to Donate",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.left,
          )
        ])));
  }
}

class Member extends StatefulWidget {
  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Nearby Member", style: TextStyle(fontSize: 20)),
            backgroundColor: Color(0xFFf7418c)),
        body: SingleChildScrollView());
  }
}

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Request", style: TextStyle(fontSize: 20)),
            backgroundColor: Color(0xFFf7418c)),
        body: SingleChildScrollView());
  }
}

class BloodData extends StatefulWidget {
  @override
  _BloodDataState createState() => _BloodDataState();
}

class _BloodDataState extends State<BloodData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Blood Availability", style: TextStyle(fontSize: 20)),
            backgroundColor: Color(0xFFf7418c)),
        body: SingleChildScrollView());
  }
}
