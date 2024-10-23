import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth_provider.dart';

class BookingCelenderScreen extends StatefulWidget {
  const BookingCelenderScreen({super.key});

  @override
  State<BookingCelenderScreen> createState() => _BookingCelenderScreenState();
}

class _BookingCelenderScreenState extends State<BookingCelenderScreen> {
  // late AuthProvider _authProvider;
  //
  // @override
  // void initState() {
  //   _authProvider = Provider.of<AuthProvider>(context);
  //   _authProvider.loadUser();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    _authProvider.loadUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authProvider.logout();
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
                  Text('uid: ${_authProvider.user?.uid ?? "N/A"}'),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
