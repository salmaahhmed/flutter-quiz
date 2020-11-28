import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BlocEventBase<BlocBase extends Bloc, State extends BlocStateBase>
    extends Equatable {
  @Deprecated('Use apply')
  Future<State> applyAsync({State currentState, BlocBase bloc}) {}
  Stream<State> apply({State currentState, BlocBase bloc}) {}
}

abstract class BlocStateBase extends Equatable {}
