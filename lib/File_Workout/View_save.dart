import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';

class View_save extends StatefulWidget {
  @override
  _View_saveState createState() => _View_saveState();
}

class _View_saveState extends State<View_save> with TickerProviderStateMixin {
  int _tabIndex = 0;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  void _toggleTab() {
    _tabIndex = _tabController.index + 1;
    _tabController.animateTo(_tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              notchMargin: 20,
            ),
            appBar: AppBar(
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      var observer = Provider.of<Observer>(context);
                      observer.save_fisier();
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text('Save')),
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text('Discard'))
              ],
              backgroundColor: Colors.yellow[800],
              toolbarHeight: 100,
              elevation: 0,
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Summary Contract'),
                  Tab(text: 'Full Contract'),
                ],
              ),
            ),
            body: Consumer<Observer>(builder: (context, cart, child) {
              return TabBarView(controller: _tabController, children: [
                Expanded(
                    flex: 1,
                    child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical, //.horizontal
                        child: cart.current_fisier != null
                            ? Text(cart.current_fisier.summary)
                            : Text(''))),
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: cart.current_fisier != null
                          ? Text(cart.current_fisier.name)
                          : Text('')),
                )
              ]);
            })));
  }
}
