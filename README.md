# RelationalDatabase_BikeRental
## How to connect to the PostgreSQL database
```sql
psql --username=freecodecamp --dbname=postgres
```
## How the PostgreSQL database was saved
```sql 
pg_dump -cC --inserts -U freecodecamp universe > universe.sql
```

## How to import the PostgreSQL database
```sql
psql -U postgres < salon.sql
```# RelationalDatabase_SalonAppointmentScheduler
# RelationalDatabase_PeriodicTable
