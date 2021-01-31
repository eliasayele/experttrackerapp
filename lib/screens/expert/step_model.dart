class StepModel {
  final int id;
  final String text;

  StepModel({this.id, this.text});

  static List<StepModel> list = [
    StepModel(
      id: 1,
      text:
          "create your profile\n please be responsible \nand use common words",
    ),
    StepModel(
      id: 2,
      text:
          "You will be expose to millions of users\ngrowth your network\nand be paid",
    ),
  ];
}
