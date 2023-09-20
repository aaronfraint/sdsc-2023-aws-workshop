WITH geoid_avg_pop(id, avg_pop) AS (
    SELECT carto.mv_quadbins_of_interest.id, avg(demog.total_pop) as avg_pop
    FROM
        carto.mv_quadbins_of_interest JOIN carto_3p_sociodemographics.carto.geography_usa_blockgroup_2019 geog ON ST_INTERSECTS(carto.mv_quadbins_of_interest.geom, geog.geom),
        carto_3p_sociodemographics.usa_acs.demographics_sociodemographics_usa_blockgroup_2019_yearly_2019 demog
    WHERE geog.geoid = demog.geoid
    GROUP BY carto.mv_quadbins_of_interest.id)
SELECT carto.mv_quadbins_of_interest.geom, avg_pop
FROM geoid_avg_pop JOIN carto.mv_quadbins_of_interest ON geoid_avg_pop.id = carto.mv_quadbins_of_interest.id
    JOIN carto_3p_sociodemographics.carto.geography_usa_blockgroup_2019 geog
    ON ST_INTERSECTS(carto.mv_quadbins_of_interest.geom, geog.geom)

