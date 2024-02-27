import 'package:billSplit/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(56, 64, 220, 0.612),
            Color.fromRGBO(7, 7, 7, 100)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(0, 214, 12, 12),
          title: const Text('Billify'),
        ),
        body: _isLoading
            ? _buildLoading()
            : _buildForm(), // meaning: if _isLoading is true, then _buildLoading(), else _buildForm()
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmailField(),
          _buildPasswordField(),
          _buildLoginButton(),
          _buildRegisterButton(),
          // _buildResetPasswordButton(),
          _buildAnonymousLoginButton(),
        ],
      ),
    );
  }

  Widget _buildAnonymousLoginButton() {
    return ElevatedButton(
      onPressed: _loginAnonymously,
      child: const Text('Login Anonymously'),
    );
  }

  void _loginAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      final User? user = userCredential.user;
      print('Logged in with ID: ${user!.uid}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyHomePage(title: 'Bill Split', firebaseuid: user.uid),
        ),
      );
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          // color should be white
          // iconColor: Colors.white,
          labelText: 'Email',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide()),
          labelStyle: const TextStyle(
            // font color to white
            // color: Colors.white,
            // backgroundColor: Colors.white,

            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter your email address',
          prefixIcon: const Icon(
            Icons.email,
          ),
          // fillColor: Colors.white,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Email is required';
          }
          final RegExp regex = RegExp(
              r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
          if (!regex.hasMatch(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide()),
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter your password',
          prefixIcon: const Icon(
            Icons.lock,
          ),
          fillColor: Colors.white,
        ),
        obscureText: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Password is required';
          }
          if (!RegExp(r'^.{6,}$').hasMatch(value)) {
            return 'Password must be at least six characters long';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      child: const Text('LOGIN'),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _register,
      child: const Text('REGISTER'),
    );
  }

  Widget _buildResetPasswordButton() {
    return ElevatedButton(
      onPressed: _resetPassword,
      child: const Text('RESET PASSWORD'),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final String email = _emailController.text;
        final String password = _passwordController.text;
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // String uid = userCredential.user!.uid;
        print('User ID:${userCredential.user!.uid}');

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyHomePage(
                title: 'Bill Split', firebaseuid: userCredential.user!.uid),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('No acc;ount was found for the given email.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('The password is incorrect.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          print(e);
          // Show error alert
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Login failed'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final String email = _emailController.text;
        final String password = _passwordController.text;
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('The password provided is too weak.'),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else if (e.code == 'email-already-in-use') {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('The account already exists for that email.'),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            print(e);
            // Create dialog box here with error message received from Firebase
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Registration failed'),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        } catch (e) {
          print(e);
        }

        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(userCredential);
        final User? user = userCredential.user;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                MyHomePage(title: 'Bill Split', firebaseuid: user!.uid),
          ),
        );

        // Show success alert
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Registration successful'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                            title: 'Bill Split', firebaseuid: user!.uid),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        // Handle error
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final String email = _emailController.text;
        await _auth.sendPasswordResetEmail(email: email);
        // Show a message to the user that the password reset email has been sent
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        // Handle error
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
