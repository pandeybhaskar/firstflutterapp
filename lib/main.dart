import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstflutterapp/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final db = FirebaseFirestore.instance;

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(const WelcomePage());
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.amber.shade100,
        body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/sea.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                const Center(
                  child: SizedBox(
                    width: 400,
                    height: 500,
                    child: WelcomeForm(),
                  ),
                )
              ],
            ),
          );
  }
}

class WelcomeForm extends StatefulWidget {
  const WelcomeForm({super.key});

  @override
  State<WelcomeForm> createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade200.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  'Welcome to Page',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.orange
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Colors.orange
                    ),
                  ),
                  label: Text(
                      'Name',
                    style: TextStyle(
                      color: Colors.orange
                    ),
                  ),
                  hintText: 'Name',
                  suffixIcon: Icon(
                      Icons.person,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Colors.orange
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Colors.orange
                      ),
                    ),
                    label: Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.orange
                      ),
                    ),
                    hintText: 'Email',
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.orange,
                    )
                ),
              ),
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Colors.orange
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Colors.orange
                      ),
                    ),
                    label: Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.orange
                      ),
                    ),
                    hintText: 'Password',
                    suffixIcon: Icon(
                      Icons.password,
                      color: Colors.orange,
                    )
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepOrange.shade400),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: const Text('Register'),
                              content: SizedBox(
                                height:60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(nameController.text),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(emailController.text),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(passwordController.text)
                                    ],
                                  )
                                ],
                              ),
                            ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      final data = <String, dynamic>{
                                        "name"      : nameController.text,
                                        "email"     : emailController.text,
                                        "password"  : passwordController.text
                                      };
                                      db.collection("users").add(data).then((value) => debugPrint(value.id + value.path));

                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=> const MainPage())
                                      );
                                    },
                                    child: const Text(
                                        'Proceed',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                ),
                                TextButton(
                                    onPressed: ()=>
                                      Navigator.of(context).pop(),
                                    child: const Text(
                                      'Discard',
                                      style: TextStyle(color: Colors.red),
                                    )
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: const Text(
                        'REGISTER',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.lightGreenAccent.shade200 ),
                      ),
                    onPressed: () {
                      debugPrint('login button ');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const MainPage())
                      );
                    },
                    child: const Text(
                        'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
