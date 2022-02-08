class   VegetableResponse {
  String status;
  String message;
  bool like;
  Data data;

  VegetableResponse({this.status, this.message, this.data});

  VegetableResponse.fromJson(Map<String, dynamic> json) {

    like = false;
    data=new Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String price;
  dynamic images;
  String description;
  String vitamins;
  String minerals;
  List<String> pros;
  List<String> cons;

  Data(
      {this.id,
        this.title,
        this.price,
        this.images,
        this.description,
        this.vitamins,
        this.minerals,
        this.pros,
        this.cons});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    images = json['images'];
    description = json['description'];
    vitamins = json['vitamins'];
    minerals = json['minerals'];
    pros = json['pros'].cast<String>();
    cons = json['Cons'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['images'] = this.images;
    data['description'] = this.description;
    data['vitamins'] = this.vitamins;
    data['minerals'] = this.minerals;
    data['pros'] = this.pros;
    data['Cons'] = this.cons;
    return data;
  }
}
