class DetailModel {
  int? id;
  String? title;
  String? content;
  String? authorName;
  String? createdDate;
  String? featuredImageUrl;

  DetailModel(
      {this.id,
      this.title,
      this.content,
      this.authorName,
      this.createdDate,
      this.featuredImageUrl});

  DetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    authorName = json['author_name'];
    createdDate = json['created_date'];
    featuredImageUrl = json['featured_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['author_name'] = this.authorName;
    data['created_date'] = this.createdDate;
    data['featured_image_url'] = this.featuredImageUrl;
    return data;
  }
}
