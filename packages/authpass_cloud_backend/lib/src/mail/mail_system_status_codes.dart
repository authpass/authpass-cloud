/// https://tools.ietf.org/html/rfc3463
class MailSystemStatusCodes {
  const MailSystemStatusCodes._(
    this.classCode,
    this.subjectCode,
    this.detailCode,
  );

  static const success = MailSystemStatusCodes._(
    CLASS_SUCCESS,
    OTHER,
    OTHER,
  );
  static const errorNetworkMisc = MailSystemStatusCodes._(
    CLASS_PERMANENT_FAILURE,
    ROUTING_OTHER,
    OTHER,
  );

  static const CLASS_SUCCESS = '2';
  static const CLASS_PERSISTENT_TRANSIENT_ERROR = '4';
  static const CLASS_PERMANENT_FAILURE = '5';

  static const ROUTING_OTHER = '4';

  static const OTHER = '0';

  final String classCode;
  final String subjectCode;
  final String detailCode;

  @override
  String toString() {
    return '$classCode.$subjectCode.$detailCode';
  }
}
