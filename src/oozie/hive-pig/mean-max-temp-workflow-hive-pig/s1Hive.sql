add jar /usr/lib/hive/lib/hive-contrib-1.1.0-cdh5.10.1.jar;
INSERT OVERWRITE DIRECTORY '${outS1}' 	
SELECT `_c0`, `_c1`, MAX(air_temperature) FROM weather_managed_lf 
WHERE at_quality_code IN (0,1,4,5,9) AND air_temperature <> 9999
GROUP BY `_c0`,`_c1`;
