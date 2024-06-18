import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:its_time/services/SnackBarServices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => BucketListResetPassword();
}

class BucketListResetPassword extends State<ResetPassword> {
  TextEditingController emailTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailTextInputController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found') {
        SnackBarService.showErrorSnackBar(
          context,
          'Пользователь с таким email незарегистрирован!',
          true,
        );
        return;
      } else {
        SnackBarService.showErrorSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
        return;
      }
    }

    SnackBarService.showSuccessfulSnackBar(
        context, 'Сброс пароля успешен. Проверьте почту', true
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF0A1128), // Цвет фона страницы
      body:
      SingleChildScrollView(
        child: Form(
          key: formKey,
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

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                          child:
                          Text(
                            'Сброс пароля',
                            style: TextStyle(
                                color: const Color(0xFFC6E9F3),
                                fontSize: phoneHeight * 0.03,
                                fontWeight: FontWeight.w500
                            ),
                          )
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: emailTextInputController,
                        validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Введите правильный Email'
                            : null,
                        style: const TextStyle(
                          color: Color(0xFFC6E9F3),
                          decoration: TextDecoration.none,
                          decorationColor: Color(0x01C6E9F3),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Электронная почта',
                          filled: true,
                          fillColor: const Color(0xFF1282A2), // Цвет фона
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0), // Закругление углов
                            borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0), // Закругление углов
                            borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0), // Закругление углов
                            borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                          ),
                          labelStyle: TextStyle(color: const Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(color: const Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w600),
                          errorStyle: TextStyle(color: Colors.red, fontSize: MediaQuery.of(context).size.height * 0.017, fontWeight: FontWeight.w500),
                          counterStyle: TextStyle(color: const Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w400),
                        ),
                        cursorColor: const Color(0xFFC6E9F3),
                        cursorWidth: 1,
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                      Icon(
                        Icons.lock_reset,
                        size: MediaQuery.of(context).size.height * 0.35, color: const Color(0xFF17A3CC),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                      ElevatedButton(
                        onPressed: () {
                          resetPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1282A2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.6, MediaQuery.of(context).size.height * 0.07),
                          side: const BorderSide(
                            color: Color(0x80FFFFFF),
                            width: 1.0,
                          ),
                        ),
                        child: Text('Сбросить пароль', style: TextStyle(color: const Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.025, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}