import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {

  BoletoModel boletoModel = BoletoModel();

  final formKey = GlobalKey<FormState>();
  String? validateName(String? value) => value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateDueDate(String? value) => (value?.isEmpty) ?? true ? "A data de vencimento não pode ser vazia" : null;
  String? validateMoney(double value) => value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateBarcode(String? value) => value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChange({String? name, String? dueDate, double? value, String? barCode}) {
    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barCode,
    );
  }
  
  Future save() async {
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList("boletos") ?? <String>[];
    boletos.add(boletoModel.toJson());
    await instance.setStringList("boletos", boletos);
    return;
  }

  Future saveRegister() async {
    final form = formKey.currentState;
    if (form!.validate()){
      return save();
    }
  }
}