import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_migration/services/fakenetwork.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FakeNetworkService _fakeNetworkService;

  HomeBloc(this._fakeNetworkService) : super(HomeInitial()) {
    on<LoadHomeEvent>(
      (event, emit) => emit(
        HomeLoadedState(),
      ),
    );

    on<RunLongRunningEvent>((event, emit) async {
      emit(HomeLoadingState('Running long running operation...'));
      final response = await _fakeNetworkService.longRunningOperation();
      emit(HomeLoadingState(response));
      await Future.delayed(Duration(seconds: 2));
      emit(HomeLoadedState());
    });

    on<RunLongRunningStreamedEvent>((event, emit) async {
      emit(HomeLoadingState('Running long running streamed operation...'));
      await for (final result in _fakeNetworkService.longRunningStream()) {
        emit(HomeLoadingState(result));
      }
      emit(HomeLoadedState());
    });

    on<RunLongRunningStreamedComplexEvent>((event, emit) async {
      emit(HomeLoadingState('Running long running streamed complex operation...'));
      await for (final result in _fakeNetworkService.longRunningComplexStream()) {
        emit(HomeLoadingState(result.message, icon: result.icon));
      }
      emit(HomeLoadedState());
    });
  }
}
