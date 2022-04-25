class RegisterRequest {
  String? tenDangNhap;
  String? matKhau;
  String? hoTen;
  String? soDienThoai;
  String? ngaySinh;
  String? diaChi;
  int? gioiTinh;

  RegisterRequest(
      {this.tenDangNhap,
        this.matKhau,
        this.hoTen,
        this.soDienThoai,
        this.ngaySinh,this.diaChi,
        this.gioiTinh});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    tenDangNhap = json['TenDangNhap'];
    matKhau = json['MatKhau'];
    hoTen = json['HoTen'];
    soDienThoai = json['SoDienThoai'];
    ngaySinh = json['NgaySinh'];
    diaChi = json['diaChi'];
    gioiTinh = json['GioiTinh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenDangNhap'] = this.tenDangNhap;
    data['MatKhau'] = this.matKhau;
    data['HoTen'] = this.hoTen;
    data['SoDienThoai'] = this.soDienThoai;
    data['NgaySinh'] = this.ngaySinh;
    data['diaChi'] = this.diaChi;
    data['GioiTinh'] = this.gioiTinh;
    return data;
  }
}

