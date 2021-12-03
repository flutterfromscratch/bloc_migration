part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  final String loadingStatus;
  final IconData? icon;

  HomeLoadingState(
    this.loadingStatus, {
    this.icon,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        loadingStatus,
        icon,
      ];
}
