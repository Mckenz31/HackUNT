enum Category { freshman, softmore, junior, senior, graduate, phd }

class AppUser {
  AppUser(
      {required this.email,
      required this.name,
      required this.major,
      required this.age,
      required this.labels,
      required this.skills,
      required this.collegeYear, 
      required this.university, 
      required this.description, 
      required this.expectation
  });

  final String email;
  final String name;
  final String major;
  final String age;
  final String labels;
  final String skills;
  final String collegeYear;
  final String university;
  final String description;
  final String expectation;

  String get formattedDate {
    return name;
  }
}
