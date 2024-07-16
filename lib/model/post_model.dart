class PostModel {
  int? id;
  String? title;
  String? featuredImage;
  String? shortContent;

  PostModel({this.id, this.title, this.featuredImage, this.shortContent});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    featuredImage = json['featured_image'];
    shortContent = json['short_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['featured_image'] = this.featuredImage;
    data['short_content'] = this.shortContent;
    return data;
  }
}
