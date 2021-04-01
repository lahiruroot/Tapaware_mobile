import 'package:flutter/material.dart';
import 'package:tap_aware/success.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  Location location = new Location(); //locatipn tracking setup
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  sendLoaction() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }

      _locationData = await location.getLocation();

      await FirebaseFirestore.instance.collection("users").doc("user").set({
        "latitude": _locationData.latitude,
        "logitude": _locationData.longitude
      });

      print(_locationData.latitude);
      print(_locationData.longitude);
    }
  }

  test(DateTime d) {
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        //getting user locate data
        "massage": "Emmergenecy",
        "latitude": currentLocation.latitude,
        "logitude": currentLocation.longitude,
        "date": d,
      });
      print("asdadad");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            "images/titile.png",
            height: 150.0,
            width: 151.0,
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment(0, -0.8),
                        child: Image.asset(
                          "images/login.png",
                          height: 400,
                          width: 450,
                        ), //main image
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.message,
                        color: Colors.green,
                        size: 60,
                      ),
                      title: const Text(
                        'Hey ',
                        style: TextStyle(fontSize: 30),
                      ),
                      subtitle: Text(
                        'Enter Your Message',
                        style: TextStyle(
                            fontSize: 25, color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        maxLength: 25,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            hintText: "Your Message"),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          // textColor: const Color(0xFF6200EE),
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Text('ACTION 1'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => success()));
                            test(DateTime.now());
                            // Perform some action
                          },
                          child: const Text('Locate'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
