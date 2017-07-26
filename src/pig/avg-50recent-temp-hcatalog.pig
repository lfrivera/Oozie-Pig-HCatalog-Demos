REGISTER $load_loc;
records = LOAD '$table_name' USING org.apache.hive.hcatalog.pig.HCatLoader();
filtered_records = FILTER records BY air_temperature != 9999 AND com.hadoopbook.pig.IsGoodQuality((int)at_quality_code) AND observation_date_year >= 1950; 
grouped_records = GROUP filtered_records BY observation_date_year; 
avg_temp = FOREACH grouped_records GENERATE group,AVG(filtered_records.air_temperature); 
DUMP avg_temp;
