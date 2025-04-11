// ignore_for_file: public_member_api_docs, sort_constructors_first

// pegar dados  que representam a regra de negócio e organizá-los

// usando métodos para facilitar o uso
class Person {
  double height;
  double weight;
  Person({this.height = 0.0, this.weight = 0.0});

  double calcularIMC() {
    return weight / (height * height);
  }

  void setHeight(String value) {
    height = double.tryParse(value) ?? 0.0;
  }

  void setWeight(String value) {
    weight = double.tryParse(value) ?? 0.0;
  }
}
