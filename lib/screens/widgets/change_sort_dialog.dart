import 'package:flutter/material.dart';
import 'package:project/_project.dart';

class ChangeSortDialog extends StatefulWidget {
  const ChangeSortDialog({
    Key? key,
    required this.onConfirm,
    this.initialStrategy,
  }) : super(key: key);

  final void Function(TaskSortStrategy priority) onConfirm;
  final TaskSortStrategy? initialStrategy;

  static Future<Task?> show({
    required BuildContext context,
    required void Function(TaskSortStrategy priority) onConfirm,
    TaskSortStrategy? initialStrategy,
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
            child: ChangeSortDialog(
              onConfirm: onConfirm,
              initialStrategy: initialStrategy,
            ),
          ),
        );
      },
    );
  }

  @override
  State<ChangeSortDialog> createState() => _ChangeSortDialogState();
}

class _ChangeSortDialogState extends State<ChangeSortDialog> {
  late TaskSortStrategy? _strategy = widget.initialStrategy;

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
                DropdownMenu<String>(
                  key: ValueKey<String?>(_strategy?.name),
                  enableFilter: false,
                  requestFocusOnTap: true,
                  initialSelection: _strategy?.name,
                  leadingIcon: const Icon(Icons.search),
                  label: const Text('Sort by'),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (String? selected) {
                    if (selected == null) {
                      return;
                    }

                    if (selected == 'Priority') {
                      _strategy = PrioritySortStrategy();
                    } else if (selected == 'Deadline') {
                      _strategy = DeadlineSortStrategy();
                    }

                    setState(() {});
                  },
                  dropdownMenuEntries: <String>[
                    PrioritySortStrategy().name,
                    DeadlineSortStrategy().name,
                  ].map<DropdownMenuEntry<String>>(
                    (String icon) {
                      return DropdownMenuEntry<String>(
                        value: icon,
                        label: icon,
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 66.0),
                ThButton(
                  title: widget.initialStrategy == null ? 'Add sort strategy' : 'Change sort strategy',
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
    if (_strategy == null) {
      return;
    }

    widget.onConfirm(_strategy!);

    Navigator.of(context).pop();
  }
}
