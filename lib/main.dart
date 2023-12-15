// import 'package:flutter/material.dart';
// import 'package:xcrowme/pages/dashboard.dart';
// import 'package:xcrowme/pages/login.dart';
// import 'package:xcrowme/pages/register.dart';
// import 'package:xcrowme/pages/registration_screen.dart';
// import 'package:xcrowme/pages/welcome.dart';
// import 'package:xcrowme/providers/auth.dart';
// import 'package:xcrowme/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:xcrowme/utils/shared_preference.dart';

// import 'domain/user.dart';
// import 'dart:core';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//   Future<User> getUserData() => UserPreferences().getUser();

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//       ],
//       child: MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             visualDensity: VisualDensity.adaptivePlatformDensity,
//           ),
//           home: FutureBuilder(
//               future: getUserData(),
//               builder: (context, snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.none:
//                   case ConnectionState.waiting:
//                     return CircularProgressIndicator();
//                   default:
//                     if (snapshot.hasError)
//                       return Text('Error: ${snapshot.error}');
//                     else if (snapshot.data == null)
//                       return Login();
//                     // else if ((snapshot.data as User).token == null)
//                     //   return Login();
//                     else
//                       return Welcome(user: snapshot.data as User);
//                 }
//               }),
//           routes: {
//             '/dashboard': (context) => DashBoard(),
//             '/login': (context) => Login(),
//             '/register': (context) => Register(),
//           }),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:xcrowme/core/services/api.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final apiProvider = Provider((ref) => Api());

// void  main() {
// runApp(const ProviderScope(child: MyApp()));
// runApp(MyApp());

// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:RegistrationScreen(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:xcrowme/apis/auth.dart';
// import 'package:xcrowme/apis/auth/auth_api.dart';
// import 'package:xcrowme/common/ThemePage.dart';
import 'package:xcrowme/controllers/login_controller.dart';
// import 'package:xcrowme/models/user_cubit.dart';
// import 'package:xcrowme/pages/home/home.dart';
// import 'package:xcrowme/pages/registration/Signin.dart';
import 'package:xcrowme/screens/home_screen/index.dart';
// import 'package:xcrowme/screens/home.dart';
// import 'package:xcrowme/screens/home_screen/index.dart';
// import 'package:xcrowme/screens/registerPage.dart';
import 'package:xcrowme/screens/sign_in_screen/index.dart';
import 'package:xcrowme/screens/sign_up_screen/index.dart';
import 'package:xcrowme/screens/verify-otp_screen/index.dart';
// import 'package:xcrowme/utils/constant.dart';

// import 'models/user_model.dart';
// import 'pages/login_page.dart';
// import 'pages/register_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:xcrowme/screens/splash_screen/index.dart';

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class RegistrationScreen extends StatefulWidget {
//   RegistrationScreen({Key? key}) : super(key: key);

//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _controllerPassword = TextEditingController();
//   final _controllerPassword2 = TextEditingController();
//   final _controllerEmail = TextEditingController();
//   final _controllerFirstName = TextEditingController();
//   final _controllerLastName = TextEditingController();
//   final _controllerPhone = TextEditingController();
//   final _controllerDob = TextEditingController();

//   bool _isLoading = false;

//   Future<dynamic> _register() async {
//     setState(() {
//       _isLoading = true;
//     });

//     // Build the request headers
//     final headers = <String, String>{
//       'Authorization': 'API Key gi6paFHGatKXClIE',
//       'Content-Type': 'application/json',
//     };

//     // Build the request body
//     final body = <String, String>{
//       'password': _controllerPassword.text,
//       'password2': _controllerPassword2.text,
//       'email': _controllerEmail.text,
//       'first_name': _controllerFirstName.text,
//       'last_name': _controllerLastName.text,
//       'phone': _controllerPhone.text,
//       'dob': _controllerDob.text,
//     };

//     // Send the request
//     final response = await http.post('https://staging.api.cashrole.com/api/v1/merchant/register',
//       headers: headers,
//       body: jsonEncode(body),
//     );

//     setState(() {
//       _isLoading = false;
//     });

//     // Handle the response
//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//       // Do something with the response body
//       print(responseBody);
//     } else {
//       throw Exception('Failed to register');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registration'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TextFormField(
//                         controller: _controllerPassword,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a password';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: _controllerPassword2,
//                         decoration: InputDecoration(
//                           labelText: 'Confirm Password',
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm your password';
//                           }
//                           if (_controllerPassword.text != value) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: _controllerEmail,
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           // Add email validation if needed
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: _controllerFirstName,
//                         decoration: InputDecoration(
//                           labelText: 'First Name',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your first name';
//                           }
//                           return null;
//                         },
//                         ),
//                       ElevatedButton(
//                         child: _isLoading
//                             ? CircularProgressIndicator()
//                             : Text('Register'),
//                         onPressed: _isLoading ? null : () {
//                           if (_formKey.currentState.validate()) {
//                             register();
//                           }
//                         },
//                       )

//                         ])))));}

// void main() => runApp(Auth());
// class Auth extends StatelessWidget {
//   @override

//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: lightTheme(),
//       debugShowCheckedModeBanner: false,
//       home: Signin(),
//     );
//   return MultiBlocProvider(
//   providers: [BlocProvider(create:(context) => AuthBloc(LoginInitState(), AuthRepository))],
//   child:MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => LoginUi(),
//       '/contacts': (context) => Contact(),
//       '/addContacts':(context) => AddContacts()
//     }
//   ));
// }
// }
// import 'package:xcrowme/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:xcrowme/core/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final LoginController loginController = Get.put(LoginController());
   Get.lazyPut(() => LoginController());  // Initializes when needed
  runApp(
  GetMaterialApp(
      // home: isLoggedIn ? TokenExpirationChecker() : SignInScreen(),
      home:  SplashScreen(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes
      )
  );
}

// class TokenExpirationChecker extends StatefulWidget {
//   @override
//   _TokenExpirationCheckerState createState() => _TokenExpirationCheckerState();
// }

// class _TokenExpirationCheckerState extends State<TokenExpirationChecker> {
//   final int refreshTokenDuration = 5000; // Refresh token duration in milliseconds
//   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   Future<void> _checkTokenExpiration() async {
//     final SharedPreferences prefs = await _prefs;
//     final int loginTime = prefs.getInt('loginTime') ?? 0;
//     final int currentTime = DateTime.now().millisecondsSinceEpoch;

//     if (currentTime - loginTime >= refreshTokenDuration) {
//       // Token has expired, redirect to the login page
//       prefs.setBool('isLoggedIn', false);
//       Get.offAll(SignInScreen());
//     } else {
//       // Token is still valid, redirect to the home page
//       Get.offAll(HomeScreen());
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkTokenExpiration();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
// // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Signin(),
//       // initialRoute: RouteHelper.getInitial(),
//       // getPages: RouteHelper.routes
//     );
//   }
// }
// This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         return UserCubit(User());
//       },
//       child: GetMaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: FutureBuilder<Box>(
//             future: Hive.openBox(tokenBox),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 var box = snapshot.data;
//                 var token = box!.get("token");
//                 if (token != null) {
//                   return FutureBuilder<User?>(
//                       future: getUser(token),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           if (snapshot.data != null) {
//                             User user = snapshot.data!;
//                             user.token = token;
//                             context.read<UserCubit>().emit(user);
//                             return  SignUpPage();
//                           } else {
//                             return const  SignUpPage();
//                           }
//                         } else {
//                           return const  SignUpPage();
//                         }
//                       });
//                 } else {
//                   return const SignUpPage();
//                 }
//               } else if (snapshot.hasError) {
//                 return const SignInPage();
//               } else {
//                 return const SignInPage();
//               }
//             }
//             ),
//             initialRoute: RouteHelper.getInitial(),
//             getPages: RouteHelper.routes),
//     );
//   }
// }

// import 'package:xcrowme/apis/api.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './screens/addTodo.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => TodoProvider(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: HomePage(),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final todoP = Provider.of<TodoProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo App'),
//       ),
//       body: ListView.builder(
//         shrinkWrap: true,
//         itemCount: todoP.todos.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//               trailing: IconButton(
//                   icon: Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     todoP.deleteTodo(todoP.todos[index]);
//                   }),
//               title: Text(
//                 todoP.todos[index].title,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 todoP.todos[index].description,
//                 style: TextStyle(fontSize: 15, color: Colors.black),
//               ));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(
//             Icons.add,
//             size: 30,
//           ),
//           onPressed: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (ctx) => AddTodoScreen()));
//           }),
//     );
//   }
// }

// /
