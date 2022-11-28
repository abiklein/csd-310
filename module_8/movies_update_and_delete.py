import mysql.connector

db = mysql.connector.connect(
    user="movies_user",
    password="popcorn",
    host="localhost",
    database="movies",
)

cursor = db.cursor()


def show_films(cursor, title):
    # method to execute an inner join on all tables,
    #   iterate over the dataset and output the results to the terminal window.

    # inner join query
    cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
                   "'Studio Name' from film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN "
                   "studio ON film.studio_id=studio.studio_id")

    # get the results from the cursor object
    films = cursor.fetchall()

    print("\n -- {} --".format(title))

    # iterate over the film data set and display the results
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2],
                                                                                          film[3]))


show_films(cursor, " -- DISPLAYING FILMS -- ")
print()

INSERT INTO film(film_id, film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id)
VALUES (4, 'Harry Potter', '2001', '152', 'Chris Columbus',
        (select studio_id from studio WHERE studio_name = 'Warner Bros.'),
        (select genre_id from genre WHERE genre_name = 'Fantasy'));

show_films(cursor, " -- DISPLAYING FILMS AFTER INSERT -- ")
print()

cursor.execute("UPDATE film SET film_id = 2, film_name = 'Alien', "
               + "genre_id = (select genre_id from genre WHERE genre_name = 'SciFi') WHERE "
               + "genre_id = (select genre_id from genre WHERE genre_name = 'Horror');")

show_films(cursor, " -- DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror -- ")
print()

cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator'")

show_films(cursor, " -- DISPLAYING FILMS AFTER DELETE -- ")
print()
