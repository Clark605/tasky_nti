import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/home/data/firebase/fb_task.dart';
import 'package:tasky_nti/feature/home/data/model/task_model.dart';
import 'package:tasky_nti/feature/home/view/widgets/card_item.dart';
import 'package:tasky_nti/feature/home/view/widgets/empty_state.dart';
import 'package:tasky_nti/feature/home/view/widgets/home_app_bar.dart';
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
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 32,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePicker(
              DateTime.now(),
              height: 100,
              initialSelectedDate: DateTime.now(),
              daysCount:
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month + 1,
                    0,
                  ).day -
                  DateTime.now().day +
                  1,
              selectionColor: AppColors.primary,
              selectedTextColor: AppColors.white,
              onDateChange: (date) {
                // New date selected
              },
            ),
            AppTextFormField(
              controller: TextEditingController(),
              validator: Validator.validateName,
              hintText: 'Search for your tasks',
              prefixIcon: Image.asset(AppConstants.searchIcon, scale: 2),
            ),
            if (tasks.isEmpty) EmptyState(),
            if (tasks.isNotEmpty)
              SizedBox(
                height: 390,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return CardItem(
                      title: tasks[index].title ?? '',
                      date: tasks[index].date ?? DateTime.now(),
                      priority: tasks[index].priority ?? 1,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemCount: tasks.length,
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subtitleText),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Completed'),
            ),
            SizedBox(
              height: 390,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CardItem(
                    title: tasks[index].title ?? '',
                    date: tasks[index].date ?? DateTime.now(),
                    priority: tasks[index].priority ?? 1,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },
                itemCount: tasks.length,
              ),
            ),
          ],
        ),
      ),

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
