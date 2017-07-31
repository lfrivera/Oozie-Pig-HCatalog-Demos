REGISTER $load_loc; 
records = LOAD '$in_s1' USING com.hadoopbook.pig.CutLoadFunc('16-19,88-92,93-93') AS (year:int, temperature:int, quality:int);
filtered_records = FILTER records BY temperature != 9999 AND com.hadoopbook.pig.IsGoodQuality(quality); 
grouped_records = GROUP filtered_records BY year; 
max_temp = FOREACH grouped_records GENERATE group,MAX(filtered_records.temperature); 
STORE max_temp INTO '$out_max';
