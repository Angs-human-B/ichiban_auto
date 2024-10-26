import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth_provider.dart';
import '../common.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            accountName: Row(
              children: [
                Text(authProvider.user?.name ?? 'User Name'),
                Text("-(${authProvider.user?.role ?? 'Role'})"),
              ],
            ),
            accountEmail: Text(authProvider.user?.email ?? 'user@example.com'),
            currentAccountPicture: CircleAvatar(
              child: Text(
                authProvider.user?.name.substring(0, 1) ?? 'U',
                style: const TextStyle(fontSize: 40),
              ),
            ),
            decoration: BoxDecoration(color: buttonRed),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              await authProvider.logout();
              Navigator.of(context).pushReplacementNamed('/logInScreen');
            },
          ),
        ],
      ),
    );
  }
}
