import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/navigation.dart';

import '../providers/user_authprovider.dart';
import '../utils.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// default login
//login direct after register

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  // TextEditingController(text: "kashifasgh@gmail.com");
  final TextEditingController passwordController = TextEditingController();
  //TextEditingController(text: "12345678");
  final TextEditingController nameController = TextEditingController();
// Create a provider for user authentication

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // Handle Google Sign-In cancellation.
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to the home page or perform the necessary action upon successful login.
    } catch (e) {
      print('Error: $e');
      // Handle login errors here.
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 13 * fem),
                  width: 408 * fem,
                  height: 387 * fem,
                  child: Image.asset(
                    'assets/resus-final-2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(30 * fem, 0 * fem, 0 * fem, 10 * fem),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3 * ffem / fem,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 430 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8 * fem,
                        top: 2 * fem,
                        child: Container(
                          width: 391 * fem,
                          height: 55 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30 * fem),
                            gradient: LinearGradient(
                              begin: Alignment(-4, -3.657),
                              end: Alignment(1.479, 1.371),
                              colors: <Color>[
                                Color(0xffd9d9d9),
                                Color(0x00d9d9d9)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 391 * fem,
                              height: 55 * fem,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30 * fem),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 5),
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Enter Email',
                                      hintStyle: TextStyle(color: Colors.white),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    onChanged: (value) {
                                      print('Current text: $value');
                                    },
                                    onSubmitted: (value) {
                                      print('Submitted text: $value');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8 * fem,
                        top: 89 * fem,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: 391 * fem,
                            height: 55 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              gradient: LinearGradient(
                                begin: Alignment(-4, -3.657),
                                end: Alignment(1.479, 1.371),
                                colors: <Color>[
                                  Color(0xffd9d9d9),
                                  Color(0x00d9d9d9)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 391 * fem,
                                height: 55 * fem,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30 * fem),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 15, top: 5),
                                    child: TextField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Enter Password',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      textAlign: TextAlign.start,
                                      obscureText: true,
                                      onChanged: (value) {
                                        print('Current text: $value');
                                      },
                                      onSubmitted: (value) {
                                        print('Submitted text: $value');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70 * fem,
                        top: 244 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 268 * fem,
                            height: 3 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffd9d9d9),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30 * fem,
                        top: 63 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 85 * fem,
                            height: 26 * fem,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3 * ffem / fem,
                                fontStyle: FontStyle.italic,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 142 * fem,
                        top: 256 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 129 * fem,
                            height: 26 * fem,
                            child: Text(
                              'Signup or login',
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3 * ffem / fem,
                                fontStyle: FontStyle.italic,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 135 * fem,
                        top: 171 * fem,
                        child: Container(
                          /*    padding: EdgeInsets.fromLTRB(
                                46 * fem, 8 * fem, 44 * fem, 0 * fem), */
                          width: 135 * fem,
                          height: 44 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xff00c2cb),
                            borderRadius: BorderRadius.circular(30 * fem),
                          ),
                          child: SigninBUtton(
                            ffem: ffem,
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 181 * fem,
                        top: 293 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 52 * fem,
                            height: 52 * fem,
                            child: Image.asset(
                              'assets/icon-google.png',
                              width: 52 * fem,
                              height: 52 * fem,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 135 * fem,
                        top: 330 * fem,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              10, 30 * fem, 0 * fem, 0 * fem),
                          child: Container(
                            /*    padding: EdgeInsets.fromLTRB(
                                46 * fem, 8 * fem, 44 * fem, 0 * fem), */
                            width: 135 * fem,
                            height: 44 * fem,
                            decoration: BoxDecoration(
                              color: Color(0xff00c2cb),
                              borderRadius: BorderRadius.circular(30 * fem),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Add the waiting indicator and disable the "Register" button when _isRegistering is true
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Registeration(
                                      nameController: nameController,
                                      emailController: emailController,
                                      passwordController: passwordController,
                                    );
                                  },
                                );
                              },

/* 
  */
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w400,
                                  // height: 1.6275 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SigninBUtton extends StatefulWidget {
  SigninBUtton({
    super.key,
    required this.ffem,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final double ffem;

  @override
  State<SigninBUtton> createState() => _SigninBUttonState();
}

class _SigninBUttonState extends State<SigninBUtton> {
  final userAuth = UserAuthProvider();
  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    bool _isSigningIn = false;

    try {
      setState(() {
        _isSigningIn = true; // Set _isSigningIn to true when signing in starts
      });

      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );

      if (authResult.user != null) {
        print("userbbb ${authResult.user!.displayName} \n \n");
        print("User is not null during sign-in");
        final displayName = authResult.user!.displayName;
        print("User's display name during sign-in: $displayName");

        userAuth.initializeUser(
          authResult.user!.uid,
          authResult.user!.displayName ?? '',
        );

        UserAuthProvider userProvider = context.read<UserAuthProvider>();

        userProvider.setUsername(authResult.user!.displayName);
        print("user ${authResult.user!.displayName} \n \n  ");
        userProvider.setUserId(authResult.user!.uid);

        setState(() {
          _isSigningIn =
              false; // Set _isSigningIn back to false after successful sign-in
        });

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        // Navigate to the home page or perform the necessary action upon successful login.
      } else {
        // Handle the case where authResult.user is null
        setState(() {
          _isSigningIn = false; // Set _isSigningIn back to false on error
        });
        print('Error: User is null');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign-In Failed'),
              content: Text('An error occurred during sign-in.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _isSigningIn = false; // Set _isSigningIn back to false on error
      });
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign-In Failed'),
            content: Text('An error occurred during sign-in.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        signInWithEmailAndPassword(context);
      },
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 22 * widget.ffem,
          fontWeight: FontWeight.w400,
          // height: 1.6275 * ffem / fem,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}

class Registeration extends StatefulWidget {
  Registeration({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  File? _image;

  bool _isRegistering = false; // Add this variable
  Future<void> requestPermissions() async {
    // Request multiple permissions as needed (customize this list)
    final permissions = [
      Permission.camera,
      Permission.storage,
      // Add other permissions here
    ];

    // Request permissions
    Map<Permission, PermissionStatus> statuses = await permissions.request();

    // Check permission statuses and show dialogs for denied permissions
    for (var permission in permissions) {
      if (statuses[permission]!.isDenied) {
        // Show a dialog if permission is denied
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text(
                  'Please grant ${permission.toString().split('.')[1]} permission to register.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    final userAuth = UserAuthProvider();

    try {
      setState(() {
        _isRegistering = true;
      });

      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );

      final uid = authResult.user?.uid; // Use ?. to handle a potential null UID

      final displayName =
          widget.nameController.text; // Get display name from widget

      print("User ID: $uid");
      print("Display Name: $displayName");

      if (uid != null) {
        await authResult.user!.updateDisplayName(displayName);

        userAuth.initializeUser(uid, displayName);

        final userReference =
            FirebaseFirestore.instance.collection('users').doc(uid);

        final userData = {
          'name': widget.nameController.text,
          'email': widget.emailController.text,
          // Add other user data fields as needed.
        };

        if (_image != null) {
          final storageRef =
              FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

          await storageRef.putFile(_image!).catchError((error) {
            print("Error uploading image: $error");
          });

          final imageUrl = await storageRef.getDownloadURL();
          print("Image URL: $imageUrl");

          userData['profileImage'] = imageUrl;
        }

        print("User Data: $userData");

        await userReference.set(userData).catchError((error) {
          print("Error setting user data: $error");
        });

        UserAuthProvider userProvider = context.read<UserAuthProvider>();

        userProvider.setUsername(displayName); // Use displayName here
        userProvider.setUserId(uid);

        setState(() {
          _isRegistering = false;
        });

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      } else {
        // Handle the case where uid is null
        setState(() {
          _isRegistering = false;
        });
        String errorMessage = 'An error occurred during registration.';

        if (uid == null) {
          errorMessage = 'Failed to create a user account.';
        }

        print("Registration Failed: $errorMessage");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registration Failed'),
              content: Text('$errorMessage'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isRegistering = false;
      });

      print("Registration Failed: An error occurred during registration.");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('An error occurred during registration.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Register'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Picture Picker
          profileimgWidget(
            image: _image,
            onImageSelected: (image) {
              setState(() {
                _image = image;
              });
            },
          ),
          TextField(
            controller: widget.nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          TextField(
            controller: widget.emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
            ),
          ),
          TextField(
            controller: widget.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          if (_isRegistering)
            CircularProgressIndicator(), // Show a waiting indicator
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _isRegistering
              ? null
              : () {
                  registerWithEmailAndPassword(context);
                },
          child: Text('Register'),
        ),
      ],
    );
  }
}

class profileimgWidget extends StatefulWidget {
  File? image;
  final Function(File?)? onImageSelected; // Add the callback function

  profileimgWidget({required this.image, this.onImageSelected});

  @override
  State<profileimgWidget> createState() => _profileimgWidgetState();
}

class _profileimgWidgetState extends State<profileimgWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          final selectedImage = File(pickedFile.path);
          setState(() {
            widget.image = selectedImage;
          });
          // Call the callback function to notify the parent widget of the selected image
          if (widget.onImageSelected != null) {
            widget.onImageSelected!(selectedImage);
          }
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: widget.image != null
            ? ClipOval(
                child: Image.file(
                  widget.image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(Icons.add_a_photo, size: 40),
      ),
    );
  }
}
