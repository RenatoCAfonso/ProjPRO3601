EXPORT File_IBGE := MODULE
	EXPORT Layout := RECORD
			UNSIGNED2 ano;
      STRING2 uf;
      STRING nome;
      STRING19 codmun6;
      UNSIGNED3 codmun7;
      STRING municipio;
      REAL sobre40;
      REAL sobre60;
      REAL t_env;
      REAL idhm;
      REAL idhm_e;
      REAL idhm_l;
      REAL idhm_r;
      REAL score_sobre40;
      REAL score_sobre60;
      REAL score_t_env;
      REAL score_idhm;
      REAL score_idhm_e;
      REAL score_idhm_l;
      REAL score_idhm_r;
      REAL score_total;
      
	END;
	EXPORT File := DATASET('~class::proj::dados_ibge.csv', Layout,CSV(heading(1)));
END;