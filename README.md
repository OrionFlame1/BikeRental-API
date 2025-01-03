# BikeRental API (WIP)
Example of API made in Python with Flask, using an OLTP database in PostgreSQL

# Installation
Just clone the project:

```bash 
git clone https://github.com/OrionFlame1/BikeRental-API
```
### Using Docker (recommended)
Recommended installation method, it needs Docker installed on your machine.

Build it and run it

```bash
docker-compose up --build
```

### Local Deploy (not recommended)
**PostgreSQL is required for this to work**

Install the python project requirements:

```bash
pip install psycopg2-binary
pip install --no-cache-dir -r requirements.txt
```

Create an .env file and complete the credentials according to your needs
```dotenv
DB_HOST="localhost"
DB_USER="your_username_here"
DB_PASS="your_password_here"
DB_NAME="your_database_name_here"
DB_PORT="5432" # default port for postgre instance
```

Run the project using:
```bash
flask run
```