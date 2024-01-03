import '../../_project.dart';

class PriorityMapper {
  static String getName(Priority priority) {
    switch (priority) {
      case Priority.low:
        return "Low";
      case Priority.medium:
        return "Medium";
      case Priority.high:
        return "High";
      default:
        return "Unknown";
    }
  }

  static int getPriority(String priority) {
    switch (priority) {
      case "Low":
        return 1;
      case "Medium":
        return 2;
      case "High":
        return 3;
      default:
        return 0;
    }
  }

  static int getIndex(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 1;
      case Priority.medium:
        return 2;
      case Priority.high:
        return 3;
      default:
        return 0;
    }
  }
}
