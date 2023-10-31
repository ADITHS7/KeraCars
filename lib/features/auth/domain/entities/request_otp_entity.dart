class RequestOTPEntity {
  final String credential;
  final bool receiveUpdate;

  const RequestOTPEntity({
    required this.credential,
    required this.receiveUpdate,
  });
}
