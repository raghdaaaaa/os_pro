import 'package:brain_stack/Featurs/Add_Task/Presentation/Widgets/add_task_picker_field.dart';
import 'package:brain_stack/Featurs/Add_Task/Presentation/Widgets/add_text_.dart';
import 'package:brain_stack/Featurs/Add_Task/Presentation/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Constants/assets.dart';
import '../../../../Core/Widgets/app_scaffold.dart';
import '../../../../Core/Widgets/primary_button.dart';
import '../widgets/category_chip.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController       = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TaskController>();

    return AppScaffold(
      currentNavIndex: 2,
      showFab: false,
      showBottomNav: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                AppStrings.addTaskTitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              // Task Name
              const Text(
                AppStrings.addTaskNameLabel,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              AppTextField(
                hint: AppStrings.addTaskNameHint,
                controller: _titleController,
              ),
              const SizedBox(height: 35),

              // Category
              const Text(
                AppStrings.addTaskCategoryLabel,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              CategoryChipRow(
                onChanged: (priority) => controller.setPriority(priority),
              ),
              const SizedBox(height: 50),

              // Date & Time
              Row(
                children: [
                  Expanded(
                    child: AddTaskPickerField(
                      label: AppStrings.addTaskDateLabel,
                      iconAsset: AppAssets.date,
                      type: PickerType.date,
                      onDatePicked: (date) => controller.setDueDate(date),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AddTaskPickerField(
                      label: AppStrings.addTaskTimeLabel,
                      iconAsset: AppAssets.time,
                      type: PickerType.time,
                      onTimePicked: (time) {
                        final hour   = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
                        final minute = time.minute.toString().padLeft(2, '0');
                        final period = time.period == DayPeriod.am ? 'AM' : 'PM';
                        controller.setStartTime('$hour:$minute $period');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Description
              const Text(
                AppStrings.addTaskDescriptionLabel,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              AppTextField(
                hint: AppStrings.addTaskDescriptionHint,
                maxLines: 5,
                controller: _descriptionController,
              ),
              const SizedBox(height: 32),

              // Error Message
              if (controller.errorMessage != null) ...[
                Text(
                  controller.errorMessage!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Create Task Button
              PrimaryButton(
                label: controller.isLoading
                    ? 'Saving...'
                    : AppStrings.addTaskCreateButton,
                height: 80,
                onPressed: controller.isLoading
                    ? () {}
                    : () {
                  controller.setTitle(_titleController.text);
                  controller.setDescription(_descriptionController.text);
                  controller.saveTask().then((_) {
                    if (controller.isSuccess && context.mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
