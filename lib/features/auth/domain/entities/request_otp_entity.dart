class RequestOTPEntity {
  final String credential;
  final bool receiveUpdate;

  RequestOTPEntity({
    required this.credential,
    required this.receiveUpdate,
  });
}
