IMPORT $, Std;

//Dataset apos transform
ds := $.File_Data_Transf.File;

ds

//Analises descritivas e bestrecord
// profileResults := STD.DataPatterns.Profile();
// bestrecord := Std.DataPatterns.BestRecordStructure();
//OUTPUT(profileResults, ALL, NAMED('profileResults'));
//OUTPUT(bestrecord, ALL, NAMED('BestRecord'));

// tabela para consultas
// layout := RECORD
 // ds.regiao;
 // ds.ranking_padronizado;
 // cnt := COUNT(GROUP);
// END;

// RankingCount := SORT(TABLE(ds,layout, regiao, ranking_padronizado), REGIAO, ranking_padronizado);

// OUTPUT(RankingCount, NAMED('RankingCount'));