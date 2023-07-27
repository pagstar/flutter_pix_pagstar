import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyInputField extends StatefulWidget {
  final Function(double?)? onChanged;
  final String prefixText;
  final EdgeInsets? padding;
  final double initialWidth;
  final double fontSize;
  final bool autoFocus;
  final bool readOnly;
  final double? maxValue;
  final bool clearButton;

  const MoneyInputField({
    required this.onChanged,
    this.prefixText = 'R\$ ',
    this.initialWidth = 120,
    this.fontSize = 42.0,
    this.autoFocus = true,
    this.readOnly = false,
    this.padding = const EdgeInsets.fromLTRB(10, 30, 10, 40),
    this.maxValue = 500,
    this.clearButton = true,
    Key? key,
  }) : super(key: key);

  @override
  State<MoneyInputField> createState() => MoneyInputFieldState();
}

class MoneyInputFieldState extends State<MoneyInputField> {
  final TextEditingController controller = TextEditingController(text: '0,00');
  double? width;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    _onChanged();
  }

  @override
  void dispose() {
    super.dispose();
    controller
      ..removeListener(_onChanged)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMoneyInputField(),
      ],
    );
  }

  Widget _buildMoneyInputField() {
    return Container(
      padding: widget.padding,
      width: width,
      child: TextFormField(
        enableInteractiveSelection: false,
        readOnly: widget.readOnly,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        inputFormatters: [
          CurrencyInputFormatter(maxValue: widget.maxValue),
        ],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: widget.fontSize,
          color: const Color(0xFF333333),
        ),
        textAlign: TextAlign.center,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixText: '${widget.prefixText} ',
          prefixStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18.0,
            color: Color(0xFF4F4F4F),
          ),
          suffixIcon: widget.clearButton ? _suffixButton() : null,
        ),
        onChanged: _onChanged,
      ),
    );
  }

  Widget _suffixButton() {
    return Semantics(
      label: '',
      child: IconButton(
        onPressed: _onClearClick,
        icon: const Icon(
          Icons.clear,
          size: 32.0,
          color: Color(0xFF009BE7),
        ),
      ),
    );
  }

  void _onChanged([String? text]) {
    if (mounted) {
      setState(() {
        final length = controller.text.length;
        final point = (length / 3).floor();
        width = widget.initialWidth +
            length * (widget.fontSize / 2.3) +
            point * (widget.fontSize / 3.8);
      });
    }

    widget.onChanged!(getNumberValue(controller.text));
  }

  void _onClearClick() {
    setState(() {
      controller.text = '0,00';
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    });
  }

  double? getNumberValue(String? value) {
    if (value == null) {
      return null;
    }
    return double.tryParse(
        value.replaceAll(',', '.').replaceAll(RegExp(r'[^\d.]'), ''));
  }

  double? getMoneyValue() {
    return double.tryParse(controller.text.replaceAll(',', '.'));
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final double? maxValue;

  CurrencyInputFormatter({this.maxValue});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(text: '0,00');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      double numericValue = double.parse(newText) / 100;
      if (maxValue != null && numericValue > maxValue!) {
        newText = (maxValue! * 100).toStringAsFixed(0);
      }
      if (newText.length < 3) {
        newText = newText.padLeft(3, '0');
      }
      newText =
          '${newText.substring(0, newText.length - 2)},${newText.substring(newText.length - 2)}';
      if (newText.startsWith(',') && !newText.startsWith('0,')) {
        newText = '0$newText';
      }
      while (
          newText.length > 1 && newText.startsWith('0') && newText[1] != ',') {
        newText = newText.substring(1);
      }
      final result = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );

      return result;
    }
    return newValue;
  }
}
