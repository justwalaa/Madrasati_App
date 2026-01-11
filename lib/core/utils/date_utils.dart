String getDayName(DateTime date) {
  const days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  return days[date.weekday % 7];
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
