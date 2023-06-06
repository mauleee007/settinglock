import 'package:app_settings/app_settings.dart';
import 'package:dpad_container/dpad_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setting_locker/colors.dart';
import 'package:setting_locker/small_text.dart';

import 'dimention.dart';

class PasswordSettings extends StatefulWidget {
  const PasswordSettings({super.key});

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  FocusNode? formFocus;
  FocusNode? buttonFocus;
  _setFirstFocus(BuildContext context) {
    if (formFocus == null) {
      formFocus = FocusNode();
      buttonFocus = FocusNode();
      FocusScope.of(context).requestFocus(buttonFocus);
      setState(() {});
    }
  }

  _changeFocus(BuildContext context, FocusNode node) {
    print(node.toString());
    FocusScope.of(context).requestFocus(node);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    formFocus!.dispose();
    buttonFocus!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedIndex;
    int? onFocusIndex;
    Dimensi().init(context);
    if (formFocus == null) {
      _setFirstFocus(context);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.primaryColor.withOpacity(0.5),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: SmallText(
          text: "Settings",
          color: Colors.white,
          size: Dimensi.blockSizeVertical! * 3,
        ),
      ),
      body: Center(
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              _changeFocus(context, buttonFocus!);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              _changeFocus(context, formFocus!);
            } else if (event.logicalKey == LogicalKeyboardKey.select &&
                buttonFocus!.parent!.hasFocus) {
              if (formKey.currentState!.validate()) {
                // Form is valid
                if (password.text == '000000') {
                  // Password is correct
                  AppSettings.openDeviceSettings();
                } else {
                  // Password is incorrect
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Incorrect password.'),
                  ));
                }
              }
            }
          },
          child: Form(
            key: formKey,
            child: Container(
              width: Dimensi.blockSizeHorizontal! * 40,
              height: Dimensi.blockSizeVertical! * 40,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 24,
                      offset: Offset(0, 11),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(Dimensi.blockSizeVertical! * 2)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      controller: password,
                      focusNode: formFocus,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hoverColor: ColorTheme.primaryColor,
                        labelText: 'Admin Password',
                        labelStyle: TextStyle(
                          color: ColorTheme.textColor3,
                        ),
                        suffixIcon: Icon(
                          Icons.key,
                          color: ColorTheme.primaryColor,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorTheme.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorTheme.primaryColor),
                        ),
                        helperText:
                            'Enter your admin password to open settings',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: buttonFocus!.hasFocus
                          ? ColorTheme.primaryColor
                          : Colors.grey, // Background color
                    ),
                    focusNode: buttonFocus,
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
