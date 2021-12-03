import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_migration/services/fakenetwork.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FakeNetworkService _fakeNetworkService;

  HomeBloc(this._fakeNetworkService) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is LoadHomeEvent) {
      yield HomeLoadedState();
    }
    if (event is RunLongRunningEvent) {
      yield HomeLoadingState('Running long running operation....');
      final response = await _fakeNetworkService.longRunningOperation();
      yield HomeLoadingState(response);
      await Future.delayed(Duration(seconds: 2));
      yield HomeLoadedState();
    }
    if (event is RunLongRunningStreamedEvent) {
      yield HomeLoadingState('Running long running streamed operation....');
      yield* _fakeNetworkService.longRunningStream().map((event) => HomeLoadingState(event));
      yield HomeLoadedState();
    }
    if (event is RunLongRunningStreamedComplexEvent) {
      yield HomeLoadingState('Running long running streamed operation with complex objects....');
      yield* _fakeNetworkService.longRunningComplexStream().map(
            (event) => HomeLoadingState(event.message, icon: event.icon),
          );
      yield HomeLoadedState();
    }
  }
}
