// ignore_for_file: public_member_api_docs, sort_constructors_first



class Person {
  final double height;
  final double weight;
  Person({required this.height, required this.weight});


  

  double calcularIMC() {
    return weight / (height * height);
  }

  Person copyWith({
    double? height,
    double? weight,
  }) {
    return Person(
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
