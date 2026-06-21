import '../models/order_history_model.dart';
import '../models/order_item_model.dart';

class MockOrderHistoryData {
  static final List<OrderHistoryModel> mockOrders = [
    // Active orders
    OrderHistoryModel(
      id: 'FG-48291',
      restaurantName: "L'Arte della Pasta",
      restaurantImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBAbeRe1OS0cbki3cZHuS7w71BLvbtck2jUDxnMUaKK1-7YoYFHpdU8xTzFSvDny0M6zBWeT7DUpAAfGC0fz3jsKinz5sTMRul3UdkjFOexqck6M8G44HAtUlnWYph_6moWFYs5-mixRjGqxB9aJ56dbk-UaEAP4QqpaZgmlM5cN-xmWft3BSLZPvmsWW-SPGpRzN2iGznQlay3mBTzntTGweZxOCW0CvmhgrlLnwuZRGY8n-RogmRY0VV4H1VteLQ7G1U8MIeP2Lsu',
      status: 'Preparing',
      date: 'Today, 12:45 PM',
      totalPrice: 24.50,
      items: [
        OrderItemModel(name: 'Handcrafted Tagliatelle', quantity: 2, price: 10.00),
        OrderItemModel(name: 'Fresh Italian Basil Soda', quantity: 1, price: 4.50),
      ],
    ),
    OrderHistoryModel(
      id: 'FG-48305',
      restaurantName: 'Zen Garden Kitchen',
      restaurantImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAG-awNMgcelWgya33p4fot7nZbn3tbhH-sZSUXI0pufgk7L3FLYALJ4ao2k0NnAbYsbqwHTA5XWYaSCl6MiI3pzJHlXLEgMryhv0zTPxmDfCz0_6jBNXAdOuvoi_N6bjCJgZaRRSv4GHWRlT6kWibY7-sjp0v8SByI2eYGnhEoZX3_pd8B2pyGBqNB6ox-0yFPqecJQkJRmfvTScbEmZQWOxR7WMMeYvnPMcC7Ou4dcCnN2alLEL_YrVr82Fi_Gh6RRJs3HvWjfxjW',
      status: 'On the Way',
      date: 'Today, 12:55 PM',
      totalPrice: 37.00,
      items: [
        OrderItemModel(name: 'Salmon Poke Bowl', quantity: 2, price: 18.50),
      ],
    ),
    
    // Past orders
    OrderHistoryModel(
      id: 'FG-29482',
      restaurantName: "Luigi's Artisan Pizza",
      restaurantImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAos1BFBe-unOZdFIy6bHXmHR9vSVI2S1TNRK0QoirWJ-PEV8D5YUtvFDjE3kEzqA93MXf1CuGoJloPz3K_pLtv2MsBXakXoJ9qCrsTkCybxBSTG5j8QVjOjJLdtJlveph5BFdw8DnvyjHeXqYWU8jExQAwEtlnV_1zJf-vwAYkFnj0OqWsqdusDABIxVKtr4GfZfytQtYV_LPvXO5PcZNIuCt9eFGPpmGHTvh1wI7pb0uLkZsP_OCiGIUYtbxdIW6NjCrf2MdHOvgF',
      status: 'Delivered',
      date: 'Oct 24, 2023',
      totalPrice: 24.50,
      items: [
        OrderItemModel(name: 'Truffle Margherita Pizza', quantity: 1, price: 22.00),
        OrderItemModel(name: 'Coca Cola', quantity: 1, price: 2.50),
      ],
    ),
    OrderHistoryModel(
      id: 'FG-29381',
      restaurantName: 'The Burger Craft',
      restaurantImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBf66ltUhBP63uGw_n5DUcKQrx6oh1rof1lgLHz687AypO3xoaaeWCQm21qPF2V6CjBI_vAxkuDjiYdyyBA3fmybz2Hdwh8BKbzzFiKNn9ZMijPjSH6nuuBdM9A0s2HuqrDBbfcgyoEN9fEQNxU1IWV8t5QOKkbf2VAP3VrogQLwD0eYY1wtg_UyyiJ0KMgW2s460nT5-Tjam_4GhUWsc7AnQ1I9ALKNmxuwYfNqdKgXrNZ6G0RxXJLUFWtBw6Pho2cX5Rf6Hr_R91L',
      status: 'Delivered',
      date: 'Oct 20, 2023',
      totalPrice: 18.90,
      items: [
        OrderItemModel(name: 'Wagyu Signature Burger', quantity: 1, price: 18.90),
      ],
    ),
    OrderHistoryModel(
      id: 'FG-29177',
      restaurantName: 'Morning Dew Bistro',
      restaurantImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAukbdZokYfJPQWNi1QCa_8DGJGHcXzZ_2IYK3wxFzkPp6fWYz_47zB-oFN6rSVZYDKgO2mEhYVh8faV2Ah9Asem9VAw5kgp570xxIjzK4sLOArNPrGcpOSMWLFvNxNAivSbOhdhxg3IX14i4n8E0ZAzeSgnzPLVZDW6rB3qLGJxM8ETKu5X-0gPvxeiVGaxEP5RlC0zFlz5yTkUzzXSlpaiad1mVpBnpQUESY7nCB-1zxYHeGOhD6rlx-t1VZ89cPv5OjdjN3vQQBB',
      status: 'Delivered',
      date: 'Oct 15, 2023',
      totalPrice: 14.50,
      items: [
        OrderItemModel(name: 'Berry Honeycomb Stack', quantity: 1, price: 14.50),
      ],
    ),
  ];
}
