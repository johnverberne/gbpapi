-- email constants
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_REQUEST_SUBJECT', 'nl', 'AERIUS - Wachtwoord reset verzoek');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_REQUEST_BODY', 'nl', '<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p><p style="font-family:Arial;font-size:14px;">Er is op de website aangegeven dat u uw wachtwoord verloren hebt.</p><p style="font-family:Arial;font-size:14px;">Klik op de volgende link om uw wachtwoord te resetten, u ontvangt vervolgens een mailtje met daarin een nieuw wachtwoord.</p><p style="font-family:Arial;font-size:14px;">[PASSWORD_RESET_URL]</p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_CONFIRM_SUBJECT', 'nl', 'AERIUS - Wachtwoord reset bevestiging');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_CONFIRM_BODY', 'nl', '<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p><p style="font-family:Arial;font-size:14px;">Uw wachtwoord is gereset.</p><p style="font-family:Arial;font-size:14px;">Uw nieuwe wachtwoord is: <b>[PASSWORD_RESET_PLAIN_TEXT_NEW]</b></p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CONNECT_APIKEY_CONFIRM_SUBJECT', 'nl', 'Uw AERIUS Connect API key');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CONNECT_APIKEY_CONFIRM_BODY', 'nl', 
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een API key aangevraagd voor AERIUS Connect.
De API key is gegenereerd en kan direct worden gebruikt om toegang te krijgen tot de Connect services.</p>
<p style="font-family:Arial;font-size:14px;">Uw API key is: <b>[CONNECT_APIKEY]</b></p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MAIL_CONTENT_TEMPLATE', 'nl',
E'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<table border="0" width="600">
<tr><td>[MAIL_CONTENT]
<p style="font-family:Arial;font-size:14px;">Met vriendelijke groet,<br />
[MAIL_SIGNATURE]</p>
<p style="font-family:Arial;font-size:14px;">PS: Dit is een automatisch gegenereerde email; u kunt op deze mail niet reageren via \'beantwoorden\'.</p><br /></td></tr>
<tr><td>
<div style="width:560px;border:1px solid #b7c5c5;border-radius:15px;padding:8px 20px 0">
	<table style="border:0" width="560px">
		<tbody>
			<tr>
				<td colspan="2" style="padding-bottom:10px">
					<img alt="AERIUS" height="34" src="data:image/gif;base64,R0lGODlhjwAfANU/AKm5y+Hy+TKItZWmvGeFpZitwrTB0dLl7zdZg+Pt8yhNetLa5HOuzeDm7FVzl8LR3nWNqdHt98LN2UNki/H2+aOyxvDy9TlrlIqiu/r7/WV9noWbtB1FdEtrkc3W4R5pmcTi8MPc6cPX5FiCpBs7bJTU7EdojrPg8WbC5PD5/HbI5ki13imp2ZG/14XO6VWcwaPa73aYtVhvk16w1JvN4zmv2ypfi1e84Ul2nLTT5COTxRtUgxqj1h18rRlCcv///yH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjAzODAxMTc0MDcyMDY4MTE4MDgzRTJEQ0EyOUQ3RjY2IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkQ2MTY4Qjg0QzdBMTExRTJBRjAyQTNBREMzOTczOTEwIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkQ2MTY4QjgzQzdBMTExRTJBRjAyQTNBREMzOTczOTEwIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKE1hY2ludG9zaCkiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDowMjgwMTE3NDA3MjA2ODExODIyQUZENkE3ODIxNkZEMCIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDowMzgwMTE3NDA3MjA2ODExODA4M0UyRENBMjlEN0Y2NiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgH//v38+/r5+Pf29fTz8vHw7+7t7Ovq6ejn5uXk4+Lh4N/e3dzb2tnY19bV1NPS0dDPzs3My8rJyMfGxcTDwsHAv769vLu6ubi3trW0s7KxsK+urayrqqmop6alpKOioaCfnp2cm5qZmJeWlZSTkpGQj46NjIuKiYiHhoWEg4KBgH9+fXx7enl4d3Z1dHNycXBvbm1sa2ppaGdmZWRjYmFgX15dXFtaWVhXVlVUU1JRUE9OTUxLSklIR0ZFRENCQUA/Pj08Ozo5ODc2NTQzMjEwLy4tLCsqKSgnJiUkIyIhIB8eHRwbGhkYFxYVFBMSERAPDg0MCwoJCAcGBQQDAgEAACH5BAEAAD8ALAAAAACPAB8AAAb/wJ9wSCwaj8ikcslsOp/QnwFB0lii2Kx2yy1uFk2I9VeZXLvotHrb4HSYFc1PQRrY1/i83ujw+QBLCA0/JBIKDQh7iotdBn4+ChRKJEIkdYSMmZpNGQ4InwgDShqidTISMpuqq1sWEwMVPxAKYKy2t00DVDK1uL6/UCU8w8QpSCA6ycrLOjRDIT3R0j0CLy0hRyIf2x9FDzvgO0gj4UcWcSaPJg4QTBQFGh0T8/T17BJZN8TEJ8fM/86EQJtGsMeLBEW0cfMWTtwRcuCMDFDwqKKfJYYsarTo4IyTFPuIqfD3b1nAHwMLThMgaYjCbQzLPZQ5ZMPGRw6UeOBws6cP/xMZnsAgtoIYC5LJQChdCiLAs2lDDjCYxoDIy25EvtEsAtGhEAkVIVSQQLbCnSQTfPoU5UQFsQj7IhxBpmxJyh5FWkB1yQ3rEK0RZwYWAuGRgSgL1Pqc8ITFsBo/ig5zMXeZ3b1DEkzDJuRqzMFct1L8iQWA4p4cnJwQ+cMF0cp1ldw1spnvwqwNx21VV9pngQ4+nbge1g/EPqdF6Ca7LI22tAO2YeLeSqQrkdE+DkMxfXNChsQ9ndQoJmRfCSPKdTCPViSHNAFW+372Ghp04UcQtDfhvvEB4fBMwDXMDUPoMwwK6JVk2VPNEfGCNFVF55cQgNFX3VZgWaRAfkzwZ/8RAUNYgJ1FTQgzzHlCmDiMMUSkVxIRswkh1XsISTifbqCRcRMCsSThYUUbFCBkAX1s1IRkPMglhIDEJadgbAKpRNBJnck3XY5DWFeEBEVq1A4SP55WERMgDXMUEY4NM1KLyzC1FIxSRvMCdAlZ+Vduglk4RAMDpGORfkWEKeZFSwx1YBEoGOUklEjcVVAL2dhJIZ5GaJlEAxpUlNMRgg7KRKIhhTqMkkKktx5eP2gmDWfx3XYndVnCekSmj4A5qJFLiKorZUOYKhtmekXDUp2uCtFAQ4MYYQM4ODSRIaFGdCrmEqvpGuoKbDJ6RIw/UCCANJC2Kh0RDRVgBGAxNOH/iB8m2HprRakp4dZkR6jIA3I/+JoEtz+495y4EwpBQDg29PLDAheE498SiDzClhEebKSABRRTLGgiSozXpBFM8oBivm26CQKdKGEmxINyAnxuQzuMIOTA4YxAxAKkjFXWLI8g4JERCGikQBHrWoSBEh0nkSYPCJb6ZDIzMMgeEapGE+4PnhkRA8tY25DsV2rRosSzj/xMRNCPTNASEiomfcS8Kyq9dNNRNkhEsNHQWbURGGAd89Zc9+QA30gYMKLYQ5D9U41JIAlDEoZu7OI/cJcs9xDeSvNClcUW0UABIyS8Aw4xLKy5Aw5gt84AgCuRAAaeIMAYERJ8MoEGAAS1AkQQADs=" width="143" /></td>
			</tr>
			<tr valign="top">
				<td style="font-family:Arial;font-size:12px;width:260px">
					<a href="http://pas.bij12.nl/content/helpdesk" style="color:#333;text-decoration:none">pas.bij12.nl/content/helpdesk</a><br />
					<a href="http://www.aerius.nl" style="color:#333;text-decoration:none">www.aerius.nl</a><br />
					<a href="http://twitter.com/AERIUSapp" style="color:#333;text-decoration:none">twitter.com/AERIUSapp</a><br />
					&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" style="font-family:Arial;color:#6e6e6e;font-size:12px;padding-top:8px">
					AERIUS is ontwikkeld in opdracht van de Rijksoverheid en de gezamenlijke provincies</td>
			</tr>
		</tbody>
	</table>
</div>
<div style="width:600px;text-align:center">
	<img alt="Ministerie van Economische Zaken" height="51" src="data:image/gif;base64,R0lGODlhNwIzAMQAAPf39+Li5YeZtBM8b9bX1+/v75aWlsHL2G2Dpai1yTxbhp6rwtfa34uLiypKewAxZbbA0VZvlufn53Nzc9/f38XFxX9/f87OzqCgoL29vbS0tKqqqldwlrXB0djb3////yH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChNYWNpbnRvc2gpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjcxRUVDODkwN0NFMjExRTI4QTU3RjZCRERERTM2NDJEIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjcxRUVDODkxN0NFMjExRTI4QTU3RjZCRERERTM2NDJEIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NzFFRUM4OEU3Q0UyMTFFMjhBNTdGNkJERERFMzY0MkQiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NzFFRUM4OEY3Q0UyMTFFMjhBNTdGNkJERERFMzY0MkQiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9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" width="567" /></div>
	<div class="tpl-content-highlight" style="width:560px;padding:40px 20px 0"><p style="font-family:Arial;font-size:12px;color:#6e6e6e">Aan de verstrekte gegevens kunnen geen rechten worden ontleend. De eigenaar van AERIUS aanvaardt geen aansprakelijkheid voor de inhoud van de door de gebruiker aangeboden informatie. Bovenstaande gegevens zijn enkel bruikbaar tot er een nieuwe versie van AERIUS beschikbaar is. AERIUS is een geregistreerd handelsmerk in Europa. Alle rechten die niet expliciet worden verleend, zijn voorbehouden.</p>
	</div>
    </td></tr></table>
</body>
</html>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MAIL_SUBJECT_TEMPLATE', 'nl', '[MAIL_SUBJECT]'); -- for now just the subject itself, we just want to provide the option to change the template

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MAIL_SIGNATURE_DEFAULT', 'nl', 'Het AERIUS team');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('ERROR_MAIL_SUBJECT', 'nl', 'Melding van AERIUS betreffende uw aangevraagde bestand');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('ERROR_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening kon niet worden voltooid.</p>

<table border="0" cellpadding="5">
<tr valign="top"><th style="font-family:Arial;font-size:14px;text-align:left">code</th><th style="font-family:Arial;font-size:14px;text-align:left">probleem</th><th style="font-family:Arial;font-size:14px;text-align:left">oplossing</th></tr>
<tr valign="top"><td><p style="font-family:Arial;font-size:14px;color:#ff0000">[ERROR_CODE]</p></td>
<td><p style="font-family:Arial;font-size:14px;color:#ff0000"">[ERROR_MESSAGE]</p></td>
<td><p style="font-family:Arial;font-size:14px;">[ERROR_SOLUTION]</p></td></tr>
</table>
<p style="font-family:Arial;font-size:14px;">Deze melding is ook bekend bij de beheerder van AERIUS. </p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen naar aanleiding van deze melding, lees dan eerst de <a href="#">veelgestelde vragen</a> over berekeningen. Uiteraard kunt u ook contact opnemen met de helpdesk van pas.bij12.nl/content/helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.
</p>');


-- Default email stuff
INSERT INTO i18n.messages (key, language_code, message) VALUES ('DEFAULT_FILE_MAIL_SUBJECT', 'nl', 'Uw AERIUS aangevraagde bestand');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('DEFAULT_FILE_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een export in AERIUS gestart. Deze export is klaar en u kunt het bestand tot uiterlijk 3 dagen na het starten van de export ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de export of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/monitor">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met onze helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');

-- email for PAA (PDF Export)
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_DEVELOPMENT_SPACES_MAIL_SUBJECT', 'nl', 'Uw AERIUS bijlage voor benodigde ontwikkelingsruimte: [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_DEMAND_MAIL_SUBJECT', 'nl', 'Uw AERIUS bijlage voor bepaling projecteffect: [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">AERIUS Calculator kan worden gebruikt voor het berekenen van de stikstofeffecten van projecten en plannen. Bij het gebruik van uw resultaten is het van belang kennis te nemen van het actuele <a href="https://www.aerius.nl/nl/over-aerius/producten/calculator">toepassingsbereik</a> (de bronnen waarvoor kan worden gerekend) van de Calculator.</p>
<p style="font-family:Arial;font-size:14px;">U kunt de pdf importeren in AERIUS om verder te rekenen of om uw bronnen aan te passen.</p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met de helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_OWN_USE_MAIL_SUBJECT', 'nl', 'Uw AERIUS berekening voor eigen gebruik: [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_OWN_USE_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">AERIUS Calculator kan worden gebruikt voor het berekenen van de stikstofeffecten van projecten en plannen. Bij het gebruik van uw resultaten is het van belang kennis te nemen van het actuele <a href="https://www.aerius.nl/nl/over-aerius/producten/calculator">toepassingsbereik</a> (de bronnen waarvoor kan worden gerekend) van de Calculator.</p>
<p style="font-family:Arial;font-size:14px;">U kunt de pdf importeren in AERIUS om verder te rekenen of om uw bronnen aan te passen.</p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met de helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');

-- email for CSV
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CSV_MAIL_SUBJECT', 'nl', 'Uw AERIUS aangevraagde bestand [AERIUS_REFERENCE]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CSV_MAIL_SUBJECT_JOB', 'nl', 'Uw AERIUS aangevraagde berekening [JOB] ([AERIUS_REFERENCE])');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CSV_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het CSV-bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met onze helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');

-- email for GML (uses default subject)
INSERT INTO i18n.messages (key, language_code, message) VALUES ('GML_MAIL_SUBJECT', 'nl', 'Uw AERIUS aangevraagde bestand [AERIUS_REFERENCE]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('GML_MAIL_SUBJECT_JOB', 'nl', 'Uw AERIUS aangevraagde berekening [JOB] ([AERIUS_REFERENCE])');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('GML_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het GML-bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het GML-bestand kunt u gebruiken om de bronnen en resultaten van uw AERIUS berekening te importeren in andere geodata systemen. Daarnaast kunt u het bestand importeren in AERIUS om verder te rekenen of om uw bronnen aan te passen.</p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met onze helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');


-- Melding mails
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REGISTERED_USER_MAIL_SUBJECT', 'nl', 'Meldingsbericht, kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REGISTERED_USER_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 8 van de Regeling Programmatische aanpak stikstof een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur.</p>
<p style="font-family:Arial;font-size:14px;">Uw melding is geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">Het bijbehorende document kan u tot uiterlijk 3 dagen na ontvangst van dit bericht downloaden.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het AERIUS kenmerk van uw melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REGISTERED_USER_MAIL_WITH_ATTACHMENTS_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 8 van de Regeling Programmatische aanpak stikstof een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur.</p>
<p style="font-family:Arial;font-size:14px;">Uw melding is geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">Het bijbehorende document kan u tot uiterlijk 3 dagen na ontvangst van dit bericht downloaden.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het AERIUS kenmerk van uw melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Dit is een overzicht van de door u meegezonden bijlagen.</p>
<p style="font-family:Arial;font-size:14px;">[MELDING_ATTACHMENTS_RESULT_LIST]</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_USER_MAIL_SUBJECT', 'nl', 'Ingediende melding niet geregistreerd');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_USER_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 8 van de Regeling Programmatische aanpak stikstof een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] met het AERIUS kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Uw melding kan niet worden geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">[TECHNICAL_REASON_NOT_REGISTERED_MELDING]</p>
<p style="font-family:Arial;font-size:14px;">In de bijlage vindt u een bestand (gml formaat) behorend bij uw berekening in AERIUS Calculator. Deze kan u rechtstreeks in AERIUS Calculator importeren zodat u, indien gewenst, de eerder ingevoerde informatie opnieuw kan gebruiken.</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_USER_MAIL_ATTACHMENTSLIST_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 8 van de Regeling Programmatische aanpak stikstof een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] met het AERIUS kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Uw melding kan niet worden geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">[TECHNICAL_REASON_NOT_REGISTERED_MELDING]</p>
<p style="font-family:Arial;font-size:14px;">Dit is een overzicht van de door u meegezonden bijlagen.</p>
<p style="font-family:Arial;font-size:14px;">[MELDING_ATTACHMENTS_RESULT_LIST]</p>
<p style="font-family:Arial;font-size:14px;">In de bijlage vindt u een bestand (gml formaat) behorend bij uw berekening in AERIUS Calculator. Deze kan u rechtstreeks in AERIUS Calculator importeren zodat u, indien gewenst, de eerder ingevoerde informatie opnieuw kan gebruiken.</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_TECHNICAL_ISSUE_USER_MAIL_SUBJECT', 'nl','Ingediende melding niet geregistreerd door technische problemen');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_TECHNICAL_REASON', 'nl', 'Reden hiervoor is omdat [REASON_NOT_REGISTERED_MELDING]');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_AUTHORITY_MAIL_SUBJECT', 'nl', '[AUTHORITY] Meldingsbericht niet geregistreerd, kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_AUTHORITY_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw van [AUTHORITY],</p>
<p style="font-family:Arial;font-size:14px;">Er is op grond van artikel 8 van de Regeling Programmatische aanpak stikstof, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] een melding gedaan via het instrument AERIUS.</p>
<p style="font-family:Arial;font-size:14px;">Bij deze ontvangt u als Bevoegd Gezag [AUTHORITY] een bericht over de niet geregistreerde melding. De melding is afgewezen omdat, [REASON_NOT_REGISTERED_MELDING]</p>
<p style="font-family:Arial;font-size:14px;">In de bijlage vindt u een bestand (gml formaat) behorend bij uw berekening in AERIUS Calculator. Deze kan u rechtstreeks in AERIUS Calculator importeren zodat u, indien gewenst, de eerder ingevoerde informatie opnieuw kan gebruiken.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_AUTHORITY_MAIL_SUBJECT', 'nl', '[AUTHORITY] Meldingsbericht, kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_AUTHORITY_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Er is op grond van artikel 8 van de Regeling Programmatische aanpak stikstof, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een melding gedaan via AERIUS. Bij deze ontvangt u als Bevoegd Gezag [AUTHORITY] een bericht van deze melding.</p>
<p style="font-family:Arial;font-size:14px;">Het bijbehorende document kan u tot uiterlijk 3 dagen na ontvangst van dit bericht downloaden.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het betreffende AERIUS kenmerk van de melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DELETE_AUTHORITY_MAIL_SUBJECT', 'nl', '[AUTHORITY] Meldingsbericht, verwijdering van kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DELETE_AUTHORITY_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Hierbij melden we u dat de melding is verwijderd.</p>
<p style="font-family:Arial;font-size:14px;">Het betreffende AERIUS kenmerk van de melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Ontvangst van de melding op [MELDING_CREATE_DATE].</p>
<p style="font-family:Arial;font-size:14px;">Verwijdering van de melding op [MELDING_REMOVE_DATE].</p>
<p style="font-family:Arial;font-size:14px;">De melding is verwijderd door [MELDING_REMOVED_BY].</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_MAIL_SUBJECT', 'nl', '[AUTHORITY] Bijlage(n) bij de melding met AERIUS Kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME], [DOCUMENT_MAIL_NR] van [MAX_DOCUMENT_MAIL_NR]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Dit zijn de bijlagen behorende bij de Melding met AERIUS Kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">[MAIL_SUBSTANTIATION]</p>
<p style="font-family:Arial;font-size:14px;"> Deze bijlagen horen bij de melding met AERIUS kenmerk [AERIUS_REFERENCE], gedaan op [CALC_CREATION_DATE] om [CALC_CREATION_TIME]</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_MAIL_SUBSTANTIATION', 'nl', 'Eigen opmerkingen door melder bij de onderbouwing referentiesituatie: [MELDING_SUBSTANTIATION]');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_STATUS_MAIL_SUBJECT', 'nl', '[AUTHORITY] Overzicht verzonden bijlage voor AERIUS Kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_STATUS_MAIL_CONTENT', 'nl',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Dit is een overzicht van de verzonden bijlage voor melding met AERIUS Kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">[MELDING_ATTACHMENTS_RESULT_LIST]</p>
<p style="font-family:Arial;font-size:14px;"> Deze bijlagen horen bij de melding met AERIUS kenmerk [AERIUS_REFERENCE], gedaan op [CALC_CREATION_DATE] om [CALC_CREATION_TIME]</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ATTACHMENTS_SEND_STATUS_OK', 'nl', 'Verzonden');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ATTACHMENTS_SEND_STATUS_FAIL', 'nl', 'Fout bij verzenden');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ATTACHMENTS_FROM', 'nl', 'van');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOES_NOT_FIT', 'nl', 'de melding van uw initiatief is afgewezen, omdat de projectbijdrage van uw initiatief groter is dan de beschikbare depositieruimte.');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ABOVE_PERMIT_THRESHOLD', 'nl', 'de grenswaarde van rechtswege is verlaagd naar 0.05 mol/ ha/j. Dit betekent dat er alsnog sprake is van een vergunningplicht voor uw initiatief.');   
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_TECHNICAL_ISSUES', 'nl', 'er als gevolg van een technische storing geen berekening is ontvangen. U kunt opnieuw een melding indienen, onze excuses voor het ongemak.');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REJECT_REASON_OTHER', 'nl', 'overige fout conditie.');

-- Splash
INSERT INTO i18n.messages (key, language_code, message) VALUES ('SPLASH_ATTRIBUTION_TEXT', 'nl', 'AERIUS is ontwikkeld in opdracht van de Rijksoverheid en de gezamelijke provincies.<br />Deze evaluatie versie is ontwikkeld in samenwerking met het JNCC en Natural England.');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('SPLASH_ATTRIBUTION_IMAGE', 'nl', '
<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 16.0.4, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 width="288.182px" height="65.094px" viewBox="0 0 288.182 65.094" enable-background="new 0 0 288.182 65.094"
	 xml:space="preserve">
<g>
	<rect x="0" fill="#DCDA20" width="65.091" height="65.094"/>
	<polygon fill="#7D184C" points="29.379,62.977 29.379,52.686 30.52,52.686 30.52,61.915 34.423,61.915 34.423,62.977 	"/>
	<polygon fill="#7D184C" points="2.117,52.7 7.447,52.7 7.447,53.762 3.262,53.762 3.262,56.815 7.325,56.815 7.325,57.879 
		3.262,57.879 3.262,61.913 7.447,61.913 7.447,62.975 2.117,62.975 	"/>
	<polygon fill="#7D184C" points="8.851,52.262 16.865,60.659 16.865,52.7 18.01,52.7 18.01,63.44 9.996,55.057 9.996,62.977 
		8.851,62.977 	"/>
	<path fill="#7D184C" d="M37.365,60.061l-1.241,2.916H34.87l4.744-10.77l4.621,10.77h-1.266l-1.214-2.916H37.365z M39.588,54.879
		l-1.759,4.115h3.476L39.588,54.879z"/>
	<polygon fill="#7D184C" points="44.971,52.262 52.987,60.659 52.987,52.7 54.131,52.7 54.131,63.44 46.116,55.057 46.116,62.977 
		44.971,62.977 	"/>
	<g>
		<defs>
			<rect id="SVGID_1_" x="0" width="65.091" height="65.094"/>
		</defs>
		<clipPath id="SVGID_2_">
			<use xlink:href="#SVGID_1_"  overflow="visible"/>
		</clipPath>
		<path clip-path="url(#SVGID_2_)" fill="#7D184C" d="M55.535,52.7h1.935c1.542,0,2.795,0.203,4.007,1.24
			c1.172,1.008,1.704,2.387,1.704,3.91c0,1.5-0.545,2.82-1.677,3.83c-1.226,1.092-2.453,1.297-4.062,1.297h-1.907V52.7z
			 M57.51,61.913c1.253,0,2.304-0.176,3.245-1.062c0.844-0.789,1.281-1.869,1.281-3.014c0-1.172-0.451-2.303-1.336-3.078
			c-0.94-0.832-1.977-0.996-3.189-0.996H56.68v8.15H57.51z"/>
		<path clip-path="url(#SVGID_2_)" fill="#7D184C" d="M24.75,58.051v1.143h1.727v2.496c-0.39,0.234-1.016,0.422-1.967,0.422
			c-2.56,0-4.17-1.576-4.17-4.232c0-2.467,1.501-4.168,4.092-4.168c1.218,0,2.279,0.453,2.921,0.795v-1.232
			c-0.516-0.266-1.608-0.625-2.857-0.625c-3.218,0-5.373,2.172-5.373,5.387c0,3.029,2.093,5.137,5.123,5.137
			c1.513,0,2.809-0.498,3.372-0.812v-4.309H24.75z"/>
		<polygon clip-path="url(#SVGID_2_)" fill="#FFFFFF" points="2.117,39.37 10.551,48.262 10.551,39.833 11.697,39.833 
			11.697,51.043 3.263,42.163 3.263,50.581 2.117,50.581 		"/>
		<path clip-path="url(#SVGID_2_)" fill="#FFFFFF" d="M14.834,47.528l-1.298,3.051h-1.255l4.961-11.26l4.832,11.26h-1.268
			l-1.269-3.051H14.834z M17.212,41.942l-1.904,4.477h3.769L17.212,41.942z"/>
		<path clip-path="url(#SVGID_2_)" fill="#FFFFFF" d="M49.673,47.528l-1.297,3.051H47.12l4.962-11.26l4.832,11.26h-1.267
			l-1.268-3.051H49.673z M52.052,41.942l-1.906,4.477h3.77L52.052,41.942z"/>
		<polygon clip-path="url(#SVGID_2_)" fill="#FFFFFF" points="25.552,50.579 24.412,50.579 24.412,40.895 20.928,40.895 
			20.928,39.833 29.064,39.833 29.064,40.895 25.552,40.895 		"/>
		<polygon clip-path="url(#SVGID_2_)" fill="#FFFFFF" points="57.698,50.571 57.698,39.811 58.841,39.811 58.841,49.508 
			62.975,49.508 62.975,50.571 		"/>
		<path clip-path="url(#SVGID_2_)" fill="#FFFFFF" d="M45.628,50.579c-1.73-2.742-2.608-4.471-3.081-4.57h-1.424v4.57h-1.141V39.821
			h2.533c2.53,0,3.554,1.354,3.557,2.971c0.004,1.541-1.094,2.518-2.281,2.842v0.016c0.343,0.162,1.431,2.17,3.178,4.93H45.628z
			 M42.514,40.881h-1.392v4.107h1.457c1.258,0,2.254-0.855,2.254-2.066C44.834,41.741,44.228,40.93,42.514,40.881"/>
		<path clip-path="url(#SVGID_2_)" fill="#FFFFFF" d="M37.289,49.709c-0.637,0.637-1.617,1.062-3.055,1.062
			c-1.356,0-2.254-0.393-2.84-0.949c-0.866-0.848-1.045-2.104-1.045-3.084V39.85h1.139v6.904c0,0.736,0.163,1.633,0.768,2.236
			c0.408,0.426,1.035,0.734,2.011,0.734c1.092,0,1.752-0.309,2.193-0.75c0.489-0.521,0.669-1.273,0.669-2.123V39.85h1.138v7.166
			C38.267,47.995,37.991,48.991,37.289,49.709"/>
	</g>
</g>
<g>
	<g>
		<path fill="#235F77" d="M138.542,58.635c-0.061,0.195-0.16,0.371-0.301,0.525c-0.139,0.156-0.324,0.277-0.553,0.371
			c-0.232,0.092-0.52,0.139-0.859,0.139c-0.57,0-1.008-0.148-1.314-0.441c-0.309-0.293-0.461-0.729-0.461-1.301v-0.371h0.811v0.252
			c0,0.174,0.014,0.334,0.043,0.48c0.027,0.145,0.078,0.271,0.148,0.379c0.072,0.107,0.172,0.189,0.299,0.248
			s0.291,0.088,0.49,0.088c0.371,0,0.625-0.098,0.766-0.293c0.139-0.197,0.209-0.461,0.209-0.793v-4.395h0.811v4.512
			C138.63,58.239,138.601,58.438,138.542,58.635"/>
		<path fill="#235F77" d="M139.954,56.467c0.09-0.277,0.227-0.521,0.408-0.725c0.184-0.205,0.408-0.367,0.676-0.484
			s0.574-0.178,0.92-0.178c0.354,0,0.662,0.061,0.926,0.178c0.268,0.117,0.49,0.279,0.672,0.484c0.182,0.203,0.318,0.447,0.41,0.725
			c0.09,0.277,0.137,0.576,0.137,0.896s-0.047,0.617-0.137,0.891c-0.092,0.275-0.229,0.518-0.41,0.723
			c-0.182,0.203-0.404,0.363-0.672,0.479c-0.264,0.117-0.572,0.172-0.926,0.172c-0.346,0-0.652-0.055-0.92-0.172
			c-0.268-0.115-0.492-0.275-0.676-0.479c-0.182-0.205-0.318-0.447-0.408-0.723c-0.092-0.273-0.139-0.57-0.139-0.891
			S139.863,56.745,139.954,56.467 M140.693,58.065c0.07,0.205,0.17,0.379,0.293,0.516c0.125,0.137,0.271,0.24,0.441,0.314
			c0.168,0.074,0.346,0.109,0.531,0.109c0.189,0,0.367-0.035,0.535-0.109s0.314-0.178,0.439-0.314s0.225-0.311,0.295-0.516
			s0.105-0.438,0.105-0.701s-0.035-0.498-0.105-0.705c-0.07-0.205-0.17-0.375-0.295-0.516s-0.271-0.248-0.439-0.32
			c-0.168-0.074-0.346-0.109-0.535-0.109c-0.186,0-0.363,0.035-0.531,0.109c-0.17,0.072-0.316,0.18-0.441,0.32
			c-0.123,0.141-0.223,0.311-0.293,0.516c-0.072,0.207-0.107,0.441-0.107,0.705S140.62,57.86,140.693,58.065"/>
		<path fill="#235F77" d="M145.212,53.526h0.725v0.873h-0.725V53.526z M145.937,59.536h-0.725v-4.354h0.725V59.536z"/>
		<path fill="#235F77" d="M147.962,55.182v0.689h0.016c0.303-0.527,0.779-0.791,1.436-0.791c0.289,0,0.531,0.039,0.725,0.117
			c0.193,0.08,0.35,0.189,0.469,0.33c0.121,0.141,0.205,0.307,0.252,0.502c0.049,0.193,0.074,0.408,0.074,0.643v2.863h-0.727V56.59
			c0-0.271-0.08-0.484-0.238-0.643c-0.16-0.156-0.379-0.236-0.658-0.236c-0.223,0-0.414,0.035-0.576,0.102s-0.299,0.164-0.406,0.287
			s-0.188,0.268-0.244,0.434c-0.053,0.166-0.08,0.348-0.08,0.543v2.459h-0.725v-4.354H147.962z"/>
		<path fill="#235F77" d="M154.095,55.182v0.631h-0.879v2.705c0,0.084,0.006,0.15,0.02,0.201s0.043,0.09,0.082,0.117
			c0.039,0.029,0.094,0.047,0.166,0.055c0.072,0.01,0.164,0.014,0.277,0.014h0.334v0.631h-0.557c-0.188,0-0.348-0.012-0.482-0.037
			c-0.133-0.027-0.24-0.072-0.322-0.139c-0.084-0.068-0.145-0.164-0.184-0.287c-0.041-0.123-0.061-0.287-0.061-0.488v-2.771h-0.75
			v-0.631h0.75v-1.305h0.727v1.305H154.095z"/>
		<polygon fill="#235F77" points="158.767,53.526 161.976,58.397 161.993,58.397 161.993,53.526 162.761,53.526 162.761,59.536 
			161.872,59.536 158.689,54.711 158.673,54.711 158.673,59.536 157.904,59.536 157.904,53.526 		"/>
		<path fill="#235F77" d="M167.579,59.627c-0.188,0-0.336-0.051-0.447-0.154s-0.168-0.273-0.168-0.512
			c-0.197,0.238-0.43,0.408-0.695,0.512c-0.264,0.104-0.551,0.154-0.857,0.154c-0.199,0-0.389-0.02-0.562-0.062
			c-0.178-0.041-0.332-0.111-0.467-0.209c-0.133-0.098-0.238-0.225-0.314-0.379c-0.078-0.156-0.115-0.342-0.115-0.561
			c0-0.248,0.041-0.449,0.129-0.607c0.084-0.156,0.197-0.285,0.334-0.383c0.141-0.098,0.301-0.174,0.48-0.223
			c0.18-0.051,0.361-0.094,0.551-0.127c0.199-0.039,0.389-0.068,0.566-0.088c0.182-0.02,0.338-0.049,0.475-0.084
			c0.137-0.037,0.244-0.09,0.324-0.16s0.119-0.174,0.119-0.307c0-0.158-0.029-0.283-0.09-0.379c-0.061-0.098-0.137-0.17-0.23-0.221
			c-0.094-0.049-0.199-0.082-0.316-0.1c-0.115-0.018-0.23-0.025-0.346-0.025c-0.307,0-0.562,0.057-0.768,0.172
			c-0.203,0.115-0.316,0.332-0.332,0.652h-0.727c0.01-0.268,0.068-0.498,0.17-0.682c0.104-0.186,0.24-0.334,0.41-0.451
			c0.172-0.115,0.369-0.197,0.59-0.248c0.223-0.051,0.455-0.076,0.699-0.076c0.201,0,0.396,0.014,0.594,0.043
			c0.195,0.027,0.375,0.086,0.533,0.172c0.16,0.088,0.289,0.209,0.383,0.367c0.098,0.156,0.146,0.361,0.146,0.615v2.24
			c0,0.166,0.01,0.291,0.029,0.369s0.086,0.117,0.203,0.117c0.061,0,0.135-0.014,0.221-0.043v0.559
			C167.976,59.592,167.802,59.627,167.579,59.627 M166.564,57.436c-0.148,0.029-0.303,0.055-0.465,0.074s-0.326,0.043-0.49,0.068
			c-0.166,0.023-0.314,0.064-0.443,0.121c-0.133,0.057-0.238,0.137-0.322,0.24c-0.082,0.104-0.123,0.246-0.123,0.426
			c0,0.117,0.025,0.219,0.072,0.299c0.049,0.082,0.111,0.146,0.188,0.197s0.168,0.088,0.275,0.109
			c0.104,0.023,0.211,0.033,0.318,0.033c0.238,0,0.445-0.029,0.615-0.094c0.17-0.066,0.309-0.148,0.42-0.246
			c0.105-0.098,0.186-0.205,0.236-0.322c0.053-0.113,0.078-0.223,0.078-0.322v-0.732C166.831,57.354,166.712,57.405,166.564,57.436"
			/>
		<path fill="#235F77" d="M170.861,55.182v0.631h-0.879v2.705c0,0.084,0.008,0.15,0.021,0.201s0.041,0.09,0.082,0.117
			c0.039,0.029,0.094,0.047,0.166,0.055c0.072,0.01,0.162,0.014,0.277,0.014h0.332v0.631h-0.555c-0.189,0-0.348-0.012-0.482-0.037
			c-0.133-0.027-0.24-0.072-0.324-0.139c-0.084-0.068-0.145-0.164-0.184-0.287s-0.059-0.287-0.059-0.488v-2.771h-0.752v-0.631h0.752
			v-1.305h0.725v1.305H170.861z"/>
		<path fill="#235F77" d="M174.784,59.536v-0.691h-0.016c-0.156,0.271-0.352,0.469-0.592,0.594
			c-0.238,0.127-0.521,0.189-0.844,0.189c-0.291,0-0.535-0.037-0.727-0.111c-0.193-0.078-0.35-0.186-0.469-0.326
			c-0.119-0.139-0.203-0.307-0.252-0.5c-0.051-0.193-0.072-0.41-0.072-0.645v-2.863h0.723v2.947c0,0.268,0.082,0.484,0.242,0.641
			s0.377,0.234,0.656,0.234c0.221,0,0.414-0.033,0.576-0.1c0.164-0.066,0.297-0.162,0.406-0.287
			c0.107-0.123,0.188-0.268,0.242-0.434c0.053-0.164,0.082-0.348,0.082-0.543v-2.459h0.725v4.354H174.784z"/>
		<path fill="#235F77" d="M177.454,55.182V56.1h0.016c0.178-0.354,0.393-0.615,0.648-0.783c0.258-0.168,0.582-0.246,0.975-0.236
			v0.758c-0.291,0-0.537,0.041-0.742,0.119s-0.371,0.193-0.496,0.346c-0.125,0.15-0.217,0.334-0.271,0.551
			c-0.057,0.217-0.086,0.465-0.086,0.744v1.938h-0.727v-4.354H177.454z"/>
		<path fill="#235F77" d="M182.972,59.256c-0.33,0.25-0.746,0.373-1.246,0.373c-0.354,0-0.66-0.057-0.918-0.168
			c-0.26-0.113-0.477-0.271-0.652-0.473c-0.178-0.203-0.309-0.441-0.398-0.725c-0.088-0.281-0.137-0.586-0.148-0.918
			c0-0.332,0.051-0.635,0.152-0.908c0.104-0.277,0.248-0.514,0.432-0.717c0.186-0.203,0.404-0.359,0.658-0.471
			c0.254-0.113,0.529-0.17,0.832-0.17c0.393,0,0.717,0.082,0.979,0.242c0.258,0.16,0.467,0.361,0.623,0.609s0.264,0.516,0.324,0.809
			c0.061,0.291,0.082,0.568,0.07,0.832h-3.303c-0.004,0.191,0.018,0.373,0.07,0.545c0.049,0.17,0.133,0.322,0.246,0.453
			c0.113,0.133,0.26,0.238,0.436,0.318c0.176,0.076,0.385,0.115,0.623,0.115c0.307,0,0.559-0.068,0.756-0.209
			c0.195-0.141,0.326-0.354,0.389-0.641h0.717C183.515,58.643,183.302,59.01,182.972,59.256 M182.798,56.461
			c-0.066-0.15-0.154-0.281-0.266-0.391c-0.109-0.109-0.242-0.197-0.393-0.262c-0.15-0.062-0.316-0.098-0.5-0.098
			c-0.188,0-0.355,0.035-0.508,0.098c-0.15,0.064-0.279,0.154-0.389,0.266c-0.107,0.111-0.193,0.242-0.256,0.393
			c-0.062,0.146-0.1,0.307-0.111,0.475h2.535C182.902,56.774,182.863,56.614,182.798,56.461"/>
		<path fill="#235F77" d="M191.116,54.374c-0.311-0.213-0.68-0.32-1.105-0.32c-0.363,0-0.676,0.068-0.936,0.203
			c-0.258,0.135-0.473,0.316-0.641,0.545c-0.168,0.225-0.291,0.484-0.371,0.777c-0.08,0.291-0.119,0.596-0.119,0.908
			c0,0.344,0.039,0.668,0.119,0.973c0.08,0.307,0.203,0.572,0.371,0.801s0.385,0.408,0.646,0.541
			c0.262,0.137,0.574,0.203,0.938,0.203c0.268,0,0.506-0.043,0.713-0.129s0.387-0.209,0.537-0.363s0.27-0.338,0.355-0.551
			c0.084-0.215,0.137-0.443,0.152-0.691h0.812c-0.082,0.758-0.346,1.348-0.795,1.77c-0.447,0.422-1.064,0.631-1.844,0.631
			c-0.473,0-0.885-0.08-1.238-0.24c-0.354-0.158-0.645-0.379-0.879-0.66s-0.408-0.613-0.525-0.994
			c-0.115-0.383-0.174-0.791-0.174-1.23c0-0.436,0.064-0.848,0.188-1.232c0.125-0.385,0.309-0.721,0.551-1.006
			c0.242-0.287,0.543-0.512,0.904-0.678s0.775-0.248,1.242-0.248c0.318,0,0.621,0.041,0.906,0.125s0.537,0.207,0.758,0.371
			c0.223,0.162,0.406,0.365,0.557,0.609c0.146,0.244,0.244,0.527,0.289,0.846h-0.811C191.626,54.909,191.425,54.588,191.116,54.374"
			/>
		<path fill="#235F77" d="M193.607,56.467c0.092-0.277,0.229-0.521,0.41-0.725c0.184-0.205,0.408-0.367,0.674-0.484
			c0.27-0.117,0.576-0.178,0.922-0.178c0.354,0,0.662,0.061,0.926,0.178c0.268,0.117,0.49,0.279,0.672,0.484
			c0.184,0.203,0.318,0.447,0.41,0.725s0.137,0.576,0.137,0.896s-0.045,0.617-0.137,0.891c-0.092,0.275-0.227,0.518-0.41,0.723
			c-0.182,0.203-0.404,0.363-0.672,0.479c-0.264,0.117-0.572,0.172-0.926,0.172c-0.346,0-0.652-0.055-0.922-0.172
			c-0.266-0.115-0.49-0.275-0.674-0.479c-0.182-0.205-0.318-0.447-0.41-0.723c-0.09-0.273-0.137-0.57-0.137-0.891
			S193.517,56.745,193.607,56.467 M194.347,58.065c0.072,0.205,0.168,0.379,0.293,0.516c0.127,0.137,0.271,0.24,0.441,0.314
			c0.168,0.074,0.346,0.109,0.531,0.109c0.189,0,0.367-0.035,0.535-0.109c0.166-0.074,0.314-0.178,0.439-0.314
			s0.223-0.311,0.295-0.516c0.07-0.205,0.107-0.438,0.107-0.701s-0.037-0.498-0.107-0.705c-0.072-0.205-0.17-0.375-0.295-0.516
			s-0.273-0.248-0.439-0.32c-0.168-0.074-0.346-0.109-0.535-0.109c-0.186,0-0.363,0.035-0.531,0.109
			c-0.17,0.072-0.314,0.18-0.441,0.32c-0.125,0.141-0.221,0.311-0.293,0.516c-0.072,0.207-0.107,0.441-0.107,0.705
			S194.275,57.86,194.347,58.065"/>
		<path fill="#235F77" d="M199.532,55.182v0.689h0.016c0.303-0.527,0.781-0.791,1.436-0.791c0.291,0,0.533,0.039,0.725,0.117
			c0.195,0.08,0.352,0.189,0.471,0.33s0.203,0.307,0.25,0.502c0.051,0.193,0.074,0.408,0.074,0.643v2.863h-0.725V56.59
			c0-0.271-0.08-0.484-0.24-0.643c-0.16-0.156-0.379-0.236-0.658-0.236c-0.221,0-0.414,0.035-0.574,0.102
			c-0.164,0.066-0.297,0.164-0.408,0.287c-0.107,0.123-0.188,0.268-0.24,0.434c-0.057,0.166-0.082,0.348-0.082,0.543v2.459h-0.727
			v-4.354H199.532z"/>
		<path fill="#235F77" d="M204.39,58.565c0.068,0.109,0.158,0.195,0.268,0.26c0.113,0.066,0.236,0.111,0.377,0.139
			c0.139,0.027,0.283,0.041,0.432,0.041c0.113,0,0.234-0.008,0.357-0.023c0.125-0.018,0.24-0.049,0.346-0.092
			c0.105-0.045,0.193-0.113,0.262-0.201c0.068-0.084,0.102-0.197,0.102-0.332c0-0.186-0.07-0.324-0.213-0.42
			s-0.32-0.174-0.533-0.232s-0.445-0.111-0.695-0.16c-0.252-0.047-0.484-0.115-0.697-0.201c-0.213-0.088-0.391-0.209-0.533-0.365
			c-0.143-0.158-0.213-0.377-0.213-0.658c0-0.219,0.049-0.406,0.148-0.564s0.227-0.285,0.385-0.383
			c0.156-0.098,0.332-0.17,0.529-0.219s0.391-0.072,0.584-0.072c0.25,0,0.48,0.023,0.693,0.064c0.209,0.043,0.395,0.115,0.559,0.219
			c0.162,0.104,0.291,0.242,0.389,0.422c0.096,0.176,0.152,0.395,0.17,0.658h-0.727c-0.01-0.139-0.049-0.254-0.111-0.348
			c-0.061-0.092-0.143-0.168-0.238-0.225c-0.098-0.055-0.203-0.096-0.32-0.121c-0.115-0.025-0.234-0.039-0.354-0.039
			c-0.107,0-0.219,0.01-0.328,0.027c-0.113,0.016-0.213,0.047-0.305,0.088c-0.09,0.043-0.166,0.1-0.223,0.168
			c-0.055,0.07-0.084,0.162-0.084,0.273c0,0.123,0.045,0.229,0.133,0.309c0.088,0.082,0.199,0.148,0.336,0.201
			s0.291,0.1,0.463,0.135c0.17,0.037,0.34,0.074,0.512,0.113c0.182,0.039,0.359,0.088,0.533,0.143
			c0.172,0.057,0.328,0.131,0.459,0.225c0.135,0.092,0.244,0.209,0.326,0.35s0.123,0.312,0.123,0.521
			c0,0.264-0.055,0.482-0.164,0.658c-0.111,0.174-0.258,0.312-0.438,0.422c-0.178,0.104-0.383,0.18-0.607,0.221
			c-0.223,0.043-0.447,0.064-0.668,0.064c-0.244,0-0.48-0.027-0.701-0.076c-0.223-0.051-0.418-0.135-0.588-0.248
			c-0.172-0.117-0.309-0.268-0.41-0.457c-0.102-0.188-0.16-0.416-0.17-0.686h0.725C204.284,58.321,204.322,58.454,204.39,58.565"/>
		<path fill="#235F77" d="M211.462,59.256c-0.332,0.25-0.746,0.373-1.246,0.373c-0.354,0-0.66-0.057-0.918-0.168
			c-0.26-0.113-0.477-0.271-0.654-0.473c-0.176-0.203-0.309-0.441-0.396-0.725c-0.088-0.281-0.137-0.586-0.15-0.918
			c0-0.332,0.053-0.635,0.154-0.908c0.104-0.277,0.248-0.514,0.434-0.717c0.182-0.203,0.402-0.359,0.654-0.471
			c0.256-0.113,0.531-0.17,0.832-0.17c0.395,0,0.721,0.082,0.979,0.242c0.26,0.16,0.467,0.361,0.623,0.609s0.266,0.516,0.326,0.809
			c0.059,0.291,0.082,0.568,0.072,0.832h-3.305c-0.006,0.191,0.018,0.373,0.068,0.545c0.053,0.17,0.135,0.322,0.248,0.453
			c0.113,0.133,0.258,0.238,0.436,0.318c0.176,0.076,0.383,0.115,0.621,0.115c0.309,0,0.561-0.068,0.758-0.209
			c0.195-0.141,0.324-0.354,0.387-0.641h0.719C212.005,58.643,211.792,59.01,211.462,59.256 M211.286,56.461
			c-0.064-0.15-0.154-0.281-0.264-0.391c-0.111-0.109-0.242-0.197-0.395-0.262c-0.148-0.062-0.316-0.098-0.498-0.098
			c-0.188,0-0.357,0.035-0.508,0.098c-0.152,0.064-0.281,0.154-0.389,0.266c-0.109,0.111-0.193,0.242-0.256,0.393
			c-0.062,0.146-0.1,0.307-0.111,0.475h2.535C211.39,56.774,211.353,56.614,211.286,56.461"/>
		<path fill="#235F77" d="M213.87,55.182V56.1h0.018c0.176-0.354,0.393-0.615,0.648-0.783s0.58-0.246,0.975-0.236v0.758
			c-0.291,0-0.539,0.041-0.744,0.119s-0.369,0.193-0.496,0.346c-0.123,0.15-0.215,0.334-0.273,0.551
			c-0.057,0.217-0.084,0.465-0.084,0.744v1.938h-0.725v-4.354H213.87z"/>
		<polygon fill="#235F77" points="217.749,59.536 216.111,55.182 216.923,55.182 218.159,58.811 218.175,58.811 219.38,55.182 
			220.14,55.182 218.527,59.536 		"/>
		<path fill="#235F77" d="M224.275,59.627c-0.186,0-0.336-0.051-0.447-0.154s-0.166-0.273-0.166-0.512
			c-0.199,0.238-0.432,0.408-0.697,0.512c-0.264,0.104-0.549,0.154-0.857,0.154c-0.199,0-0.387-0.02-0.562-0.062
			c-0.178-0.041-0.332-0.111-0.467-0.209c-0.131-0.098-0.238-0.225-0.314-0.379c-0.076-0.156-0.115-0.342-0.115-0.561
			c0-0.248,0.043-0.449,0.129-0.607c0.084-0.156,0.197-0.285,0.336-0.383c0.141-0.098,0.301-0.174,0.479-0.223
			c0.18-0.051,0.363-0.094,0.551-0.127c0.199-0.039,0.389-0.068,0.566-0.088c0.182-0.02,0.338-0.049,0.475-0.084
			c0.135-0.037,0.244-0.09,0.324-0.16s0.121-0.174,0.121-0.307c0-0.158-0.031-0.283-0.092-0.379
			c-0.059-0.098-0.137-0.17-0.229-0.221c-0.094-0.049-0.201-0.082-0.318-0.1c-0.115-0.018-0.23-0.025-0.344-0.025
			c-0.307,0-0.562,0.057-0.77,0.172c-0.205,0.115-0.316,0.332-0.332,0.652h-0.725c0.01-0.268,0.066-0.498,0.168-0.682
			c0.105-0.186,0.24-0.334,0.41-0.451c0.172-0.115,0.369-0.197,0.59-0.248c0.223-0.051,0.457-0.076,0.701-0.076
			c0.199,0,0.396,0.014,0.592,0.043c0.197,0.027,0.375,0.086,0.533,0.172c0.16,0.088,0.289,0.209,0.385,0.367
			c0.098,0.156,0.145,0.361,0.145,0.615v2.24c0,0.166,0.012,0.291,0.031,0.369s0.086,0.117,0.199,0.117
			c0.062,0,0.139-0.014,0.223-0.043v0.559C224.671,59.592,224.497,59.627,224.275,59.627 M223.259,57.436
			c-0.146,0.029-0.303,0.055-0.463,0.074c-0.162,0.02-0.326,0.043-0.492,0.068c-0.166,0.023-0.312,0.064-0.443,0.121
			s-0.238,0.137-0.32,0.24c-0.084,0.104-0.123,0.246-0.123,0.426c0,0.117,0.023,0.219,0.072,0.299
			c0.049,0.082,0.109,0.146,0.188,0.197c0.076,0.051,0.168,0.088,0.271,0.109c0.107,0.023,0.213,0.033,0.322,0.033
			c0.238,0,0.443-0.029,0.613-0.094c0.17-0.066,0.311-0.148,0.42-0.246c0.105-0.098,0.188-0.205,0.236-0.322
			c0.053-0.113,0.078-0.223,0.078-0.322v-0.732C223.527,57.354,223.407,57.405,223.259,57.436"/>
		<path fill="#235F77" d="M227.558,55.182v0.631h-0.881v2.705c0,0.084,0.008,0.15,0.023,0.201c0.014,0.051,0.039,0.09,0.08,0.117
			c0.039,0.029,0.096,0.047,0.166,0.055c0.07,0.01,0.164,0.014,0.279,0.014h0.332v0.631h-0.555c-0.188,0-0.35-0.012-0.482-0.037
			c-0.135-0.027-0.244-0.072-0.324-0.139c-0.082-0.068-0.145-0.164-0.184-0.287s-0.061-0.287-0.061-0.488v-2.771H225.2v-0.631h0.752
			v-1.305h0.725v1.305H227.558z"/>
		<path fill="#235F77" d="M228.581,53.526h0.725v0.873h-0.725V53.526z M229.306,59.536h-0.725v-4.354h0.725V59.536z"/>
		<path fill="#235F77" d="M230.562,56.467c0.09-0.277,0.229-0.521,0.41-0.725c0.182-0.205,0.406-0.367,0.674-0.484
			s0.576-0.178,0.922-0.178c0.354,0,0.662,0.061,0.926,0.178c0.266,0.117,0.49,0.279,0.67,0.484c0.184,0.203,0.318,0.447,0.41,0.725
			s0.137,0.576,0.137,0.896s-0.045,0.617-0.137,0.891c-0.092,0.275-0.227,0.518-0.41,0.723c-0.18,0.203-0.404,0.363-0.67,0.479
			c-0.264,0.117-0.572,0.172-0.926,0.172c-0.346,0-0.654-0.055-0.922-0.172c-0.268-0.115-0.492-0.275-0.674-0.479
			c-0.182-0.205-0.32-0.447-0.41-0.723c-0.09-0.273-0.137-0.57-0.137-0.891S230.472,56.745,230.562,56.467 M231.3,58.065
			c0.072,0.205,0.17,0.379,0.295,0.516s0.271,0.24,0.441,0.314c0.166,0.074,0.346,0.109,0.531,0.109
			c0.188,0,0.367-0.035,0.533-0.109c0.168-0.074,0.314-0.178,0.441-0.314c0.125-0.137,0.223-0.311,0.293-0.516
			c0.072-0.205,0.109-0.438,0.109-0.701s-0.037-0.498-0.109-0.705c-0.07-0.205-0.168-0.375-0.293-0.516
			c-0.127-0.141-0.273-0.248-0.441-0.32c-0.166-0.074-0.346-0.109-0.533-0.109c-0.186,0-0.365,0.035-0.531,0.109
			c-0.17,0.072-0.316,0.18-0.441,0.32s-0.223,0.311-0.295,0.516c-0.07,0.207-0.107,0.441-0.107,0.705S231.23,57.86,231.3,58.065"/>
		<path fill="#235F77" d="M236.486,55.182v0.689h0.02c0.299-0.527,0.777-0.791,1.434-0.791c0.289,0,0.531,0.039,0.725,0.117
			c0.193,0.08,0.35,0.189,0.469,0.33c0.121,0.141,0.203,0.307,0.252,0.502c0.049,0.193,0.072,0.408,0.072,0.643v2.863h-0.725V56.59
			c0-0.271-0.08-0.484-0.24-0.643c-0.16-0.156-0.377-0.236-0.656-0.236c-0.221,0-0.414,0.035-0.576,0.102
			c-0.164,0.066-0.297,0.164-0.406,0.287c-0.107,0.123-0.188,0.268-0.244,0.434c-0.053,0.166-0.08,0.348-0.08,0.543v2.459h-0.725
			v-4.354H236.486z"/>
		<path fill="#235F77" d="M247.333,54.374c-0.311-0.213-0.68-0.32-1.105-0.32c-0.365,0-0.676,0.068-0.938,0.203
			c-0.256,0.135-0.471,0.316-0.639,0.545c-0.168,0.225-0.291,0.484-0.371,0.777c-0.08,0.291-0.119,0.596-0.119,0.908
			c0,0.344,0.039,0.668,0.119,0.973c0.08,0.307,0.203,0.572,0.371,0.801s0.383,0.408,0.646,0.541
			c0.26,0.137,0.574,0.203,0.938,0.203c0.268,0,0.506-0.043,0.713-0.129c0.209-0.086,0.387-0.209,0.537-0.363
			c0.152-0.154,0.27-0.338,0.354-0.551c0.088-0.215,0.139-0.443,0.154-0.691h0.812c-0.08,0.758-0.344,1.348-0.795,1.77
			c-0.449,0.422-1.064,0.631-1.844,0.631c-0.473,0-0.885-0.08-1.238-0.24c-0.352-0.158-0.646-0.379-0.881-0.66
			c-0.23-0.281-0.406-0.613-0.523-0.994c-0.117-0.383-0.174-0.791-0.174-1.23c0-0.436,0.062-0.848,0.188-1.232
			c0.123-0.385,0.309-0.721,0.551-1.006c0.24-0.287,0.543-0.512,0.904-0.678s0.775-0.248,1.242-0.248
			c0.318,0,0.619,0.041,0.904,0.125s0.539,0.207,0.76,0.371c0.223,0.162,0.408,0.365,0.557,0.609
			c0.146,0.244,0.242,0.527,0.289,0.846h-0.812C247.843,54.909,247.642,54.588,247.333,54.374"/>
		<path fill="#235F77" d="M249.825,56.467c0.09-0.277,0.227-0.521,0.408-0.725c0.184-0.205,0.408-0.367,0.676-0.484
			s0.574-0.178,0.922-0.178c0.352,0,0.66,0.061,0.926,0.178c0.264,0.117,0.488,0.279,0.668,0.484
			c0.184,0.203,0.32,0.447,0.412,0.725c0.09,0.277,0.137,0.576,0.137,0.896s-0.047,0.617-0.137,0.891
			c-0.092,0.275-0.229,0.518-0.412,0.723c-0.18,0.203-0.404,0.363-0.668,0.479c-0.266,0.117-0.574,0.172-0.926,0.172
			c-0.348,0-0.654-0.055-0.922-0.172c-0.268-0.115-0.492-0.275-0.676-0.479c-0.182-0.205-0.318-0.447-0.408-0.723
			c-0.092-0.273-0.139-0.57-0.139-0.891S249.734,56.745,249.825,56.467 M250.564,58.065c0.07,0.205,0.17,0.379,0.295,0.516
			c0.123,0.137,0.27,0.24,0.439,0.314c0.168,0.074,0.346,0.109,0.533,0.109c0.186,0,0.365-0.035,0.533-0.109
			s0.314-0.178,0.439-0.314s0.223-0.311,0.295-0.516c0.07-0.205,0.107-0.438,0.107-0.701s-0.037-0.498-0.107-0.705
			c-0.072-0.205-0.17-0.375-0.295-0.516s-0.271-0.248-0.439-0.32c-0.168-0.074-0.348-0.109-0.533-0.109
			c-0.188,0-0.365,0.035-0.533,0.109c-0.17,0.072-0.316,0.18-0.439,0.32c-0.125,0.141-0.225,0.311-0.295,0.516
			c-0.072,0.207-0.109,0.441-0.109,0.705S250.491,57.86,250.564,58.065"/>
		<path fill="#235F77" d="M255.747,55.182v0.641h0.02c0.33-0.494,0.805-0.742,1.424-0.742c0.273,0,0.521,0.057,0.744,0.17
			c0.223,0.111,0.377,0.301,0.467,0.572c0.15-0.236,0.344-0.42,0.588-0.549c0.24-0.127,0.508-0.193,0.797-0.193
			c0.223,0,0.422,0.023,0.602,0.072s0.334,0.121,0.461,0.225c0.129,0.1,0.229,0.229,0.299,0.389c0.072,0.16,0.107,0.354,0.107,0.578
			v3.191h-0.727v-2.854c0-0.137-0.01-0.262-0.033-0.379c-0.023-0.119-0.066-0.221-0.127-0.309c-0.064-0.088-0.15-0.156-0.262-0.207
			c-0.111-0.049-0.254-0.076-0.432-0.076c-0.357,0-0.641,0.102-0.846,0.305s-0.307,0.471-0.307,0.809v2.711h-0.725v-2.854
			c0-0.143-0.014-0.271-0.039-0.389s-0.07-0.221-0.133-0.307c-0.062-0.088-0.146-0.154-0.252-0.201
			c-0.104-0.049-0.24-0.074-0.404-0.074c-0.211,0-0.393,0.043-0.543,0.127c-0.15,0.086-0.271,0.186-0.367,0.305
			c-0.094,0.117-0.162,0.238-0.203,0.365c-0.045,0.127-0.064,0.232-0.064,0.316v2.711h-0.727v-4.354H255.747z"/>
		<path fill="#235F77" d="M263.255,55.182v0.641h0.016c0.33-0.494,0.807-0.742,1.426-0.742c0.273,0,0.521,0.057,0.744,0.17
			c0.221,0.111,0.379,0.301,0.469,0.572c0.148-0.236,0.344-0.42,0.584-0.549c0.244-0.127,0.51-0.193,0.799-0.193
			c0.223,0,0.424,0.023,0.604,0.072s0.332,0.121,0.461,0.225c0.127,0.1,0.227,0.229,0.299,0.389c0.07,0.16,0.105,0.354,0.105,0.578
			v3.191h-0.725v-2.854c0-0.137-0.014-0.262-0.035-0.379c-0.021-0.119-0.066-0.221-0.127-0.309c-0.062-0.088-0.15-0.156-0.262-0.207
			c-0.111-0.049-0.254-0.076-0.43-0.076c-0.359,0-0.641,0.102-0.846,0.305s-0.307,0.471-0.307,0.809v2.711h-0.727v-2.854
			c0-0.143-0.014-0.271-0.039-0.389c-0.023-0.117-0.07-0.221-0.131-0.307c-0.064-0.088-0.146-0.154-0.252-0.201
			c-0.107-0.049-0.24-0.074-0.406-0.074c-0.211,0-0.391,0.043-0.543,0.127c-0.15,0.086-0.273,0.186-0.365,0.305
			c-0.096,0.117-0.164,0.238-0.205,0.365c-0.043,0.127-0.064,0.232-0.064,0.316v2.711h-0.727v-4.354H263.255z"/>
		<path fill="#235F77" d="M270.101,53.526h0.727v0.873h-0.727V53.526z M270.827,59.536h-0.727v-4.354h0.727V59.536z"/>
		<path fill="#235F77" d="M274.06,55.182v0.631h-0.877v2.705c0,0.084,0.008,0.15,0.02,0.201c0.016,0.051,0.043,0.09,0.082,0.117
			c0.039,0.029,0.094,0.047,0.166,0.055c0.072,0.01,0.164,0.014,0.277,0.014h0.332v0.631h-0.553c-0.189,0-0.35-0.012-0.484-0.037
			c-0.133-0.027-0.24-0.072-0.324-0.139c-0.082-0.068-0.145-0.164-0.182-0.287c-0.041-0.123-0.061-0.287-0.061-0.488v-2.771h-0.75
			v-0.631h0.75v-1.305h0.727v1.305H274.06z"/>
		<path fill="#235F77" d="M277.132,55.182v0.631h-0.881v2.705c0,0.084,0.008,0.15,0.021,0.201s0.041,0.09,0.08,0.117
			c0.041,0.029,0.096,0.047,0.168,0.055c0.07,0.01,0.164,0.014,0.277,0.014h0.334v0.631h-0.557c-0.188,0-0.35-0.012-0.482-0.037
			c-0.133-0.027-0.24-0.072-0.324-0.139c-0.082-0.068-0.143-0.164-0.184-0.287c-0.039-0.123-0.061-0.287-0.061-0.488v-2.771h-0.75
			v-0.631h0.75v-1.305h0.727v1.305H277.132z"/>
		<path fill="#235F77" d="M281.134,59.256c-0.328,0.25-0.744,0.373-1.246,0.373c-0.352,0-0.658-0.057-0.918-0.168
			c-0.258-0.113-0.477-0.271-0.652-0.473c-0.178-0.203-0.309-0.441-0.396-0.725c-0.088-0.281-0.137-0.586-0.148-0.918
			c0-0.332,0.049-0.635,0.152-0.908c0.102-0.277,0.246-0.514,0.432-0.717s0.404-0.359,0.658-0.471
			c0.252-0.113,0.529-0.17,0.832-0.17c0.391,0,0.717,0.082,0.977,0.242s0.467,0.361,0.623,0.609
			c0.158,0.248,0.264,0.516,0.324,0.809c0.061,0.291,0.084,0.568,0.072,0.832h-3.303c-0.006,0.191,0.016,0.373,0.068,0.545
			c0.051,0.17,0.133,0.322,0.246,0.453c0.115,0.133,0.262,0.238,0.436,0.318c0.178,0.076,0.385,0.115,0.625,0.115
			c0.307,0,0.557-0.068,0.756-0.209c0.195-0.141,0.324-0.354,0.389-0.641h0.715C281.677,58.643,281.464,59.01,281.134,59.256
			 M280.96,56.461c-0.064-0.15-0.154-0.281-0.266-0.391c-0.109-0.109-0.24-0.197-0.391-0.262c-0.152-0.062-0.318-0.098-0.5-0.098
			c-0.188,0-0.359,0.035-0.508,0.098c-0.15,0.064-0.281,0.154-0.389,0.266s-0.195,0.242-0.258,0.393
			c-0.062,0.146-0.098,0.307-0.109,0.475h2.535C281.064,56.774,281.027,56.614,280.96,56.461"/>
		<path fill="#235F77" d="M286.013,59.256c-0.332,0.25-0.746,0.373-1.248,0.373c-0.352,0-0.658-0.057-0.918-0.168
			c-0.26-0.113-0.477-0.271-0.652-0.473c-0.178-0.203-0.309-0.441-0.396-0.725c-0.088-0.281-0.137-0.586-0.15-0.918
			c0-0.332,0.051-0.635,0.154-0.908c0.102-0.277,0.246-0.514,0.432-0.717c0.184-0.203,0.404-0.359,0.656-0.471
			c0.254-0.113,0.531-0.17,0.832-0.17c0.395,0,0.719,0.082,0.979,0.242c0.258,0.16,0.467,0.361,0.623,0.609s0.264,0.516,0.324,0.809
			c0.061,0.291,0.084,0.568,0.072,0.832h-3.303c-0.006,0.191,0.018,0.373,0.068,0.545c0.049,0.17,0.133,0.322,0.246,0.453
			c0.113,0.133,0.26,0.238,0.436,0.318c0.178,0.076,0.385,0.115,0.623,0.115c0.307,0,0.559-0.068,0.758-0.209
			c0.195-0.141,0.324-0.354,0.387-0.641h0.717C286.554,58.643,286.341,59.01,286.013,59.256 M285.837,56.461
			c-0.064-0.15-0.152-0.281-0.266-0.391c-0.109-0.109-0.24-0.197-0.393-0.262c-0.15-0.062-0.316-0.098-0.498-0.098
			c-0.189,0-0.359,0.035-0.51,0.098c-0.15,0.064-0.279,0.154-0.389,0.266c-0.107,0.111-0.191,0.242-0.256,0.393
			c-0.062,0.146-0.1,0.307-0.109,0.475h2.535C285.941,56.774,285.904,56.614,285.837,56.461"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#53A842" d="M256.648,45.948c-12.113,6.756-26.848,1.516-28.209-10.674
			c-1.316-11.812,6.26-20.322,18.363-19.475c3.973,0.277,8.971,1.606,9.578,4.801c0.531,2.797-0.959,3.967-2.395,5.336
			c-1.641-0.111-2.582-1.758-4.26-2.4c-8.486-3.268-15.742,4.389-12.771,12.805c1.957,5.547,10.436,7.119,15.967,3.738
			C254.667,41.53,255.456,43.938,256.648,45.948 M283.027,40.079c-5.529,3.381-14.01,1.809-15.965-3.738
			c-2.971-8.416,4.283-16.072,12.771-12.805c1.676,0.643,2.615,2.289,4.258,2.4c1.438-1.369,2.928-2.539,2.396-5.336
			c-0.607-3.195-5.607-4.524-9.58-4.801c-12.104-0.847-19.68,7.663-18.361,19.475c1.359,12.189,16.096,17.43,28.205,10.674
			C285.564,43.938,284.775,41.53,283.027,40.079 M215.687,16.929c-0.369,4.732,0.793,11.648,0.227,16.55
			c-1.664-2.471-3.621-5.787-5.717-8.828c-1.674-2.432-3.99-7.377-6.359-8.495c-2.033-0.959-6.08-0.343-6.887,1.288
			c-0.723,1.457-0.266,4.443-0.266,6.949v24.164h7.795V30.405c4.504,5.922,8.135,11.943,12.34,18.152h7.154V16.414
			C222.042,15.322,217.021,15.36,215.687,16.929 M192.163,16.201h-2.484v0.013h-13.27c-1.076,1.798-1.043,5.783,0.488,7.048h7.215
			c0.043,5.279,1.131,13.754,0.133,16.311c-1.764,4.518-11.486,1.752-13.057-2.166c-1.93,1.264-3.881,2.885-5.102,4.84
			c3.602,6.25,17.383,10.143,24.023,2.164c2.031-2.439,2.166-6.012,2.068-9.795L192.163,16.201z"/>
	</g>
	<g>
		<defs>
			<path id="SVGID_3_" d="M134.865,21.7c0,8.988,7.287,16.273,16.273,16.273s16.273-7.285,16.273-16.273
				c0-8.987-7.287-16.275-16.273-16.275S134.865,12.713,134.865,21.7"/>
		</defs>
		<clipPath id="SVGID_4_">
			<use xlink:href="#SVGID_3_"  overflow="visible"/>
		</clipPath>
		
			<radialGradient id="SVGID_5_" cx="-176.1628" cy="443.4683" r="0.7655" gradientTransform="matrix(10.5714 10.5714 10.5714 -10.5714 -2676.6809 6569.4365)" gradientUnits="userSpaceOnUse">
			<stop  offset="0" style="stop-color:#5A869C"/>
			<stop  offset="0.287" style="stop-color:#56839A"/>
			<stop  offset="0.5476" style="stop-color:#4B7B92"/>
			<stop  offset="0.7971" style="stop-color:#396E85"/>
			<stop  offset="1" style="stop-color:#245F77"/>
		</radialGradient>
		<polygon clip-path="url(#SVGID_4_)" fill="url(#SVGID_5_)" points="151.138,-10.848 183.685,21.7 151.138,54.247 118.593,21.7 		
			"/>
	</g>
	<g>
		<defs>
			<path id="SVGID_6_" d="M141.208,32.172c2.039,1.398,4.553,1.211,7.064,2.99c-0.025,0.086-0.039,0.174-0.039,0.262
				c0,0.9,1.283,1.631,2.869,1.631c1.582,0,2.867-0.73,2.867-1.631s-1.285-1.633-2.867-1.633c-1.285,0-2.371,0.092-2.738,0.752
				c-0.34-0.287-0.732-0.549-1.078-0.627c-1.508-3.982,0.996-7.262-1.396-10.182c-1.627-1.986-4.627-1.523-6.666-3.5
				C138.341,24.145,136.745,29.12,141.208,32.172 M155.495,13.374c0.967,1.992-1.316,4.099-1.451,4.367
				c-0.133,0.26,1.371-0.268,2.121-0.49c0.754-0.226,1.344-1.547,2.014-2.073c0.674-0.527,1.348-0.216,2.178,1.018
				c0.857,1.278,0.562,3.084,0.162,4.028c-0.885,2.062-2.123,3.277-2.418,3.461c-0.297,0.189-0.35,0.15-0.35-0.074
				c0-0.227,0.451-1.496,0.484-1.883c0.025-0.338-1.102,0.668-1.451,1.127c-0.457,0.607-0.672,2.488-0.672,2.488
				s-0.457,0.379-0.779,0.639c-0.322,0.266-0.965,1.205-1.449,1.586c-0.482,0.371-1.826,1.275-2.014,1.689
				c-0.189,0.416,0.402,0.15,0.535,0.34c0.133,0.191-0.643,0.715-0.322,1.055c0.322,0.34,2.723,1.32,5.453,0.754
				c1.639-0.342,2.711-1.205,3.195-1.584c0.482-0.375,0.377,0.039,2.338-0.75c1.959-0.791,2.629-2.785,2.951-4.031
				c0.322-1.242,0.189-1.393,0.029-0.939c-0.162,0.453-1.666,1.467-1.881,1.43c-0.213-0.037-0.27-0.301,0.592-3.99
				c0.859-3.689-2.15-7.153-3.684-7.793c-1.529-0.641-2.33-1.164-3.031-2.182c-0.697-1.015-3.088-1.281-4.162-1.432
				c-0.055-0.007-0.1-0.011-0.141-0.011C152.978,10.122,154.575,11.476,155.495,13.374 M141.646,14.118
				c-1.334-0.14-2.131-1.981-3.451-0.776c1.514,6.6,8.994,5.909,12.869,9.434c1.279-1.547,0.229-3.9-0.488-4.965
				c-1.162-0.094-2.326-0.191-3.488-0.287c0.209-4.02,5.656-8.197,6.992-10.752c-0.438-0.137-0.916-0.202-1.428-0.202
				C148.878,6.569,143.464,10.105,141.646,14.118"/>
		</defs>
		<clipPath id="SVGID_7_">
			<use xlink:href="#SVGID_6_"  overflow="visible"/>
		</clipPath>
		
			<radialGradient id="SVGID_8_" cx="-204.9905" cy="473.353" r="0.7654" gradientTransform="matrix(-11.9053 -13.6837 -13.6837 11.9053 4187.6543 -8418.3789)" gradientUnits="userSpaceOnUse">
			<stop  offset="0" style="stop-color:#D1E02B"/>
			<stop  offset="0.2574" style="stop-color:#D1E02B"/>
			<stop  offset="0.381" style="stop-color:#C6DA2D"/>
			<stop  offset="0.601" style="stop-color:#A7CA31"/>
			<stop  offset="0.8897" style="stop-color:#76B039"/>
			<stop  offset="0.9939" style="stop-color:#63A63C"/>
			<stop  offset="1" style="stop-color:#63A63C"/>
		</radialGradient>
		<polygon clip-path="url(#SVGID_7_)" fill="url(#SVGID_8_)" points="149.497,51.711 121.652,19.704 153.593,-8.087 181.441,23.92 
					"/>
	</g>
</g>
</svg>
');
