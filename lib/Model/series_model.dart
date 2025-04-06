class Series {
  final int seriesId;
  final String seriesName;
  final String startDate;
  final String endDate;
  final String tournamentName;

  Series({
    required this.seriesId,
    required this.seriesName,
    required this.startDate,
    required this.endDate,
    required this.tournamentName,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      seriesId: json['seriesId'],
      seriesName: json['seriesName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      tournamentName: json['tournamentName'],
    );
  }
}

class SeriesResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Series> data;

  SeriesResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SeriesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Series> seriesList = list.map((i) => Series.fromJson(i)).toList();

    return SeriesResponse(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: seriesList,
    );
  }
}