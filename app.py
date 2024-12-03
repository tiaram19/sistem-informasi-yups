from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector
from mysql.connector import errorcode
from flask import Flask, jsonify
app = Flask(__name__)
app.secret_key = 'your_secret_key'

# MySQL database configuration
db_config = {
    'user': 'root',
    'password': '',
    'host': 'localhost',
    'database': 'test',
    'ssl_disabled': True  # Disable SSL if needed
}

def get_db_connection():
    try:
        connection = mysql.connector.connect(**db_config)
        return connection
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Access denied: Check your username or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
    return None
# @app.route('/', methods=["GET", "POST"])
# def pages():
#     return 


@app.route('/donatur', methods=['GET', 'POST'])
def add_donatur():
    if request.method == 'POST':
        # Get form data
        Nama_Donatur = request.form['Nama_Donatur']
        no_telp = request.form.get('no_telp')
        no_wa = request.form.get('no_wa')
        Alamat = request.form.get('Alamat')
        Tipe_Donatur = request.form['Tipe_Donatur']
        Status_Keanggotaan = request.form.get('Status_Keanggotaan', 'Satu_Kali')
        Tgl_gabung = request.form.get('Tgl_gabung')
        Tgl_lahir = request.form.get('Tgl_lahir')
        Kota_lahir = request.form.get('Kota_lahir')
        Kelurahan = request.form.get('Kelurahan')
        Kecamatan = request.form.get('Kecamatan')
        Kode_pos = request.form.get('Kode_pos')
        Propinsi = request.form.get('Propinsi')

        # Insert data into database
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('''
                INSERT INTO donatur (
                    Nama_Donatur, no_telp, no_wa, Alamat, Tipe_Donatur, 
                    Status_Keanggotaan, Tgl_gabung, Tgl_lahir, Kota_lahir, 
                    Kelurahan, Kecamatan, Kode_pos, Propinsi
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            ''', (Nama_Donatur, no_telp, no_wa, Alamat, Tipe_Donatur, Status_Keanggotaan,
                  Tgl_gabung, Tgl_lahir, Kota_lahir, Kelurahan, Kecamatan, Kode_pos, Propinsi))
            
            connection.commit()
            cursor.close()
            connection.close()
            flash('Donatur successfully added!')
        else:
            flash('Database connection failed!')
        
        return redirect(url_for('add_donatur'))
    
    return render_template('/form/donatur_form.html')

@app.route('/donatur_list')
def donatur_list():
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)  # Use dictionary for easy access
        cursor.execute('SELECT * FROM donatur')
        donatur_data = cursor.fetchall()
        cursor.close()
        connection.close()
    else:
        donatur_data = []
    
    return render_template('donatur_list.html', donatur_data=donatur_data)

if __name__ == '__main__':
    app.run(debug=True)
