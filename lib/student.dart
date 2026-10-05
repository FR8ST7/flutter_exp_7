class Student {
  final int id;
  final String name;
  final String course;

  Student({
    required this.id,
    required this.name,
    required this.course,
  });

  // Step 4 - Convert object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
    };
  }

  // Step 5 - Convert JSON Map back to Student object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'].toString(),
      course: json['course'].toString(),
    );
  }
}
