import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:attendance_webapp/style.dart';

class AttendanceDetailsScreen extends StatefulWidget {
  @override
  _AttendanceDetailsScreenState createState() =>
      _AttendanceDetailsScreenState();
  static const routeName = '/attendance-detail';
}

var formatter = new DateFormat('dd-MM-yyyy');
DateTime selectedDate = DateTime.now();

class _AttendanceDetailsScreenState extends State<AttendanceDetailsScreen> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width / 200),
              Container(
                width: size.width,
                height: size.height - size.height / 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 130),
                          width: MediaQuery.of(context).size.width / 7.5,
                          height: MediaQuery.of(context).size.width / 40,
                          child: Text('Select Date'),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 130),
                          width: MediaQuery.of(context).size.width / 7.5,
                          height: MediaQuery.of(context).size.width / 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border:
                                  Border.all(color: Colors.black87, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RaisedButton(
                                color: Colors.white,
                                onPressed: () {
                                  _selectDate(context);
                                  var date =
                                      formatter.format(selectedDate.toLocal());
                                  print(date);
                                },
                                child: Text(
                                  selectedDate == DateTime.now()
                                      ? Text('no date')
                                      : "${formatter.format(selectedDate.toLocal())}",
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 200),
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: tabledetails,
                          child: Text('Get Records'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height / 1.25,
                width: size.width,
                child: SizedBox(), //tabledetails(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

chooseStream() {
  if (selectedDate = null) {
    return null;
  } else {
    return Firestore.instance
        .collectionGroup('Attendance History')
        .where("date", isEqualTo: "${formatter.format(selectedDate.toLocal())}")
        .snapshots();
  }
}

tabledetails() {
  getDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: Style.columnStyle,
      ),
    );
  }

  return SingleChildScrollView(
    child: StreamBuilder<QuerySnapshot>(
      stream: chooseStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Text(
              'Data not Found',
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          ));
        }
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new PaginatedDataTable(
              header: Text('Records', style: Style.headStyle),
              columns: [
                getDataColumn('Sl.No.'),
                getDataColumn('Name'),
                getDataColumn('Roll Number'),
              ],
              source: DTSStuRec(snapshot.data.documents),
              rowsPerPage: 10,
            );
        }
      },
    ),
  );
}

class DTSStuRec extends DataTableSource {
  final List<DocumentSnapshot> d;

  DTSStuRec(this.d);

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}', style: Style.cellStyle)),
        DataCell(
          d[index]['sName'] == null
              ? Text('No Data')
              : Text(d[index]['sName'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['rollNum'] == null
              ? Text('No Data')
              : Text(d[index]['rollNum'], style: Style.cellStyle),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => d.length;

  @override
  int get selectedRowCount => 0;
}
