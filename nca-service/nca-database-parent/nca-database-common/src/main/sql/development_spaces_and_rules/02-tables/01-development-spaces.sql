/*
 * reserved_development_spaces
 * ---------------------------
 * Totale gereserveerde ontwikkelingsruimte voor alle OR-relevante receptoren.
 *
 * @column space Gereserveerde ontwikkelingsruimte (inclusief geleende ruimte)
 * @column borrowed Deel van de gereserveerde ontwikkelingsruimte dat geleend is. Dit is alleen van toepassing op
 *   zogenaamde "bijsturingshexagonen". Deze geleende ruimte komt normaliter uit andere segmenten, bijvoorbeeld
 *   voor S2 kan het uit GWR komen. Deze ruimte is bij uitzondering beschikbaar gemaakt om een bepaalde aanvraag
 *   te laten passen. Het is echter niet de bedoeling dat dergelijke ruimte "terug in de pot" komt als de aanvraag komt
 *   te vervallen. De geleende ruimte is daarom initieel altijd in gebruik, want geleende ruimte die niet in
 *   gebruik is moet als "niet bestaand" worden beschouwd. De geleende ruimte zal dus nooit onderdeel kunnen zijn van de
 *   nog beschikbare ruimte; dit wordt bewerkstelligt via de initial_available_development_spaces tabel.
 *   Samengevat: Het "borrowed" gedeelte is een deel van de initieel te benutten ruimte welke alleen meedoet als het al in gebruik is.
 *
 * @see initial_available_development_spaces
 */
CREATE TABLE reserved_development_spaces (
	segment segment_type NOT NULL,
	receptor_id integer NOT NULL,
	space posreal NOT NULL,
	borrowed posreal NOT NULL,

	CONSTRAINT reserved_development_spaces_pkey PRIMARY KEY (segment, receptor_id),
	CONSTRAINT reserved_development_spaces_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,

	CONSTRAINT reserved_development_spaces_chk_segment CHECK (segment <> 'priority_subprojects'),
	CONSTRAINT reserved_development_spaces_chk_borrowed CHECK (borrowed <= space),
	CONSTRAINT reserved_development_spaces_chk_no_s1_borrowed CHECK (borrowed = 0 OR segment <> 'priority_projects')
);


/*
 * initial_available_development_spaces
 * ------------------------------------
 * Retourneert de (initieel) te benutten ontwikkelingsruimte. Er zijn twee redenen waarom deze kan afwijken van de totale gereserveerde
 * ontwikkelingsruimte:
 *
 * - Sommige segmenten mogen voor de non-exceeding receptoren de te gebruiken ruimte van hun segment delen, deze mag dan als één geheel worden beschouwd.
 *   Momenteel betreft dat segment 2 en de GWR. De initieel te benutten ruimte is dan de optelling van de gereserveerde ontwikkelingsruimte van beide
 *   segmenten.
 *
 * - Indien er vrije ruimte ontstaat op een segment waar leenruimte is ingezet (bijv. omdat een andere aanvraag later toch wordt afgewezen), dan mag deze
 *   leenruimte niet beschikbaar worden gesteld in die vrije ruimte. Dit doen we door de (initieel) te benutten ontwikkelingsruimte al direct naar
 *   beneden bij te stellen. Initieel te benutten ruimte die niet al is toegekend mag niet meer zijn dan de gereserveerde ontwikkelingsruimte minus de leenruimtes.
 *
 * Deze tabel wordt automatisch geupdate middels een trigger op de tabel {@link development_spaces}, o.b.v. {@link calc_initial_available_development_spaces_view}.
 */
CREATE TABLE initial_available_development_spaces (
	segment segment_type NOT NULL,
	receptor_id integer NOT NULL,
	space posreal NOT NULL,

	CONSTRAINT initial_available_development_spaces_pkey PRIMARY KEY (segment, receptor_id),
	CONSTRAINT initial_available_development_spaces_fkey_receptors FOREIGN KEY (segment, receptor_id) REFERENCES reserved_development_spaces
);


/*
 * development_spaces
 * ------------------
 * De ontwikkelingsbehoefte / reservering per segment en OR-aanvraag status voor alle OR-relevante receptoren.
 */
CREATE TABLE development_spaces (
	segment segment_type NOT NULL,
	status development_space_state NOT NULL,
	receptor_id integer NOT NULL,
	space posreal NOT NULL,

	CONSTRAINT development_spaces_pkey PRIMARY KEY (segment, status, receptor_id),
	CONSTRAINT development_spaces_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,

	CONSTRAINT development_spaces_chk_segment_status CHECK (
		segment <> 'priority_subprojects'
		AND (segment <> 'permit_threshold' OR status = 'assigned')
		AND (segment <> 'priority_projects' OR status = 'assigned')
	)
);


/*
 * non_exceeding_receptors
 * -----------------------
 * Tabel met daarin de OR-relevante receptoren waarbij de KDW na realisatie van de behoefte NIET overschreden dreigt te worden (KDW - 70 mol).
 */
CREATE TABLE non_exceeding_receptors (
	receptor_id integer NOT NULL,

	CONSTRAINT non_exceeding_receptors_policies_pkey PRIMARY KEY (receptor_id),
	CONSTRAINT non_exceeding_receptors_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);