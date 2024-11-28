class CreateSocialMediaRequestModel {

  final String platform;
  final String link;

  CreateSocialMediaRequestModel ({
    required this.platform,
    required this.link
});


  Map<String , dynamic>  toJson () {
    return {

      "platform": platform,
      "link" :link

    };
  }

}