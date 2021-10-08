import 'package:flutter/material.dart';
import 'package:flutter_app/Services/Announcement_Service.dart';
import 'package:flutter_app/api/AnnouncementApi.dart';
import 'package:flutter_app/models/AnnouncementModel.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/screens/AnnouncementScreen/Announce.dart';
import 'package:flutter_app/screens/AnnouncementScreen/DeleteAnnouncement.dart';
import 'package:get_it/get_it.dart';


class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  Annoucement_Service get service => GetIt.I<Annoucement_Service>();

  APIResponse<List<AnnouncementModel>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchAnnouncement();
    super.initState();
  }
  _fetchAnnouncement() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getAnnouncements();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Announcements')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Announce()));
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }
            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.green),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data[index].AnnID),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => DeleteAnnouncement());
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponse.data[index].Ann_Title,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(_apiResponse.data[index].Ann_Dis,),

                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Announce(
                      AnnID: _apiResponse.data[index].AnnID)));
                    },
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}