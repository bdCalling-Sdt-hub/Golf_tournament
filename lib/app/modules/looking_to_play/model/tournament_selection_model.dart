class TournamentSelectionModel {
  int? code;
  String? message;
  TournamentSelectionData? data;

  TournamentSelectionModel({this.code, this.message, this.data});

  TournamentSelectionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? TournamentSelectionData.fromJson(json['data']) : null;
  }
}

class TournamentSelectionData {
  TournamentSelectionAttributes? attributes;

  TournamentSelectionData({this.attributes});

  TournamentSelectionData.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? TournamentSelectionAttributes.fromJson(json['attributes'])
        : null;
  }
}

class TournamentSelectionAttributes {
  List<SmallTournament>? smallTournament;
  List<BigTournament>? bigTournament;

  TournamentSelectionAttributes({this.smallTournament, this.bigTournament});

  TournamentSelectionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['smallTournament'] != null) {
      smallTournament = <SmallTournament>[];
      json['smallTournament'].forEach((v) {
        smallTournament!.add(SmallTournament.fromJson(v));
      });
    }
    if (json['bigTournament'] != null) {
      bigTournament = <BigTournament>[];
      json['bigTournament'].forEach((v) {
        bigTournament!.add(BigTournament.fromJson(v));
      });
    }
  }
}

class SmallTournament {
  CourseLocation? courseLocation;
  String? sId;
  String? tournamentCreator;
  List<String>? tournamentPlayersList;
  String? tournamentName;
  String? tournamentType;
  String? typeName;
  String? date;
  String? time;
  String? city;
  String? courseName;
  bool? isApproved;
  bool? isRejected;
  int? courseRating;
  int? slopeRating;
  int? numberOfPlayers;
  int? handicapFromRange;
  int? handicapToRange;
  TournamentImage? tournamentImage;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SmallTournament(
      {this.courseLocation,
        this.sId,
        this.tournamentCreator,
        this.tournamentPlayersList,
        this.tournamentName,
        this.tournamentType,
        this.typeName,
        this.date,
        this.time,
        this.city,
        this.courseName,
        this.isApproved,
        this.isRejected,
        this.courseRating,
        this.slopeRating,
        this.numberOfPlayers,
        this.handicapFromRange,
        this.handicapToRange,
        this.tournamentImage,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SmallTournament.fromJson(Map<String, dynamic> json) {
    courseLocation = json['courseLocation'] != null
        ? CourseLocation.fromJson(json['courseLocation'])
        : null;
    sId = json['_id'];
    tournamentCreator = json['tournamentCreator'];
    tournamentPlayersList = json['tournamentPlayersList'].cast<String>();
    tournamentName = json['tournamentName'];
    tournamentType = json['tournamentType'];
    typeName = json['typeName'];
    date = json['date'];
    time = json['time'];
    city = json['city'];
    courseName = json['courseName'];
    isApproved = json['isApproved'];
    isRejected = json['isRejected'];
    courseRating = json['courseRating'];
    slopeRating = json['slopeRating'];
    numberOfPlayers = json['numberOfPlayers'];
    handicapFromRange = json['handicapFromRange'];
    handicapToRange = json['handicapToRange'];
    tournamentImage = json['tournamentImage'] != null
        ? TournamentImage.fromJson(json['tournamentImage'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class CourseLocation {
  List<double>? coordinates;
  String? type;

  CourseLocation({this.coordinates, this.type});

  CourseLocation.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    type = json['type'];
  }
}

class TournamentImage {
  String? url;
  String? path;

  TournamentImage({this.url, this.path});

  TournamentImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class BigTournament {
  CourseLocation? courseLocation;
  String? sId;
  String? clubName;
  String? tournamentCreator;
  List<String>? tournamentPlayersList;
  String? tournamentType;
  String? typeName;
  String? date;
  String? time;
  String? city;
  String? courseName;
  bool? isApproved;
  bool? isRejected;
  int? courseRating;
  double? slopeRating;
  int? numberOfPlayers;
  int? gaggleLength;
  TournamentImage? tournamentImage;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BigTournament(
      {this.courseLocation,
        this.sId,
        this.clubName,
        this.tournamentCreator,
        this.tournamentPlayersList,
        this.tournamentType,
        this.typeName,
        this.date,
        this.time,
        this.city,
        this.courseName,
        this.isApproved,
        this.isRejected,
        this.courseRating,
        this.slopeRating,
        this.numberOfPlayers,
        this.gaggleLength,
        this.tournamentImage,
        this.createdAt,
        this.updatedAt,
        this.iV});

  BigTournament.fromJson(Map<String, dynamic> json) {
    courseLocation = json['courseLocation'] != null
        ? CourseLocation.fromJson(json['courseLocation'])
        : null;
    sId = json['_id'];
    clubName = json['clubName'];
    tournamentCreator = json['tournamentCreator'];
    tournamentPlayersList = json['tournamentPlayersList'].cast<String>();
    tournamentType = json['tournamentType'];
    typeName = json['typeName'];
    date = json['date'];
    time = json['time'];
    city = json['city'];
    courseName = json['courseName'];
    isApproved = json['isApproved'];
    isRejected = json['isRejected'];
    courseRating = json['courseRating'];
    slopeRating = json['slopeRating'];
    numberOfPlayers = json['numberOfPlayers'];
    gaggleLength = json['gaggleLength'];
    tournamentImage = json['tournamentImage'] != null
        ? TournamentImage.fromJson(json['tournamentImage'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
