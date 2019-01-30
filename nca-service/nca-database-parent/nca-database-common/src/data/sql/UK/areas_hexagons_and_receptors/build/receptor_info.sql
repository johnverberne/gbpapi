SELECT ae_raise_notice('Build: included_receptors @ ' || timeofday());
BEGIN;
	INSERT INTO included_receptors(receptor_id)
		SELECT receptor_id
		FROM setup.build_included_receptors_view;
COMMIT;

SELECT ae_raise_notice('Build: critical_depositions @ ' || timeofday());
BEGIN;
	INSERT INTO critical_depositions(receptor_id, critical_deposition)
		SELECT receptor_id, critical_deposition
		FROM setup.build_critical_depositions;
COMMIT;
