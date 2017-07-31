records = LOAD '$in_s2' AS (station:chararray,date:chararray,temperature:int);
formated_records = FOREACH records GENERATE station, SUBSTRING(date, 4, 8), temperature;
grouped_records = GROUP formated_records BY ($0,$1);
mean_station_day_month = FOREACH grouped_records GENERATE FLATTEN(group),AVG(formated_records.temperature);
STORE  mean_station_day_month INTO '$out_s2';