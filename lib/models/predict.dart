class Predict {
  String breed;
  String emotion;
  double percentage;
  String secondEmotion;
  double secondEmotionPercentage;
  String thirdEmotion;
  double thirdEmotionPercentage;

  Predict(
      this.breed,
      this.emotion,
      this.percentage,
      this.secondEmotion,
      this.secondEmotionPercentage,
      this.thirdEmotion,
      this.thirdEmotionPercentage);

  Predict.fromJson(json) {
    breed = json['breed'];
    emotion = json['emotion'];
    percentage = json['percentage'];
    secondEmotion = json['second_label']['second_emotion'];
    secondEmotionPercentage = json['second_label']['second_emotion_percent'];
    thirdEmotion = json['third_label']['third_emotion'];
    thirdEmotionPercentage = json['third_label']['third_emotion_percent'];
  }
}
