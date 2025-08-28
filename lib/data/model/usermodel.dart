// data/model/usermodel.dart
class UserModel {
  final String uid;
  final String name;
  final String bio;
  final String profilePic;

  UserModel({
    required this.uid,
    required this.name,
    required this.bio,
    required this.profilePic,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'bio': bio,
      'profilePic': profilePic,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? bio,
    String? profilePic,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}
