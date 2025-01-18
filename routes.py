from flask import Blueprint, jsonify, request
from db import get, post

routes = Blueprint('routes', __name__)


@routes.route('/getAllAvailableBikes', methods=['GET'])  # BROKEN SQL?
def getAvailableBikes():
    return jsonify(get(
        "SELECT b.BikeID, b.BikeType, b.PurchaseDate, b.BikeProducer, b.BikeDefaultTarif " +
        "FROM Bikes b " +
        "LEFT JOIN Rentals r ON b.BikeID = r.BikeID " +
        "AND r.StartTime <= NOW() " +
        "AND r.EndTime >= NOW() " +
        "WHERE r.RentalID IS NULL "
    ))


@routes.route('/getAllBikes', methods=['GET'])
def getAllBikes():
    return jsonify(get(f"SELECT * FROM bikes"))

# @routes.route('/checkAvailability', methods=['GET'])
# def checkAvailability():
#     return jsonify(get(f"SELECT * FROM bikes"))


@routes.route('/getUserRentals', methods=['GET'])
def getUserRentals():
    return jsonify(get(f"SELECT * FROM rentals WHERE userid = {request.args.get("user_id")}"))


@routes.route('/startRental', methods=['POST'])
def startRental():
    p = request.get_json()
    user = "User1"
    return jsonify(post(
        f"INSERT INTO rentals (userid, bikeid, starttime, startlocation) "
        f"VALUES ({user}, {p["bike_id"]}, LOCALTIMESTAMP, {p["start_location"]}"))

@routes.route('/stopRental', methods=['POST'])
def stopRental():
    p = request.get_json()

    # finishing rental
    post(f"INSERT INTO rentals (endtime, endlocation) "
         f"VALUES (LOCALTIMESTAMP, {p["location_end"]}) "
         f"WHERE rentalid = {p["rental_id"]}")

    # TODO: FIX CALCULATION
    amount = 0

    # adding payment details, card number hint hardcoded or get from request?
    post(f"INSERT INTO payments (rentalid, paymentdate, amount, paymentmethod, currency, cardnumberhint)"
         f"VALUES ({p["rental_id"]}, LOCALTIMESTAMP, {amount}, \"Card\", \"EURO\", \"1234\")")


