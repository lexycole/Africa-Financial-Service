import 'package:flutter/material.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool isPassword; // New property to indicate if it's a password field

  const PasswordTextField({
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isPassword = false, // Default to not a password field
    Key? key,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordVisible = false; // Keep track of password visibility

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: TextField(
        controller: widget.textController,
        obscureText: widget.isPassword ? !isPasswordVisible : false, // Hide/show password
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.textColor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
