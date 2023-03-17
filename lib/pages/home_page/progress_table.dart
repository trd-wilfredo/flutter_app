import 'package:flutter/material.dart';

import 'table_list.dart';

ProgressTable() {
  List<TableList> table_data = [
    TableList(
        page: 'Login Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 229, 111, 111)),
    TableList(
        page: 'Register Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 220, 159, 61)),
    TableList(
        page: 'Profile Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 72, 215, 33)),
    TableList(
        page: 'User Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 83, 255, 244)),
    TableList(
        page: 'Add User Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 242, 112, 244)),
    TableList(
        page: 'Edit User Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 51, 64, 160)),
    TableList(
        page: 'Company Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 180, 156, 156)),
    TableList(
        page: 'Adit Company Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 100, 29, 105)),
    TableList(
        page: 'Edit Company Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 118, 241, 145)),
    TableList(
        page: 'Product Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 234, 254, 21)),
    TableList(
        page: 'Add Product Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 43, 176, 132)),
    TableList(
        page: 'Edit Product Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 255, 196, 35)),
    TableList(
        page: 'File Upload Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 116, 116, 116)),
    TableList(
        page: 'Group List Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 37, 121, 100)),
    TableList(
        page: 'Chat Page',
        bar: 0.9,
        pecent: '90%',
        link: '',
        color: Color.fromARGB(255, 162, 255, 168)),
    TableList(
        page: 'Download App for Andriod Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 0, 0, 0)),
    TableList(
        page: 'Search Company Page',
        bar: 1.0,
        pecent: '100%',
        link: '',
        color: Color.fromARGB(255, 178, 152, 152)),
    TableList(
        page: 'About Us Page',
        bar: .7,
        pecent: '70%',
        link: '',
        color: Color.fromARGB(255, 183, 169, 44)),
    TableList(
        page: 'Appversion Page',
        bar: 8.8,
        pecent: '80%',
        link: '',
        color: Color.fromARGB(255, 74, 255, 195)),
  ];

  return DataTable(
    columns: [
      DataColumn(
        label: Text('Page'),
      ),
      DataColumn(
        label: Text('Bar'),
      ),
      DataColumn(
        label: Text('Percent'),
      ),
      // Lets add one more column to show a delete button
      DataColumn(
        label: Text('Link'),
      )
    ],
    rows: table_data
        .map(
          (tablist) => DataRow(cells: [
            DataCell(
              Text(tablist.page),
              // onTap: () {},
            ),
            DataCell(
              Container(
                width: 145,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: tablist.color,
                  ),
                ),
                child: LinearProgressIndicator(
                  value: tablist.bar, // Defaults to 0.5.
                  color: tablist.color,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            DataCell(
              Text(tablist.pecent),
              // onTap: () {},
            ),
            DataCell(
              Text(''),
              // onTap: () {},
            ),
          ]),
        )
        .toList(),
  );
}
