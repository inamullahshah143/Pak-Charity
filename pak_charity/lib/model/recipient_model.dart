class RecipientModel {
  const RecipientModel({
    this.requestId,
    this.imageURL,
    this.title,
    this.details,
    this.donationType,
    this.amountNeed,
    this.collectedPercentage,
    this.viewDetails,
    this.donate,
  });
  final String requestId;
  final String imageURL;
  final String title;
  final String details;
  final String donationType;
  final double amountNeed;
  final double collectedPercentage;
  final Function viewDetails;
  final Function donate;
}
