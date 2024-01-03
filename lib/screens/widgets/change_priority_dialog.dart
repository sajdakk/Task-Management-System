import 'package:flutter/material.dart';
import 'package:project/_project.dart';

class ChangePriorityDialog extends StatefulWidget {
  const ChangePriorityDialog({
    Key? key,
    required this.onConfirm,
    this.initialPriority,
  }) : super(key: key);

  final void Function(Priority priority) onConfirm;
  final Priority? initialPriority;

  static Future<Task?> show({
    required BuildContext context,
    required void Function(Priority priority) onConfirm,
    Priority? initialPriority,
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
            child: ChangePriorityDialog(
              onConfirm: onConfirm,
              initialPriority: initialPriority,
            ),
          ),
        );
      },
    );
  }

  @override
  State<ChangePriorityDialog> createState() => _ChangePriorityDialogState();
}

class _ChangePriorityDialogState extends State<ChangePriorityDialog> {
  late Priority? _priority = widget.initialPriority;

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
                DropdownMenu<Priority>(
                  enableFilter: false,
                  requestFocusOnTap: true,
                  initialSelection: _priority,
                  leadingIcon: const Icon(Icons.search),
                  label: const Text('Priority'),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (Priority? selected) {
                    if (selected == null) {
                      return;
                    }

                    _priority = selected;

                    setState(() {});
                  },
                  dropdownMenuEntries: Priority.values.map<DropdownMenuEntry<Priority>>(
                    (Priority icon) {
                      return DropdownMenuEntry<Priority>(
                        value: icon,
                        label: PriorityMapper.getName(icon),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 66.0),
                ThButton(
                  title: widget.initialPriority == null ? 'Add priority' : 'Change priority',
                  onTap: () async => await _submit(context),
                  size: ThPrimaryButtonSize.large,
                  style: ThPrimaryButtonStyle.secondary,
                ),
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
            Navigator.of(context).pop();
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
    if (_priority == null) {
      return;
    }

    widget.onConfirm(_priority!);

    Navigator.of(context).pop();
  }
}
