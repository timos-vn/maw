class LoginResponse {
	LoginResponseData? data;
	int? statusCode;
	String? message;

	LoginResponse({this.data, this.statusCode, this.message});

	LoginResponse.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new LoginResponseData.fromJson(json['data']) : null;
		statusCode = json['statusCode'];
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
			data['data'] = this.data!.toJson();
		}
		data['statusCode'] = this.statusCode;
		data['message'] = this.message;
		return data;
	}
}

class LoginResponseData {
	String? accessToken;
	String? refreshToken;
	TaiKhoan? taiKhoan;

	LoginResponseData({this.accessToken, this.refreshToken, this.taiKhoan});

	LoginResponseData.fromJson(Map<String, dynamic> json) {
		accessToken = json['accessToken'];
		refreshToken = json['refreshToken'];
		taiKhoan = json['taiKhoan'] != null
				? new TaiKhoan.fromJson(json['taiKhoan'])
				: null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['accessToken'] = this.accessToken;
		data['refreshToken'] = this.refreshToken;
		if (this.taiKhoan != null) {
			data['taiKhoan'] = this.taiKhoan!.toJson();
		}
		return data;
	}
}

class TaiKhoan {
	int? id;
	String? tenDangNhap;
	String? soDienThoai;
	String? email;
	String? hoTen;
	String? ngaySinh;
	int? gioiTinh;
	String? diaChi;
	String? anhDaiDien;

	TaiKhoan(
			{this.id,
				this.tenDangNhap,
				this.soDienThoai,
				this.email,
				this.hoTen,
				this.ngaySinh,
				this.gioiTinh,
				this.diaChi,
				this.anhDaiDien});

	TaiKhoan.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		tenDangNhap = json['tenDangNhap'];
		soDienThoai = json['soDienThoai'];
		email = json['email'];
		hoTen = json['hoTen'];
		ngaySinh = json['ngaySinh'];
		gioiTinh = json['gioiTinh'];
		diaChi = json['diaChi'];
		anhDaiDien = json['anhDaiDien'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['tenDangNhap'] = this.tenDangNhap;
		data['soDienThoai'] = this.soDienThoai;
		data['email'] = this.email;
		data['hoTen'] = this.hoTen;
		data['ngaySinh'] = this.ngaySinh;
		data['gioiTinh'] = this.gioiTinh;
		data['diaChi'] = this.diaChi;
		data['anhDaiDien'] = this.anhDaiDien;
		return data;
	}
}

