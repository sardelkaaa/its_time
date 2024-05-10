import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_time/services/DateTimePickerScreen.dart';
import 'package:flutter/widgets.dart';

class Authorization extends StatefulWidget {
  const Authorization({super.key});

  @override
  State<Authorization> createState() => BucketListAuthorization();
}

class BucketListAuthorization extends State<Authorization> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.9, // Уменьшаем высоту контейнера
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1282A2), Color(0xFF034078)],
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),

              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(child: Text('Авторизация', style: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.03, fontWeight: FontWeight.w500),)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  TextFormField(
                    style: TextStyle(
                      color: Color(0xFFC6E9F3),
                      decoration: TextDecoration.none,
                      decorationColor: Color(0x01C6E9F3),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Электронная почта',
                      filled: true,
                      fillColor: Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w500),
                      hintStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w600),
                      counterStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w400),
                    ),
                    cursorColor: Color(0xFFC6E9F3),
                    cursorWidth: 1,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                  TextFormField(
                    style: TextStyle(
                      color: Color(0xFFC6E9F3),
                      decoration: TextDecoration.none,
                      decorationColor: Color(0x01C6E9F3),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      filled: true,
                      fillColor: Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w500),
                      hintStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w600),
                      counterStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w400),
                    ),
                    cursorColor: Color(0xFFC6E9F3),
                    cursorWidth: 1,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        children: [
                          Icon(Icons.person, size: MediaQuery.of(context).size.height * 0.03, color: Color(0xFFC6E9F3)),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Забыли пароль?',
                            style: TextStyle(
                              color: Color(0xFFC6E9F3),
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  Icon(
                    Icons.verified_user,
                    size: MediaQuery.of(context).size.height * 0.3, color: Color(0xFF1282A2),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.045),

                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Войти в аккаунт', style: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.025, fontWeight: FontWeight.w500)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1282A2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.6, MediaQuery.of(context).size.height * 0.07),
                      side: BorderSide(
                        color: Color(0x80FFFFFF),
                        width: 1.0,
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}