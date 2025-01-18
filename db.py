import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def get_db_connection():
    connection = psycopg2.connect(
        host=os.getenv('DB_HOST'),
        database=os.getenv('DB_NAME'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASS'),
        port=os.getenv('DB_PORT')
    )
    return connection

def get(sql):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute(sql)
    rows = []
    for buff in cursor:
        row = {}
        c = 0
        for col in cursor.description:
            row.update({str(col[0]): buff[c]})
            c += 1
        rows.append(row)
    # rows = cursor.fetchall()
    cursor.close()
    connection.close()
    return rows

def post(sql):
    try:
        connection = get_db_connection()
        cursor = connection.cursor()

        # Assuming you're inserting a record with two fields (adjust based on your table)
        cursor.execute(sql)
        connection.commit()
        cursor.close()
        connection.close()
    except Exception as e:
        return {"message" : e}
    else:
        return {"message" : "Data inserted successfully"}