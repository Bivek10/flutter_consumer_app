class MenuItemModel {
  String? type;
  List<MenuItems>? menuItems;
  int? offset;
  int? number;
  int? totalMenuItems;
  int? processingTimeMs;
  int? expires;
  bool? isStale;
  String? errorMessage;

  MenuItemModel(
      {type,
      menuItems,
      offset,
      number,
      totalMenuItems,
      processingTimeMs,
      expires,
      isStale});

  MenuItemModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['menuItems'] != null) {
      menuItems = <MenuItems>[];
      json['menuItems'].forEach((v) {
        menuItems!.add(MenuItems.fromJson(v));
      });
    }
    offset = json['offset'];
    number = json['number'];
    totalMenuItems = json['totalMenuItems'];
    processingTimeMs = json['processingTimeMs'];
    expires = json['expires'];
    isStale = json['isStale'];
  }
  MenuItemModel.erroMessage(Map<String, dynamic> error) {
    errorMessage = error["error"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    if (menuItems != null) {
      data['menuItems'] = menuItems!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    data['number'] = number;
    data['totalMenuItems'] = totalMenuItems;
    data['processingTimeMs'] = processingTimeMs;
    data['expires'] = expires;
    data['isStale'] = isStale;
    return data;
  }
}

class MenuItems {
  int? id;
  String? title;
  String? image;
  String? imageType;
  String? restaurantChain;
  String? servingSize;
  String? readableServingSize;
  Servings? servings;

  MenuItems(
      {id,
      title,
      image,
      imageType,
      restaurantChain,
      servingSize,
      readableServingSize,
      servings});

  MenuItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
    restaurantChain = json['restaurantChain'];
    servingSize = json['servingSize'];
    readableServingSize = json['readableServingSize'];
    servings =
        json['servings'] != null ? Servings.fromJson(json['servings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['imageType'] = imageType;
    data['restaurantChain'] = restaurantChain;
    data['servingSize'] = servingSize;
    data['readableServingSize'] = readableServingSize;
    if (servings != null) {
      data['servings'] = servings!.toJson();
    }
    return data;
  }
}

class Servings {
  num? number;
  num? size;
  String? unit;

  Servings({number, size, unit});

  Servings.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    size = json['size'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = number;
    data['size'] = size;
    data['unit'] = unit;
    return data;
  }
}
