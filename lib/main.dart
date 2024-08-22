import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final localAuthentication = LocalAuthentication();

  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!isAuthenticated) {
            final bool canAuthenticateWithBiometrics =
                await localAuthentication.canCheckBiometrics;

            print(canAuthenticateWithBiometrics);

            if (canAuthenticateWithBiometrics) {
              try {
                final bool didAuthenticate =
                    await localAuthentication.authenticate(
                  localizedReason: 'Por favor, autentique-se',
                );

                setState(() {
                  isAuthenticated = didAuthenticate;
                });
              } catch (e) {
                print(e);
              }
            }
          } else {
            setState(() {
              isAuthenticated = false;
            });
          }
        },
        tooltip: 'Increment',
        child: isAuthenticated
            ? const Icon(Icons.lock)
            : const Icon(Icons.lock_open),
      ),
    );
  }
}
