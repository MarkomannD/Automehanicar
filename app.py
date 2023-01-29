from flask import Flask, render_template, url_for, request, redirect, session
from werkzeug.security import generate_password_hash, check_password_hash

import mariadb
import mysql.connector
import ast
konekcija = mysql.connector.connect(
    password = "", #lozinka za bazu
   user = "root", #korisnicko ime
   database = "evidencija", #ime baze
   port = 3306 , #port msql servera 
   auth_plugin = 'mysql_native_password'
)

kursor = konekcija.cursor(dictionary=True)


#deklaracija aplikacije
app = Flask (__name__)  
app.secret_key = "tajni_kljuc_aplikacije"

#logika aplikacije

@app.route('/login', methods=['GET' , 'POST '])
def render_login():
    if request.method == 'GET':
        return render_template("login.html")
    if request.method == 'POST':
        forma = request.form
        upit = "SELECT * FROM korisnici WHERE email=%s"
        vrednost = (forma["email"],)
        kursor.execute(upit, vrednost)
        korisnik = kursor.fetchone()

        if korisnik != None:
            if check_password_hash(korisnik["lozinka"], forma["lozinka"]):
                session ["ulogovani_korisnik"] = str(korisnik)
                return redirect(url_for("korisnici"))
            else:
                return render_template("login.html")
        else:
                return render_template("login.html")

@app.route('/logout')
def logout():
    session.pop('ulogovani_korisnik',None)
    return redirect(url_for('login'))

@app.route('/', methods=["GET", "POST"])
def render_primer() -> 'html':  
    return render_template('Automobili.html')

@app.route('/korisnici', methods=['GET'])
def render_korisnici():
    upit = "select * from korisnici"
    kursor.execute(upit)
    korisnici = kursor.fetchall()
    return render_template('korisnici.html', korisnici = korisnici)

    

@app.route('/korisnik_novi', methods=['GET', 'POST'])
def korisnik_novi():
    
        
        if request.method == "GET":
            return render_template('korisnik_novi.html')

        if request.method == "POST":
            forma = request.form
            hesovana_lozinka = generate_password_hash(forma["lozinka"])
            vrednosti = (
                forma["ime"],
                forma["prezime"],
                forma["email"],
                forma["ime_vozila"],
                forma["rola"],
                hesovana_lozinka
            )

            upit = """insert into 
                        korisnici(ime, prezime, email, ime_vozila, rola, lozinka)
                        values (%s, %s,%s, %s, %s, %s)  
            """

            kursor.execute(upit, vrednosti)
            konekcija.commit()

            return redirect(url_for("render_korisnici"))
    
       
@app.route('/korisnik_izmena/<id>', methods=["GET", "POST"])
def korisnik_izmena(id):
    if request.method == "GET":
        upit="select * from korisnici where id=%s"
        vrednost = (id, )
        kursor.execute(upit, vrednost)
        korisnik = kursor.fetchone()

        return render_template("korisnik_izmena.html", korisnik=korisnik)

    if request.method == "POST":
        upit = """update korisnici set 
                    ime  = %s, prezime = %s, email = %s, ime_vozila=%s, rola = %s, lozinka = %s
                    where id = %s
        """

        forma = request.form
        vrednosti = (
            forma["ime"],
            forma["prezime"],
            forma["email"],
            forma["ime_vozila"],
            forma["rola"],
            forma["lozinka"],
            id
        )
        kursor.execute(upit, vrednosti)
        konekcija.commit()
        return redirect(url_for('render_korisnici'))

@app.route('/korisnik_brisanje/<id>', methods=["POST"])
def korisnik_brisanje(id):
    upit = """
            DELETE FROM korisnici WHERE id=%s
    """
    vrednost = (id, )
    kursor.execute(upit, vrednost)
    konekcija.commit()
    return redirect(url_for("render_korisnici"))

@app.route('/radnici', methods=['GET'])
def render_radnici():
    upit = "select * from korisnici where rola='radnik'"
    kursor.execute(upit)
    korisnici = kursor.fetchall()
    return render_template('radnici.html', korisnici = korisnici)
    
    
@app.route('/musterije', methods=['GET'])
def render_musterije():
    upit =  "select * from korisnici where rola='musterija'"
    kursor.execute(upit)
    korisnici = kursor.fetchall()
    return render_template('musterije.html', korisnici = korisnici)





#pokretanje aplikacije
app.run(debug=True)