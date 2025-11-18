import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/home/data/firebase/fb_task.dart';
import 'package:tasky_nti/feature/home/data/model/task_model.dart';
import 'package:tasky_nti/feature/home/view/task_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: HomeAppBar(),
      body: Column(
        children: [
          // Fixed header content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  initialSelectedDate: selectedDate,
                  daysCount:
                      // Calculate remaining days in the month
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month + 1,
                        0,
                      ).day -
                      DateTime.now().day +
                      1,
                  selectionColor: AppColors.primary,
                  selectedTextColor: AppColors.white,
                  onDateChange: (date) async {
                    selectedDate = date;
                    getAllTasks();
                    setState(() {});
                  },
                ),
                AppTextFormField(
                  enabled:
                      !(uncompletedTasks.isEmpty &&
                          completedTasks.isEmpty &&
                          searchController.text.isEmpty),
                  controller: searchController,
                  hintText: 'Search for your tasks',
                  prefixIcon: Image.asset(AppConstants.searchIcon, scale: 2),
                  onChanged: (value) {
                    uncompletedTasks = uncompletedTasks
                        .where(
                          (task) => task.title!.toLowerCase().contains(
                            value.toLowerCase(),
                          ),
                        )
                        .toList();
                    completedTasks = completedTasks
                        .where(
                          (task) => task.title!.toLowerCase().contains(
                            value.toLowerCase(),
                          ),
                        )
                        .toList();
                    setState(() {});
                    if (value.isEmpty) {
                      getAllTasks();
                    }
                  },
                ),
                if (uncompletedTasks.isEmpty &&
                    completedTasks.isEmpty &&
                    searchController.text.isEmpty)
                  EmptyState(),
              ],
            ),
          ),

          // Scrollable task lists
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 32,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Uncompleted tasks
                  if (uncompletedTasks.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardItem(
                          title: uncompletedTasks[index].title ?? '',
                          date: uncompletedTasks[index].date ?? DateTime.now(),
                          priority: uncompletedTasks[index].priority ?? 1,
                          isCompleted:
                              uncompletedTasks[index].isCompleted ?? false,
                          onChanged: (value) async {
                            uncompletedTasks[index].isCompleted =
                                value ?? false;
                            await FbTask.updateTask(uncompletedTasks[index]);
                            getAllTasks();
                            setState(() {});
                          },
                          onTap: () => Navigator.pushNamed(
                            context,
                            TaskScreen.routeName,
                            arguments: uncompletedTasks[index],
                          ).whenComplete(getAllTasks),
                          onDelete: (_) async {
                            await FbTask.deleteTask(
                              uncompletedTasks[index].id!,
                            );
                            getAllTasks();
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemCount: uncompletedTasks.length,
                    ),

                  // Completed label
                  if (uncompletedTasks.isNotEmpty || completedTasks.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.subtitleText),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Completed'),
                    ),

                  // No completed tasks message
                  if (completedTasks.isEmpty && uncompletedTasks.isNotEmpty)
                    Center(
                      child: Text(
                        'No completed tasks',
                        style: TextStyle(
                          color: AppColors.subtitleText,
                          fontSize: 16,
                        ),
                      ),
                    ),

                  // Completed tasks
                  if (completedTasks.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardItem(
                          title: completedTasks[index].title ?? '',
                          date: completedTasks[index].date ?? DateTime.now(),
                          priority: completedTasks[index].priority ?? 1,
                          isCompleted:
                              completedTasks[index].isCompleted ?? false,
                          onChanged: (value) async {
                            completedTasks[index].isCompleted = value ?? false;
                            await FbTask.updateTask(completedTasks[index]);
                            getAllTasks();
                            setState(() {});
                          },
                          onTap: () => Navigator.pushNamed(
                            context,
                            TaskScreen.routeName,
                            arguments: completedTasks[index],
                          ).whenComplete(getAllTasks),
                          onDelete: (_) async {
                            await FbTask.deleteTask(completedTasks[index].id!);
                            getAllTasks();
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemCount: completedTasks.length,
                    ),

                  // Bottom padding for FAB
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
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

  List<TaskModel> uncompletedTasks = [];
  List<TaskModel> completedTasks = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  void getAllTasks() async {
    final uncompletedResult = await FbTask.getUncompletedTasksOnDate(
      selectedDate,
    );
    switch (uncompletedResult) {
      case Success():
        uncompletedTasks = uncompletedResult.data ?? [];
        log(uncompletedTasks.toString());
      case Failure():
        AppDialogs.showErrorDialog(
          context,
          message: uncompletedResult.errorMsg,
        );
    }
    final completedResult = await FbTask.getCompletedTasksOnDate(selectedDate);
    switch (completedResult) {
      case Success():
        completedTasks = completedResult.data ?? [];
        log(completedTasks.toString());
      case Failure():
        AppDialogs.showErrorDialog(context, message: completedResult.errorMsg);
    }
    setState(() {});
  }

  Future<dynamic> floatingActionOnPressed(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => TaskBottomSheet(),
      isScrollControlled: true,
    ).then((_) async => getAllTasks());
  }
}
