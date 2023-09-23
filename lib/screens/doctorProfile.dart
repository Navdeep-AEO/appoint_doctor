import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appoint_doctor/screens/bookingScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfile extends StatefulWidget {
  final String? doctor;

  const DoctorProfile({Key? key, this.doctor}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .orderBy('name')
              .startAt([widget.doctor]).endAt(
                  [widget.doctor! + '\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: ListView.builder(
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left_sharp,
                              color: Colors.indigo,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(document['image']),
                          //backgroundColor: Colors.lightBlue[100],
                          radius: 80,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: ()async{
                            try {
                              // Initialize Firebase (if not already initialized)
                              await Firebase.initializeApp();

                              // Reference to the Firestore database
                              FirebaseFirestore firestore = FirebaseFirestore.instance;

                              // Reference to the "doctors" collection
                              CollectionReference doctorsCollection = firestore.collection('doctors');

                              // Add each JSON object in the list to the "doctors" collection
                              [
                                {
                                  "address": "123, Main Street, Kolkata, West Bengal, India",
                                  "closeHour": "4:30 PM",
                                  "image": "https://example.com/doctor1.jpg",
                                  "name": "Dr. Rajesh Sharma",
                                  "openHour": "9:00 AM",
                                  "phone": "+91 12345 67890",
                                  "rating": 4.5,
                                  "specification": "Cardiologist",
                                  "type": "Cardiologist"
                                },
                                {
                                  "address": "456, Park Avenue, Mumbai, Maharashtra, India",
                                  "closeHour": "5:15 PM",
                                  "image": "https://example.com/doctor2.jpg",
                                  "name": "Dr. Priya Patel",
                                  "openHour": "8:30 AM",
                                  "phone": "+91 98765 43210",
                                  "rating": 4.2,
                                  "specification": "Dentist",
                                  "type": "Dentist"
                                },
                                {
                                  "address": "789, Lake Road, Delhi, India",
                                  "closeHour": "3:45 PM",
                                  "image": "https://example.com/doctor3.jpg",
                                  "name": "Dr. Sanjay Kumar",
                                  "openHour": "10:00 AM",
                                  "phone": "+91 87654 32109",
                                  "rating": 4.8,
                                  "specification": "Eye Specialist",
                                  "type": "Eye Specialist"
                                },
                                {
                                  "address": "567, Green Street, Bangalore, Karnataka, India",
                                  "closeHour": "2:30 PM",
                                  "image": "https://example.com/doctor4.jpg",
                                  "name": "Dr. Meera Reddy",
                                  "openHour": "8:45 AM",
                                  "phone": "+91 23456 78901",
                                  "rating": 4.1,
                                  "specification": "Orthopaedic",
                                  "type": "Orthopaedic"
                                },
                                {
                                  "address": "321, Maple Lane, Chennai, Tamil Nadu, India",
                                  "closeHour": "1:15 PM",
                                  "image": "https://example.com/doctor5.jpg",
                                  "name": "Dr. Aarav Gupta",
                                  "openHour": "10:30 AM",
                                  "phone": "+91 76543 21098",
                                  "rating": 4.9,
                                  "specification": "Paediatrician",
                                  "type": "Paediatrician"
                                },
                                {
                                  "address": "234, Oak Street, Hyderabad, Telangana, India",
                                  "closeHour": "5:00 PM",
                                  "image": "https://example.com/doctor6.jpg",
                                  "name": "Dr. Kavya Singh",
                                  "openHour": "9:15 AM",
                                  "phone": "+91 34567 89012",
                                  "rating": 4.3,
                                  "specification": "Cardiologist",
                                  "type": "Cardiologist"
                                },
                                {
                                  "address": "678, Pine Road, Pune, Maharashtra, India",
                                  "closeHour": "3:00 PM",
                                  "image": "https://example.com/doctor7.jpg",
                                  "name": "Dr. Siddharth Joshi",
                                  "openHour": "8:15 AM",
                                  "phone": "+91 87654 32109",
                                  "rating": 4.6,
                                  "specification": "Dentist",
                                  "type": "Dentist"
                                },
                                {
                                  "address": "890, Elm Street, Jaipur, Rajasthan, India",
                                  "closeHour": "4:00 PM",
                                  "image": "https://example.com/doctor8.jpg",
                                  "name": "Dr. Ananya Khanna",
                                  "openHour": "10:15 AM",
                                  "phone": "+91 98765 43210",
                                  "rating": 4.7,
                                  "specification": "Orthopaedic",
                                  "type": "Orthopaedic"
                                }
                              ]
                                  .forEach((doctor) async {
                                await doctorsCollection.add(doctor);
                              });

                              print('Doctors added successfully.');

                            } catch (e) {
                              print('Error adding doctors: $e');
                            }
                          },
                          child: Text(
                            document['name'],
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          document['type'],
                          style: GoogleFonts.lato(
                              //fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < document['rating']; i++)
                              Icon(
                                Icons.star_rounded,
                                color: Colors.indigoAccent,
                                size: 30,
                              ),
                            if (5 - document['rating'] > 0)
                              for (var i = 0; i < 5 - document['rating']; i++)
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.black12,
                                  size: 30,
                                ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 22, right: 22),
                          alignment: Alignment.center,
                          child: Text(
                            document['specification'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.place_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  document['address'],
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.phone),
                              SizedBox(
                                width: 11,
                              ),
                              TextButton(
                                onPressed: () =>
                                    _launchCaller("tel:" + document['phone']),
                                child: Text(
                                  document['phone'].toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.access_time_rounded),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Working Hours',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.only(left: 60),
                          child: Row(
                            children: [
                              Text(
                                'Today: ',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                document['openHour'] +
                                    " - " +
                                    document['closeHour'],
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.indigo.withOpacity(0.9),
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                    doctor: document['name'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Book an Appointment',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
