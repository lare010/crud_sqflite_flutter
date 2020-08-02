class CategoryModel {
  CategoryModel({
    this.id,
    this.categoryname,
  });

  int id;
  String categoryname;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        categoryname: json["categoryname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryname": categoryname,
      };
}
