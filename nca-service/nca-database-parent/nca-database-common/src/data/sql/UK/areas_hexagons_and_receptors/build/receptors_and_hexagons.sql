SELECT ae_raise_notice('Build: setup.geometry_of_interests @ ' || timeofday());
BEGIN; SELECT setup.ae_build_geometry_of_interests(); COMMIT;

SELECT ae_raise_notice('Build: receptors @ ' || timeofday());
BEGIN; SELECT setup.ae_build_receptors(); COMMIT;

SELECT ae_raise_notice('Build: hexagons @ ' || timeofday());
BEGIN; SELECT setup.ae_build_hexagons(); COMMIT;
