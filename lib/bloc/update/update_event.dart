part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class CheckForUpdate extends UpdateEvent {}

class DownloadUpdate extends UpdateEvent {
  final String apkUrl;

  const DownloadUpdate(this.apkUrl);

  @override
  List<Object> get props => [apkUrl];
}
