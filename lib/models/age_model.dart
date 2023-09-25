// class Age {
//   int years;
//   int months;
//   int days;
//
//   Age(this.years, this.months, this.days);
// }

String calculateAge(int dobTimestamp) {
  final dob = DateTime.fromMillisecondsSinceEpoch(dobTimestamp);
  final now = DateTime.now();

  int years = now.year - dob.year;
  int months = now.month - dob.month;
  int days = now.day - dob.day;

  if (days < 0) {
    months--;
    days += DateTime(now.year, now.month - 1, 0).day;
  }

  if (months < 0) {
    years--;
    months += 12;
  }

  return '${years} years, ${months} months, ${days} days';
}