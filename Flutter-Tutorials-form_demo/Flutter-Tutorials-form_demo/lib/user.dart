class User {
  String name;
  int age;
  String gender;
  String country;
  List<String> hobbies;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.country,
    required this.hobbies,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'],
        gender = json['gender'],
        country = json['country'],
        hobbies = List<String>.from(json['hobbies']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'gender': gender,
        'country': country,
        'hobbies': hobbies,
      };
}
