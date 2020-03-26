var mysql = require('mysql');
var prompt = require('prompt');
var username;
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database : "demo1"
});


con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
 var sql = "INSERT INTO students (idCompte, prenom,nom,email,password,idEntreprise) VALUES (71624, 'Ismael','Zirek','ismael@ntm.com','blablabla',155)";
 con.query(sql, function (err, result) {
   if (err) throw err;
   console.log("NTM!");
 });
});






//"CREATE TABLE students (prenom VARCHAR(30), nom VARCHAR(30) ,courriel VARCHAR(50), motdepasse VARCHAR(50), idEntreprise INT)";

//"CREATE TABLE anneeScolaire (date_debut DATE, date_fin DATE, idAnneeScolaire INT)";

//"CREATE TABLE entreprises (nom VARCHAR(50), adesse VARCHAR(255))";

// CREATE TABLE students (id INT AUTO_INCREMENT PRIMARY KEY, idCompte INT, prenom VARCHAR(30), nom VARCHAR(30) ,email VARCHAR(50), password VARCHAR(50), ,idEntreprise INT)";