--1
delimiter $
CREATE OR REPLACE PROCEDURE materi1(UMUR INT)
BEGIN
	DECLARE ID VARCHAR(50);
	DECLARE NAMA VARCHAR(50);
	DECLARE CEK_KOSONG INT;
	DECLARE NOTELP VARCHAR(12);
	DECLARE EMAIL VARCHAR (100);
	DECLARE UMUR_K INT;
	
	DECLARE LIST CURSOR FOR
		SELECT K.ID
		FROM KARYAWAN K
		WHERE TIMESTAMPDIFF(YEAR,K.TANGGAL_LAHIR,CURDATE())<UMUR
		ORDER BY K.NAMA;
		
	DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET CEK_KOSONG = 1;
	
	SELECT "#============================================#";
	SELECT "|                DATA KARYAWAN               |";
	SELECT "#============================================#";
	
	OPEN LIST;
	
	LUPS: LOOP
		FETCH LIST INTO ID;
		
		IF CEK_KOSONG = 1 THEN
			LEAVE LUPS;
		ELSE
			SELECT K.NAMA, K.TELP,K.EMAIL, TIMESTAMPDIFF(YEAR,K.TANGGAL_LAHIR,CURDATE()) INTO NAMA, NOTELP, EMAIL, UMUR_K
			FROM KARYAWAN K
			WHERE K.ID = ID;
			SELECT "#--------------------------------------------#";
			SELECT CONCAT("| Nama  : ",RPAD(NAMA,35),"#");
			SELECT CONCAT("| Telp  : ",RPAD(NOTELP,35),"#");
			SELECT CONCAT("| Email  : ",RPAD(EMAIL,34),"#");
			SELECT CONCAT("| Usia  : ",RPAD(CONCAT(UMUR_K," tahun"),35),"#");
			SELECT "#--------------------------------------------#";
		END IF;
		
	END LOOP LUPS;
	CLOSE LIST;
	
END$
DELIMITER ;
CALL materi1(45);
			
--2
DELIMITER $
CREATE OR REPLACE PROCEDURE materi2(KODE VARCHAR(5))
BEGIN
	DECLARE ID VARCHAR(5);
	DECLARE TGL VARCHAR(100);
	DECLARE STAT VARCHAR(100);
	DECLARE ASAL VARCHAR(100);
	DECLARE TUJUAN VARCHAR(100);
	DECLARE NO_KEND VARCHAR(100);
	DECLARE NAMA_S VARCHAR(100);
	DECLARE NAMA_K VARCHAR(100);
	
	SELECT CONCAT(DAY(HP.TANGGAL)," ", MONTHNAME(HP.TANGGAL)," ", YEAR(HP.TANGGAL)),
	CONCAT("| Asal      : WAREHOUSE ",HP.ASAL,"              |"), CONCAT("| Tujuan    : WAREHOUSE ",HP.TUJUAN,"              |"), CONCAT("| Kendaraan : ",RPAD(KN.NOPOL,25),"|"), CONCAT("| Supir     : ",RPAD(S.NAMA,25),"|"), CONCAT("|",LPAD(K.NAMA,38),"|"),
	CONCAT(CASE
		WHEN HP.ID_KARYAWAN IS NULL THEN
			CONCAT("|              PERJALANAN              |")
		ELSE
			CONCAT("|                SELESAI               |")
		END)
	INTO TGL, ASAL, TUJUAN, NO_KEND,NAMA_S,NAMA_K, STAT
	FROM KARYAWAN K,SUPIR S, KENDARAAN KN, H_PINDAH HP
	WHERE HP.KODE=KODE AND HP.ID_KARYAWAN=K.ID AND HP.ID_SUPIR = S.ID AND HP.ID_KENDARAAN=KN.ID;
	
	SELECT "========================================";
	SELECT TGL;
	SELECT STAT;
	SELECT "========================================";
	SELECT ASAL;
	SELECT TUJUAN;
	SELECT NO_KEND;
	SELECT NAMA_S;
	SELECT "|--------------------------------------|";
	SELECT NAMA_K;
	SELECT "========================================";
END$
DELIMITER ;
CALL materi2('H0001');