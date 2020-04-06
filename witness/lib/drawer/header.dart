import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/state/actions.dart';
import 'package:morpheus_common/widgets/did_selector.dart';
import 'package:redux/redux.dart';
import 'package:witness/store/state/app_state.dart';

class Header extends StatefulWidget{
  final List<String> _dids;

  const Header(this._dids, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeaderState();
  }
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final header = <Widget>[
      Expanded(child: const Text('Your Profile',style: TextStyle(color: Colors.white,fontSize: 24)))
    ];

    if(widget._dids == null) {
      header.add(SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ));
    }

    return DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.zero,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(children: header),
              StoreConnector(
                converter: (Store<AppState> store) => DidsSelectorContext(
                    store.state.activeDid,
                    (newActiveDid) => store.dispatch(SetActiveDIDAction(newActiveDid))
                ),
                builder: (_,DidsSelectorContext selectorContext) => DidsDropdown(
                    widget._dids,
                    selectorContext.activeDid,
                    selectorContext.setActiveDid
                ),
              )
            ]
        )
    );
  }
}