// Biblioteca
const mysql = require('mysql2');
//metodo de Conexion de base de datos 
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'BancoDB'
});
//opciones en caso de eror
connection.connect((err) => {
    if (err) {
        console.error('Error al conectarse a la base de datos:', err.message);
        return;
    }
    //Mostrar la configuracion de la base de datos si esta se ha conectado
    console.log('Conexión exitosa a la base de datos:', connection.config.database);
});     

module.exports = connection;