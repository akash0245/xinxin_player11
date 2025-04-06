import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_helper.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isShowBack;
  final bool isShowNotificationIcon;
  final bool isShowCartIcon;
  final double? fontSize;
  final Widget icon;

  const AppBarView({Key? key, this.fontSize, this.title, this.isShowBack, this.isShowNotificationIcon = true, this.isShowCartIcon = true, this.icon = const SizedBox()}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)), color: ColorHelper.primaryred),
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 52,
            left: 0,
            child: isShowBack ?? true
                ? IconButton(
                    color: Colors.white,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    icon: isShowBack ?? true ? const Icon(Icons.arrow_back_rounded) : icon,
                    onPressed: () {
                      if (isShowBack ?? true) {
                        Get.back();
                      }
                    })
                : icon,
          ),
        ],
      ),
    );
  }
}
