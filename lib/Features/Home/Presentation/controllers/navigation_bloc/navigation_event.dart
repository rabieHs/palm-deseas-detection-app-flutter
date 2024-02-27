// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPage1 extends NavigationEvent {}

class NavigateToPage2 extends NavigationEvent {}

class NavigateToPage3 extends NavigationEvent {}

class HandleNavigation extends NavigationEvent {
  final int index;
  const HandleNavigation({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}
