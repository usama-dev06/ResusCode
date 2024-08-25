import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/providers/colorToggle_provoder.dart';

import '../Levels/data.dart';
import '../Login/login.dart';
import '../providers/levelcompletion_provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/user_authprovider.dart';
import '../utils.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        // iphone14pro19mXF (21:1159)
        padding: EdgeInsets.fromLTRB(7 * fem, 93 * fem, 7 * fem, 24.47 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/background.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // group7Q4R (21:1164)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                padding: EdgeInsets.fromLTRB(
                    121 * fem, 41 * fem, 106 * fem, 0 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30 * fem),
                  gradient: LinearGradient(
                    begin: Alignment(-4, -3.657),
                    end: Alignment(1.479, 1.371),
                    colors: <Color>[Color(0xffd9d9d9), Color(0x00d9d9d9)],
                    stops: <double>[0, 1],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogrouppkqpAC1 (3TpLFKKer6k6GThoy6pKqP)
                      margin: EdgeInsets.fromLTRB(
                          18 * fem, 0 * fem, 33 * fem, 61 * fem),
                      width: double.infinity,
                      height: 166 * fem,
                      child: EditProfile(fem: fem, ffem: ffem),
                    ),
                    Container(
                      // autogroupzsqdmLD (3TpLPUkif52zQvLnSRZSQD)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 45 * fem, 13 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // iconmedalhjf (21:1195)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 24 * fem, 1 * fem),
                            width: 36 * fem,
                            height: 36 * fem,
                            child: Image.asset(
                              'assets/icon-medal.png',
                              width: 36 * fem,
                              height: 36 * fem,
                            ),
                          ),
                          Text(
                            // level2DCD (21:1201)
                            'Level 2',
                            style: SafeGoogleFont(
                              'Nexa Bold',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2575 * ffem / fem,
                              letterSpacing: -0.4 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupdmxhjwF (3TpLVPkXoeiTYETSz4DmxH)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 31 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // iconuserprogresseoK (21:1200)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 25 * fem, 0 * fem),
                            width: 34 * fem,
                            height: 34 * fem,
                            child: Image.asset(
                              'assets/icon-user-progress.png',
                              width: 34 * fem,
                              height: 34 * fem,
                            ),
                          ),
                          Text(
                            // overallX6R (21:1202)
                            '40% over all',
                            style: SafeGoogleFont(
                              'Nexa Bold',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2575 * ffem / fem,
                              letterSpacing: -0.4 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupxicd3aZ (3TpLaomBFUhq74u9zRXicd)
                      margin: EdgeInsets.fromLTRB(
                          3 * fem, 0 * fem, 59 * fem, 98 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // vectoryDK (21:1203)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 27 * fem, 6 * fem),
                            width: 30 * fem,
                            height: 30 * fem,
                            child: Image.asset(
                              'assets/vector-ZZT.png',
                              width: 30 * fem,
                              height: 30 * fem,
                            ),
                          ),
                          Text(
                            // goodtbB (21:1204)
                            'Good',
                            style: SafeGoogleFont(
                              'Nexa Bold',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2575 * ffem / fem,
                              letterSpacing: -0.4 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  // Call the signOut method from the Auth Provider
                  await Provider.of<UserAuthProvider>(context, listen: false)
                      .signOut();
// Inside your logout logic, after signing out the user
                  /*  final levelCompletionProvider =
                      Provider.of(context).read<LevelCompletionProvider>(); */
                  //   levelCompletionProvider.reset(); // Call the reset method

                  Provider.of(context).read<OutlineProvider>().reset();
                  Provider.of(context).read<NavigationProvider>().reset();

                  levelsDataFirebase.clear();
                  /*      UsernameGlobal = "";
                  UseriDGlobal = "";
         */
                  // For example, if you have a LoginPage, you can navigate to it like this:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
                },
                child: Text('Logout',
                    style: TextStyle(
                        color: Colors.amber, // Text color
                        fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.fem,
    required this.ffem,
  });

  final double fem;
  final double ffem;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  String? _profileImageURL; // Store the profile image URL

/*   @override
  void initState() {
    super.initState();

    // Retrieve the user's profile image URL from Firestore here
    // Replace 'currentUserUid' with the actual UID of the logged-in user
// Use Future.delayed to add a small delay
    Future.delayed(Duration(milliseconds: 100), () {
      // Retrieve the user's profile image URL from Firestore here
      // Replace 'currentUserUid' with the actual UID of the logged-in user
      UserAuthProvider userProvider = context.read<UserAuthProvider>();
      print(" chkkkk ${userProvider.userId}...${userProvider.username}");
      FirebaseFirestore.instance
          .collection('users')
          .doc('${userProvider.username}')
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          setState(() {
            _profileImageURL = docSnapshot.data()!['profileImage'];
            print("Profile Image1 URL: $_profileImageURL");
          });
        }
      }).catchError((error) {
        print('Error loading profile image: $error');
      });
    });
  } */

  @override
  Widget build(BuildContext context) {
    UserAuthProvider userProvider = context.read<UserAuthProvider>();
    // print("Profile Image URLvv: $_profileImageURL");

    return Stack(
      children: [
        Positioned(
          left: 0 * widget.fem,
          top: 0 * widget.fem,
          child: Align(
            child: SizedBox(
                width: 113 * widget.fem,
                height: 113 * widget.fem,
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc('${userProvider.userId}')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While the data is being fetched, you can display a loading indicator
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If there's an error, display a placeholder profile icon
                      return ClipOval(
                        child: Image.asset(
                          'assets/icon-user-circle.png',
                          width: 113 * widget.fem,
                          height: 113 * widget.fem,
                        ),
                      );
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      // If the document doesn't exist, or 'profileImage' field doesn't exist,
                      // display a placeholder profile icon
                      return ClipOval(
                        child: Image.asset(
                          'assets/icon-user-circle.png',
                          width: 113 * widget.fem,
                          height: 113 * widget.fem,
                        ),
                      );
                    } else {
                      try {
                        // Check if the 'profileImage' field exists in the document
                        String? profileImageURL =
                            snapshot.data!.get('profileImage');

                        // If 'profileImage' doesn't exist or is null, display a placeholder profile icon
                        if (profileImageURL == null ||
                            profileImageURL.isEmpty) {
                          return ClipOval(
                            child: Image.asset(
                              'assets/icon-user-circle.png',
                              width: 113 * widget.fem,
                              height: 113 * widget.fem,
                            ),
                          );
                        }

                        return ClipOval(
                          child: Image.network(
                            profileImageURL,
                            width: 113 * widget.fem,
                            height: 113 * widget.fem,
                            fit: BoxFit.cover,
                          ),
                        );
                      } catch (e) {
                        print('Error in FutureBuilder: $e');
                        // Display a placeholder profile icon in case of an error
                        return ClipOval(
                          child: Image.asset(
                            'assets/icon-user-circle.png',
                            width: 113 * widget.fem,
                            height: 113 * widget.fem,
                          ),
                        );
                      }
                    }
                  },
                )),
          ),
        ),
        Positioned(
          left: 28 * widget.fem,
          top: 113 * widget.fem,
          child: Align(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  userProvider.username!,
                  style: SafeGoogleFont(
                    'Timmana',
                    fontSize: 25 * widget.ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.6275 * widget.ffem / widget.fem,
                    letterSpacing: -0.64 * widget.fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 80 * widget.fem,
          top: 86 * widget.fem,
          child: Align(
            child: GestureDetector(
              // Inside your GestureDetector onTap callback
              // Inside your onTap callback for selecting a new profile image
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  // Upload the new profile image to Firebase Storage
                  Reference storageReference = FirebaseStorage.instance
                      .ref()
                      .child('profile_images')
                      .child('${userProvider.username}.jpg');

                  UploadTask uploadTask =
                      storageReference.putFile(File(pickedFile.path));

                  // Wait for the upload to complete and get the download URL
                  TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

                  // Get the download URL for the uploaded image
                  String downloadURL = await snapshot.ref.getDownloadURL();

                  // Check if the document exists in Firestore
                  DocumentSnapshot documentSnapshot = await FirebaseFirestore
                      .instance
                      .collection('users')
                      .doc('${userProvider.username}')
                      .get();

                  if (documentSnapshot.exists) {
                    // Document exists, update the 'profileImage' field
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc('${userProvider.username}')
                        .update({'profileImage': downloadURL});
                  } else {
                    // Document doesn't exist, create a new document
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc('${userProvider.username}')
                        .set({'profileImage': downloadURL});
                  }

                  setState(() {
                    _image = File(pickedFile.path);
                    _profileImageURL = downloadURL; // Store the new image URL
                  });

                  print('Profile image updated successfully.');
                }
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                width: 33 * widget.fem,
                height: 33 * widget.fem,
                child: Icon(
                  _image != null || _profileImageURL != null
                      ? Icons.edit
                      : Icons
                          .add_a_photo, // Change icon based on image availability
                  color: Colors.black, // Change the icon color as needed
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
