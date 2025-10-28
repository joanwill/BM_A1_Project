class DogProfile {
  final String id;
  final String name;
  final String imageUrl;
  final String profileUrl;
  final String birthDate;
  final String age;
  final String breed;
  final String gender;
  final String weight;
  final String height;
  final String location;
  final DateTime? createdAt;

  DogProfile({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.profileUrl,
    required this.birthDate,
    required this.age,
    required this.breed,
    required this.gender,
    required this.weight,
    required this.height,
    required this.location,
    this.createdAt,
  });

  factory DogProfile.fromMap(Map<String, dynamic> map) {
    return DogProfile(
      id: map['id'],
      name: map['name'],
      imageUrl: map['image_url'],
      profileUrl: map['profile_url'],
      birthDate: map['birth_date'],
      age: map['age'],
      breed: map['breed'],
      gender: map['gender'],
      weight: map['weight'],
      height: map['height'],
      location: map['location'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
    );
  }

  factory DogProfile.fromJson(Map<String, dynamic> json) {
    return DogProfile(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      profileUrl: json['profile_url'],
      birthDate: json['birth_date'],
      age: json['age'],
      breed: json['breed'],
      gender: json['gender'],
      weight: json['weight'],
      height: json['height'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'image_url': imageUrl,
      'profile_url': profileUrl,
      'birth_date': birthDate,
      'age': age,
      'breed': breed,
      'gender': gender,
      'weight': weight,
      'height': height,
      'location': location,
      'created_at': createdAt,
    };

    // Only include ID if it's not empty
    if (id.isNotEmpty) {
      map['id'] = id;
    }

    return map;
  }
}
