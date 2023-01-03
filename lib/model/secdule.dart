class Secdule {
  static const CAFTERIAID = "cafeteriaid";
  static const END_HOUR = "end_work_hour";
  static const START_HOUR = "start_work_hour";
  static const VENDOR_NAME = "vendor_name";
  static const VENDORID = "vendorid";
  static const WORK_DATE = "work_date";
  static const WORKS_HOURS = "works_hours";

  String cafateriaId;
  String start_work_hour;
  String end_work_hour;
  String vendor_name;
  String vendorid;
  String work_date;
  String works_hours;

  Secdule.fromSnapshot(Map<String, dynamic> data) {
    cafateriaId = data[CAFTERIAID];
    start_work_hour = data[START_HOUR];
    end_work_hour = data[END_HOUR];
    vendor_name = data[VENDOR_NAME];
    vendorid = data[VENDORID];
    work_date = data[WORK_DATE];
    works_hours = data[WORKS_HOURS];
  }
}
