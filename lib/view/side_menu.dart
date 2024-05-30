import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/jobs_list_page.dart';

import '../utils/routes/routes_names.dart';
import 'candidate_list_page.dart';
import 'home_screen.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: Column(
        children: [
          DrawerHeader(
            child: Text('Menu', style: TextStyle(fontSize: 24)),
          ),
        //  MenuTile(icon: Icons.home, title: 'Home', routeName: RoutesNames.candidateList,),
          MenuTile(icon: Icons.work, title: 'Jobs', routeName: RoutesNames.jobsList ),
          MenuTile(icon: Icons.group, title: 'Candidates', routeName: RoutesNames.candidateList, ),
          MenuTile(icon: Icons.work_history_outlined, title: 'Create Job', routeName: RoutesNames.createJob, ),
          MenuTile(icon: Icons.account_circle_outlined, title: 'Create Candidates', routeName: RoutesNames.createCandidate, ),
          MenuTile(icon: Icons.inbox, title: 'Inbox', routeName: '', ),
          MenuTile(icon: Icons.bar_chart, title: 'Reports', routeName: '', ),
          MenuTile(icon: Icons.settings, title: 'Settings', routeName: '', ),
        ],
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;

  MenuTile({required this.icon, required this.title, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
    );
  }
}

class InboxPage extends StatelessWidget {
  late String title;
  InboxPage({ required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${title}')),
      body: Center(child: Text('Coming Soon...')),
    );
  }
}
