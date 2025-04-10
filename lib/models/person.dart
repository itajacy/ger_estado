// ignore_for_file: public_member_api_docs, sort_constructors_first



class Person {
  double height;
  double weight;
  Person({this.height = 0.0, this.weight = 0.0});


  

  double calcularIMC() {
    return weight / (height * height);
  }

  
}
