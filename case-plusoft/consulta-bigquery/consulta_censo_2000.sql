WITH censo_2000_prep AS (
  SELECT
    id_municipio,
    p001 AS peso,
    CASE
      WHEN v0439 = 2 THEN 1
      WHEN v0439 = 1 THEN 0
    END AS trabalhou_remunerado,
    CASE
      WHEN v0415 = 2 AND v0416 <= 2 THEN 1
      ELSE 0
    END AS migrante_recente
  FROM `basedosdados.br_ibge_censo_demografico.microdados_pessoa_2000`
  WHERE v4752 >= 25
)
SELECT
  id_municipio,
  SUM(trabalhou_remunerado * peso) / SUM(peso) AS prop_pop_trab_remun,
  SUM(migrante_recente * peso) / SUM(peso) AS prop_migrantes_recentes
FROM censo_2000_prep
GROUP BY id_municipio