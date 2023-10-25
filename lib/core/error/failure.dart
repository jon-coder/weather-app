import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerError extends Failure {
  const ServerError(message) : super(message);
}

class ConnectionError extends Failure {
  const ConnectionError(message) : super(message);
}

class DatabaseError extends Failure {
  const DatabaseError(message) : super(message);
}
