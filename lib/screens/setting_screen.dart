import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donghanh_flutter/providers/ThemeProvider.dart';
import 'package:donghanh_flutter/providers/LanguageProvider.dart';
import 'package:donghanh_flutter/generated/l10n.dart';

class SettingScreen extends StatelessWidget {  
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
     final languageProvider = Provider.of<LanguageProvider>(context);

     return Scaffold(
       appBar: AppBar(
          title: Text(S.of(context).setting),    
          centerTitle: true, 
       ),     
        body: Column(          
          children: <Widget>[        
            Expanded(
               child: Container(
                color: Theme.of(context).primaryColor, // Màu nền của Container
                child:Padding(
                  padding: EdgeInsets.all(16.0), // Khoảng cách xung quanh Column)
                  child: Column(                  
                  children: [
                    Row(children: [
                      Text("${S.of(context).theme}: ", style: Theme.of(context).textTheme.bodyMedium),                     
                      TextButton(
                        onPressed: () {
                          // Hành động khi nhấn nút
                          themeProvider.toggleTheme();
                        },
                        child: Text('${themeProvider.themeMode == ThemeMode.light ? 'Light' : 'Dark'}',  style: Theme.of(context).textTheme.bodyMedium),
                      ),
                     
                    ],),
                    Row(children: [
                      Text("${S.of(context).lang}:      ", style: Theme.of(context).textTheme.bodyMedium),                     
                      DropdownButton<Locale>(
                        value: languageProvider.locale,
                        onChanged: (Locale? newLocale) {
                          if (newLocale != null) {
                            languageProvider.setLocale(newLocale);
                          }
                        },
                        items: [
                        DropdownMenuItem(
                            value: Locale('en', ''),
                            child: Row(
                              children: [
                              Image.asset(
                                  'assets/flags/en.png', 
                                  fit: BoxFit.cover, 
                                  width: 20,  // Đặt chiều rộng của hình ảnh
                                  height: 20, // Đặt chiều cao của hình ảnh
                                ),
                                SizedBox(width: 8),
                                Text(S.of(context).english),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: Locale('vi', ''),
                            child: Row(
                              children: [
                              Image.asset(
                                  'assets/flags/vn.png', 
                                  fit: BoxFit.cover, 
                                  width: 20,  // Đặt chiều rộng của hình ảnh
                                  height: 20, // Đặt chiều cao của hình ảnh
                                ),
                                SizedBox(width: 8),
                                Text(S.of(context).vietnam),
                              ],
                            ),
                          ),
                        ],
                      ), 
                    ],),
                  ],
                ),
                ) 
              ),
            ),
          ],
      ),
    );
  }
}
