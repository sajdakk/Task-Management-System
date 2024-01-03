import 'package:flutter/material.dart';
import 'package:project/_project.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    Key? key,
  }) : super(key: key);

  static Future<Task?> show({
    required BuildContext context,
  }) {
    return showDialog<Task?>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600.0,
              maxHeight: 575.0,
            ),
            child: const AddTaskDialog(),
          ),
        );
      },
    );
  }

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _descriptionKey = GlobalKey<FormFieldState<String>>();

  Task? _result;

  int? _index = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: ThColors.backgroundBG1,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TmTextInput(
                        isRequired: true,
                        formFieldKey: _descriptionKey,
                        labelText: 'Description *',
                        maxLines: null,
                      ),
                      const SizedBox(height: 8.0),
                      DropdownMenu<int>(
                        enableFilter: true,
                        requestFocusOnTap: true,
                        leadingIcon: const Icon(Icons.search),
                        initialSelection: 1,
                        label: const Text('Initial state'),
                        inputDecorationTheme: const InputDecorationTheme(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        onSelected: (int? selected) {
                          if (_formKey.currentState?.validate() != true) {
                            return;
                          }

                          _index = selected;

                          setState(() {});
                        },
                        dropdownMenuEntries: <int>[1, 2, 3].map<DropdownMenuEntry<int>>(
                          (int icon) {
                            return DropdownMenuEntry<int>(
                              value: icon,
                              label: icon == 1
                                  ? 'To Do'
                                  : icon == 2
                                      ? 'In Progress'
                                      : 'Done',
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 32.0),
                      ThButton(
                        title: 'Add task',
                        onTap: () async => await _submit(context),
                        size: ThPrimaryButtonSize.large,
                        style: ThPrimaryButtonStyle.secondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 66.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () {
            Navigator.of(context).pop(_result);
          },
          child: const Icon(
            Icons.cancel_outlined,
            size: 20.0,
            color: ThColors.ascentAscent,
          ),
        ),
      ],
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    String? description = _descriptionKey.currentState?.value;
    if (description == null) {
      TmMessage.showError("Invalid description.");
      return;
    }

    switch (_index) {
      case 1:
        _result = ToDoTaskTypeFactory().createTask(description);
        break;
      case 2:
        _result = InProgressTaskTypeFactory().createTask(description);
        break;
      case 3:
        _result = DoneTaskTypeFactory().createTask(description);
        break;
      default:
        TmMessage.showError("Invalid status choice.");
        return;
    }

    Navigator.of(context).pop(_result);
  }
}
