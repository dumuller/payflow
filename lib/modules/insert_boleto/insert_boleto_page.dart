import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyMaskInputTextController = MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");
  final dueDateMaskInputTextController = MaskedTextController(mask: "00/00/0000");
  final barCodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barCodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text("Preencha os dados do boleto",
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                children: [
                  InputTextWidget(
                    label: "Descrição do boleto",
                    icon: Icons.description_outlined,
                    validator: controller.validateName,
                    onChange: (value){
                      controller.onChange(name: value);
                    },
                  ),
                  InputTextWidget(
                    label: "Vencimento",
                    icon: FontAwesomeIcons.timesCircle,
                    controller: dueDateMaskInputTextController,
                    validator: controller.validateDueDate,
                    onChange: (value){
                      controller.onChange(dueDate: value);
                    },
                  ),
                  InputTextWidget(
                    label: "Valor",
                    icon: FontAwesomeIcons.wallet,
                    controller: moneyMaskInputTextController,
                    validator: (_) => controller.validateMoney(moneyMaskInputTextController.numberValue),
                    onChange: (value){
                      controller.onChange(value: moneyMaskInputTextController.numberValue);
                    },
                  ),
                  InputTextWidget(
                    label: "Código de barras",
                    icon: FontAwesomeIcons.barcode,
                    controller: barCodeInputTextController,
                    validator: controller.validateBarcode,
                    onChange: (value){
                      controller.onChange(barCode: value);
                    },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        primaryOnPressed: (){
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          await controller.saveRegister();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
