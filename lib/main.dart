import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Basics',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstRoute(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondRoute(),
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
    );
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains a customizable
// title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class NavigationButton extends StatelessWidget {
  NavigationButton({
    Key key,
    this.buttonText,
    this.routeName,
    this.arguments,
  }) : super(key: key);

  final String buttonText;
  final String routeName;
  final ScreenArguments arguments;

  // A button that navigates to a named route. The named route
  // extracts the arguments by itself.
  @override
  Widget build(BuildContext context){
    return RaisedButton(
      child: Text(buttonText),
      onPressed: () {
        // When the user taps the button, navigate to the specific route
        // and provide the arguments as part of the RouteSettings.
        Navigator.pushNamed(
          context,
          routeName,
          arguments: arguments,
        );
      },
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        /* child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.pushNamed(context, '/second');
          },
        ), */
        child: NavigationButton(
          buttonText: 'Custom navigation button text',
          routeName: ExtractArgumentsScreen.routeName,
          arguments: ScreenArguments(
            'Extract Arguments Screen',
            'This message is extracted in the build method. Hot reload',
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

// A widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}
