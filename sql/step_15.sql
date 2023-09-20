SELECT quadbins.geom as geom,
carto.ml_fn_predict_sales_by_demographics(
  quadbins.id,
  demog.total_pop,
  demog.median_income,
  demog.male_15_to_17,
  demog.male_18_to_19,
  demog.male_20,
  demog.male_21,
  demog.male_22_to_24,
  demog.male_25_to_29,
  demog.male_30_to_34,
  demog.female_15_to_17,
  demog.female_18_to_19,
  demog.female_20,
  demog.female_21,
  demog.female_22_to_24,
  demog.female_25_to_29,
  demog.female_30_to_34) AS predicted_yearly_sales
FROM carto.mv_quadbins_of_interest quadbins JOIN
    "carto_3p_sociodemographics"."carto"."geography_usa_blockgroup_2019" geog
    ON ST_INTERSECTS(geog.geom, quadbins.geom) JOIN
    "carto_3p_sociodemographics"."usa_acs"."demographics_sociodemographics_usa_blockgroup_2019_yearly_2019" demog
    ON demog.geoid = geog.geoid
