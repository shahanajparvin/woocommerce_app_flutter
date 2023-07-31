import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/bloc/place_order_bloc.dart';
import 'package:woocommerce_app/helper/ui_helper.dart';
import 'package:woocommerce_app/model/ordered_product.dart';

class PlaceOrderPage extends StatefulWidget {

  var customer;  // Order place to this customer

  PlaceOrderPage(this.customer);

  @override
  PlaceOrderPageState createState() => new PlaceOrderPageState(this);
}

class PlaceOrderPageState extends State<PlaceOrderPage> {

  Widget _mainFormWidget;

  var bloc;

  BuildContext _context;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PlaceOrderPage parent;

  PlaceOrderPageState(this.parent);

  @override
  void initState() {
    super.initState();
     bloc = PlaceOrderBloc(parent.customer);

  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    if (_mainFormWidget == null) {
      _mainFormWidget = mainBody();
    }
    return _mainFormWidget; // Show the form in the application
  }

  Widget mainBody() {
    return new Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: new Container(
          height: 45,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: InkWell(
                      onTap: () {
                        bloc.routeToCartPage(_context, _scaffoldKey);
                      },
                      child: Container(
                          color: UIHelper.themeColor,
                          child: Center(
                            child: Text('Go Cart',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white)),
                          )))),
              Expanded(
                flex: 5,
                child: Center(
                  child: totalCreditWidget(),
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        appBar: new AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: new Text("New Order", style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              routeToCartWidget()
            ]),
        body: body());
  }

  /*
  * Function request to the bloc for total ordered product credit and return a widget with total credit value
  */

  Widget totalCreditWidget() {
    bloc.fetchTotalProductsCreditValue();
    return StreamBuilder(
      stream: bloc.totalCreditValueFetcher.stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Text(
                '\$ ' + snapshot.data.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: UIHelper.themeColor),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /*
  * Return the main widget body
  */

  Widget body() {
    return new Column(children: <Widget>[

      // Product list search widget
      Container(
        height: 50,
        child: new Card(
            child: new Row(
          children: <Widget>[
            new Expanded(
                flex: 6,
                child: new TextField(
                  decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.search),
                      hintText: '  Search',
                      border: InputBorder.none),
                  onChanged: bloc.onSearchTextChanged,
                )),
            new Container(
              width: 1,
              height: 50,
              color: Colors.grey,
            ),
            categoriesWidget()
          ],
        )),
      ),

      // Product List Build
      productListBuild()
    ]);
  }

  Widget routeToCartWidget() {
    bloc.totalCountProductItemInCart();
    return StreamBuilder(
      stream: bloc.totalCountProductItemInCartFetcher.stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? cartdButton(snapshot)
            : Center(child: Container());
      },
    );
  }

  Widget cartdButton(AsyncSnapshot<dynamic> s) {
    return new Container(
      child: new Stack(
        children: <Widget>[
          new IconButton(
              padding: EdgeInsets.all(0),
              icon:
                  new Icon(Icons.shopping_cart, color: Colors.white, size: 32),
              onPressed: () {
                bloc.routeToCartPage(_context, _scaffoldKey);
              }),
          new Positioned(
            left: 30.0,
            top: 5,
            child: Container(
                height: 24,
                width: 24,
                decoration: new BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(
                  s.data.toString(),
                  style: TextStyle(color: Colors.white),
                ))),
          ),
        ],
      ),
    );
  }

  /*
  * Function request categories list by bloc
  * Return a dropdown widget by getting value
  */

  Widget categoriesWidget() {
    bloc.fetchCategories();
    return StreamBuilder(
      stream: bloc.categoriesFetcher.stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? categoryDropDownWidget(snapshot)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /*
  * Function takes AsyncSnapshot data for build a dropdown widget
  * Function return a Dropdown widget
  */

  Widget categoryDropDownWidget(AsyncSnapshot<dynamic> snapshot) {
    String selectedValue;
    List<String> categoriesList;
    snapshot.data.forEach((key, value) {
      selectedValue = key;
      categoriesList = value;
    });

    return new Expanded(
        flex: 4,
        child: Center(
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
            alignedDropdown: true,
            child: new DropdownButton(
              style: new TextStyle(
                  inherit: false,
                  color: Colors.black,
                  decorationColor: Colors.white),
              isExpanded: true, // Not necessary for Option 1
              value: selectedValue,
              onChanged: (newValue) {
                bloc.searchByCategories(newValue);
              },
              items: categoriesList.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
          )),
        ));
  }

  /*
  * Function request product list using BLoc
  * Return a list widget using Stream builder
  */

  Widget productListBuild() {
    bloc.fetchProducts('', '');
    return StreamBuilder(
      stream: bloc.allProducts,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? productListViewWidget(snapshot)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
  /*
  * Function takes AsyncSnapshot data for build a ListView
  * Function return a ListView widget
  */

  Widget productListViewWidget(AsyncSnapshot<dynamic> s) {
    return new Expanded(
        child: ListView.builder(
            itemCount: s.data.length,
            itemBuilder: (_, index) {
              OrderProducts product = s.data[index];

              String productImageUrl = product.imageUrl;

              if (productImageUrl != null &&
                  !productImageUrl.contains('woocommerce-placeholder')) {
                productImageUrl = product.imageUrl;
              } else {
                productImageUrl = null;
              }

              return Container(
                  margin: EdgeInsets.all(6),
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: new Container(
                            child: productImageUrl != null
                                ? new Container()
                                : new Center(
                                    child: Text(
                                      product.name.substring(0, 1),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                            width: 40.0,
                            height: 40.0,
                            decoration: productImageUrl != null
                                ? new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            new NetworkImage(product.imageUrl)))
                                : new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: UIHelper.themeColor)),
                        title: Text(product.name),
                        subtitle: Text("MRP : " +
                            product.mrp.toString() +
                            "  |  " +
                            "Stock : " +
                            product.stock.toString()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 70,
                          ),
                          new Flexible(
                              child: Container(
                            width: 80,
                            child: new Text(
                                '\$ ' + product.totalCreditValue.toString()),
                          )),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: UIHelper.themeColor, width: 2)),
                            width: 122,
                            height: 40,
                            child: new Row(
                              children: <Widget>[
                                Container(
                                  width: 39,
                                  child: Center(
                                      child: IconButton(
                                          icon: Icon(Icons.remove,
                                              color: UIHelper.themeColor),
                                          onPressed: () {
                                            bloc.orderRemove(product.id);
                                          })),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    product.orderCount.toString(),
                                    style:
                                        TextStyle(color: UIHelper.themeColor),
                                  )),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 1.0,
                                          color: UIHelper.themeColor),
                                      left: BorderSide(
                                          width: 1.0,
                                          color: UIHelper.themeColor),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  width: 39,
                                  child: Center(
                                      child: IconButton(
                                          icon: Icon(Icons.add,
                                              color: UIHelper.themeColor),
                                          onPressed: () {
                                            bloc.orderAdd(product.id);
                                          })),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )));
            }));
  }
}
