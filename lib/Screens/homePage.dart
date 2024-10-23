import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  late AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authProvider.logout(); // Uncomment this line to call the logout method
              Navigator.of(context).pushReplacementNamed('/logInScreen');
            },
          ),
        ],
      ),
      body: Center(
        child: _authProvider.user != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${_authProvider.user?.name ?? "N/A"}'),
            Text('Email: ${_authProvider.user?.email ?? "N/A"}'),
            Text('Phone: ${_authProvider.user?.phone ?? "N/A"}'),
            Text('Role: ${_authProvider.user?.role ?? "N/A"}'),
          ],
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
