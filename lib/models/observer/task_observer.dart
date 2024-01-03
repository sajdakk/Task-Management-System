import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../_project.dart';

class TaskObserver implements TaskObserverInterface {
  TaskObserver(this.fileName);

  final String fileName;

  @override
  void update(List<TaskInterface> tasks) async {
    final Directory downloadsDir = await getApplicationDocumentsDirectory();

    final String filePath = path.join(downloadsDir.path, fileName);

    var file = File(filePath);
    var tasksText = tasks.map((task) {
      return task.toString();
    }).join('\n');

    try {
      file.writeAsStringSync(tasksText);
      TmMessage.showInfo('Tasks saved to downloads dir: $filePath');
    } catch (e) {
      TmMessage.showError('Error saving tasks to file: $e');
    }
  }
}
