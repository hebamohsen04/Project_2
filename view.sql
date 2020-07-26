CREATE VIEW all_trips AS (SELECT x.*, zone.latitude as dropoff_lat, zone.longitude as dropoff_lng, zone.zip as dropoff_zip from 
(SELECT t.*, zone.latitude as pickup_lat, zone.longitude as pickup_lng, zone.zip as pickup_zip FROM (SELECT CASE WHEN taxi_type = 1 THEN 'Yellow Taxi' ELSE 'Green Taxi' END AS company, pickup_time, dropoff_time, date_part('hour', pickup_time) as pickup_hour,  date_part('hour', dropoff_time) as dropoff_hour, pickup_loc_id, dropoff_loc_id,
CASE WHEN passenger_count > 1 THEN 1 ELSE 0 END as shared_flag
FROM taxi_trip
UNION ALL
SELECT company, pickup_time, dropoff_time, date_part('hour', pickup_time) as pickup_hour,
  date_part('hour', dropoff_time) as dropoff_hour, pickup_loc_id, dropoff_loc_id, shared_flag 
  FROM for_hire_trip) as t, zone WHERE t.pickup_loc_id = zone.location_id) as x, zone WHERE x.dropoff_loc_id = zone.location_id);