class User {
  final String id;
  final String first_name;
  final String middle_name;
  final String last_name;
  final String user_type;
  final String email;
  final String? phone_number;
  final List<dynamic> addresses;
  final String? profilePicture;
  final String? gender;
  final bool is_active;
  final bool is_blocked;
  final String created_at;
  final String updated_at;

  // Constructor
  User({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.user_type,
    required this.email,
    this.phone_number,
    required this.addresses,
    this.profilePicture,
    this.gender,
    required this.is_active,
    required this.is_blocked,
    required this.created_at,
    required this.updated_at,
  });

  // Factory constructor to create a User from a JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      middle_name: json['middle_name'],
      last_name: json['last_name'],
      user_type: json['user_type'],
      email: json['email'],
      phone_number: json['phone_number'],
      addresses: json['addresses'] ?? [],
      profilePicture: json['profile_image_url'],
      gender: json['gender'],
      is_active: json['is_active'],
      is_blocked: json['is_blocked'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      
    );
  }
}
