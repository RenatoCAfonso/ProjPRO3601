EXPORT File_IBGE_Raw := MODULE
	EXPORT Layout := RECORD
			STRING  ano;
      STRING  UF;
			STRING 	nome;
			STRING 	codmun6;
			STRING 	codmun7;
			STRING 	municipio;
			STRING 	sobre40;
			STRING  sobre60;
			STRING 	t_env;
			STRING 	gini;
			STRING  idhm;
			STRING 	idhm_e;
			STRING 	idhm_l;
			STRING 	idhm_r;
	END;
	EXPORT File := DATASET('~class::proj::dados_ibge.csv', Layout,CSV(heading(1)));
END;