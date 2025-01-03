from flask import Blueprint, jsonify
from db import get_db_connection, get

routes = Blueprint('routes', __name__)


@routes.route('/get/<tablename>', methods=['GET'])
def getUsers(tablename):
    return jsonify(get(f"SELECT * FROM {tablename}"))


@routes.route('/get-available-bikes', methods=['GET']) # BROKEN SQL?
def getAvailableBikes():
    return jsonify(get(
        "SELECT b.BikeID, b.BikeType, b.PurchaseDate, b.BikeProducer, b.BikeDefaultTarif " +
        "FROM Bikes b " +
        "LEFT JOIN Rentals r ON b.BikeID = r.BikeID " +
        "AND r.StartTime <= NOW() " +
        "AND r.EndTime >= NOW() " +
        "WHERE r.RentalID IS NULL "
    ))


# @routes.route('/insert', methods=['POST'])
# def insert_data():
#     connection = get_db_connection()
#     cursor = connection.cursor()
#
#     # Assuming you're inserting a record with two fields (adjust based on your table)
#     cursor.execute('INSERT INTO your_table (column1, column2) VALUES (%s, %s)', ('value1', 'value2'))
#     connection.commit()
#     cursor.close()
#     connection.close()
#
#     return jsonify({"message": "Data inserted successfully!"})
