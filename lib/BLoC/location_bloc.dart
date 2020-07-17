import 'dart:async';

import '../DataLayer/location.dart';

import 'bloc.dart';

class LocationBloc implements Bloc
{
  Location _location;
  Location get selectedLocation => _location;

  // Будет управлять потоком и стоком (приватный)
  final _locationController = StreamController<Location>();

  // Публичный геттер к потоку у контроллера
  Stream<Location> get locationStream => _locationController.stream;

  // Эта функция вход для BloC (устанавливаем источник sink)
  void selectLocation(Location location)
  {
    _location = location;
    _locationController.sink.add(location);
  }

  // Закрываем поток, чтобы память не утекала
  @override
  void dispose() {
    _locationController.close();
  }
}