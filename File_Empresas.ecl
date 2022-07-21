
EXPORT File_Empresas := MODULE
	EXPORT Layout := RECORD
    STRING14 cnpj;
    UNSIGNED1 identificador_matriz_filial;
    STRING183 razao_social;
    STRING70 nome_fantasia;
    INTEGER1 situacao_cadastral;
    STRING10 data_situacao_cadastral;
    UNSIGNED1 motivo_situacao_cadastral;
    STRING52 nome_cidade_exterior;
    UNSIGNED2 codigo_natureza_juridica;
    STRING10 data_inicio_atividade;
    UNSIGNED4 cnae_fiscal;
    STRING183 descricao_tipo_logradouro;
    STRING73 logradouro;
    STRING12 numero;
    STRING156 complemento;
    STRING57 bairro;
    UNSIGNED4 cep;
    UNSIGNED2 id_municipio_rf;
    UNSIGNED4 id_municipio;
    STRING2 sigla_uf;
    STRING12 ddd_telefone_1;
    STRING12 ddd_telefone_2;
    STRING12 ddd_fax;
    UNSIGNED1 qualificacao_do_responsavel;
    REAL8 capital_social;
    INTEGER2 porte;
    INTEGER1 opcao_pelo_simples;
    STRING10 data_opcao_pelo_simples;
    STRING10 data_exclusao_do_simples;
    INTEGER1 opcao_pelo_mei;
    STRING22 situacao_especial;
    STRING10 data_situacao_especial;
	END;
	EXPORT File := DATASET('~class::proj::empresa.csv', Layout,CSV(heading(1)));
END;




