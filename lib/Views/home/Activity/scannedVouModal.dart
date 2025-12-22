class ScannedVouModal {
  String? deliveryDate;
  Voucher? voucher;

  ScannedVouModal({this.deliveryDate, this.voucher});

  ScannedVouModal.fromJson(Map<String, dynamic> json) {
    deliveryDate = json['delivery_date'];
    voucher =
        json['voucher'] != null ? new Voucher.fromJson(json['voucher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_date'] = this.deliveryDate;
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    return data;
  }
}

class Voucher {
  int? id;
  String? voucherTitle;
  String? voucherCode;
  int? brandId;
  int? category;
  String? description;
  String? discountType;
  int? discountAmount;
  String? validFrom;
  String? validUpto;
  String? minPurchase;
  String? maxDiscount;
  String? termsConditions;
  int? selectedDesign;
  String? createdAt;
  String? updatedAt;

  Voucher(
      {this.id,
      this.voucherTitle,
      this.voucherCode,
      this.brandId,
      this.category,
      this.description,
      this.discountType,
      this.discountAmount,
      this.validFrom,
      this.validUpto,
      this.minPurchase,
      this.maxDiscount,
      this.termsConditions,
      this.selectedDesign,
      this.createdAt,
      this.updatedAt});

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherTitle = json['voucher_title'];
    voucherCode = json['voucher_code'];
    brandId = json['brand_id'];
    category = json['category'];
    description = json['description'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    validFrom = json['valid_from'];
    validUpto = json['valid_upto'];
    minPurchase = json['min_purchase'];
    maxDiscount = json['max_discount'];
    termsConditions = json['terms_conditions'];
    selectedDesign = json['selected_design'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_title'] = this.voucherTitle;
    data['voucher_code'] = this.voucherCode;
    data['brand_id'] = this.brandId;
    data['category'] = this.category;
    data['description'] = this.description;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['valid_from'] = this.validFrom;
    data['valid_upto'] = this.validUpto;
    data['min_purchase'] = this.minPurchase;
    data['max_discount'] = this.maxDiscount;
    data['terms_conditions'] = this.termsConditions;
    data['selected_design'] = this.selectedDesign;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
