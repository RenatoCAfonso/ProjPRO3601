 IMPORT $,STD;

// Chama dataset completo
JoinRecs := $.File_Data_Join.File;

// Ordenacao de valores
sortbl := SORT(JoinRecs,cnpj, id_municipio);

// Remocao de duplicidades
dedptbl := DEDUP(sortbl,cnpj, id_municipio);

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
// Adicao de scores no dataset
rec2 := RECORD

  RECORDOF(JoinRecs); // Campos Antigos
  STRING24 regiao; // Adiciona Regiao
  INTEGER3 score_sobre40; // Adiciona Score para Probabilidade de sobrevivencia 40 anos
  INTEGER3 score_t_env; // Adiciona Score para Taxa de Envelhecimento
  INTEGER3 score_IDHM; // Adiciona Score para IDHM
  INTEGER3 score_soma_IBGE; // Soma scores do ibge
  INTEGER3 score_final_IBGE; // Retira scores negativos
  INTEGER3 score_situacao_cadastral; // Adiciona Score para Situacao Cadastral
  INTEGER3 score_porte; // Adiciona Score para Porte da empresa
  INTEGER3 score_mei_simples; // Adiciona Score para Empresas com MEi ou SImples
  INTEGER3 score_geral; // Soma todos os scores
  String8 ranking; // Classifica as empresas segundo score
  
END;

rec2 MyTransf(RECORDOF(JoinRecs) Le) := TRANSFORM

  // Campos Antigos
  SELF := Le;

  // Adiciona Regiao
  self.regiao := if(le.sigla_uf in ['AM', 'AC', 'RO', 'RR', 'PA', 'AP', 'TO'], 'NORTE', 
                 if(le.sigla_uf in ['MT', 'GO', 'MS'], 'CENTRO OESTE',
                 if(le.sigla_uf in ['MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA'], 'NORDESTE',  
                 if(le.sigla_uf in ['SP', 'MG', 'ES', 'RJ'], 'SUDESTE',
                 if(le.sigla_uf in ['PR', 'RS', 'SC'], 'SUL', 'REGIAO NAO IDENTIFICADA')))));
  
  // Adiciona Score para Probabilidade de sobrevivencia 40 anos
  self.score_sobre40 := if(Le.sobre40<=9709 AND Le.sobre40 > 9338, 200, 
                          if(Le.sobre40<=9338 AND Le.sobre40 > 9139, 150,
                          if(Le.sobre40<=9139 AND Le.sobre40 > 8710, 100,
                          if(Le.sobre40<=8710 AND Le.sobre40 > 6906, 50,
                          if(Le.sobre40<=6906, 0,0)))));
  
  // Adiciona Score para Taxa de Envelhecimento
  self.score_t_env := if(Le.t_env<=2042 AND Le.t_env > 818, 200, 
                          if(Le.t_env<=818 AND Le.t_env > 645, 150,
                          if(Le.t_env<=645 AND Le.t_env > 499, 100,
                          if(Le.t_env<=499 AND Le.t_env > 28, 50,
                          if(Le.t_env<=28, 0,0)))));
  
  // Adiciona Score para IDHM
  self.score_IDHM := if(Le.idhm<=862 AND Le.idhm > 638, 200, 
                          if(Le.idhm<=638 AND Le.idhm > 539, 150,
                          if(Le.idhm<=539 AND Le.idhm > 409, 100,
                          if(Le.idhm<=409 AND Le.idhm > 120, 50,
                          if(Le.idhm<=120, 0,0)))));
  
  // Soma scores do ibge
  self.score_soma_IBGE := self.score_sobre40 + self.score_t_env + self.score_IDHM;
  
  // Retira scores negativos
  Self.score_final_IBGE := if(self.score_soma_IBGE < 0, 0, self.score_soma_IBGE);
  
  // Adiciona Score para Situacao Cadastral
  self.score_situacao_cadastral := if(Le.situacao_cadastral = 2, 200, 0);
  
  // Adiciona Score para Porte da empresa
  self.score_porte := if(Le.porte = 5, 200, 0);
  
  // Adiciona Score para Empresas com MEi ou SImples
  self.score_mei_simples := if(Le.opcao_pelo_simples = 1 or Le.opcao_pelo_mei = 1, 200, 0);
  
  // Soma todos os scores
  self.score_geral := self.score_situacao_cadastral + self.score_mei_simples + self.score_final_IBGE + SELF.score_porte;
  
  // Classifica as empresas segundo score
  self.ranking := if(self.score_geral >= 800, 'BOM', IF(self.score_geral >= 600 AND self.score_geral < 800, 'REGULAR', 
                                                      IF(self.score_geral < 600, 'RUIM','')));
    
END;

newds := PROJECT(dedptbl,MyTransf(LEFT));

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
// Transforme para padronizacao do ranking
rec3 := RECORD
  INTEGER3 score_geral_padronizado; // Padroniza Score
  String8 ranking_padronizado; // Classifica as empresas segundo score padronizado
  RECORDOF(newds); // Campos Antigos
END;

// SCORES MIN MAX
SCOREMAX :=MAX(newds, newds.score_geral);
SCOREMIN :=MIN(newds, newds.score_geral);

rec3 MyTransf2(RECORDOF(newds) Le) := TRANSFORM

  // Campos Antigos
  SELF := Le;
  
  // Padroniza Score
  self.score_geral_padronizado := ((SCOREMAX- le.score_geral)/(SCOREMAX- SCOREMIN))*1000;
  
  // Classifica as empresas segundo score padronizado
  self.ranking_padronizado := if(self.score_geral_padronizado >= 800, 'BOM', IF(self.score_geral_padronizado >= 600 AND self.score_geral_padronizado < 800, 'REGULAR', 
                                                      IF(self.score_geral_padronizado < 600, 'RUIM','')));
END;

newds2 := PROJECT(newds,MyTransf2(LEFT));


OUTPUT(newds2,,'~class::proj::out::Empresa_IBGE_Transf',overwrite);
