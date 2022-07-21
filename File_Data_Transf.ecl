IMPORT $;
EXPORT File_Data_Transf := MODULE
	EXPORT Layout := RECORD
      INTEGER3 score_geral_padronizado;
      String8 ranking_padronizado;
      RECORDOF($.File_Data_Join.File);
      STRING24 regiao;
      INTEGER3 score_sobre40; 
      INTEGER3 score_t_env; 
      INTEGER3 score_IDHM; 
      INTEGER3 score_soma_IBGE; 
      INTEGER3 score_final_IBGE;
      INTEGER3 score_situacao_cadastral;
      INTEGER3 score_porte;
      INTEGER3 score_mei_simples; 
      INTEGER3 score_geral; 
      String8 ranking; 
	END;
	EXPORT File := DATASET('~class::proj::out::Empresa_IBGE_transf',Layout,FLAT);
	EXPORT IDX_cnpj := INDEX(File,{cnpj},{cnpj, razao_social, municipio,  ranking_padronizado},'~CLASS::hmw::KEY::cnpj');
END;