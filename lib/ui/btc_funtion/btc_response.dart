import 'package:json_annotation/json_annotation.dart';

class BtcDetailResponse {
  Time? time;
  String? disclaimer;
  String? chartName;
  Bpi? bpi;

  BtcDetailResponse({this.time, this.disclaimer, this.chartName, this.bpi});

  BtcDetailResponse.fromJson(Map<String, dynamic> json) {
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    disclaimer = json['disclaimer'];
    chartName = json['chartName'];
    bpi = json['bpi'] != null ? Bpi.fromJson(json['bpi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['disclaimer'] = disclaimer;
    data['chartName'] = chartName;
    if (bpi != null) {
      data['bpi'] = bpi!.toJson();
    }
    return data;
  }
}

class Time {
  String? updated;
  String? updatedISO;
  String? updateduk;

  Time({this.updated, this.updatedISO, this.updateduk});

  Time.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    updatedISO = json['updatedISO'];
    updateduk = json['updateduk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updated'] = updated;
    data['updatedISO'] = updatedISO;
    data['updateduk'] = updateduk;
    return data;
  }
}

class Bpi {
  USD? uSD;
  USD? gBP;
  USD? eUR;

  Bpi({this.uSD, this.gBP, this.eUR});

  Bpi.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
    gBP = json['GBP'] != null ? USD.fromJson(json['GBP']) : null;
    eUR = json['EUR'] != null ? USD.fromJson(json['EUR']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    if (gBP != null) {
      data['GBP'] = gBP!.toJson();
    }
    if (eUR != null) {
      data['EUR'] = eUR!.toJson();
    }
    return data;
  }
}

class USD {
  String? code;
  String? symbol;
  String? rate;
  String? description;
  double? rateFloat;

  USD({this.code, this.symbol, this.rate, this.description, this.rateFloat});

  USD.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}

class BtcDetailAddListLocal {
  List<BtcDetailResponse>? btcDetailLatest = [];

  BtcDetailAddListLocal({this.btcDetailLatest});

  BtcDetailAddListLocal.fromJson(Map<String, dynamic> json) {
    if (json['lists'] != null) {
      btcDetailLatest = <BtcDetailResponse>[];
      json['lists'].forEach((v) {
        btcDetailLatest!.add(BtcDetailResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (btcDetailLatest != null) {
      data['lists'] = btcDetailLatest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
