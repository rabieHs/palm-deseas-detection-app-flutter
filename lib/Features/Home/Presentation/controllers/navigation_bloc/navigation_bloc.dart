import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial(0)) {
    on<NavigationEvent>((event, emit) {
      if (event is NavigateToPage1) {
        emit(NavigationInitial(0));
      } else if (event is HandleNavigation) {
        switch (event.index) {
          case 0:
            emit(NavigationInitial(0));
            break;
          case 1:
            emit(NavigationInitial(1));
            break;
          case 2:
            emit(NavigationInitial(2));
            break;
        }
      }
    });
  }
}
