## column descriptions
### 📊 User Information
user_id: Unique identifier for each user.

create_date: The date the user registered on the platform.

### 💰 Financial & Purchase Data (from payments table)
total_purchases: Total number of successful purchases made by the user.

active_purchase_dates: Number of distinct days on which the user made at least one purchase.

unique_movies_purchased: Number of distinct movies purchased by the user (repeated purchases of the same movie count as one).

discounted_purchases: Number of purchases where the user applied a discount or coupon.

discount_percentage: Average discount percentage received by the user across all purchases (e.g., 15%).

total_purchase_value: Total amount actually paid by the user (after discounts and coupons).

### ⏰ Behavioral Data (from events table)
peak_activity_time: The time period during which the user is most active (Morning, Noon, Evening, or Night). This is calculated based on the timestamps of system events.

### 🎟️ Coupon & Discount Data (from user_voucher table)
total_vouchers: Total number of coupons received by the user.

total_voucher_value: Total monetary value of all coupons received by the user.

total_voucher_days: Total number of validity days across all coupons (e.g., one 30-day coupon and one 10-day coupon equals 40 days).

### 🎬 Preference Data (from payments and category tables)
fav_category: The user’s preferred category (e.g., “Action”, “Drama”). This is determined by the most purchased category for that user.
