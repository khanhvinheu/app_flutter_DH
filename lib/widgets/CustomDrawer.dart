import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import if you are using Provider
import 'package:donghanh_flutter/generated/l10n.dart';
import 'package:donghanh_flutter/utils/route_utils.dart';
import 'package:donghanh_flutter/screens/forgot_password_screen.dart';
import 'package:donghanh_flutter/screens/setting_screen.dart';
import 'package:donghanh_flutter/providers/UserProvider.dart'; // Assuming UserProvider manages the user state

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Drawer(
      width: 270,  // Customize the width
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // const SizedBox(height: 20),

          // User header (optional)
          // if (user != null) 
          //   UserAccountsDrawerHeader(
          //     accountName: Text(user.name ?? 'Guest'),
          //     accountEmail: Text(user.email ?? 'No email'),
          //     currentAccountPicture: CircleAvatar(
          //       // backgroundImage: NetworkImage(user.profilePictureUrl ?? ''),
          //     ),
          //   ),

          _buildListTile(
            title: S.of(context).home,
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildListTile(
            title: S.of(context).account,
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildListTile(
            title: S.of(context).setting,
            icon: Icons.settings,
            onTap: () {
                Navigator.of(context).push(createRoute(SettingScreen()));
            },
          ),

          _buildListTile(
            title: S.of(context).forgotPassword,
            icon: Icons.lock,
            onTap: () {
              Navigator.of(context).push(createRoute(ForgotPasswordScreen(username:  user?.name ?? '')));
            },
          ),

          _buildListTile(
            title: S.of(context).logout,
            icon: Icons.logout,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  // Helper method for creating list tiles with an icon
  Widget _buildListTile({
    required String title, 
    required IconData icon, 
    required Function() onTap
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
