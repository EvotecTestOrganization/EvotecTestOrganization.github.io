# Project 2016 unit tests for data consistency after a migration or dry run

## Original Links

- [x] Original Technet URL [Project 2016 unit tests for data consistency after a migration or dry run](https://gallery.technet.microsoft.com/2016-unit-tests-for-data-1e518340)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/2016-unit-tests-for-data-1e518340/description)
- [x] Download: [Download Link](Download\unittests project 2016 migration.sql)

## Output from Technet Gallery

this sql script allows quickly check data consistency at serveral carefully selected points (tests) between two ms project databases. This is handy to do after a migration from 2010 to 2013 or 2016 when you want to quickly test consistency of data between  the old and the new environment. If you run queries on project 2010 you have to slightly modify the query and remove [pjrep.] from the  queries as project 2010 does not have it.

the script consist of multiple union queries (tests) that all have three fields: test message, test value and the measured value. The test is negative if the measured value differ more then 10% (change 0.1 to whatever fits your goals) from the test value.

Script usage:

run this script in one environment, take the measured MeasureValues and replace the test values. You have to do it per test.

Example:

for instance we have 1150 projects in one environment, we put it into the first query

   select case when  count(\*) between 1150-100 and 1150+100 then 'Project count OK' else 'Project count ERROR' end Test, 1150 TestValue, count(\*) MeasuredValue

   from pjrep.[MSP\_EpmProject\_UserView]

run the script with the fixed test values in the environment that you want to test.

Example output:

| Test | TestValue | MeasuredValue |

| --- | --- | --- |

| Project count ERROR | 1150 | 10.609.000.000 |

| Total Project work ERROR | 5367850 | 1.098.289.827.066 |

| Average Projecten duration OK | 813 | 813.000.000 |

| Total resource capacity ERROR | 15936380 | 10.628.439.460.000 |

| Resources count ERROR | 1580 | 1.192.000.000 |

| Task count ERROR | 94855 | 1.086.561.000.000 |

| Assignements coun ERROR | 52726 | 704.120.000.000 |

