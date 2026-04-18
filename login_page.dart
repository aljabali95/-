
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController u = TextEditingController();
  TextEditingController p = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: u, decoration: InputDecoration(labelText: 'اسم المستخدم')),
            TextField(controller: p, decoration: InputDecoration(labelText: 'كلمة المرور')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var res = await DBHelper().login(u.text, p.text);
                if (res != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(role: res['role']),
                    ),
                  );
                }
              },
              child: Text('دخول'),
            )
          ],
        ),
      ),
    );
  }
}
