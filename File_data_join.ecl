IMPORT $;
EXPORT File_Data_Join := MODULE
	EXPORT Layout := RECORD
			RECORDOF($.File_Empresas.File);
      RECORDOF($.File_IBGE.File)
	END;
	EXPORT File := DATASET('~class::proj::out::Empresa_IBGE_Join',Layout,FLAT);
END;