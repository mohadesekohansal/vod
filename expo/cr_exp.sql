WITH event_stats AS (
    -- مرحله ۱: جمع‌آوری آمار اولیه برای هر فیلم
    SELECT 
        film_id,
        COUNT(CASE WHEN event_type = 'click' THEN 1 END) as clicks,
        COUNT(CASE WHEN event_type = 'add_to_basket' THEN 1 END) as adds,
        COUNT(CASE WHEN event_type = 'payment' THEN 1 END) as payments
    FROM vod.events
    WHERE create_date >= CURRENT_DATE - INTERVAL '30 days'
      AND film_id != -1  -- حذف فیلم‌های نامعتبر
    GROUP BY film_id
),
calculated_scores AS (
    -- مرحله ۲: محاسبه نرخ‌ها و امتیاز نهایی
    SELECT 
        film_id,
        clicks,
        adds,
        payments,
        -- محاسبه نرخ کلیک به سبد خرید (با smoothing)
        (adds + 5.0) / (clicks + 10.0) as click_add_rate,
        -- محاسبه نرخ سبد خرید به پرداخت (با smoothing)
        (payments + 2.0) / (adds + 5.0) as add_pay_rate,
        -- محاسبه امتیاز نهایی CR_Score
        (
            ((adds + 5.0) / (clicks + 10.0) * 0.4) + 
            ((payments + 2.0) / (adds + 5.0) * 0.6)
        ) * LN(clicks + 1) as cr_score
    FROM event_stats
)
-- مرحله ۳: انتخاب ۱۰۰ فیلم برتر
SELECT 
    film_id,
    clicks,
    adds,
    payments,
    ROUND((click_add_rate)::numeric, 4) as click_add_rate,
    ROUND((add_pay_rate)::numeric, 4) as add_pay_rate,
    ROUND((cr_score)::numeric, 4) as cr_score
FROM calculated_scores
ORDER BY cr_score DESC
LIMIT 100;
