class TasksService {
  static String formatDuration(Duration duration) =>
      duration.toString().split('.').first;
}
