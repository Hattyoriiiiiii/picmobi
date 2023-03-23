import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

import time
import gpsd

def update_hub_location(db, lat, lon, name):
    doc_ref = db.collection(u'hub_locations').document(u'hub')
    doc_ref.set({
        'lat': lat,
        'lon': lon,
        'time': firestore.SERVER_TIMESTAMP,
        'name': name
    })

def get_gnss_data():
    gpsd.connect()
    packet = gpsd.get_current()

    if packet.mode >= 2:
        return packet.lat, packet.lon
    else:
        return None, None


def main():
    cred = credentials.Certificate("./firebase-sdk.json")
    firebase_admin.initialize_app(cred)
    db = firestore.client()

    while True:
        try:
            lat, lon = get_gnss_data()
            if lat is not None and lon is not None:
                update_hub_location(db, lat, lon, 'hub')
            else:
                print("No GNSS data")
        except Exception as e:
            print(e)
        time.sleep(1800)

if __name__ == '__main__':
    main()


