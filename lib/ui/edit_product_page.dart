import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/providers/products_provider.dart';
import 'package:shop_app/util/style/colors.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
  String id;
  EditProductPage({this.id});
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product product = Product(
      id: null, description: null, imageUrl: null, price: 0, title: null);

  @override
  void initState() {
    print('mDebug: init');
    if (widget.id != null) {
      product = Provider.of<ProductsModel>(context, listen: false)
          .getProductById(widget.id);
      _imageUrlController.text = product.imageUrl;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('mDebug: build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                initialValue: product.title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  product = Product(
                    title: value,
                    description: product.description,
                    price: product.price,
                    imageUrl: product.imageUrl,
                    id: product.id,
                    isFavourite: product.isFavourite,
                  );
                },
                onChanged: (text) {
                  print('mDebug: onChange $text');
                },
                onFieldSubmitted: (text) {
                  print('mDebug: onFieldSubmitted $text');
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onEditingComplete: () {
                  print('mDebug: onEdittingComplete');
                },
              ),
              TextFormField(
                initialValue: product.price.toString(),
                onSaved: (value) {
                  product = Product(
                    title: product.title,
                    description: product.description,
                    price: double.tryParse(value) ?? 0,
                    imageUrl: product.imageUrl,
                    isFavourite: product.isFavourite,
                    id: product.id,
                  );
                },
                validator: (value) {
                  //null = text correct
                  // text is error message

                  if (value.isEmpty) return "valid value";

                  return null;
                },
                decoration: InputDecoration(labelText: 'price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                onSaved: (value) {
                  product = Product(
                    title: product.title,
                    description: value,
                    price: product.price,
                    imageUrl: product.imageUrl,
                    isFavourite: product.isFavourite,
                    id: product.id,
                  );
                },
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                initialValue: product.description,
                onChanged: (text) {
                  print('mDebug: onChange $text');
                },
                onFieldSubmitted: (text) {
                  print('mDebug: onFieldSubmitted $text');
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onEditingComplete: () {
                  print('mDebug: onEdittingComplete');
                },
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(child: Text('Enter Url'))
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onSaved: (value) {
                        product = Product(
                          title: product.title,
                          description: product.description,
                          price: product.price,
                          imageUrl: value,
                          id: product.id,
                          isFavourite: product.isFavourite,
                        );
                      },
                      controller: _imageUrlController,
                      decoration: InputDecoration(labelText: 'Image url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: FlatButton(
                  onPressed: _saveForm,
                  color: AppColors.primarySwatch,
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    _form.currentState.save();
    final productProivder = Provider.of<ProductsModel>(context, listen: false);
    product.id == null
        ? productProivder.addProduct(product)
        : productProivder.updateProduct(product.id, product);
    Navigator.pop(context);
    print('mDebug: save');
    print('mDebug: isValid ${_form.currentState.validate()}');
  }
}
