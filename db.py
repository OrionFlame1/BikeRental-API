import oracledb

def get_db_connection():
    un = 'sql_dev'
    cs = 'localhost/orclpdb'
    pw = 'oracle'
    connection = oracledb.connect(user=un, password=pw, dsn=cs)
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