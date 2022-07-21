IMPORT $;

EXPORT FN_FetchCnpj (STRING info) := FUNCTION
	
	ds := $.File_Data_Transf.IDX_cnpj(cnpj=info);
	

	RETURN OUTPUT(ds);
END;