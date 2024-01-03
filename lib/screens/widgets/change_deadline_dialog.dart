import 'package:flutter/material.dart';
import 'package:project/_project.dart';

class ChangeDeadlineDialog extends StatefulWidget {
  const ChangeDeadlineDialog({
    Key? key,
    required this.onConfirm,
    this.initialDeadline,
  }) : super(key: key);

  final void Function(DateTime deadline) onConfirm;
  final DateTime? initialDeadline;

  static Future<Task?> show({
    required BuildContext context,
    required void Function(DateTime deadline) onConfirm,
    DateTime? initialDeadline,
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
            child: ChangeDeadlineDialog(
              onConfirm: onConfirm,
              initialDeadline: initialDeadline,
            ),
          ),
        );
      },
    );
  }

  @override
  State<ChangeDeadlineDialog> createState() => _ChangeDeadlineDialogState();
}

class _ChangeDeadlineDialogState extends State<ChangeDeadlineDialog> {


  late DateTime? _deadline = widget.initialDeadline;

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
                TmTextInput(
                  labelText: "Date",
                  initialValue: _deadline?.toIso8601String().substring(0, 10),
                  hintText: "yyyy-mm-dd",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Date is required.";
                    }

                    DateTime? deadline = DateTime.tryParse(value);
                    if (deadline == null) {
                      return "Invalid date format. Please enter a valid date.";
                    }

                    _deadline = deadline;

                    return null;
                  },
                ),
                const SizedBox(height: 66.0),
                ThButton(
                  title: widget.initialDeadline == null ? 'Add deadline' : 'Change deadline',
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



    if (_deadline == null) {
      TmMessage.showError("Invalid deadline.");
      return;
    }

    widget.onConfirm(_deadline!);
    Navigator.of(context).pop();
  }
}
