const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const connection = require('./Database');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

// -------------------- GET ENDPOINTS --------------------
app.get('/clientes', (req, res) => {
    connection.query('SELECT * FROM Cliente', (err, results) => {
        if (err) return res.status(500).json({ error: 'Error al obtener clientes' });
        if (results.length === 0) return res.status(404).json({ error: 'No se encontraron clientes' });
        res.json(results);
    });
});

app.get('/departamentos', (req, res) => {
    connection.query('SELECT * FROM Departamento', (err, results) => {
        if (err) return res.status(500).json({ error: 'Error al obtener departamentos' });
        if (results.length === 0) return res.status(404).json({ error: 'No existen departamentos' });
        res.json(results);
    });
});

app.get('/transacciones', (req, res) => {
    connection.query('SELECT * FROM Transaccion', (err, results) => {
        if (err) return res.status(500).json({ error: 'Error al obtener transacciones' });
        if (results.length === 0) return res.status(404).json({ error: 'No existen transacciones' });
        res.json(results);
    });
});

app.get('/sucursales', (req, res) => {
    connection.query('SELECT * FROM Sucursal', (err, results) => {
        if (err) return res.status(500).json({ error: 'Error al obtener sucursales' });
        if (results.length === 0) return res.status(404).json({ error: 'No se encontraron sucursales' });
        res.json(results);
    });
});

app.get('/cuentas', (req, res) => {
    connection.query('SELECT * FROM Cuenta', (err, results) => {
        if (err) return res.status(500).json({ error: 'Error al obtener cuentas' });
        if (results.length === 0) return res.status(404).json({ error: 'No se encontraron cuentas' });
        res.json(results);
    });
});

// -------------------- DELETE ENDPOINTS --------------------
const genDeleteHandler = (table, path) => {
    app.delete(path, (req, res) => {
        const { id } = req.body;
        if (!id) return res.status(400).json({ error: 'ID no proporcionado' });
        connection.query(`DELETE FROM ${table} WHERE Id = ?`, [id], (err, result) => {
            if (err) return res.status(500).json({ error: `Error al eliminar ${table.toLowerCase()}` });
            if (result.affectedRows === 0) return res.status(404).json({ error: `${table} no encontrado` });
            res.json({ message: `${table} eliminado exitosamente` });
        });
    });
};

genDeleteHandler('Cliente', '/clientes/eliminar');
genDeleteHandler('Departamento', '/departamentos/eliminar');
genDeleteHandler('Transaccion', '/transacciones/eliminar');
genDeleteHandler('Sucursal', '/sucursales/eliminar');
genDeleteHandler('Cuenta', '/cuentas/eliminar');

// -------------------- PUT ENDPOINTS --------------------
app.put('/clientes/actualizar', (req, res) => {
    const { Cedula, Nombre, Apellido, Direccion, Telefono, Correo } = req.body;
    if (!Cedula) return res.status(400).json({ error: 'Cédula no proporcionada' });
    const query = `UPDATE Cliente SET Nombre=?, Apellido=?, Direccion=?, Telefono=?, Correo=? WHERE Cedula=?`;
    connection.query(query, [Nombre, Apellido, Direccion, Telefono, Correo, Cedula], (err, result) => {
        if (err) return res.status(500).json({ error: 'Error al actualizar cliente' });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'Cliente no encontrado' });
        res.json({ message: 'Cliente actualizado correctamente' });
    });
});

app.put('/sucursales/actualizar', (req, res) => {
    const { id, Nombre, Direccion, Ciudad, Codigo_postal, Telefono } = req.body;
    if (!id) return res.status(400).json({ error: 'ID no proporcionado' });
    const query = `UPDATE Sucursal SET Nombre=?, Direccion=?, Ciudad=?, Codigo_postal=?, Telefono=? WHERE Id=?`;
    connection.query(query, [Nombre, Direccion, Ciudad, Codigo_postal, Telefono, id], (err, result) => {
        if (err) return res.status(500).json({ error: 'Error al actualizar sucursal' });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'Sucursal no encontrada' });
        res.json({ message: 'Sucursal actualizada correctamente' });
    });
});

app.put('/cuentas/actualizar', (req, res) => {
    const { Numero_Cuenta, Tipo_Cuenta, Saldo, Fecha_Apertura, Cliente_Id, Sucursal_Id } = req.body;
    if (!Numero_Cuenta) return res.status(400).json({ error: 'Número de cuenta no proporcionado' });
    const query = `UPDATE Cuenta SET Tipo_Cuenta=?, Saldo=?, Fecha_Apertura=?, Cliente_Id=?, Sucursal_Id=? WHERE Numero_Cuenta=?`;
    connection.query(query, [Tipo_Cuenta, Saldo, Fecha_Apertura, Cliente_Id, Sucursal_Id, Numero_Cuenta], (err, result) => {
        if (err) return res.status(500).json({ error: 'Error al actualizar cuenta' });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'Cuenta no encontrada' });
        res.json({ message: 'Cuenta actualizada correctamente' });
    });
});

app.put('/departamentos/actualizar', (req, res) => {
    const { Id, Nombre, Descripcion } = req.body;
    if (!Id) return res.status(400).json({ error: 'ID no proporcionado' });
    const query = `UPDATE Departamento SET Nombre=?, Descripcion=? WHERE Id=?`;
    connection.query(query, [Nombre, Descripcion, Id], (err, result) => {
        if (err) return res.status(500).json({ error: 'Error al actualizar departamento' });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'Departamento no encontrado' });
        res.json({ message: 'Departamento actualizado correctamente' });
    });
});

// -------------------- POST ENDPOINTS --------------------
const genPostHandler = (table, path, columns, keyField = 'Id') => {
    app.post(path, (req, res) => {
        const params = columns.map(col => req.body[col]);
        const checkQuery = `SELECT * FROM ${table} WHERE ${keyField} = ?`;
        connection.query(checkQuery, [req.body[keyField]], (err, results) => {
            if (err) return res.status(500).json({ error: `Error al verificar ${table.toLowerCase()}` });
            if (results.length > 0) return res.status(409).json({ error: `${table} ya existe` });
            const insertQuery = `INSERT INTO ${table} (${columns.join(',')}) VALUES (${columns.map(() => '?').join(',')})`;
            connection.query(insertQuery, params, (err) => {
                if (err) return res.status(500).json({ error: `Error al agregar ${table.toLowerCase()}` });
                res.status(201).json({ message: `${table} agregado exitosamente` });
            });
        });
    });
};

genPostHandler('Cliente', '/clientes/agregar', ['Nombre', 'Apellido', 'Cedula', 'Direccion', 'Telefono', 'Correo'], 'Cedula');
genPostHandler('Sucursal', '/sucursales/agregar', ['Nombre', 'Direccion', 'Ciudad', 'Codigo_postal', 'Telefono'], 'Direccion');
genPostHandler('Cuenta', '/cuentas/agregar', ['Numero_Cuenta', 'Tipo_Cuenta', 'Saldo', 'Cliente_Id', 'Sucursal_Id'], 'Numero_Cuenta');
genPostHandler('Departamento', '/departamentos/agregar', ['Nombre', 'Descripcion'], 'Nombre');
genPostHandler('Transaccion', '/transacciones/agregar', ['Tipo_Transaccion', 'Monto', 'Cuenta_Origen_Id', 'Cuenta_Destino_Id', 'Ficha_Transaccion'], 'Ficha_Transaccion');

// -------------------- AUTH (USUARIO) --------------------
const Codigo_admin = 'ADMON123';

function isAdmin(req, res, next) {
    if (req.user && req.user.id_perfil === 2) return next();
    return res.status(403).json({ error: 'Acceso no autorizado' });
}

app.post('/registro', async (req, res) => {
    const { nombre, email, contrasena, id_perfil, adminCode } = req.body;
    if (!nombre || !email || !contrasena || !id_perfil) return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    if (id_perfil === 2 && adminCode !== Codigo_admin) return res.status(403).json({ error: 'Código de administrador incorrecto' });
    connection.query('SELECT * FROM usuario WHERE email = ?', [email], async (err, results) => {
        if (err) return res.status(500).json({ error: 'Error en el servidor' });
        if (results.length) return res.status(409).json({ error: 'Email ya registrado' });
        const hash = await bcrypt.hash(contrasena, 10);
        connection.query('INSERT INTO usuario (nombre,email,contrasena,id_perfil) VALUES (?,?,?,?)', [nombre, email, hash, id_perfil], (err, rs) => {
            if (err) return res.status(500).json({ error: 'Error al registrar usuario' });
            connection.query('SELECT id,nombre,email,id_perfil FROM usuario WHERE id = ?', [rs.insertId], (err, urs) => {
                if (err || !urs.length) return res.status(201).json({ message: 'Usuario registrado' });
                res.status(201).json({ message: 'Usuario registrado', usuario: urs[0] });
            });
        });
    });
});

app.post('/login', async (req, res) => {
    const { usuario, password, id_perfil } = req.body;
    if (!usuario || !password) return res.status(400).json({ error: 'Usuario y contraseña requeridos' });
    connection.query('SELECT * FROM usuario WHERE (email = ? OR nombre = ?) AND id_perfil = ?', [usuario, usuario, id_perfil], async (err, results) => {
        if (err) return res.status(500).json({ error: 'Error en servidor' });
        if (!results.length) return res.status(404).json({ error: 'Usuario no encontrado' });
        const user = results[0];
        const match = await bcrypt.compare(password, user.contrasena);
        if (!match) return res.status(401).json({ error: 'Credenciales inválidas' });
        delete user.contrasena;
        // Aquí podrías generar un token JWT y adjuntarlo a user
        res.json({ message: 'Inicio de sesión exitoso', usuario: user });
    });
});

// Ejemplo de ruta protegida para admin
app.get('/admin/dashboard', isAdmin, (req, res) => {
    res.json({ message: 'Bienvenido al panel de administración', usuario: req.user });
});

// -------------------- START SERVER --------------------
app.listen(port, () => console.log(`Servidor corriendo en http://localhost:${port}`));
