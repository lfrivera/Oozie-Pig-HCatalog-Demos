REGISTER $load_loc;
records = LOAD '$in_s1' USING com.hadoopbook.pig.CutLoadFunc('5-10,11-15,16-23,88-92,93-93') AS (usaf_id:chararray,wban_id:chararray,date:int, temperature:int, quality:int);
filtered_records = FILTER records BY temperature != 9999 AND com.hadoopbook.pig.IsGoodQuality(quality);
formated_records = FOREACH filtered_records GENERATE  CONCAT(usaf_id,'-',wban_id), date, temperature;
grouped_records = GROUP formated_records BY ($0,$1);
max_day_station_date = FOREACH grouped_records GENERATE FLATTEN(group),MAX(formated_records.temperature);
STORE  max_day_station_date INTO '$out_s1';
