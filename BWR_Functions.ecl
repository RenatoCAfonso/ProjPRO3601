IMPORT $, Std;

//Dataset apos transform
// ds := $.File_Data_Transf.File;

// ds;

//Analises descritivas e bestrecord
// profileResults := STD.DataPatterns.Profile();
// bestrecord := Std.DataPatterns.BestRecordStructure();
//OUTPUT(profileResults, ALL, NAMED('profileResults'));
//OUTPUT(bestrecord, ALL, NAMED('BestRecord'));

// Constroi indices
// BUILD ($.File_Data_Transf.IDX_cnpj,OVERWRITE);


// tabela para consultas
// ds2 := newds2(regiao <> 'REGIAO NAO IDENTIFICADA');

// layout := RECORD
 // ds2.regiao;
 // ds2.ranking_padronizado;
 // cnt := COUNT(GROUP);
// END;

// RankingCount := SORT(TABLE(ds,layout, regiao, ranking_padronizado), REGIAO, ranking_padronizado);

// OUTPUT(RankingCount, NAMED('RankingCount'));