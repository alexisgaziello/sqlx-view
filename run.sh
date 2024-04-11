
docker-compose -f ./docker-compose.yaml up -d

echo -n "Waiting for the database to be ready..."

# Wait for the specific log message indicating the database is ready
while ! docker-compose logs db | grep -q "database system is ready to accept connections"; do
    echo -n "."
    sleep 1
done

echo "!"
echo "Database is ready. Initializing database..."

POSTGRESQL_HOST=localhost
POSTGRESQL_PORT=5432
POSTGRESQL_DATABASE=rust-bug
POSTGRESQL_USERNAME=root
POSTGRESQL_PASSWORD=postgres_password

# Run the SQL commands in db-init.sql against the database
PGPASSWORD="$POSTGRESQL_PASSWORD" psql -h "$POSTGRESQL_HOST" -p "$POSTGRESQL_PORT" -U "$POSTGRESQL_USERNAME" -d "$POSTGRESQL_DATABASE" -f db-init.sql

echo "Database initialization complete."

cargo build
