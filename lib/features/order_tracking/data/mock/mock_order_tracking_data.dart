import '../models/driver_model.dart';
import '../models/order_tracking_model.dart';
import '../models/tracking_timeline_model.dart';

class MockOrderTrackingData {
  static final DriverModel mockDriver = DriverModel(
    name: 'Ahmed K.',
    avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDL_elsORefaL1rTZMwSF16sva6UjAj7XvnrlQIBfWwuUgBHRedBLqdSK0QO4CQ2UaOnIycWHRNWLL6Td-_meqD3_FTSWl30Wee4NngTRBJgrFSjuNw6lok-olPIs9oS3ZrQXpJQLSv2m8pp2tTNnW3oOJ-Z1nYTlpLUt7qMJPqZpkpkKJEu9Q355fXWymhNxhopQGy7mNfb6U0f2GD5cQonfrknwSpcTBkncUh0TYAIYgkEn1DAKPM78be89Mcwsg9eAtWgPKUmJBe',
    rating: 4.9,
    ratingsCount: '2.4k ratings',
    phone: '+201234567890',
  );

  static final List<TrackingTimelineModel> initialTimeline = [
    TrackingTimelineModel(
      title: 'Order Confirmed',
      time: '12:30 PM',
      isCompleted: true,
      isActive: false,
      description: 'Your order has been confirmed.',
    ),
    TrackingTimelineModel(
      title: 'Preparing',
      time: '12:45 PM',
      isCompleted: true,
      isActive: false,
      description: 'The kitchen is preparing your fresh meal.',
    ),
    TrackingTimelineModel(
      title: 'On the Way',
      time: '12:55 PM',
      isCompleted: false,
      isActive: true,
      description: 'Our driver is nearby your location.',
    ),
    TrackingTimelineModel(
      title: 'Delivered',
      time: 'ETA 1:10 PM',
      isCompleted: false,
      isActive: false,
      description: 'Food is delivered to your doorstep.',
    ),
  ];

  static final OrderTrackingModel activeOrderTracking = OrderTrackingModel(
    id: 'FG-48291',
    restaurantName: "L'Arte della Pasta",
    restaurantImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBAbeRe1OS0cbki3cZHuS7w71BLvbtck2jUDxnMUaKK1-7YoYFHpdU8xTzFSvDny0M6zBWeT7DUpAAfGC0fz3jsKinz5sTMRul3UdkjFOexqck6M8G44HAtUlnWYph_6moWFYs5-mixRjGqxB9aJ56dbk-UaEAP4QqpaZgmlM5cN-xmWft3BSLZPvmsWW-SPGpRzN2iGznQlay3mBTzntTGweZxOCW0CvmhgrlLnwuZRGY8n-RogmRY0VV4H1VteLQ7G1U8MIeP2Lsu',
    etaMinutes: 15,
    status: 'On the Way',
    driver: mockDriver,
    timeline: initialTimeline,
  );
}
