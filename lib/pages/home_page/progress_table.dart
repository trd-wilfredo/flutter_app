import 'package:flutter/material.dart';

import 'table_list.dart';

ProgressTable() {
  List<TableList> table_data = [
    TableList(page: 'Login Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Register Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Profile Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'User Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Add User Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Edit User Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Company Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Adit Company Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Edit Company Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Product Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Add Product Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Edit Product Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'File Upload Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Group List Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'Chat Page', bar: 0.9, pecent: '90%', link: ''),
    TableList(
        page: 'Download App for Andriod Page',
        bar: 1.0,
        pecent: 'sdfs',
        link: ''),
    TableList(page: 'Search Company Page', bar: 1.0, pecent: '100%', link: ''),
    TableList(page: 'About Us Page', bar: .7, pecent: '70%', link: ''),
    TableList(page: 'Appversion Page', bar: 8.8, pecent: '80%', link: ''),
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
                    color: Color.fromARGB(255, 10, 0, 0),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: tablist.bar, // Defaults to 0.5.
                  color: Color.fromARGB(255, 0, 0, 0),
                  backgroundColor: Colors.white,
                ),
              ),
              // LinearProgressIndicator(
              //   value: tablist.bar, // Defaults to 0.5.
              //   color: Color.fromARGB(255, 0, 0, 0),
              //   backgroundColor: Colors.white,
              // ),
              // onTap: () {},
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
