import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_skripsi/Comm/comHelper.dart';
import 'package:project_skripsi/Comm/getTextFormField.dart';
import 'package:project_skripsi/Database/DbHelper.dart';
import 'package:project_skripsi/Model/userModel.dart';
import 'package:project_skripsi/Screens/loginPage.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conConfPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String pass = _conPassword.text;
    String cpass = _conConfPassword.text;

    if (_formKey.currentState!.validate()) {
      if (pass != cpass) {
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState!.save();
        UserModel uModel = UserModel(uid, uname, email, pass);
        dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => loginPage()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error: Data Save Fail");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //pict
              new Image(
                image: new AssetImage("images/register.PNG"),
                width: 250.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),

              Text(
                'Hello !',
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'login for use',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              //User ID
              getTextFormField(
                  controller: _conUserId,
                  icon: Icons.person,
                  hintName: 'User ID'),
              SizedBox(height: 5),

              //User ID
              getTextFormField(
                  controller: _conUserName,
                  icon: Icons.person_outline,
                  hintName: 'User Name'),
              SizedBox(height: 5),

              //User ID
              getTextFormField(
                  controller: _conEmail, icon: Icons.email, hintName: 'Email'),
              SizedBox(height: 5),

              //password
              getTextFormField(
                controller: _conPassword,
                icon: Icons.lock,
                hintName: 'Password',
                isObscrueText: true,
              ),
              SizedBox(height: 5),

              // Confirm Password
              getTextFormField(
                controller: _conConfPassword,
                icon: Icons.lock_outline,
                hintName: 'Confirm Password',
                isObscrueText: true,
              ),
              SizedBox(height: 5),

              Container(
                margin: EdgeInsets.all(20.0),
                width: double.infinity,
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        'login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' Punya akun  ',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => loginPage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      'Login Now',
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: Colors.deepOrange[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
