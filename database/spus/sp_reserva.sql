-- USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_obtener_reserva_por_pagocontrato;
DELIMITER $$
CREATE PROCEDURE sp_obtener_reserva_por_pagocontrato
(
	IN _idpagocontrato INT
)
BEGIN
	SELECT 
	R.idreserva, PC.monto, R.vigencia, R.fechacreada
    FROM reservas R
    LEFT JOIN pagos_contrato PC ON PC.idpagocontrato = R.idpagocontrato
    WHERE PC.idpagocontrato = _idpagocontrato;
END $$

CALL sp_obtener_reserva_por_pagocontrato (5)