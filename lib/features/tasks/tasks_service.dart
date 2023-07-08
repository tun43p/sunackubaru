class TasksService {
  String formatDuration(Duration duration) =>
      duration.toString().split('.').first;
}
