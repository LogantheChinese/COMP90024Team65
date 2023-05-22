import pandas as pd
from couchdb import Server
import os

# Retrieve the credentials and connection details from environment variables
username = os.environ.get('COUCHDB_USERNAME')
password = os.environ.get('COUCHDB_PASSWORD')
host = os.environ.get('COUCHDB_HOST')
port = os.environ.get('COUCHDB_PORT')
database = os.environ.get('COUCHDB_DATABASE')
excel = os.environ.get('EXCEL_FILE_NAME')

# Create the server URL using the retrieved credentials and connection details
server_url = f"https://{username}:{password}@{host}:{port}/"

# Connect to the CouchDB server
server = Server(server_url)

db = []
# Check if the database exists in the server, otherwise create a new database
if database in server:
    db = server[database]
else:
    db = server.create(database)

# Read the data from the Excel file into a DataFrame
data = pd.read_excel(excel, sheet_name='SA4 & City Metro')

# Convert the 'Date' column to datetime format for further processing
data['Date'] = pd.to_datetime(data['Date'])

# Create a mask to filter the data based on date range and specific regions
mask1 = (
    (data['Date'] >= '2022-02-01') & (data['Date'] < '2022-09-01') & (
        data['Region'].str.startswith('Melbourne') |
        data['Region'].str.startswith('Sydney') |
        data['Region'].str.startswith('Brisbane') |
        data['Region'].str.startswith('Adelaide') |
        data['Region'].str.startswith('Perth') |
        data['Region'].str.startswith('Hobart') |
        data['Region'].str.startswith('Darwin')
    )
)

# Apply the mask to filter the data
filtered_data = data.loc[mask1]

# Select specific columns from the filtered data
columns = filtered_data.iloc[:, [0, 2, 4]]

# Define the list of regions
regions = ['Melbourne', 'Sydney', 'Brisbane', 'Adelaide', 'Perth', 'Hobart', 'Darwin']

# Create a new column 'GCC' based on the 'Region' column using a lambda function
columns['GCC'] = columns['Region'].apply(
    lambda x: next((region for region in regions if x.startswith(region)), 'other')
)

# Compute the average unemployment rate grouped by 'Date' and 'GCC'
averages = columns.groupby(['Date', 'GCC'])['Unemployment Rate (15+)  '].mean()

# Convert the averages to a dictionary
dic = dict(averages.to_dict())

# Iterate through the dictionary items and save the data to the CouchDB database
for t in dic.items():
    data = {
        "city": t[0][1],
        "unemployment": t[1],
        "year": str(t[0][0])[:4],
        "month": str(t[0][0])[5:7]
    }
    db.save(data)
