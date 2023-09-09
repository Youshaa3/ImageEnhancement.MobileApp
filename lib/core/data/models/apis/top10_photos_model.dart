class Top10Model {
  int? id;
  String? image;
  String? category;
  String? owner;
  String? addedAt;
  double? rating;

  Top10Model(
      {this.id,
      this.image,
      this.category,
      this.owner,
      this.addedAt,
      this.rating});

  Top10Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    owner = json['owner'];
    addedAt = json['added_at'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    data['owner'] = this.owner;
    data['added_at'] = this.addedAt;
    data['rating'] = this.rating;
    return data;
  }
}
