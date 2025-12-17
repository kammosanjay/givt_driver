class VouchersList {
  bool? success;
  String? message;
  String? brandLogoBaseUrl;
  List<Vouchers>? vouchers;

  VouchersList({
    this.success,
    this.message,
    this.brandLogoBaseUrl,
    this.vouchers,
  });

  VouchersList.fromJson(Map<String, dynamic> json) {
    success = json['success'];  
    message = json['message'];
    brandLogoBaseUrl = json['brand_logo_base_url'];
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers!.add(Vouchers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['brand_logo_base_url'] = this.brandLogoBaseUrl;
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vouchers {
  int? id;
  String? voucherTitle;
  int? brandId;
  Category? category;
  String? discountType;
  int? discountAmount;
  Brand? brand;

  Vouchers({
    this.id,
    this.voucherTitle,
    this.brandId,
    this.category,
    this.discountType,
    this.discountAmount,
    this.brand,
  });

  Vouchers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherTitle = json['voucher_title'];
    brandId = json['brand_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_title'] = this.voucherTitle;
    data['brand_id'] = this.brandId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? category;

  Category({this.id, this.category});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}

class Brand {
  int? id;
  String? companyName;
  String? brandLogo;

  Brand({this.id, this.companyName, this.brandLogo});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    brandLogo = json['brand_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['brand_logo'] = this.brandLogo;
    return data;
  }
}
