import 'package:equatable/equatable.dart';

abstract class DetailProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends DetailProductEvent {
  @override
  String toString() => 'GetPrefs';
}

class IndexBanner extends DetailProductEvent{
  final int? indexBanner;

  IndexBanner({this.indexBanner});
  @override
  String toString() {
    return 'IndexBanner{indexBanner: $indexBanner}';
  }
}
