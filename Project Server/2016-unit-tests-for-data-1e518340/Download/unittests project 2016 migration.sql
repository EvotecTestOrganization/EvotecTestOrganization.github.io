

-- UNIT tests project server 2013- 2016 
-- design PLANSIS
-- this script consist of multiple union queries that all have test message, test value and the measured value
-- when measured value differ more then 10% (change 0.1 to whatever fits your goals) from the test value the test is not passed
-- run this script in one environment, put the measured MeasureValues into the test values
-- for instance we have 1150 projects in one environment, we put it into the first query
  select case when  count(*) between 1150-100 and 1150+100 then 'Project count OK' else 'Project count ERROR' end Test, 1150 TestValue, count(*) MeasuredValue
  from pjrep.[MSP_EpmProject_UserView]

  UNION ALL
  select case when  sum([ProjectWork]) between 5367850-5367850*0.1 and 5367850+5367850*0.1 then 'Total Project work OK' else 'Total Project work ERROR' end Test
  , 5367850 TestValue, sum([ProjectWork]) MeasureValue
  from pjrep.[MSP_EpmProject_UserView]

UNION ALL
  select case when  sum(datediff(DAY,[ProjectStartDate],[ProjectFinishDate] ))/count(*)  between 813-813*0.1 and 813+813*0.1 then 'Average Project duration OK' else 'Average Projecten duration ERROR' end Test
  , 813 TestValue, sum(datediff(DAY,[ProjectStartDate],[ProjectFinishDate] ))/count(*) MeasureValue
  from pjrep.[MSP_EpmProject_UserView]

UNION ALL
  select case when   sum([Capacity]) between 15936380-15936380*0.1 and 15936380+15936380*0.1 then 'Total resource capacity OK' else 'Total resource capacity ERROR' end Test
  ,15936380 TestValue,  sum([Capacity]) MeasureValue
  from pjrep.[MSP_EpmResourceByDay_UserView] 

UNION ALL
  select case when   count(*)  between 1580-1580*0.1 and 1580+1580*0.1 then 'Resources count OK' else 'Resources count ERROR' end Test
  , 1580 TestValue,  count(*) MeasureValue
  from  pjrep.[MSP_EpmResource_UserView]

  UNION ALL
  select case when   count(*)  between 94855-94855*0.1 and 94855+94855*0.1 then 'Task count OK' else 'Task count ERROR' end Test
  , 94855 TestValue, count(*) MeasureValue
  from  pjrep.[MSP_EpmTask_UserView]

  UNION ALL
  select case when   count(*)  between 52726-52726*0.1 and 52726+52726*0.1 then 'Assignements count' else 'Assignements coun ERROR' end Test
  ,52726 TestValue,  count(*)  MeasureValue
  from  pjrep.[MSP_EpmAssignment_UserView] 
