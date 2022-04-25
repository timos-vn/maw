class ResetPassRequest {
  String? tenDangNhap;
  String? matKhau;

  ResetPassRequest({this.tenDangNhap, this.matKhau});

  ResetPassRequest.fromJson(Map<String, dynamic> json) {
    tenDangNhap = json['TenDangNhap'];
    matKhau = json['MatKhau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenDangNhap'] = this.tenDangNhap;
    data['MatKhau'] = this.matKhau;
    return data;
  }
}

