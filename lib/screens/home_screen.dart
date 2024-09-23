import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donghanh_flutter/providers/ThemeProvider.dart';
import 'package:donghanh_flutter/providers/LanguageProvider.dart';
import 'package:donghanh_flutter/providers/UserProvider.dart';
import 'package:donghanh_flutter/generated/l10n.dart';
import 'package:donghanh_flutter/widgets/CustomDrawer.dart';
import 'package:donghanh_flutter/widgets/CustormMenu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final user = context.watch<UserProvider>().user;

    final List<Map<String, String>> menuItems = [
      {
        'imagePath': 'assets/images/vegetation.png',
        'text': S.of(context).thongtinvungtrong,
        'router':'/'
      },     
      // Add more items as needed...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home),
        centerTitle: true,
        leading: null,
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Xử lý khi nhấn vào biểu tượng tìm kiếm
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      // right menu
      endDrawer: CustomDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 80,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      color: Theme.of(context)
                          .primaryColor, // Màu nền của Container
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/logo_App_DongHanh.png',
                                  fit: BoxFit.cover,
                                  width: 60, // Đặt chiều rộng của hình ảnh
                                  height: 60, // Đặt chiều cao của hình ảnh
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(user?.email ?? '',
                                      style: TextStyle(color: Colors.white)),
                                  Text(user?.name ?? '',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          Divider(
            color: const Color.fromARGB(255, 27, 27, 27),
            thickness: 4.0,
            height: 4.0, // Space above and below the divider
          ),
          CustormMenu(listMenu: menuItems)
        ],
      ),
    );
  }
}
