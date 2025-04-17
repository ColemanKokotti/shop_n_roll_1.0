import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuantityControl extends StatefulWidget {
  final String documentId;
  final int quantity;

  const QuantityControl({
    super.key,
    required this.documentId,
    required this.quantity,
  });

  @override
  State<QuantityControl> createState() => _QuantityControlState();
}

class _QuantityControlState extends State<QuantityControl> {
  late int _currentQuantity;
  late ValueNotifier<int> _quantityNotifier;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.quantity;
    _quantityNotifier = ValueNotifier(widget.quantity);
  }

  @override
  void dispose() {
    _quantityNotifier.dispose();
    super.dispose();
  }

  Future<void> _updateQuantity(int newQuantity) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(widget.documentId)
          .update({
            'quantity': newQuantity,
            'updatedAt': FieldValue.serverTimestamp()
          });
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            context,
            icon: Icons.remove,
            onPressed: () {
              if (_currentQuantity > 0) {
                setState(() {
                  _currentQuantity--;
                  _updateQuantity(_currentQuantity);
                });
                _quantityNotifier.value = _currentQuantity;
              }
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: _quantityNotifier,
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '$value',
                  style: TextStyle(
                    color: theme.textTheme.labelLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
          _buildButton(
            context,
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _currentQuantity++;
                _updateQuantity(_currentQuantity);
              });
              _quantityNotifier.value = _currentQuantity;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}