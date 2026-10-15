import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/add_button.dart';
import '../components/cart_component.dart';
import '../components/customer_component.dart';
import '../components/hud.dart';

class ArabiaGame extends FlameGame {
  int customersServed = 0;
  int money = 0;
  final List<CustomerComponent> _activeCustomers = [];

  @override
  Color backgroundColor() => const Color(0xFF2A1F14);

  @override
  Future<void> onLoad() async {
    // 1. خلفية الزقاق
    final bgImage = await Flame.images.load('assets/images/arabia/street_bg.png');
    add(
      SpriteComponent(
        sprite: Sprite(bgImage),
        size: size,
        priority: -100,
      ),
    );

    // 2. العربية — في نص الشاشة تحت
    add(CartComponent(
      screenSize: size,
    ));

    // 3. HUD — فوق
    add(HudComponent(game: this));

    // 4. زرار "زبون جديد" — تحت
    add(AddCustomerButton(game: this, screenSize: size));
  }

  void addNewCustomer() {
    if (_activeCustomers.length >= 4) return;

    final variant = (_activeCustomers.length % 4) + 1;

    final c = CustomerComponent(
      game: this,
      variant: variant,
      slotIndex: _activeCustomers.length,
      screenSize: size,
    );

    _activeCustomers.add(c);
    add(c);
  }

  void removeCustomer(CustomerComponent c) {
    _activeCustomers.remove(c);
  }

  void serveCustomer(CustomerComponent c) {
    customersServed++;
    money += 10;
    c.removeFromParent();
    _activeCustomers.remove(c);
  }
}