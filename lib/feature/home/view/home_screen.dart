import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/feature/home/data/firebase/fb_task.dart';
import 'package:tasky_nti/feature/home/data/model/task_model.dart';
import 'package:tasky_nti/feature/home/view/widgets/card_item.dart';
import 'package:tasky_nti/feature/home/view/widgets/empty_state.dart';
import 'package:tasky_nti/feature/splash/splash.dart';
import 'package:tasky_nti/feature/home/view/widgets/task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void getTasks() async {
    final result = await FbTask.getTasks();
    switch (result) {
      case Success():
        tasks = result.data ?? [];
        log(tasks.toString());
      case Failure():
        AppDialogs.showErrorDialog(context, message: result.errorMsg);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(AppConstants.appLogo, scale: 2),
        ),
        leadingWidth: 100,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, SplashScreen.routeName),
            child: Row(
              children: [
                Image.asset(AppConstants.logOutIcon, scale: 2),
                const SizedBox(width: 10),
                Text(
                  'Log out',
                  style: AppFonts.labelText.copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(children: [CardItem()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => floatingActionOnPressed(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Future<dynamic> floatingActionOnPressed(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => TaskBottomSheet(),
      isScrollControlled: true,
    );
  }
}
