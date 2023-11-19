from opencage.geocoder import OpenCageGeocode
import pandas as pd

# Import csv file / I split csv file into parts 5000 rows each, to optimize usage OpenCage free API.
# 2500 requests per day 1sec per request. So need to change file name from 1-8.
df = pd.read_csv('name_geographic_information.csv', sep=';')

# API key from OpenCage stored in APIkey.txt file
with open('APIkey.txt', 'r') as file:
    api_key = file.read().strip()

geo = OpenCageGeocode(api_key)

for index, row in df.iterrows():
    if pd.isna(row['latitude']) or pd.isna(row['longitude']):
        location = geo.geocode(f"{row['nom_commune']}, {row['préfecture']}, {row['nom_département']}, "
                               f"{row['nom_région']}, France")

        if location and len(location):
            df.at[index, 'latitude'] = location[0]['geometry']['lat']
            df.at[index, 'longitude'] = location[0]['geometry']['lng']
            print(index)

# saved file with new name. After all files was done. I compose them into one file.
df.to_csv('name_geographic_information_updated.csv', index=False)
