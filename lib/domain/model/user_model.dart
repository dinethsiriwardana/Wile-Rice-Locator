class UserDataModel {
  String uid;
  String name;
  String town;
  String district;
  int age;

  UserDataModel({
    required this.uid,
    required this.name,
    required this.district,
    required this.age,
    this.town = '', // Default value if not provided
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'district': district,
      'age': age,
      'town': town,
    };
  }

  static UserDataModel fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uid: json['uid'],
      name: json['name'],
      district: json['district'],
      age: json['age'],
      town: json['own'] ?? '', // Use empty string if 'own' is missing
    );
  }
}
