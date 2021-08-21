import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class ServiceState extends Equatable {
  final String totalPrice;
  final ServicesStatus status;

  const ServiceState({this.status, this.totalPrice});

  @override
  // TODO: implement props
  List<Object> get props => [status, totalPrice];

  ServiceState copyWith({String totalPrice, ServicesStatus status}) {
    return ServiceState(
        status: status ?? this.status,
        totalPrice: totalPrice ?? this.totalPrice);
  }
}

enum ServicesStatus { init, loading, loaded, loadError }

extension Explaination on ServicesStatus {
  bool get isInit => this == ServicesStatus.init;

  bool get isLoading => this == ServicesStatus.loading;

  bool get isLoaded => this == ServicesStatus.loaded;

  bool get isLoadError => this == ServicesStatus.loadError;
}
