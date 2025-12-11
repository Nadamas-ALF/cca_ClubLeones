--hacer un join para mostrar el id de socio y el id de la actividad junto con sus nombres
CREATE OR REPLACE PROCEDURE listar_actividades_socios (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
        SELECT 
            asoc.id_activ_soc,
            act.nombre_actividad,
            soc.nombre_socio
        FROM activ_socio asoc
        JOIN actividades act ON act.id_actividad = asoc.id_actividad
        JOIN socios soc ON soc.id_socio = asoc.id_socio
        ORDER BY asoc.id_activ_soc;
END listar_actividades_socios;
/

--Mostrar cantones por provincia -falta 
CREATE OR REPLACE PROCEDURE listar_cantones_por_provincia (
    p_cod_provincia IN CANTONES.cod_provincia%TYPE
)
IS
    CURSOR cur_cantones IS
        SELECT cod_canton, nombre_canton
        FROM CANTONES
        WHERE cod_provincia = p_cod_provincia;

    v_cod   CANTONES.cod_canton%TYPE;
    v_nom   CANTONES.nombre_canton%TYPE;
BEGIN
    OPEN cur_cantones;
    LOOP
        FETCH cur_cantones INTO v_cod, v_nom;
        EXIT WHEN cur_cantones%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Cantón: ' || v_cod || ' - ' || v_nom);
    END LOOP;
    CLOSE cur_cantones;
END listar_cantones_por_provincia;
/

--Mostrar socios activos -falta 
CREATE OR REPLACE PROCEDURE listar_socios_activos
IS
    CURSOR cur_socios IS
        SELECT id_socio, nombre_socio, estado_socio
        FROM SOCIOS
        WHERE estado_socio = 'A';

    v_id   SOCIOS.id_socio%TYPE;
    v_nom  SOCIOS.nombre_socio%TYPE;
    v_est  SOCIOS.estado_socio%TYPE;
BEGIN
    OPEN cur_socios;
    LOOP
        FETCH cur_socios INTO v_id, v_nom, v_est;
        EXIT WHEN cur_socios%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Socio: ' || v_id || ' - ' || v_nom || ' (' || v_est || ')');
    END LOOP;
    CLOSE cur_socios;
END listar_socios_activos;
/

--Transacciones por año de pago -falta 
CREATE OR REPLACE PROCEDURE listar_transacciones_an (
    p_an_pago IN TRANSACCIONES.an_pago%TYPE
)
IS
    CURSOR cur_trans IS
        SELECT id_transaccion, fec_transaccion, monto_colones, monto_dolares
        FROM TRANSACCIONES
        WHERE an_pago = p_an_pago;

    v_id    TRANSACCIONES.id_transaccion%TYPE;
    v_fec   TRANSACCIONES.fec_transaccion%TYPE;
    v_col   TRANSACCIONES.monto_colones%TYPE;
    v_dol   TRANSACCIONES.monto_dolares%TYPE;
BEGIN
    OPEN cur_trans;
    LOOP
        FETCH cur_trans INTO v_id, v_fec, v_col, v_dol;
        EXIT WHEN cur_trans%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Transacción: ' || v_id || ' - Fecha: ' || v_fec ||
                             ' - Colones: ' || v_col || ' - Dólares: ' || NVL(v_dol,0));
    END LOOP;
    CLOSE cur_trans;
END listar_transacciones_anio;
/

