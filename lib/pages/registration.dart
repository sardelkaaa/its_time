import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:its_time/services/SnackBarServices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => BucketListRegistration();
}

class BucketListRegistration extends State<Registration> {

  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextConfirmInputController =
  TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextConfirmInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
    });
  }

  Future<void> registerUser() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showErrorSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }
    SnackBarService.showSuccessfulSnackBar(
        context,
        'Регистрация прошла успешно. Письмо с подтверждением отправлено на почту',
        true
    );
    Navigator.popAndPushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02
                        ),
                        Center(
                            child: Text(
                              'Регистрация',
                              style: TextStyle(
                                  color: Color(0xFFC6E9F3),
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
                              ? 'Введён неверный формат Email'
                              : null,
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
                            errorStyle: TextStyle(color: Colors.red, fontSize: MediaQuery.of(context).size.height * 0.017, fontWeight: FontWeight.w500),
                            counterStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w400),
                          ),
                          cursorColor: Color(0xFFC6E9F3),
                          cursorWidth: 1,
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    
                        TextFormField(
                          autocorrect: false,
                          controller: passwordTextInputController,
                          obscureText: isHiddenPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите пароль';
                            }
                            if (value.length < 8) {
                              return 'Пароль должен быть не менее 8 символов';
                            }
                            if (!RegExp(r'^(?=.*[a-z])(?=.*[0-9])').hasMatch(value)) {
                              return 'Пароль должен содержать:\n'
                                  '- хотя бы одну букву\n'
                                  '- хотя бы одну цифру';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            color: Color(0xFFC6E9F3),
                            decoration: TextDecoration.none,
                            decorationColor: Color(0x01C6E9F3),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            suffix: InkWell(
                              onTap: togglePasswordView,
                              child: Icon(
                                isHiddenPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
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
                            errorStyle: TextStyle(color: Colors.red, fontSize: MediaQuery.of(context).size.height * 0.017, fontWeight: FontWeight.w500),
                            counterStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w400),
                          ),
                          cursorColor: Color(0xFFC6E9F3),
                          cursorWidth: 1,
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    
                        TextFormField(
                          autocorrect: false,
                          controller: passwordTextConfirmInputController,
                          obscureText: isHiddenConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Подтвердите пароль';
                            }
                            if (value != passwordTextInputController.text) {
                              return 'Пароли не совпадают';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            color: Color(0xFFC6E9F3),
                            decoration: TextDecoration.none,
                            decorationColor: Color(0x01C6E9F3),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Подтверждение пароля',
                            suffix: InkWell(
                              onTap: toggleConfirmPasswordView,
                              child: Icon(
                                isHiddenConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white, // ПОМЕНЯТЬ ЦВЕТ ИКОНКИ ГЛАЗА
                              ),
                            ),
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
                            errorStyle: TextStyle(color: Colors.red, fontSize: MediaQuery.of(context).size.height * 0.017, fontWeight: FontWeight.w600),
                            counterStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.023, fontWeight: FontWeight.w400),
                          ),
                          cursorColor: Color(0xFFC6E9F3),
                          cursorWidth: 1,
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    
                        Icon(
                          Icons.supervised_user_circle,
                          size: MediaQuery.of(context).size.height * 0.3, color: Color(0xFF17A3CC),
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    
                        ElevatedButton(
                          onPressed: () {
                            registerUser();
                          },
                          child: Text('Создать аккаунт', style: TextStyle(color: Color(0xFFC6E9F3), fontSize: MediaQuery.of(context).size.height * 0.025, fontWeight: FontWeight.w500)),
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
                ),
              ],
                    ),
                  ),
          ),
    );
  }
}