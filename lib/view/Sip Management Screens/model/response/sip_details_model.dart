class SipDetailsModel {

  final String totalSip;
  final String activeSip;
  final String completedSip;
  final String missedSip;
  final String totalGoldSip;


  SipDetailsModel ({
    required this.completedSip,
    required this.activeSip,
    required this.missedSip,
    required this.totalGoldSip,
    required this.totalSip
});

}