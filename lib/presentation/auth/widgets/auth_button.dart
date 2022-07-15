import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    this.onTap,
    required this.title,
    this.isLoading = false,
  }) : super(key: key);

  final Function()? onTap;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 200.w,
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff38acec),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(title),
      ),
    );
  }
}
