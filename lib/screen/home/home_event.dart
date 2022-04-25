import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends HomeEvent {
  @override
  String toString() => 'GetPrefs';
}

class IndexBanner extends HomeEvent{
  final int? indexBanner;

  IndexBanner({this.indexBanner});
  @override
  String toString() {
    return 'IndexBanner{indexBanner: $indexBanner}';
  }
}

