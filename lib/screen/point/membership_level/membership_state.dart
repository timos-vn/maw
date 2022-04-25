import 'package:equatable/equatable.dart';

abstract class MembershipState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialMembershipState extends MembershipState {

  @override
  String toString() {
    return 'InitialMembershipState{}';
  }
}