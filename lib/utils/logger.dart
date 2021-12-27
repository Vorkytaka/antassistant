import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin Logger<State> on BlocBase<State> {
  @override
  void onChange(Change<State> change) {
    super.onChange(change);
    if (kDebugMode) {
      print('---------');
      print(change.currentState);
      print(change.nextState);
      print('---------');
    }
  }
}
