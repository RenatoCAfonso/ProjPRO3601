IMPORT $;

Empresas := $.File_Empresas.File;
IBGE := $.File_IBGE.File;

// Join entre datasets IBGE e Empresas
$.File_Data_Join.Layout Slimdown($.File_Empresas.Layout L,
																		$.File_IBGE.Layout R) := TRANSFORM
		SELF := L;
		SELF := R;
END;

JoinRecs := JOIN(Empresas,IBGE,
									LEFT.id_municipio=RIGHT.codmun7,
									Slimdown(LEFT,RIGHT));

// Cria novo arquivo logico
OUTPUT(JoinRecs,,'~class::proj::out::Empresa_IBGE_Join',overwrite);