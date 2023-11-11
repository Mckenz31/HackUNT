enum Category {freshman, softmore, junior, senior, graduate, phd}

class User{

  User({required this.id, required this.name, required this.image, required this.major, required this.studentType, required this.skillset});


  final int id;
  final String name;
  final String major;
  final String image;
  final Category studentType;
  final List<String> skillset;

  String get formattedDate{
    return name;
  }

}