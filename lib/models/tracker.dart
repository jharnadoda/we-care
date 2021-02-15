import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerModel {
  BloodPressureTracker bloodPressureTracker;
  BloodSugarTracker bloodSugarTracker;
  TrackerModel();
}

class BloodSugar {
  int bloodSugar;
  String notes;
  DateTime dateTime;
  BloodSugar({this.bloodSugar, this.notes, this.dateTime});
}

class BloodSugarTracker {
  bool isTracking;
  BloodSugar bloodSugar;
  BloodSugarTracker();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['dateAndTime'] = this.bloodSugar.dateTime.toString();
    map['blood_sugar'] = this.bloodSugar.bloodSugar.toString();
    map['notes'] = this.bloodSugar.notes;

    return map;
  }

  fromMap(Map<String, dynamic> map) {
    BloodSugar bloodSugar = BloodSugar();
    bloodSugar.dateTime = DateTime.parse(map['dateAndTime']);
    bloodSugar.bloodSugar = int.parse(map['blood_sugar']);

    bloodSugar.notes = map['notes'];
    return bloodSugar;
  }

  List<BloodSugar> loadData(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.documents;
    List<BloodSugar> bloodSugarList = [];
    for (var data in documents) {
      Map map = data.data;
      bloodSugarList.add(this.fromMap(map));
    }
    return bloodSugarList;
  }
}

class BloodPressure {
  int systolic, diastolic, pulse;
  String notes;
  DateTime dateTime;

  BloodPressure(
      {this.systolic, this.diastolic, this.pulse, this.notes, this.dateTime});
}

class BloodPressureTracker {
  bool isTracking;
  BloodPressure bloodPressure;
  BloodPressureTracker();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['dateAndTime'] = this.bloodPressure.dateTime.toString();
    map['diastolic'] = this.bloodPressure.diastolic.toString();
    map['systolic'] = this.bloodPressure.systolic.toString();
    map['pulse'] = this.bloodPressure.pulse.toString();
    map['notes'] = this.bloodPressure.notes;

    return map;
  }

  fromMap(Map<String, dynamic> map) {
    BloodPressure bloodPressure = BloodPressure();
    bloodPressure.dateTime = DateTime.parse(map['dateAndTime']);
    bloodPressure.diastolic = int.parse(map['diastolic']);
    bloodPressure.systolic = int.parse(map['systolic']);
    bloodPressure.pulse = int.parse(map['pulse']);

    bloodPressure.notes = map['notes'];
    return bloodPressure;
  }

  List<BloodPressure> loadData(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.documents;
    List<BloodPressure> bloodPressureList = [];
    for (var data in documents) {
      Map map = data.data;
      bloodPressureList.add(this.fromMap(map));
    }
    return bloodPressureList;
  }
}
