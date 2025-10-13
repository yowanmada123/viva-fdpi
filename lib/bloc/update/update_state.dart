part of 'update_bloc.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object?> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateChecking extends UpdateState {}

class UpdateAvailable extends UpdateState {
  final String latestVersion;
  final String apkUrl;
  final String updateNotes;

  const UpdateAvailable({
    required this.latestVersion,
    required this.apkUrl,
    required this.updateNotes,
  });

  @override
  List<Object?> get props => [latestVersion, apkUrl, updateNotes];
}

class UpdateNotAvailable extends UpdateState {}

class UpdateError extends UpdateState {
  final String message;

  const UpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateDownloading extends UpdateState {
  final double progress;

  const UpdateDownloading(this.progress);

  @override
  List<Object?> get props => [progress];
}

class UpdateDownloaded extends UpdateState {
  final String filePath;

  const UpdateDownloaded(this.filePath);

  @override
  List<Object?> get props => [filePath];
}
