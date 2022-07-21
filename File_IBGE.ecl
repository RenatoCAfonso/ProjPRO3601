EXPORT File_IBGE := MODULE
	EXPORT Layout := RECORD
    
    UNSIGNED2 ano;
    UNSIGNED1 uf;
    STRING19 nome;
    UNSIGNED3 codmun6;
    UNSIGNED4 codmun7;
    STRING33 municipio;
    INTEGER3 sobre40;
    INTEGER3 t_env;
    INTEGER3 idhm;
      
	END;
	EXPORT File := DATASET('~class::proj::dados_ibge.csv', Layout,CSV(heading(1)));
END;

