class PromotionBanner {
  int adverts2Id;
  int enabled;
  String campaignName;
  String itemUrl;
  String itemLinkUrl;

  PromotionBanner({
    required this.adverts2Id,
    required this.enabled,
    required this.campaignName,
    required this.itemUrl,
    required this.itemLinkUrl,
  });

  factory PromotionBanner.fromJson(Map<String, dynamic> json) => PromotionBanner(
        adverts2Id: json["Adverts2Id"],
        enabled: json["Enabled"],
        campaignName: json["CampaignName"],
        itemUrl: json["ItemUrl"],
        itemLinkUrl: json["ItemLinkUrl"],
      );
}
