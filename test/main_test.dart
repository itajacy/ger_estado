// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

abstract class Listenable {
  void addListener(void Function() listener);
  void removeListener(void Function() listener);
}

class ChangeNotifier implements Listenable {
  final _listeners = <void Function()>[];

  @override
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  // notificar os listeners
  void notifyListener(void Function() listener) {
    //lendo os listeners
    for (var listener in _listeners) {
      //executando o listener
      listener();
    }
  }
}

void main() {
  // atribuindo uma função a uma variável

  // primeiro caso: uma função atribuiída a uma variável
  // final func = () {
  //   print('Hello World');
  // };

  // func();

  // segundo caso: lista de funçoes
  // final list = [() => print('Hello'), () => print('World'), () => print('!')];

  // list[0]();
  // list[1]();
  // list[2]();

  // terceiro caso: usando for

  //! reatividade
  // principio de enclosuramento

  // padrão do observsador

  // representando quem está ouvindo com funções
  // final list = [() => print('Hello'), () => print('World'), () => print('!')];

  // list.add(() => print('!!'));
  // list.add(() => print('!!!'));
  // for (var l in list) {
  //   l();
  // }

  //-----------------------------

  //**
  //Principio de enclosuramento
  //usando uma função para chamar outra e postergar a execução dela.
  //
  //Através disso que o principio de reatividade se faz presente
  //
  //ela usa observer(listener)
  //
  //Para representar quem está ouvindo vamos representar com funções que ela podem postergar a execução
  //-- representadas com listeners */

  // usando objetos ouvintes
}
