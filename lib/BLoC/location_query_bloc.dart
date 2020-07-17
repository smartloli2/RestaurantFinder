import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'bloc.dart';

class LocationQueryBloc implements Bloc
{
  // Контроллер
  final _controller = StreamController<List<Location>>();
  // Клиент зомато
  final _client = ZomatoClient();
  // Получить поток из контроллера
  Stream<List<Location>> get locationStream => _controller.stream;

  // Получаем запрос асинхроно
  void submitQuery(String query) async {
    // Синхронизируем локацию с АПИ зомато
    final results = await _client.fetchLocations(query);
    // Результат помещаем в поток
    _controller.sink.add(results);
  }

  // Освобождаем поток
  @override
  void dispose() {
    _controller.close();
  }
}