// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final int navigationState;
  const NavigationState(
    this.navigationState,
  );

  @override
  List<Object> get props => [navigationState];
}

class NavigationInitial extends NavigationState {
  const NavigationInitial(super.navigationState);
}

class NavigationHandleState extends NavigationState {
  const NavigationHandleState(super.navigationState);
}
