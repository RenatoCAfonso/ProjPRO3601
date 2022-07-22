IMPORT $;

EXPORT FN_FetchCnpj (STRING DIGITE_CNPJ) := FUNCTION
	
	ds := $.File_Data_Transf.IDX_cnpj(cnpj=DIGITE_CNPJ);
	

	RETURN OUTPUT(ds);
END;