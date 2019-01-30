-- email constants
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_REQUEST_SUBJECT', 'en', 'AERIUS - Wachtwoord reset verzoek');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_REQUEST_BODY', 'en', '<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p><p style="font-family:Arial;font-size:14px;">Er is op de website aangegeven dat u uw wachtwoord verloren hebt.</p><p style="font-family:Arial;font-size:14px;">Klik op de volgende link om uw wachtwoord te resetten, u ontvangt vervolgens een mailtje met daarin een nieuw wachtwoord.</p><p style="font-family:Arial;font-size:14px;">[PASSWORD_RESET_URL]</p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_CONFIRM_SUBJECT', 'en', 'AERIUS - Wachtwoord reset bevestiging');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PASSWORD_RESET_CONFIRM_BODY', 'en', '<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p><p style="font-family:Arial;font-size:14px;">Uw wachtwoord is gereset.</p><p style="font-family:Arial;font-size:14px;">Uw nieuwe wachtwoord is: <b>[PASSWORD_RESET_PLAIN_TEXT_NEW]</b></p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CONNECT_APIKEY_CONFIRM_SUBJECT', 'en', 'Uw AERIUS Connect API key');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CONNECT_APIKEY_CONFIRM_BODY', 'en', 
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een API key aangevraagd voor AERIUS Connect.
De API key is gegenereerd en kan direct worden gebruikt om toegang te krijgen tot de Connect services.</p>
<p style="font-family:Arial;font-size:14px;">Uw API key is: <b>[CONNECT_APIKEY]</b></p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MAIL_CONTENT_TEMPLATE', 'en',
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
	<img alt="Ministerie van Economische Zaken" height="51" src="data:image/gif;base64,R0lGODlhNwIzAMQAAPf39+Li5YeZtBM8b9bX1+/v75aWlsHL2G2Dpai1yTxbhp6rwtfa34uLiypKewAxZbbA0VZvlufn53Nzc9/f38XFxX9/f87OzqCgoL29vbS0tKqqqldwlrXB0djb3////yH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChNYWNpbnRvc2gpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjcxRUVDODkwN0NFMjExRTI4QTU3RjZCRERERTM2NDJEIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjcxRUVDODkxN0NFMjExRTI4QTU3RjZCRERERTM2NDJEIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NzFFRUM4OEU3Q0UyMTFFMjhBNTdGNkJERERFMzY0MkQiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NzFFRUM4OEY3Q0UyMTFFMjhBNTdGNkJERERFMzY0MkQiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4B//79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQz87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGgn56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFwb25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFAPz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQDw4NDAsKCQgHBgUEAwIBAAAh+QQAAAAAACwAAAAANwIzAAAF/+AnjmRpnmiqrmzrvnAsz3Rtv0Ou73zv57egcEgsGo/IpHLJbDqfUNVvStVFr9isdsvter9gbHXsC5vP6LR6zW6LyXCge06v2+/4fDEe1/v/gIGCg1F8cISIiYqLjIGGZI2RkpOUlU2PY5aam5ydnphVnqKjpKV5oFSmqqusrW+oZa6ys7S1MLA/trq7vLK4sb3BwsOUvz3EyMnKgMY8y8/Q0WnNO9LW19hQ1FbZ3d7fNtty4OTl5iXiA+fr7N7p7fDxz3EOh/L3+LxkDwoI9vkAA7LaF0GAgweZBCpUAYBAFgIAblCYICHGxIoyKlhIVoUfgo8fE7aAaIJki4ZoTP+WuGiR4kIRGTJ8mDhhgoWaDS580DCBAk8KEytIaDBB5gcCBrIYcDgiQwEZPaFSmDERhVNbVTgIQBABgVYBClKZmLjhAwALGD4sNbFWBAANKZDaqFBzI5G2JqKeoFszKQm9Cs/a7Qm0J4GNVat+6GkBYgURGj9kKOoWg4ULADBMuDDRwIS0Ii40sNCggmbOExpsGGpBAuucFCcbuFCTtmrWEjJf1mihwmG9vDF4Tqv7Am+6h59azoxBMwYAwUdMRGv2NO3NtaooECBggYAEWutNQVETAO0KFzUSRR97ggGemy9YyDBRdWT5Rpc3dw7dAnURVT3GGgEbfCZBfRMIOBr/ap5tsN5Fsn3A2nQJfoCfCAS41hNfMk2QXHHqVdhOBRk04FBNEyxGQQUNzJSiYj1lMF9ELk5E4wcbVCCfBhUUQFFPAETlYwGH8eijBB5S0AAF8uV0mIoT0BhVkkvKl6N8ExUgQWt62QhkT1dakCWS72EYJQacqejlVC4G6VOPP7JJSw/i6SCAawFIwEAECOVQJzcr2XTBBgakRViKBKTYU5QuisAlkgQU9sGjR52Z5qFuAlhTWmJm9phpKiY6aWFuiirqojR2iiQFolIqAgZwTXVqmWFWJWo7RE0A14aL2RRRYimqeFQDoFXF02O92oRinMIiaV6uNa1Kk02NiaYi/0+GTnVoXSiK+aKibFY15bTeilDeCA1o0KJohwrb6KIoroqVDg9E0EEHHOTwgAMQJLBABws80CcCBySgQJ/qjPWeAb1lC+y1nwEbbVQTTYtRuusSJWmXKbJn7lTiFgZjxQ/3hK1iasLr0gcaRSRBgYoy2u3D7BDQYqJuSpAoUrGmiGQBBVgA3bCaAqBzsKWJkPTH7nrWwFDIqnikCDw9vViGbo479QdLVzUkx8L21HWwuoLG8mbOtgu22FEDNssODyzwAQMI1BOBAgVt5RUH/AjwFAIIn0AABkhmUEFS7YqL9aIfDMl0lhM8NQJdF6S9cbgpXuAjBUF+WhamFFGwUf/iii5OG+fSRh75CEHrpG6kimqQ1tiNsrMcXXwlOMEGABhQAV1TTWaiWu5hVKBol4kwVFHLY5Aoe8gyKiFRzn9m4U0y0hgUUTJpcJn18jHPPe6SWdAW5QkGtbzh6SeogQERFUAcwyaij6z9zb+V/JwDCPyAQx1QgAIS4IF7FeAAEGBAAAgAlggE4AMC8F/CSqCZAhhAApoJCvCAlyDu9S4+n0lUWgrEpM/QSH5moR8B7AeZulzvaZrhXVBO16QDJeh0HGQRZZqEOxqaUDIowoBsYFOB961vg257iRNyZQHJpYCJTlRiEnLAgbsJAAAN2coCKCCAAAiwAwzQogcAUID/CFQxLFJMYxAAUKD5rICNNjGKGpGQAwQIgAMK6AAAAhBBBAAAYA4QwAEIcLAEFAAAYLEjGufIyEbqQQcOwCMCEnCAC3DHAwvgSr8IgIAFBKBfd6uTI0dJSjfo4G4RKEAAvLKAAnSgO9tZwB7B4jdCRkA8pZSGSkawS4YwxQy91BRGXsCSeOjAKwkAwALAM4AEfCABioTAB/wxSWcqchy57AVZzEIdvIwAL2+Ji19owBe7DMGbf5FTCXI3TqYZMwfbmSUDCsABBEAwmdwpwHY+AIEr0g1Q2exFec6THtK0TwKygc8F8FOfHG3kQh/QT3NMGB1NsWx6jSkQ4RCkoMt0/2Z3D2pPUiakrMdANEOr4tDVmggig0YtG/oagN8YIEB65jEABYAAAQApAA88AAE6Cws2A6qL6QyqUCmrFJR+FaxHJakqlMIZmrRFKo5Zr1MY+FS2WlVVViEKXNJTlWFS5KqIxkqp7oFLrb76DX0pQAICgCcE8PWAnoJSpgdYwEEccIC4DpWotaDAwhqW1JCd7FsTA5nKLqYuC2ksZBb1mLBCVjGykexbEMMAyg5lMcgITUIw61VEZoZZd/SPA1wUTyDzNYCCHMwBIelfHv06QcDaYnCFO1xhS5cbxjlusqqLIuUsB9lGae5LnktZkA40OkkprrenM9qhftu45L1OXNuy4xqyaNYNt/7rYHWFwAEY4AECjNcDHjhABwD3AA4cwB9/ta0sKnjBDCYIidsrygcXGkLrkZA2zxEBCntHmhVuRkTlfCEGdweAGfakhg5e0aJ0KBMe3vDBP5zMpoZ4HiOOb0NJtMYOApnJCBwAvQdIsYoHicmCMBOg8o2xjIdALwUcAKcppi0PHEBJAqgyAdWYsZCHTIMdOyCSXEEYDz6igHr8ichQjjILfiAwKlQZGFLOspbfoeUuS5nLXg6zkMEs5jLblsxmTnMu0azmNjeSzW6OsxThLGdAhAAAOw==" width="567" /></div>
	<div class="tpl-content-highlight" style="width:560px;padding:40px 20px 0"><p style="font-family:Arial;font-size:12px;color:#6e6e6e">Aan de verstrekte gegevens kunnen geen rechten worden ontleend. De eigenaar van AERIUS aanvaardt geen aansprakelijkheid voor de inhoud van de door de gebruiker aangeboden informatie. Bovenstaande gegevens zijn enkel bruikbaar tot er een nieuwe versie van AERIUS beschikbaar is. AERIUS is een geregistreerd handelsmerk in Europa. Alle rechten die niet expliciet worden verleend, zijn voorbehouden.</p>
	</div>
    </td></tr></table>
</body>
</html>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MAIL_SUBJECT_TEMPLATE', 'en', '[MAIL_SUBJECT]'); -- for now just the subject itself, we just want to provide the option to change the template

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MAIL_SIGNATURE_DEFAULT', 'en', 'Het AERIUS team');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('ERROR_MAIL_SUBJECT', 'en', 'Melding van AERIUS betreffende uw aangevraagde bestand');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('ERROR_MAIL_CONTENT', 'en',
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
INSERT INTO i18n.messages (key, language_code, message) VALUES ('DEFAULT_FILE_MAIL_SUBJECT', 'en', 'Uw AERIUS aangevraagde bestand');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('DEFAULT_FILE_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een export in AERIUS gestart. Deze export is klaar en u kunt het bestand tot uiterlijk 3 dagen na het starten van de export ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de export of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/monitor">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met onze helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');

-- email for PAA (PDF Export)
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_DEVELOPMENT_SPACES_MAIL_SUBJECT', 'en', 'Uw AERIUS bijlage voor benodigde ontwikkelingsruimte: [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_DEMAND_MAIL_SUBJECT', 'en', 'Uw AERIUS bijlage voor bepaling projecteffect: [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">AERIUS Calculator kan worden gebruikt voor het berekenen van de stikstofeffecten van projecten en plannen. Bij het gebruik van uw resultaten is het van belang kennis te nemen van het actuele <a href="https://www.aerius.nl/nl/over-aerius/producten/calculator">toepassingsbereik</a> (de bronnen waarvoor kan worden gerekend) van de Calculator.</p>
<p style="font-family:Arial;font-size:14px;">U kunt de pdf importeren in AERIUS om verder te rekenen of om uw bronnen aan te passen.</p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met de helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_OWN_USE_MAIL_SUBJECT', 'en', 'Uw AERIUS berekening voor eigen gebruik: [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('PAA_OWN_USE_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">AERIUS Calculator kan worden gebruikt voor het berekenen van de stikstofeffecten van projecten en plannen. Bij het gebruik van uw resultaten is het van belang kennis te nemen van het actuele <a href="https://www.aerius.nl/nl/over-aerius/producten/calculator">toepassingsbereik</a> (de bronnen waarvoor kan worden gerekend) van de Calculator.</p>
<p style="font-family:Arial;font-size:14px;">U kunt de pdf importeren in AERIUS om verder te rekenen of om uw bronnen aan te passen.</p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met de helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');

-- email for CSV
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CSV_MAIL_SUBJECT', 'en', 'Uw AERIUS aangevraagde bestand [AERIUS_REFERENCE]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CSV_MAIL_SUBJECT_JOB', 'en', 'Uw AERIUS aangevraagde berekening [JOB] ([AERIUS_REFERENCE])');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('CSV_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het CSV-bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met onze helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');

-- email for GML (uses default subject)
INSERT INTO i18n.messages (key, language_code, message) VALUES ('GML_MAIL_SUBJECT', 'en', 'Uw AERIUS aangevraagde bestand [AERIUS_REFERENCE]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('GML_MAIL_SUBJECT_JOB', 'en', 'Uw AERIUS aangevraagde berekening [JOB] ([AERIUS_REFERENCE])');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('GML_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een berekening in AERIUS gestart. Deze berekening is klaar en u kunt het GML-bestand tot uiterlijk 3 dagen na het starten van de berekening ophalen.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het GML-bestand kunt u gebruiken om de bronnen en resultaten van uw AERIUS berekening te importeren in andere geodata systemen. Daarnaast kunt u het bestand importeren in AERIUS om verder te rekenen of om uw bronnen aan te passen.</p>
<p style="font-family:Arial;font-size:14px;">Heeft u nog vragen, naar aanleiding van de berekening of over AERIUS, bekijk dan eerst de <a href="http://www.aerius.nl/nl/manuals/calculator">handleiding</a> of onze website <a href="http://www.aerius.nl">AERIUS.nl</a>. Uiteraard kunt u ook contact opnemen met onze helpdesk: <a href="http://pas.bij12.nl/content/helpdesk">pas.bij12.nl/content/helpdesk</a>.</p>');


-- Melding mails
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REGISTERED_USER_MAIL_SUBJECT', 'en', 'Meldingsbericht, kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REGISTERED_USER_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 2.7 van de Regeling natuurbescherming een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur.</p>
<p style="font-family:Arial;font-size:14px;">Uw melding is geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">Het bijbehorende document kan u tot uiterlijk 3 dagen na ontvangst van dit bericht downloaden.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het AERIUS kenmerk van uw melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REGISTERED_USER_MAIL_WITH_ATTACHMENTS_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 2.7 van de Regeling natuurbescherming een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur.</p>
<p style="font-family:Arial;font-size:14px;">Uw melding is geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">Het bijbehorende document kan u tot uiterlijk 3 dagen na ontvangst van dit bericht downloaden.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het AERIUS kenmerk van uw melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Dit is een overzicht van de door u meegezonden bijlagen.</p>
<p style="font-family:Arial;font-size:14px;">[MELDING_ATTACHMENTS_RESULT_LIST]</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_USER_MAIL_SUBJECT', 'en', 'Ingediende melding niet geregistreerd');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_USER_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 2.7 van de Regeling natuurbescherming een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] met het AERIUS kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Uw melding kan niet worden geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">[TECHNICAL_REASON_NOT_REGISTERED_MELDING]</p>
<p style="font-family:Arial;font-size:14px;">In de bijlage vindt u een bestand (gml formaat) behorend bij uw berekening in AERIUS Calculator. Deze kan u rechtstreeks in AERIUS Calculator importeren zodat u, indien gewenst, de eerder ingevoerde informatie opnieuw kan gebruiken.</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_USER_MAIL_ATTACHMENTSLIST_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">U heeft op grond van artikel 2.7 van de Regeling natuurbescherming een melding ingediend voor uw initiatief, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] met het AERIUS kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Uw melding kan niet worden geregistreerd.</p>
<p style="font-family:Arial;font-size:14px;">[TECHNICAL_REASON_NOT_REGISTERED_MELDING]</p>
<p style="font-family:Arial;font-size:14px;">Dit is een overzicht van de door u meegezonden bijlagen.</p>
<p style="font-family:Arial;font-size:14px;">[MELDING_ATTACHMENTS_RESULT_LIST]</p>
<p style="font-family:Arial;font-size:14px;">In de bijlage vindt u een bestand (gml formaat) behorend bij uw berekening in AERIUS Calculator. Deze kan u rechtstreeks in AERIUS Calculator importeren zodat u, indien gewenst, de eerder ingevoerde informatie opnieuw kan gebruiken.</p>
<p style="font-family:Arial;font-size:14px;">Voor inhoudelijke vragen betreffende de meldingsplicht en / of de vergunningplicht kunt u contact opnemen met het bevoegd gezag, voor meer toelichting verwijzen we u naar de website <a href="http://pas.bij12.nl">pas.bij12.nl</a>.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_TECHNICAL_ISSUE_USER_MAIL_SUBJECT', 'en', 'Ingediende melding niet geregistreerd');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_TECHNICAL_REASON', 'en', 'Reden hiervoor is omdat [REASON_NOT_REGISTERED_MELDING]');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_AUTHORITY_MAIL_SUBJECT', 'en', '[AUTHORITY] Meldingsbericht niet geregistreerd, kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_NOT_REGISTERED_AUTHORITY_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw van [AUTHORITY],</p>
<p style="font-family:Arial;font-size:14px;">Er is op grond van artikel 2.7 van de Regeling natuurbescherming, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] een melding gedaan via het instrument AERIUS..</p>
<p style="font-family:Arial;font-size:14px;">Bij deze ontvangt u als Bevoegd Gezag [AUTHORITY] een bericht over de niet geregistreerde melding. De melding is niet geregistreerd omdat, [REASON_NOT_REGISTERED_MELDING]</p>
<p style="font-family:Arial;font-size:14px;">In de bijlage vindt u een bestand (gml formaat) behorend bij uw berekening in AERIUS Calculator. Deze kan u rechtstreeks in AERIUS Calculator importeren zodat u, indien gewenst, de eerder ingevoerde informatie opnieuw kan gebruiken.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_AUTHORITY_MAIL_SUBJECT', 'en', '[AUTHORITY] Meldingsbericht, kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_AUTHORITY_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Er is op grond van artikel 2.7 van de Regeling natuurbescherming, op [CALC_CREATION_DATE] om [CALC_CREATION_TIME] uur een melding gedaan via AERIUS. Bij deze ontvangt u als Bevoegd Gezag [AUTHORITY] een bericht van deze melding.</p>
<p style="font-family:Arial;font-size:14px;">Het bijbehorende document kan u tot uiterlijk 3 dagen na ontvangst van dit bericht downloaden.</p>
<div style="text-align:center"><a href="[DOWNLOAD_LINK]" style="display:inline-block;font-family:Arial;font-size:14px;background:linear-gradient(#DBE1E1, #B8C6C5) repeat scroll 0 0 transparent;width:auto;padding:10px 40px 0px;border:1px solid #4c4c4c; -moz-border-radius: 2px;border-radius:2px;box-shadow: 0 1px 0 #FFFFFF inset;color: #333333;height: 33px;text-align: center;text-shadow: 0 1px 0 white;text-decoration:none;font-weight:bold">Bestand ophalen</a></div>
<p style="font-family:Arial;font-size:14px;">Het betreffende AERIUS kenmerk van de melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DELETE_AUTHORITY_MAIL_SUBJECT', 'en', '[AUTHORITY] Meldingsbericht, verwijdering van kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DELETE_AUTHORITY_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Hierbij melden we u dat de melding is verwijderd.</p>
<p style="font-family:Arial;font-size:14px;">Het betreffende AERIUS kenmerk van de melding is [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">Ontvangst van de melding op [MELDING_CREATE_DATE].</p>
<p style="font-family:Arial;font-size:14px;">Verwijdering van de melding op [MELDING_REMOVE_DATE].</p>
<p style="font-family:Arial;font-size:14px;">De melding is verwijderd door [MELDING_REMOVED_BY].</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_MAIL_SUBJECT', 'en', '[AUTHORITY] Bijlage(n) bij de melding met AERIUS Kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME], [DOCUMENT_MAIL_NR] van [MAX_DOCUMENT_MAIL_NR]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Dit zijn de bijlagen behorende bij de Melding met AERIUS Kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">[MAIL_SUBSTANTIATION]</p>
<p style="font-family:Arial;font-size:14px;"> Deze bijlagen horen bij de melding met AERIUS kenmerk [AERIUS_REFERENCE], gedaan op [CALC_CREATION_DATE] om [CALC_CREATION_TIME]</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_MAIL_SUBSTANTIATION', 'en', 'Eigen opmerkingen door melder bij de onderbouwing referentiesituatie: [MELDING_SUBSTANTIATION]');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_STATUS_MAIL_SUBJECT', 'en', '[AUTHORITY] Overzicht verzonden bijlage voor AERIUS Kenmerk [AERIUS_REFERENCE] bedrijfsnaam [PROJECT_NAME]');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOCUMENTS_AUTHORITY_STATUS_MAIL_CONTENT', 'en',
E'<p style="font-family:Arial;font-size:14px;">Geachte heer/mevrouw,</p>
<p style="font-family:Arial;font-size:14px;">Dit is een overzicht van de verzonden bijlage voor melding met AERIUS Kenmerk [AERIUS_REFERENCE].</p>
<p style="font-family:Arial;font-size:14px;">[MELDING_ATTACHMENTS_RESULT_LIST]</p>
<p style="font-family:Arial;font-size:14px;"> Deze bijlagen horen bij de melding met AERIUS kenmerk [AERIUS_REFERENCE], gedaan op [CALC_CREATION_DATE] om [CALC_CREATION_TIME]</p>
<p style="font-family:Arial;font-size:14px;">Alle meldingen zijn te bekijken via AERIUS Register.</p>');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ATTACHMENTS_SEND_STATUS_OK', 'en', 'Verzonden');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ATTACHMENTS_SEND_STATUS_FAIL', 'en', 'Fout bij verzenden');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ATTACHMENTS_FROM', 'en', 'van');

INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_DOES_NOT_FIT', 'en', 'de melding van uw initiatief is afgewezen, omdat de projectbijdrage van uw initiatief groter is dan de beschikbare depositieruimte.');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_ABOVE_PERMIT_THRESHOLD', 'en', 'de grenswaarde van rechtswege is verlaagd naar 0.05 mol/ ha/j. Dit betekent dat er alsnog sprake is van een vergunningplicht voor uw initiatief.');    
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_TECHNICAL_ISSUES', 'en', 'er als gevolg van een technische storing geen berekening is ontvangen. U kunt opnieuw een melding indienen, onze excuses voor het ongemak.');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('MELDING_REJECT_REASON_OTHER', 'en', 'Overige fout conditie.');

-- Splash
INSERT INTO i18n.messages (key, language_code, message) VALUES ('SPLASH_ATTRIBUTION_TEXT', 'en', 'Development of AERIUS is commissioned by the Dutch government.');
INSERT INTO i18n.messages (key, language_code, message) VALUES ('SPLASH_ATTRIBUTION_IMAGE', 'en', '
<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 16.0.4, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 width="535.507px" height="261.18px" viewBox="0 0 535.507 261.18" enable-background="new 0 0 535.507 261.18"
	 xml:space="preserve">
<g>
	<g>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M2.505,9.121c0.394-0.492,0.894-0.796,1.298-0.796
			c1.1,0,1.593,0.904,1.593,2.695c0,1.502-0.493,2.299-1.495,2.299c-0.599,0-1.101-0.296-1.396-0.797V9.121L2.505,9.121L2.505,9.121
			z M6.898,10.723c0-1.995-0.895-2.997-2.702-2.997c-0.698,0-1.199,0.196-1.691,0.697V7.824H0.207v0.599h0.993v8.099H0.207v0.6
			h3.292v-0.6H2.505v-3.204C2.899,13.622,3.399,13.819,4,13.819c1.002,0,1.7-0.393,2.202-0.993
			C6.604,12.226,6.898,11.519,6.898,10.723L6.898,10.723z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M11.499,13.721v-0.6h-1.002V9.524
			c0.304-0.404,0.699-0.698,0.895-0.698c0.305,0,0.608,0.294,0.904,0.698l0.099,0.099c0.099-0.198,0.304-0.699,0.501-1.397
			c-0.295-0.304-0.6-0.5-1.002-0.5c-0.295,0-0.795,0.294-1.396,1.101V7.824H8.098v0.599h1.102v4.698H8.098v0.6H11.499L11.499,13.721
			z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M15.49,10.822v-0.1c0-1.602,0.599-2.398,1.799-2.398
			c1.199,0,1.799,0.796,1.799,2.595c0,1.504-0.6,2.3-1.799,2.3C16.196,13.219,15.598,12.423,15.49,10.822L15.49,10.822L15.49,10.822
			z M17.289,7.726c-0.895,0-1.691,0.294-2.299,0.903c-0.599,0.492-0.896,1.298-0.896,2.094c0,0.904,0.296,1.603,0.896,2.193
			c0.608,0.608,1.404,0.904,2.299,0.904c1.002,0,1.699-0.296,2.398-0.904c0.599-0.59,0.904-1.289,0.904-2.193
			c0-0.796-0.305-1.602-1.003-2.201C18.987,8.02,18.193,7.726,17.289,7.726L17.289,7.726z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="21.69,7.824 21.69,8.423 22.389,8.423 24.688,13.819 
			24.984,13.819 26.988,8.423 27.784,8.423 27.784,7.824 25.485,7.824 25.485,8.423 26.389,8.423 25.189,11.726 23.785,8.423 
			24.59,8.423 24.59,7.824 21.69,7.824 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M29.888,5.229l-0.305,0.492c0,0.599,0.305,0.804,0.797,0.804
			c0.599,0,0.805-0.206,0.805-0.804c0-0.492-0.207-0.796-0.805-0.796L29.888,5.229L29.888,5.229z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="31.185,7.824 28.885,7.824 28.885,8.423 29.888,8.423 
			29.888,13.121 28.885,13.121 28.885,13.721 32.178,13.721 32.178,13.121 31.185,13.121 31.185,7.824 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M33.279,8.423h1.101v4.698h-1.101v0.6h3.401v-0.6h-1.002V9.023
			c0.501-0.395,1.002-0.601,1.405-0.601c0.698,0,1.092,0.501,1.092,1.504v3.194h-0.895v0.6h3.195v-0.6h-1.003V9.72
			c0-0.697-0.197-1.198-0.393-1.495c-0.304-0.401-0.699-0.5-1.297-0.5c-0.6,0-1.298,0.196-2.005,0.697l-0.098,0.099V7.824h-2.398
			V8.423L33.279,8.423z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M45.171,7.726h-0.403L44.671,8.02
			c-0.295-0.196-0.699-0.294-1.102-0.294c-0.599,0-0.993,0.099-1.396,0.5c-0.297,0.296-0.501,0.698-0.501,1.199
			c0,0.699,0.501,1.298,1.404,1.799l0.6,0.295c0.492,0.306,0.797,0.708,0.797,1.002c0,0.5-0.305,0.797-0.904,0.797
			c-0.797,0-1.298-0.492-1.593-1.297h-0.304v1.799h0.402l0.099-0.393h0.098c0.403,0.294,0.905,0.393,1.405,0.393
			c1.298,0,1.996-0.601,1.996-1.7l-0.197-0.796c-0.304-0.404-0.804-0.797-1.7-1.298c-0.698-0.304-1.002-0.697-1.002-1.001
			c0-0.501,0.305-0.798,0.904-0.798c0.599,0,0.994,0.403,1.19,1.102h0.305V7.726L45.171,7.726z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M48.375,4.925c-0.501,0-0.806,0.304-0.806,0.796
			c0,0.599,0.305,0.804,0.906,0.804c0.5,0,0.697-0.206,0.697-0.697C49.171,5.229,48.974,4.925,48.375,4.925L48.375,4.925z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M46.872,7.824v0.599h1.001v6.301
			c0,0.795-0.305,1.396-0.805,1.798c-0.196,0.098-0.294,0.196-0.294,0.394c0,0.107,0.098,0.206,0.294,0.206
			c0.304,0,0.706-0.206,1.102-0.502c0.696-0.6,1.001-1.504,1.001-2.497V7.824H46.872L46.872,7.824z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M55.166,9.72h-2.497c0.198-0.993,0.502-1.495,1.298-1.495
			C54.666,8.226,55.166,8.728,55.166,9.72L55.166,9.72L55.166,9.72z M52.669,10.32h3.893c-0.197-1.798-1.002-2.595-2.595-2.595
			c-1.799,0-2.604,0.903-2.604,2.8c0,0.993,0.304,1.7,0.805,2.39c0.599,0.608,1.396,0.904,2.299,0.904
			c0.6,0,1.298-0.198,2.095-0.698l0.098-0.6c-0.698,0.395-1.298,0.6-1.798,0.6C53.467,13.121,52.669,12.226,52.669,10.32
			L52.669,10.32z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M66.656,4.127L65.761,4.03c-2.201,0-3.302,1.101-3.302,3.193
			v0.601h-0.903v0.698h0.903v4.599h-1.002v0.6h3.5v-0.6h-1.2V8.522h1.396V7.824h-1.396V6.625c0-1.298,0.502-1.996,1.396-1.996
			c0.708,0,1.001,0.394,1.101,1.199v0.098h0.403V4.127L66.656,4.127z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M66.057,7.824v0.599h1.1v4.698h-1.1v0.6h3.399v-0.6h-1.002V9.524
			c0.404-0.404,0.698-0.698,1.002-0.698c0.198,0,0.6,0.294,0.797,0.698l0.099,0.099c0.304-0.296,0.402-0.699,0.5-1.397
			c-0.294-0.304-0.697-0.5-0.993-0.5c-0.304,0-0.804,0.294-1.406,1.101V7.824H66.057L66.057,7.824z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="77.35,8.423 78.048,8.423 78.048,7.824 76.051,7.824 
			76.051,8.423 76.75,8.423 75.353,12.119 73.949,8.423 74.647,8.423 74.647,7.824 71.854,7.824 71.854,8.423 72.553,8.423 
			74.45,13.427 72.858,17.122 73.949,17.122 77.35,8.423 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M82.441,9.327h0.206V7.726h-0.296L82.243,8.02l-1.1-0.294
			c-0.599,0-0.993,0.099-1.397,0.5c-0.294,0.296-0.599,0.698-0.599,1.199c0,0.699,0.502,1.298,1.495,1.799l0.501,0.295
			c0.6,0.306,0.903,0.708,0.903,1.002c0,0.5-0.402,0.797-1.002,0.797c-0.698,0-1.298-0.492-1.494-1.297h-0.402v1.799h0.502v-0.393
			h0.196c0.402,0.294,0.903,0.393,1.297,0.393c0.6,0,1.1-0.198,1.503-0.501c0.393-0.402,0.502-0.797,0.502-1.199l-0.109-0.796
			c-0.295-0.404-0.895-0.797-1.69-1.298c-0.707-0.304-1.101-0.697-1.101-1.001c0-0.501,0.296-0.798,0.895-0.798
			C81.841,8.226,82.145,8.628,82.441,9.327L82.441,9.327z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="86.646,4.423 84.249,4.423 84.249,5.023 85.242,5.023 
			85.242,13.121 84.249,13.121 84.249,13.721 87.64,13.721 87.64,13.121 86.646,13.121 86.646,4.423 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="93.135,7.126 93.34,7.126 92.043,4.826 90.843,4.826 
			89.546,7.126 89.636,7.126 91.237,5.632 93.135,7.126 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M91.641,10.919h0.098v1.602
			c-0.395,0.305-0.698,0.395-0.993,0.395c-0.501,0-0.707-0.199-0.707-0.796C90.039,11.626,90.539,11.224,91.641,10.919
			L91.641,10.919L91.641,10.919z M93.036,12.119V9.72c0-1.396-0.6-1.995-1.897-1.995c-0.698,0-1.502,0.294-2.202,0.903l0.206,0.395
			c0.698-0.395,1.199-0.601,1.604-0.601c0.697,0,0.993,0.403,0.993,1.102v0.796l-1.298,0.402c-1.002,0.196-1.593,0.698-1.593,1.503
			c0,1.092,0.492,1.593,1.296,1.593c0.494,0,0.994-0.296,1.791-0.798c0.206,0.502,0.601,0.798,1.101,0.798
			c0.403,0,0.806-0.198,1.2-0.393v-0.405h-0.1c-0.099,0-0.197,0-0.502,0C93.242,13.021,93.036,12.717,93.036,12.119L93.036,12.119z"
			/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M95.138,8.423h1.101v4.698h-1.101v0.6h3.402v-0.6h-1.004V9.023
			c0.502-0.395,1.004-0.601,1.397-0.601c0.698,0,1.102,0.501,1.102,1.504v3.194h-0.905v0.6h3.204v-0.6h-1.003V9.72
			c0-0.697-0.196-1.198-0.4-1.495c-0.298-0.401-0.798-0.5-1.299-0.5c-0.6,0-1.298,0.196-1.996,0.697l-0.099,0.099V7.824h-2.398
			V8.423L95.138,8.423z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M61.664,20.62v0.6h0.993v4.689h-0.993v0.501h3.399v-0.501h-1.109
			v-4.689h1.405v-0.6h-1.405v-1.2c0-1.306,0.51-2.003,1.405-2.003c0.599,0,1.002,0.402,1.1,1.101v0.198h0.395v-1.799h-0.098
			l-0.797-0.1c-2.299,0-3.301,1.003-3.301,3.204v0.6H61.664L61.664,20.62z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M66.154,20.62v0.6h1.102v4.689h-1.102v0.501h3.5v-0.501h-1.002
			v-3.598c0.304-0.493,0.708-0.698,0.904-0.698c0.304,0,0.6,0.206,0.895,0.698c0,0,0,0.1,0.107,0.1
			c0.196-0.493,0.393-0.994,0.5-1.396c-0.402-0.394-0.706-0.6-1.002-0.6c-0.402,0-0.806,0.404-1.404,1.198V20.62H66.154
			L66.154,20.62z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="71.953,20.62 71.953,21.219 72.651,21.219 
			74.647,26.213 72.957,29.908 74.047,29.908 77.448,21.219 78.146,21.219 78.146,20.62 76.151,20.62 76.151,21.219 76.956,21.219 
			75.453,24.915 74.047,21.219 74.754,21.219 74.754,20.62 71.953,20.62 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M81.448,22.812c-0.699-0.402-1.002-0.698-1.002-1.101
			c0-0.493,0.197-0.698,0.903-0.698c0.6,0,1.001,0.304,1.198,1.002h0.296v-1.602h-0.403v0.304l-1.2-0.304
			c-0.599,0-0.993,0.206-1.297,0.5c-0.394,0.403-0.599,0.797-0.599,1.2c0,0.698,0.5,1.297,1.503,1.897l0.5,0.305
			c0.6,0.295,0.796,0.599,0.796,0.994c0,0.501-0.304,0.706-1.001,0.706s-1.199-0.402-1.494-1.306h-0.304v1.906h0.401l0.1-0.402
			h0.098c0.501,0.196,1.002,0.295,1.405,0.295c0.6,0,1.001-0.099,1.396-0.493c0.404-0.304,0.599-0.706,0.599-1.198l-0.195-0.708
			C82.95,23.715,82.351,23.313,81.448,22.812L81.448,22.812z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="84.347,17.819 85.448,17.819 85.448,25.908 
			84.347,25.908 84.347,26.409 87.738,26.409 87.738,25.908 86.746,25.908 86.746,17.22 84.347,17.22 84.347,17.819 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="93.34,19.814 93.538,19.814 92.141,17.613 
			90.941,17.613 89.636,19.814 89.841,19.814 91.443,18.419 93.34,19.814 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M91.836,23.715h0.099v1.496c-0.394,0.304-0.796,0.5-0.994,0.5
			c-0.5,0-0.797-0.294-0.797-0.796C90.145,24.316,90.639,23.913,91.836,23.715L91.836,23.715L91.836,23.715z M89.143,21.417
			l0.1,0.401c0.698-0.401,1.297-0.599,1.699-0.599c0.6,0,0.994,0.296,0.994,1.091v0.806l-1.296,0.294
			c-1.093,0.304-1.603,0.796-1.603,1.602c0,1.002,0.403,1.495,1.306,1.495c0.501,0,1.102-0.196,1.701-0.797
			c0.294,0.601,0.599,0.797,1.092,0.797c0.402,0,0.804-0.099,1.306-0.394v-0.403h-0.107c-0.198,0.1-0.296,0.1-0.492,0.1
			c-0.403,0-0.707-0.295-0.707-0.896v-2.398c0-1.404-0.494-2.102-1.791-2.102C90.639,20.414,89.841,20.718,89.143,21.417
			L89.143,21.417z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M95.336,21.219h1.1v4.689h-1.1v0.501h3.3v-0.501h-1.001v-4.09
			c0.501-0.401,1.001-0.599,1.494-0.599c0.708,0,1.002,0.493,1.002,1.494v3.195h-0.894v0.501h3.293v-0.501h-1.101v-3.392
			c0-0.698-0.1-1.198-0.296-1.602c-0.402-0.295-0.805-0.5-1.297-0.5c-0.708,0-1.297,0.304-2.103,0.805h-0.099v-0.6h-2.299V21.219
			L95.336,21.219z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M2.3,21.612c0.501-0.5,0.904-0.698,1.396-0.698
			c1.002,0,1.602,0.903,1.602,2.596c0,1.6-0.493,2.3-1.495,2.3c-0.6,0-1.1-0.295-1.503-0.797V21.612L2.3,21.612L2.3,21.612z
			 M0,20.915h1.101v8.099H0v0.6h3.399v-0.6H2.3v-3.105c0.501,0.206,1.002,0.403,1.503,0.403c1.002,0,1.7-0.296,2.201-1.002
			c0.492-0.493,0.698-1.2,0.698-2.095c0-1.995-0.903-2.997-2.702-2.997c-0.501,0-1.101,0.197-1.7,0.697v-0.599H0V20.915L0,20.915z"
			/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M11.292,21.318c0.305,0,0.6,0.294,0.903,0.698
			c0,0.098,0,0.098,0,0.196l0.6-1.495c-0.402-0.304-0.697-0.5-1.001-0.5c-0.403,0-0.895,0.294-1.397,1.101H10.3v-1.002H8v0.599
			h1.002v4.698H8v0.6h3.391v-0.6H10.3v-3.597C10.801,21.612,11.097,21.318,11.292,21.318L11.292,21.318z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M15.391,23.313v-0.099c0-1.602,0.6-2.396,1.701-2.396
			c1.297,0,1.896,0.794,1.896,2.593c0,1.503-0.599,2.3-1.797,2.3C15.991,25.711,15.391,24.915,15.391,23.313L15.391,23.313
			L15.391,23.313z M19.489,21.014c-0.599-0.502-1.396-0.796-2.398-0.796c-0.895,0-1.602,0.294-2.202,0.895
			c-0.599,0.5-0.895,1.298-0.895,2.102c0,0.895,0.296,1.603,0.895,2.202c0.601,0.599,1.307,0.895,2.301,0.895
			c0.903,0,1.7-0.296,2.299-0.895c0.599-0.6,0.895-1.307,0.895-2.202C20.384,22.41,20.088,21.612,19.489,21.014L19.489,21.014z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="21.494,20.316 21.494,20.915 22.29,20.915 24.59,26.312 
			24.886,26.312 26.783,20.915 27.579,20.915 27.579,20.316 25.386,20.316 25.386,20.915 26.282,20.915 25.09,24.208 23.686,20.915 
			24.385,20.915 24.385,20.316 21.494,20.316 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M29.682,17.719l-0.197,0.493c0,0.609,0.197,0.807,0.797,0.807
			c0.5,0,0.805-0.198,0.805-0.807c0-0.493-0.304-0.698-0.805-0.698L29.682,17.719L29.682,17.719z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="28.689,20.915 29.78,20.915 29.78,25.613 28.689,25.613 
			28.689,26.213 32.081,26.213 32.081,25.613 31.086,25.613 31.086,20.316 28.689,20.316 28.689,20.915 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M33.182,20.915h1.001v4.698h-1.001v0.6h3.301v-0.6h-0.903v-4
			c0.402-0.393,0.903-0.599,1.395-0.599c0.698,0,1.003,0.502,1.003,1.396v3.203h-0.895v0.6h3.292v-0.6h-1.101v-3.4
			c0-0.697-0.097-1.199-0.402-1.495c-0.197-0.402-0.698-0.5-1.199-0.5c-0.59,0-1.297,0.197-2.093,0.697v0.099v-0.698h-2.397V20.915
			L33.182,20.915z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M45.77,20.512c-0.5-0.196-1.001-0.294-1.494-0.294
			c-0.805,0-1.503,0.197-2.004,0.796c-0.5,0.502-0.795,1.297-0.795,2.103c0,0.895,0.295,1.7,0.895,2.3
			c0.501,0.599,1.199,0.895,2.005,0.895c0.796,0,1.494-0.296,1.995-0.699c0.099-0.098,0.206-0.196,0.296-0.402v-0.1l-0.091-0.098
			c0-0.099,0-0.099-0.107-0.099c0,0,0,0-0.099,0v0.099c-0.6,0.296-1.002,0.502-1.503,0.502c-1.297,0-1.896-0.904-1.896-2.604
			c0-0.698,0.107-1.298,0.402-1.593c0.305-0.403,0.6-0.6,1.102-0.6c0.698,0,1.199,0.395,1.396,1.298h0.403v-1.799H45.87
			L45.77,20.512L45.77,20.512z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M48.866,17.719l-0.294,0.493c0,0.609,0.294,0.807,0.796,0.807
			c0.6,0,0.797-0.198,0.797-0.807c0-0.493-0.197-0.698-0.797-0.698L48.866,17.719L48.866,17.719z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#004676" points="47.874,20.915 48.866,20.915 48.866,25.613 
			47.874,25.613 47.874,26.213 51.167,26.213 51.167,25.613 50.165,25.613 50.165,20.316 47.874,20.316 47.874,20.915 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#004676" d="M56.464,22.212h-2.497c0-0.993,0.403-1.495,1.198-1.495
			C55.865,20.718,56.366,21.219,56.464,22.212L56.464,22.212L56.464,22.212z M53.968,22.812h3.793
			c-0.196-1.799-1.101-2.595-2.595-2.595c-1.699,0-2.604,0.895-2.604,2.8c0,0.994,0.306,1.799,0.805,2.399
			c0.601,0.599,1.299,0.895,2.301,0.895c0.599,0,1.297-0.198,1.995-0.699h0.098l0.108-0.6c-0.707,0.403-1.307,0.6-1.808,0.6
			C54.666,25.613,53.968,24.709,53.968,22.812L53.968,22.812z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#ED1C24" d="M109.527,20.915c-1.198,0.502-1.995,1.602-2.398,3.195
			c-0.601,2.998,0.305,5.297,2.801,6.802c0.728,0.487,1.48,0.807,2.248,0.961h2.152c0.099-0.019,0.199-0.042,0.299-0.066
			c1.296-0.198,2.291-0.798,3.194-1.496c1.199-1.101,1.699-2.301,1.601-3.695c-0.106-1.1-0.698-1.906-1.7-2.506
			c-0.904-0.491-2.102-0.197-3.596,1.102c-0.207,0.206-0.502,0.304-0.609,0.206c-0.198-0.107-0.198-0.306-0.089-0.6
			c0.393-1.906,0.089-3.105-0.904-3.705C111.522,20.512,110.529,20.414,109.527,20.915L109.527,20.915z"/>
	</g>
	<g>
		<linearGradient id="SVGID_1_" gradientUnits="userSpaceOnUse" x1="231.271" y1="13.7837" x2="257.8594" y2="13.7837">
			<stop  offset="0" style="stop-color:#FFFFFF"/>
			<stop  offset="1" style="stop-color:#005DA4"/>
		</linearGradient>
		<rect x="231.271" y="8.69" fill="url(#SVGID_1_)" width="26.588" height="10.187"/>
		<linearGradient id="SVGID_2_" gradientUnits="userSpaceOnUse" x1="209.0391" y1="13.4595" x2="257.8535" y2="13.4595">
			<stop  offset="0" style="stop-color:#FFFFFF"/>
			<stop  offset="1" style="stop-color:#005DA4"/>
		</linearGradient>
		<rect x="209.039" y="9.622" fill="url(#SVGID_2_)" width="48.814" height="7.676"/>
		<linearGradient id="SVGID_3_" gradientUnits="userSpaceOnUse" x1="208.9644" y1="22.3379" x2="257.9531" y2="22.3379">
			<stop  offset="0" style="stop-color:#FFFFFF"/>
			<stop  offset="1" style="stop-color:#005DA4"/>
		</linearGradient>
		<rect x="208.964" y="18.356" fill="url(#SVGID_3_)" width="48.989" height="7.964"/>
		<linearGradient id="SVGID_4_" gradientUnits="userSpaceOnUse" x1="208.9155" y1="4.873" x2="257.7285" y2="4.873">
			<stop  offset="0" style="stop-color:#FFFFFF"/>
			<stop  offset="1" style="stop-color:#005DA4"/>
		</linearGradient>
		<rect x="208.916" y="1.036" fill="url(#SVGID_4_)" width="48.813" height="7.675"/>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.632" stroke-miterlimit="3.8637" d="
				M266.227,16.684"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.632" stroke-miterlimit="3.8637" d="
				M264.514,16.227"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M256.248,1.624c0,0-2.377-1.829-2.24,1.832
				c0.121,3.319,1.842,4.312,1.842,4.312h0.461c0,0-0.748-0.929-1.074-1.984c-0.209-0.672-0.281-1.565-0.184-2.098
				c0.244-1.374,1.137-0.267,1.137-0.267L256.248,1.624z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M253.703,2.571c0,0-2.365-1.171-1.777,2.081
				c0.531,2.951,2.199,3.503,2.199,3.503l0.412-0.091c0,0-0.785-0.685-1.215-1.568c-0.271-0.56-0.449-1.347-0.432-1.845
				c0.045-1.278,0.984-0.462,0.984-0.462L253.703,2.571z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M251.459,3.646c0,0-2.258-0.636-1.357,2.185
				c0.816,2.559,2.379,2.759,2.379,2.759l0.359-0.154c0,0-0.785-0.477-1.271-1.194c-0.309-0.457-0.557-1.131-0.598-1.582
				c-0.107-1.158,0.83-0.589,0.83-0.589L251.459,3.646z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M259.424,1.624c0,0,2.377-1.829,2.242,1.832
				c-0.123,3.319-1.844,4.312-1.844,4.312h-0.461c0,0,0.748-0.929,1.074-1.984c0.209-0.672,0.281-1.565,0.186-2.098
				c-0.246-1.374-1.137-0.267-1.137-0.267L259.424,1.624z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M261.971,2.571c0,0,2.363-1.171,1.775,2.081
				c-0.531,2.951-2.199,3.503-2.199,3.503l-0.412-0.091c0,0,0.787-0.685,1.217-1.568c0.27-0.56,0.449-1.347,0.432-1.845
				c-0.047-1.278-0.984-0.462-0.984-0.462L261.971,2.571z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M264.213,3.646c0,0,2.26-0.636,1.357,2.185
				c-0.816,2.559-2.377,2.759-2.377,2.759l-0.363-0.154c0,0,0.789-0.477,1.273-1.194c0.311-0.457,0.559-1.131,0.6-1.582
				c0.105-1.158-0.832-0.589-0.832-0.589L264.213,3.646z"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.632" stroke-miterlimit="3.8637" d="
				M251.068,16.476"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M255.488,11.218"/>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M281.703,2.556c-0.316-0.411-0.725-0.616-1.227-0.616
					c-0.369,0-0.721,0.154-1.059,0.464V2.032h-0.666h-0.666v6.259h0.666h0.666V5.926c0.328,0.293,0.682,0.441,1.059,0.444
					c0.502,0,0.91-0.205,1.227-0.614c0.316-0.41,0.473-0.942,0.473-1.597C282.176,3.502,282.02,2.967,281.703,2.556z M280.619,5.041
					c-0.117,0.2-0.295,0.301-0.531,0.301c-0.225,0-0.416-0.091-0.57-0.27c-0.031-0.044-0.064-0.083-0.1-0.116V3.355l0.127-0.174
					c0.154-0.178,0.336-0.268,0.543-0.268c0.236,0,0.414,0.102,0.531,0.303s0.178,0.506,0.178,0.913
					C280.797,4.536,280.736,4.84,280.619,5.041z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M283.053,6.278V2.032h0.615h0.621v1.58
				c0.07-0.294,0.148-0.552,0.238-0.777c0.236-0.572,0.553-0.858,0.949-0.858c0.318-0.003,0.566,0.082,0.746,0.255l-0.297,1.232
				c-0.143-0.177-0.33-0.264-0.559-0.264c-0.271,0-0.496,0.193-0.674,0.581c-0.176,0.387-0.279,0.91-0.309,1.568v0.929h-0.668
				H283.053z"/>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M289.883,2.556c-0.383-0.411-0.881-0.616-1.49-0.616
					c-0.611,0-1.107,0.205-1.488,0.616c-0.383,0.411-0.574,0.946-0.574,1.604c0,0.654,0.191,1.187,0.574,1.597
					c0.381,0.409,0.877,0.614,1.488,0.614c0.609,0,1.107-0.205,1.49-0.614c0.383-0.41,0.574-0.942,0.574-1.597
					C290.457,3.502,290.266,2.967,289.883,2.556z M288.908,5.088c-0.115,0.206-0.287,0.308-0.516,0.308
					c-0.23,0-0.4-0.103-0.514-0.308c-0.113-0.205-0.17-0.515-0.17-0.928c0-0.417,0.057-0.729,0.17-0.935
					c0.113-0.208,0.283-0.311,0.514-0.311c0.229,0,0.4,0.104,0.516,0.311c0.113,0.207,0.172,0.518,0.172,0.935
					C289.08,4.573,289.021,4.883,288.908,5.088z"/>
			</g>
		</g>
		<g>
			<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" points="290.357,2.032 290.99,2.032 291.629,2.032 292.5,4.302 
				292.504,4.302 293.275,2.032 293.898,2.032 294.527,2.032 292.826,6.37 292.48,6.37 292.137,6.37 			"/>
		</g>
		<g>
			<g>
				<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" points="295.064,6.278 295.064,2.032 295.73,2.032 
					296.396,2.032 296.396,6.278 295.73,6.278 				"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M295.73,0c0.199,0,0.369,0.069,0.506,0.206
					c0.137,0.138,0.205,0.307,0.205,0.507c0,0.2-0.068,0.369-0.205,0.506s-0.307,0.206-0.506,0.206
					c-0.201,0-0.369-0.069-0.506-0.206c-0.139-0.137-0.207-0.306-0.207-0.506c0-0.2,0.068-0.369,0.207-0.507
					C295.361,0.069,295.529,0,295.73,0z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M297.459,6.278V2.032h0.666h0.666v0.576
				c0.09-0.107,0.182-0.205,0.273-0.292c0.275-0.25,0.578-0.376,0.906-0.376c0.447,0,0.791,0.129,1.025,0.388
				c0.234,0.258,0.352,0.634,0.352,1.128v2.822h-0.668h-0.666V3.596c0-0.207-0.045-0.374-0.133-0.5
				c-0.09-0.127-0.209-0.19-0.357-0.19c-0.137,0-0.271,0.062-0.404,0.186c-0.131,0.124-0.242,0.292-0.328,0.505v2.682h-0.666
				H297.459z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M305.451,6.067c-0.264,0.119-0.475,0.2-0.635,0.241
				c-0.16,0.042-0.336,0.062-0.523,0.062c-0.635,0-1.15-0.205-1.547-0.614c-0.396-0.41-0.596-0.942-0.596-1.597
				c0-0.658,0.199-1.192,0.596-1.604s0.914-0.616,1.549-0.616c0.18,0,0.344,0.02,0.498,0.06c0.148,0.04,0.35,0.115,0.594,0.224
				v0.984c-0.17-0.095-0.311-0.16-0.416-0.195c-0.107-0.035-0.217-0.053-0.332-0.053c-0.373,0-0.65,0.099-0.834,0.298
				c-0.184,0.199-0.275,0.499-0.275,0.901c0,0.398,0.092,0.696,0.275,0.894c0.184,0.199,0.461,0.296,0.832,0.296
				c0.131,0,0.256-0.019,0.371-0.057s0.264-0.108,0.443-0.209V6.067z"/>
		</g>
		<g>
			<g>
				<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" points="306.262,6.278 306.262,2.032 306.928,2.032 
					307.596,2.032 307.596,6.278 306.928,6.278 				"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M306.928,0c0.201,0,0.371,0.069,0.508,0.206
					c0.137,0.138,0.205,0.307,0.205,0.507c0,0.2-0.068,0.369-0.205,0.506s-0.307,0.206-0.508,0.206
					c-0.199,0-0.367-0.069-0.506-0.206s-0.205-0.306-0.205-0.506c0-0.2,0.066-0.369,0.205-0.507C306.561,0.069,306.729,0,306.928,0z
					"/>
			</g>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#FAA61A" d="M312.105,4.163c0-0.659-0.162-1.194-0.486-1.605
					c-0.322-0.412-0.742-0.618-1.26-0.618c-0.561,0-1.014,0.205-1.363,0.616c-0.348,0.411-0.521,0.946-0.521,1.604
					c0,0.7,0.174,1.243,0.521,1.63c0.348,0.387,0.838,0.581,1.469,0.581c0.271,0,0.516-0.03,0.73-0.091
					c0.217-0.061,0.482-0.174,0.799-0.34V5.111c-0.221,0.143-0.414,0.241-0.58,0.295s-0.352,0.082-0.559,0.082
					c-0.357,0-0.625-0.113-0.803-0.339c-0.148-0.196-0.236-0.466-0.26-0.811h2.312V4.163z M309.793,3.732
					c0.021-0.309,0.062-0.539,0.121-0.692c0.09-0.213,0.238-0.319,0.445-0.319s0.355,0.101,0.441,0.305
					c0.066,0.153,0.107,0.388,0.125,0.706H309.793z"/>
			</g>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M286.039,9.272h-1.811c-0.117-0.018-0.242-0.027-0.377-0.027
					c-0.527,0-0.955,0.149-1.283,0.449c-0.326,0.3-0.492,0.689-0.492,1.168c0,0.476,0.166,0.863,0.492,1.16
					c0.098,0.083,0.197,0.158,0.307,0.224l-0.189,0.076c-0.32,0.148-0.479,0.333-0.479,0.55c0,0.304,0.143,0.547,0.432,0.729
					l0.018,0.01c-0.219,0.057-0.404,0.175-0.555,0.356s-0.227,0.374-0.227,0.577c0,0.32,0.186,0.591,0.561,0.812
					c0.373,0.221,0.832,0.332,1.373,0.332c0.744,0,1.303-0.112,1.674-0.336c0.371-0.225,0.557-0.562,0.557-1.011
					c0-0.425-0.143-0.735-0.424-0.928c-0.283-0.193-0.771-0.311-1.465-0.353c-0.398-0.026-0.658-0.055-0.779-0.087
					c-0.121-0.031-0.182-0.083-0.182-0.157c0-0.097,0.064-0.179,0.193-0.243l0.115-0.054c-0.029,0.015,0.027,0.015,0.172,0
					c0.143-0.014,0.332-0.039,0.57-0.075c0.348-0.052,0.646-0.176,0.891-0.374c0.33-0.271,0.494-0.622,0.494-1.054
					c-0.002-0.38-0.088-0.708-0.252-0.98h0.666V9.272z M283.568,13.971c0.191-0.037,0.391-0.05,0.594-0.038l0.143,0.009
					c0.186,0.012,0.34,0.068,0.469,0.167c0.127,0.099,0.189,0.214,0.189,0.347c0,0.152-0.102,0.282-0.305,0.387
					S284.207,15,283.914,15c-0.254,0-0.469-0.053-0.645-0.16s-0.264-0.237-0.264-0.393c0-0.112,0.053-0.217,0.162-0.315
					C283.24,14.062,283.375,14.008,283.568,13.971z M284.314,11.619c-0.094,0.146-0.236,0.219-0.428,0.219
					c-0.189,0-0.332-0.073-0.426-0.219c-0.096-0.146-0.143-0.366-0.143-0.66c0-0.297,0.047-0.519,0.143-0.667
					c0.094-0.147,0.236-0.221,0.426-0.221c0.191,0,0.332,0.074,0.426,0.221c0.098,0.147,0.145,0.37,0.145,0.667
					C284.457,11.253,284.41,11.473,284.314,11.619z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M286.58,13.583V9.337h0.617h0.621v1.58
				c0.068-0.294,0.148-0.553,0.238-0.777c0.234-0.572,0.553-0.858,0.949-0.858c0.316-0.003,0.566,0.082,0.744,0.255l-0.295,1.232
				c-0.143-0.177-0.33-0.266-0.561-0.266c-0.271,0-0.496,0.194-0.672,0.582c-0.178,0.387-0.281,0.91-0.311,1.568v0.929h-0.666
				H286.58z"/>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M293.596,9.861c-0.385-0.41-0.881-0.616-1.492-0.616
					c-0.609,0-1.107,0.206-1.488,0.616c-0.381,0.412-0.572,0.946-0.572,1.604c0,0.655,0.191,1.186,0.572,1.596
					c0.381,0.41,0.879,0.615,1.488,0.615c0.611,0,1.107-0.205,1.492-0.615c0.383-0.41,0.574-0.941,0.574-1.596
					C294.17,10.807,293.979,10.272,293.596,9.861z M292.619,12.393c-0.115,0.206-0.285,0.308-0.516,0.308
					c-0.229,0-0.398-0.103-0.512-0.308s-0.17-0.514-0.17-0.928c0-0.417,0.057-0.729,0.17-0.935c0.113-0.207,0.283-0.311,0.512-0.311
					c0.23,0,0.4,0.104,0.516,0.311c0.113,0.206,0.172,0.519,0.172,0.935C292.791,11.879,292.732,12.188,292.619,12.393z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M295.018,13.583V9.337h0.666h0.666v0.576
				c0.09-0.107,0.18-0.204,0.273-0.292c0.275-0.251,0.576-0.376,0.906-0.376c0.449,0,0.789,0.128,1.023,0.387
				c0.234,0.259,0.354,0.635,0.354,1.129v2.822h-0.668h-0.666V10.9c0-0.206-0.045-0.373-0.135-0.5
				c-0.088-0.126-0.207-0.19-0.355-0.19c-0.137,0-0.273,0.061-0.404,0.186c-0.131,0.123-0.242,0.291-0.328,0.503v2.683h-0.666
				H295.018z"/>
		</g>
		<g>
			<g>
				<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" points="299.895,13.583 299.895,9.337 300.559,9.337 
					301.227,9.337 301.227,13.583 300.559,13.583 				"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M300.559,7.305c0.201,0,0.369,0.068,0.506,0.206
					c0.139,0.137,0.207,0.306,0.207,0.506s-0.068,0.368-0.207,0.506c-0.137,0.137-0.305,0.206-0.506,0.206
					c-0.199,0-0.367-0.068-0.506-0.206c-0.137-0.138-0.205-0.306-0.205-0.506s0.068-0.369,0.205-0.506
					C300.191,7.374,300.359,7.305,300.559,7.305z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M302.289,13.583V9.337h0.666h0.666v0.576
				c0.09-0.107,0.182-0.204,0.273-0.292c0.275-0.251,0.578-0.376,0.906-0.376c0.447,0,0.791,0.128,1.025,0.387
				c0.234,0.259,0.352,0.635,0.352,1.129v2.822h-0.668h-0.666V10.9c0-0.206-0.045-0.373-0.133-0.5
				c-0.09-0.126-0.209-0.19-0.357-0.19c-0.139,0-0.271,0.061-0.404,0.186c-0.133,0.123-0.242,0.291-0.328,0.503v2.683h-0.666
				H302.289z"/>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M311.025,9.272h-1.811c-0.117-0.018-0.242-0.027-0.377-0.027
					c-0.527,0-0.955,0.149-1.281,0.449c-0.33,0.3-0.492,0.689-0.492,1.168c0,0.476,0.162,0.863,0.492,1.16
					c0.096,0.083,0.197,0.158,0.305,0.224l-0.189,0.076c-0.318,0.148-0.48,0.333-0.48,0.55c0,0.304,0.145,0.547,0.436,0.729
					l0.016,0.01c-0.219,0.057-0.404,0.175-0.555,0.356s-0.227,0.374-0.227,0.577c0,0.32,0.188,0.591,0.561,0.812
					c0.375,0.221,0.832,0.332,1.373,0.332c0.746,0,1.305-0.112,1.676-0.336c0.369-0.225,0.555-0.562,0.555-1.011
					c0-0.425-0.141-0.735-0.424-0.928c-0.281-0.193-0.771-0.311-1.465-0.353c-0.398-0.026-0.656-0.055-0.779-0.087
					c-0.121-0.031-0.182-0.083-0.182-0.157c0-0.097,0.064-0.179,0.193-0.243l0.117-0.054c-0.031,0.015,0.025,0.015,0.17,0
					c0.143-0.014,0.334-0.039,0.57-0.075c0.35-0.052,0.648-0.176,0.893-0.374c0.33-0.271,0.492-0.622,0.492-1.054
					c-0.002-0.38-0.086-0.708-0.25-0.98h0.664V9.272z M308.555,13.971c0.191-0.037,0.391-0.05,0.594-0.038l0.143,0.009
					c0.186,0.012,0.342,0.068,0.469,0.167c0.127,0.099,0.191,0.214,0.191,0.347c0,0.152-0.102,0.282-0.307,0.387
					c-0.201,0.104-0.449,0.158-0.742,0.158c-0.254,0-0.469-0.053-0.645-0.16c-0.178-0.107-0.266-0.237-0.266-0.393
					c0-0.112,0.055-0.217,0.162-0.315C308.229,14.062,308.361,14.008,308.555,13.971z M309.303,11.619
					c-0.096,0.146-0.238,0.219-0.428,0.219s-0.332-0.073-0.428-0.219c-0.094-0.146-0.143-0.366-0.143-0.66
					c0-0.297,0.049-0.519,0.143-0.667c0.096-0.147,0.238-0.221,0.428-0.221s0.332,0.074,0.426,0.221
					c0.096,0.147,0.145,0.37,0.145,0.667C309.445,11.253,309.398,11.473,309.303,11.619z"/>
			</g>
		</g>
		<g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M315.014,11.468c0-0.658-0.162-1.194-0.484-1.605
					c-0.322-0.412-0.744-0.618-1.262-0.618c-0.559,0-1.014,0.206-1.361,0.616c-0.35,0.412-0.521,0.946-0.521,1.604
					c0,0.699,0.172,1.243,0.521,1.63c0.348,0.387,0.838,0.581,1.467,0.581c0.273,0,0.518-0.031,0.732-0.092
					c0.215-0.061,0.482-0.174,0.799-0.341v-0.827c-0.221,0.144-0.416,0.242-0.58,0.296c-0.166,0.055-0.354,0.082-0.561,0.082
					c-0.357,0-0.625-0.113-0.801-0.338c-0.15-0.197-0.236-0.467-0.26-0.811h2.311V11.468z M312.703,11.037
					c0.02-0.309,0.061-0.539,0.121-0.692c0.09-0.212,0.238-0.319,0.445-0.319s0.354,0.102,0.441,0.306
					c0.064,0.153,0.107,0.388,0.125,0.705H312.703z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M315.883,13.583V9.337h0.666h0.666v0.576
				c0.092-0.107,0.182-0.204,0.273-0.292c0.275-0.251,0.578-0.376,0.906-0.376c0.449,0,0.789,0.128,1.023,0.387
				c0.234,0.259,0.354,0.635,0.354,1.129v2.822h-0.666h-0.668V10.9c0-0.206-0.043-0.373-0.133-0.5
				c-0.09-0.126-0.209-0.19-0.357-0.19c-0.137,0-0.271,0.061-0.404,0.186c-0.131,0.123-0.242,0.291-0.328,0.503v2.683h-0.666
				H315.883z"/>
		</g>
		<g>
			<rect x="251.512" y="17.289" fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" width="13.256" height="0.096"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="3.8014" stroke-miterlimit="3.8637" d="
				M257.814,9.133"/>
		</g>
		<g>
			<g>
				<path fill="#005DA4" d="M277.246,10.308c-1.525-1.36-2.311-0.268-2.311-0.268s1.402-0.361,1.197,0.567
					c0,0,0.02,0.289-1.32,0.464c-1.809,0.236-1.566,2.64-1.299,3.175c0.197,0.396,1.551,1.724,2.248,2.567
					c0,0,0.637,0.608,0.432,1.434c-0.018,0.072-0.273,0.902-1.031,0.928c-1.195,0.041-2.02-1.485-2.02-1.485
					s-0.619-1.155-0.641-2.475c0,0-0.531,0.683-1.113,0.248c-0.082-0.062,0.217,2.333,2.557,4.104
					c0.764,0.578,2.492,0.305,2.848-1.134c0.33-1.34-0.104-1.629-1.508-3.073c-1.402-1.443-1.113-2.371-0.639-2.846
					s1.424,0.165,2.125,0.248S278.771,11.67,277.246,10.308z M275.578,11.827c-0.766-0.23-1.434,0.384-1.434,0.384
					s0.465-0.679,1.01-0.66c1.666,0.059,1.666-0.64,1.666-0.64C277.539,11.96,276.549,12.118,275.578,11.827z"/>
			</g>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M269.656,6.326c-0.541,1.3-1.658,0.962-1.67,1.033
				c-0.084,0.496,0.721,1.423,0.988,1.404c0.207-0.016,1.127-0.097,1.127-0.097s0.213,0.484,0.129,0.464
				c-1.049-0.263-1.408,0.113-1.408,0.113s-0.072,0.536-0.26,0.984c1.061,0.379,2.658-0.62,2.188-0.453
				c-0.471,0.168-1.443,0.202-1.66,0.111c-0.068,0.025,0.102-0.351,0.154-0.381c0.482-0.275,1.176-0.024,1.219-0.066
				c0.252-0.245-0.078-1.133-0.078-1.133s0.035-0.101-1.305,0.085c-0.365-0.084-0.443-0.702-0.436-0.702
				c0.854,0,1.199-0.675,1.299-0.681c2.311-0.141,1.838-1.461,1.902-1.404c0.301,0.273,0.617,0.639,0.617,0.639l0.533-0.099
				c0,0-0.289-0.656-0.742-1.117c-0.486-0.492-1.135-0.786-1.09-0.659C271.973,6.733,269.656,6.326,269.656,6.326z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M272.295,7.563c0,0,0.004-0.801-0.309-0.801
				c-0.021,0,1.094-0.518,1.938-0.288c0.23,0.062-0.352,1.131-0.352,1.131s1.734,1.796-0.492,4.373c-2.225,2.577,0,1.979,0,1.979
				s-0.182,0.394-0.66,0.394c-0.477,0-1.072-0.801-0.807-1.32c0.268-0.519,1.777-2.085,1.797-3.011
				c0.021-0.928-0.182-1.425-0.947-1.959c0,0,0.83-0.503,0.928-1.074C273.432,6.742,272.295,7.563,272.295,7.563z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005BAA" d="M271.367,7.431c0,0-0.535-0.402-0.762-0.237
				c-0.023,0.016-0.32,0.492-0.305,0.492c0.496,0,0.961,0.043,0.961,0.043L271.367,7.431z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M274.646,22.333c-3.113,0.288-3.547-1.176-3.67-2.269
				c-0.123-1.093,0.908-2.207-0.434-3.135c-1.34-0.928-1.176-1.299-1.176-1.299s-0.971,0.297-1.01,0.701
				c-0.043,0.413,0.658,0.661,1.381,1.114c0.723,0.454,0.742,0.825,0.66,2.351C270.316,21.321,271.285,23.589,274.646,22.333z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M277.225,24.271c-1.066-0.305-0.969-0.742-0.969-0.742
				c0.516-0.64,0.352-1.629,0.352-1.629c-2.566-0.642-2.27-1.835-2.27-1.835s-0.598-0.042-1.031-0.537c0,0,0,2.166,2.516,2.784
				c0,0,0.324,0.507-0.186,1.32c-0.102,0.165,0.867,0.7,0.867,0.7s-0.189,0.846-0.127,1.299c0,0-1.35-0.76-2.938-0.43
				c0,0-0.1-0.837,0.17-1.105c0,0-0.158-0.217-0.859-0.279c0,0,0.35,1.052-0.082,2.413c0,0,2.494-1.443,4.062-0.02
				C276.379,25.24,277.332,24.301,277.225,24.271z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M265.1,24.085c3.34,0.578,0.846-4.042,0.846-4.042
				c3.029-0.536,3.607-2.351,3.607-2.351s0.783,0.309,0.641,1.052c0,0-0.311,0.948-3.342,1.505c0,0,1.547,4.806-1.279,4.289
				l-0.328-0.186L265.1,24.085z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M270.152,20.414c0.082-0.165-0.021,0.515,0.205,0.928
				c0,0-0.557,0.763-2.186,0.701l0.082-0.454C268.254,21.589,269.436,21.844,270.152,20.414z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M265.119,24.58c-0.014-0.017,0.105,0.433,0.041,0.866
				c-0.072,0.489-0.33,0.97-0.33,0.97c1.939-1.175,3.816-0.248,3.816-0.248s0.844-1.051,0.557-1.794
				c-0.66-1.696-0.188-2.124-0.188-2.124s-0.637,0.062-0.822,0.062s-0.084,0.908,0.287,2.001c0.371,1.092-0.082,1.484-0.082,1.484
				s-1.393-0.85-2.691-0.333c0,0,0.299-0.594,0.195-0.698C265.902,24.765,265.512,25.013,265.119,24.58z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M274.172,22.786l-0.699,0.248c0,0-0.084,0.701,1.463,1.175
				c0.035,0.011-0.354-0.276-0.557-0.639C274.182,23.215,274.172,22.786,274.172,22.786z"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="1.3745" stroke-miterlimit="3.8637" d="
				M262.939,17.283"/>
		</g>
		<g>
			<path fill="#FFFFFF" d="M255.152,15.058l0.027,0.041c0.039,0.059,0.115,0.243,0.135,0.301c0.057,0.17,0.158,0.356,0.279,0.535
				c0.121-0.258,0.232-0.553,0.484-0.503c0.123,0.025,0.193,0.112,0.25,0.239l0.033,0.076c-0.066-0.039-0.094-0.087-0.166-0.102
				c-0.131-0.026-0.24,0.102-0.266,0.251c-0.01,0.066-0.008,0.105-0.012,0.173c0.164-0.07,0.266-0.101,0.434-0.067
				c0.156,0.032,0.217,0.188,0.26,0.36l0.006,0.07c-0.076-0.123-0.156-0.186-0.283-0.212c-0.111-0.021-0.201,0.003-0.285,0.081
				c0.191,0.18,0.402,0.325,0.359,0.603c-0.023,0.146-0.109,0.214-0.225,0.281l-0.004-0.07c0.006-0.024,0.033-0.031,0.039-0.06
				c0.059-0.378-0.264-0.653-0.596-0.719c-0.189-0.038-0.307,0.075-0.494,0.038c-0.076-0.016-0.121-0.038-0.199-0.049
				c0.148-0.176,0.311-0.182,0.525-0.177c-0.062-0.319-0.205-0.452-0.395-0.662c-0.018-0.02-0.057-0.069-0.096-0.125
				c-0.082,0.214-0.203,0.511-0.311,0.696c-0.027,0.047-0.17-0.136-0.426-0.762c-0.037,0.076-0.082,0.155-0.102,0.182
				c-0.162,0.238-0.287,0.393-0.309,0.719c0.211-0.039,0.373-0.06,0.541,0.092c-0.074,0.023-0.117,0.052-0.191,0.08
				c-0.182,0.066-0.312-0.027-0.492,0.04c-0.32,0.118-0.607,0.442-0.504,0.807c0.008,0.028,0.037,0.031,0.049,0.054l0.004,0.07
				c-0.123-0.048-0.217-0.103-0.258-0.243c-0.076-0.27,0.115-0.447,0.281-0.654c-0.092-0.063-0.184-0.074-0.291-0.035
				c-0.123,0.046-0.195,0.121-0.254,0.254l-0.006-0.069c0.023-0.177,0.062-0.343,0.215-0.398c0.162-0.061,0.268-0.045,0.438-0.002
				c-0.012-0.067-0.016-0.106-0.033-0.17c-0.043-0.144-0.166-0.253-0.295-0.207c-0.068,0.027-0.09,0.079-0.15,0.127l0.023-0.08
				c0.041-0.134,0.1-0.231,0.219-0.276c0.244-0.089,0.389,0.185,0.543,0.421c0.098-0.197,0.174-0.397,0.209-0.575
				c0.01-0.052,0.051-0.205,0.084-0.287c-0.115,0.054-0.244,0.104-0.393,0.143c-0.646,0.17-1.443-0.854-1.262-0.82
				c0.457,0.086,1.006-0.188,0.736-0.137s-0.66-0.068-0.992-0.615c-0.33-0.546-0.256-1.212-0.164-1.076
				c0.318,0.482,1.201,0.666,1.035,0.581c-0.373-0.193-0.938-0.523-1.066-1.281c-0.182-1.059,0.371-1.361,0.371-1.361
				s0.98-0.073,1.102,2.113c0,0,0.031,0.035,0.121-0.102s0.211-0.12,0.375-0.256c0.166-0.137,0.227-0.341,0.227-0.529
				s-0.061-0.256-0.197-0.308c-0.135-0.052-0.449-0.239-0.449-0.239s0.646,0.051,0.449-0.069c-0.193-0.12-0.525-0.102-0.525-0.102
				l0.09-0.138c0,0,0.301-0.085,0.496-0.204c0.195-0.12,0.137-0.206,0.451-0.051c0.316,0.153,0.166,0.666,0.121,1.145
				c-0.037,0.384,0.102,0.536,0.158,0.582c0.055-0.046,0.193-0.198,0.156-0.582c-0.045-0.479-0.195-0.991,0.119-1.145
				c0.318-0.154,0.258-0.068,0.451,0.051c0.197,0.119,0.498,0.204,0.498,0.204l0.09,0.138c0,0-0.33-0.018-0.527,0.102
				c-0.193,0.12,0.451,0.069,0.451,0.069s-0.314,0.187-0.451,0.239c-0.135,0.051-0.193,0.12-0.193,0.308s0.059,0.393,0.225,0.529
				s0.285,0.12,0.375,0.256c0.092,0.137,0.121,0.102,0.121,0.102c0.119-2.186,1.127-2.289,1.127-2.289s0.525,0.479,0.346,1.537
				c-0.129,0.758-0.693,1.088-1.068,1.281c-0.164,0.085,0.719-0.098,1.037-0.581c0.09-0.136,0.166,0.53-0.164,1.076
				c-0.33,0.547-0.723,0.667-0.992,0.615c-0.271-0.051,0.279,0.223,0.736,0.137c0.18-0.034-0.617,0.99-1.262,0.82
				C255.48,15.228,255.297,15.143,255.152,15.058z"/>
		</g>
		<g>
			<path fill="#FFFFFF" d="M257.854,20.384l-0.035,1.784l-2.16,2.587c0.65,0.35,1.373,0.638,2.16,0.868l-0.016,0.96
				c-3.541-1.035-5.965-3.67-6.686-7.458c-0.125-0.656-0.086-1.367-0.086-1.367v-0.271c-0.027,0.041-0.064,0.085-0.113,0.136
				c-0.842-0.274-1.531,0.588-1.553,0.588c-0.115,0-0.407-0.681-0.727-1.295c-0.328-0.627-1.334-1.333-2.067-1.539
				c-1.177-0.33-1.114-0.763-1.114-0.763c-1.65,1.444-2.477-0.145-2.477-0.145s1.094,0.723,1.672,0.083
				c0.577-0.639,0.742-1.691,0.742-1.691s-0.082,0.805,0.949,1.382c1.031,0.578,0.763,0.29,1.67,1.011c0,0,0.855,0.713,1.174,1.662
				c0.248,0.752-0.231,0.388,0.432,0.296c0.434-0.06,1.322-0.046,1.322-0.046s0.047,0.007,0.09,0.031v-0.372
				c-0.016-0.007-0.033-0.015-0.055-0.025c-0.932-0.485-1.252,0.061-1.297,0.014c-0.09-0.09-0.297-1.985-1.667-4.048
				c-1.371-2.063-3.354-1.407-3.354-1.407c0.166-0.43-0.35-1.011-0.35-1.011s2.717-0.222,3.903,1.478
				c1.187,1.701,1.671,4.26,1.671,4.26s0.443-0.387,1.141,0.308l0.006-6.335c-0.105,0.191-0.275,0.386-0.547,0.55
				c0,0-0.131,1.449-1.467,2.243l-0.315-0.71c1.752-0.928,1.204-1.879,1.204-1.879c0.447-0.135,0.875-0.578,0.875-0.578
				c-0.711,0.313-1.121-0.049-1.188,0.113c-0.275,0.67-1.488,1.554-1.488,1.554l-0.442-0.547c0,0,1.428-0.514,1.747-1.616
				c0,0,0.99,0.51,1.75-0.033c0,0,0.07,0.255-0.004,0.579c0.656-0.205,3.418-1.008,6.635-1.062v0.553
				c-1.389,0.011-2.781,0.297-4.434,0.715c-0.828,0.208-1.488,0.562-1.836,0.774v7.072h-0.025c0.004,0.17,0.02,0.718,0.117,1.223
				c0.057,0.301,0.125,0.592,0.201,0.871l2.207-2.507h1.443l-3.227,3.705c0.195,0.447,0.42,0.86,0.676,1.242l4.271-4.947h0.686
				l-0.02,0.889l-4.203,4.974c0.326,0.345,0.686,0.658,1.076,0.939L257.854,20.384z"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="1.4697" stroke-miterlimit="3.8637" d="
				M252.088,16.601"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M246.123,7.864"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M258.342,12.224"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M245.994,6.24c0.539,1.299,1.658,0.961,1.668,1.032
				c0.084,0.496-0.721,1.424-0.986,1.404c-0.21-0.015-1.129-0.096-1.129-0.096s-0.213,0.484-0.128,0.463
				c1.048-0.262,1.407,0.113,1.407,0.113s0.072,0.535,0.26,0.983c-1.061,0.379-2.658-0.62-2.188-0.452
				c0.472,0.168,1.443,0.201,1.662,0.112c0.067,0.025-0.103-0.352-0.156-0.381c-0.482-0.275-1.175-0.024-1.218-0.065
				c-0.253-0.246,0.077-1.133,0.077-1.133s-0.034-0.1,1.307,0.085c0.363-0.085,0.441-0.702,0.434-0.702
				c-0.852,0-1.198-0.674-1.298-0.681c-2.31-0.141-1.84-1.46-1.901-1.403c-0.301,0.272-0.619,0.639-0.619,0.639l-0.533-0.099
				c0,0,0.289-0.655,0.744-1.116c0.484-0.493,1.132-0.787,1.088-0.66C243.677,6.646,245.994,6.24,245.994,6.24z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M243.353,7.476c0,0-0.004-0.801,0.309-0.801
				c0.021,0-1.094-0.518-1.938-0.288c-0.23,0.062,0.352,1.131,0.352,1.131s-1.734,1.797,0.492,4.374c2.225,2.577,0,1.98,0,1.98
				s0.184,0.393,0.659,0.393c0.478,0,1.073-0.801,0.808-1.32c-0.268-0.52-2.816-3.812-0.85-4.971c0,0-0.829-0.504-0.927-1.074
				C242.216,6.653,243.353,7.476,243.353,7.476z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M244.282,7.343c0,0,0.535-0.402,0.762-0.236
				c0.022,0.017,0.32,0.491,0.303,0.491c-0.495,0-0.961,0.044-0.961,0.044L244.282,7.343z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M241.001,22.245c3.113,0.288,3.547-1.175,3.67-2.269
				c0.125-1.094-0.907-2.207,0.434-3.135c1.34-0.929,1.176-1.299,1.176-1.299s0.971,0.298,1.01,0.701
				c0.042,0.413-0.658,0.66-1.381,1.114c-0.722,0.454-0.742,0.824-0.66,2.352C245.332,21.233,244.363,23.502,241.001,22.245z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M238.423,24.183c1.066-0.305,0.97-0.742,0.97-0.742
				c-0.517-0.639-0.351-1.629-0.351-1.629c2.564-0.641,2.268-1.835,2.268-1.835s0.599-0.042,1.031-0.537c0,0,0,2.166-2.516,2.785
				c0,0-0.322,0.506,0.186,1.32c0.104,0.165-0.867,0.7-0.867,0.7s0.189,0.846,0.127,1.3c0,0,1.35-0.761,2.938-0.432
				c0,0,0.1-0.837-0.168-1.105c0,0,0.156-0.216,0.857-0.278c0,0-0.35,1.051,0.082,2.413c0,0-2.494-1.443-4.062-0.021
				C239.269,25.152,238.316,24.214,238.423,24.183z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M250.551,23.998c-3.342,0.577-0.846-4.042-0.846-4.042
				c-3.032-0.536-3.61-2.351-3.61-2.351s-0.783,0.309-0.639,1.051c0,0,0.309,0.949,3.342,1.505c0,0-1.548,4.806,1.278,4.29
				l0.33-0.185L250.551,23.998z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M245.498,20.326c-0.082-0.165,0.021,0.516-0.207,0.928
				c0,0,0.559,0.762,2.186,0.701l-0.082-0.454C247.394,21.501,246.212,21.756,245.498,20.326z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M250.529,24.492c0.016-0.017-0.104,0.433-0.041,0.866
				c0.074,0.489,0.33,0.97,0.33,0.97c-1.938-1.175-3.815-0.247-3.815-0.247s-0.846-1.052-0.559-1.794
				c0.661-1.696,0.188-2.124,0.188-2.124s0.639,0.062,0.824,0.062c0.184,0,0.082,0.907-0.289,2
				c-0.371,1.094,0.083,1.485,0.083,1.485s1.392-0.85,2.689-0.333c0,0-0.297-0.594-0.195-0.697
				C249.744,24.678,250.139,24.926,250.529,24.492z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M241.476,22.698l0.701,0.248c0,0,0.082,0.701-1.465,1.176
				c-0.035,0.01,0.354-0.277,0.557-0.64C241.466,23.128,241.476,22.698,241.476,22.698z"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="1.3745" stroke-miterlimit="3.8637" d="
				M252.643,17.542"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M252.51,18.852c0-0.128,0-0.203,0-0.331
				c0-0.188-0.053-0.419-0.227-0.419c-0.107,0-0.223,0.08-0.209,0.193c0.014,0.094-0.006,0.009,0.014,0.104
				c-0.09-0.015-0.031-0.01-0.084-0.01c-0.102,0-0.162,0.132-0.162,0.239c0,0.156,0.17,0.222,0.314,0.222
				C252.316,18.85,252.348,18.854,252.51,18.852z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M255.811,18.529c0-0.129,0-0.203,0-0.332
				c0-0.188-0.053-0.419-0.227-0.419c-0.107,0-0.229,0.096-0.213,0.21c0.014,0.093,0.012,0.066,0.02,0.088
				c-0.09-0.015-0.033-0.01-0.086-0.01c-0.098,0-0.16,0.132-0.16,0.239c0,0.156,0.168,0.222,0.314,0.222
				C255.619,18.527,255.65,18.532,255.811,18.529z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M254.994,19.458c0-0.128-0.002-0.202-0.002-0.331
				c0-0.186-0.051-0.419-0.227-0.419c-0.105,0-0.229,0.09-0.213,0.203c0.014,0.095,0.01,0.077,0.02,0.095
				c-0.09-0.015-0.033-0.01-0.084-0.01c-0.1,0-0.162,0.131-0.162,0.24c0,0.156,0.17,0.221,0.314,0.221
				C254.803,19.458,254.832,19.462,254.994,19.458z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M254.176,20.454c0-0.128-0.002-0.203-0.002-0.331
				c0-0.188-0.051-0.419-0.225-0.419c-0.107,0-0.227,0.092-0.213,0.205c0.016,0.094,0.006,0.068,0.018,0.092
				c-0.09-0.014-0.033-0.01-0.084-0.01c-0.1,0-0.16,0.132-0.16,0.239c0,0.157,0.168,0.223,0.312,0.223
				C253.984,20.453,254.014,20.458,254.176,20.454z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M253.32,21.422c0-0.128,0-0.202,0-0.331
				c0-0.187-0.053-0.419-0.227-0.419c-0.107,0-0.225,0.09-0.209,0.204c0.012,0.094,0.006,0.064,0.016,0.094
				c-0.09-0.015-0.033-0.01-0.084-0.01c-0.102,0-0.162,0.132-0.162,0.24c0,0.156,0.168,0.222,0.314,0.222
				C253.131,21.422,253.16,21.426,253.32,21.422z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M257.291,20.66c0-0.128,0-0.202,0-0.33
				c0-0.188-0.053-0.42-0.227-0.42c-0.107,0-0.225,0.084-0.211,0.198c0.014,0.093,0.008,0.084,0.018,0.1
				c-0.09-0.015-0.035-0.01-0.086-0.01c-0.1,0-0.16,0.133-0.16,0.24c0,0.156,0.168,0.222,0.312,0.222
				C257.098,20.659,257.129,20.664,257.291,20.66z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M256.436,21.643c0-0.129,0-0.203,0-0.332
				c0-0.187-0.051-0.42-0.227-0.42c-0.105,0-0.225,0.094-0.211,0.208c0.014,0.093,0.008,0.058,0.018,0.09
				c-0.09-0.015-0.033-0.01-0.084-0.01c-0.102,0-0.16,0.132-0.16,0.239c0,0.156,0.166,0.222,0.312,0.222
				C256.246,21.641,256.275,21.646,256.436,21.643z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M255.654,22.56c0-0.128,0-0.203,0-0.332
				c0-0.188-0.053-0.42-0.227-0.42c-0.105,0-0.227,0.091-0.211,0.205c0.014,0.093,0.008,0.062,0.018,0.094
				c-0.09-0.016-0.033-0.01-0.084-0.01c-0.102,0-0.162,0.131-0.162,0.239c0,0.155,0.168,0.222,0.314,0.222
				C255.463,22.559,255.494,22.563,255.654,22.56z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M254.824,23.581c0-0.128,0-0.202,0-0.331
				c0-0.188-0.053-0.42-0.227-0.42c-0.107,0-0.223,0.092-0.207,0.206c0.014,0.094,0.004,0.069,0.014,0.093
				c-0.09-0.015-0.033-0.01-0.084-0.01c-0.102,0-0.164,0.131-0.164,0.239c0,0.157,0.17,0.222,0.314,0.222
				C254.633,23.579,254.664,23.584,254.824,23.581z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M256.91,24.968c0-0.128,0-0.202,0-0.33
				c0-0.188-0.051-0.419-0.225-0.419c-0.105,0-0.223,0.081-0.207,0.194c0.012,0.093-0.006,0.008,0.012,0.103
				c-0.088-0.015-0.031-0.01-0.084-0.01c-0.1,0-0.16,0.132-0.16,0.239c0,0.157,0.168,0.222,0.312,0.222
				C256.719,24.967,256.75,24.972,256.91,24.968z"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="1.4697" stroke-miterlimit="3.8637" d="
				M263.492,16.853"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M258.898,10.732c0-0.138,0-0.219,0-0.358
				c0-0.203-0.055-0.455-0.238-0.455c-0.111,0-0.234,0.088-0.217,0.211c0.014,0.101-0.006,0.009,0.014,0.112
				c-0.096-0.017-0.037-0.011-0.09-0.011c-0.105,0-0.17,0.143-0.17,0.26c0,0.169,0.178,0.24,0.33,0.24
				C258.697,10.731,258.73,10.736,258.898,10.732z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M261.805,11.197c0-0.139,0-0.219,0-0.358
				c0-0.204-0.055-0.456-0.24-0.456c-0.111,0-0.244,0.106-0.229,0.229c0.014,0.102,0.016,0.074,0.025,0.094
				c-0.094-0.017-0.033-0.011-0.09-0.011c-0.105,0-0.168,0.143-0.168,0.259c0,0.169,0.176,0.241,0.33,0.241
				C261.604,11.196,261.635,11.2,261.805,11.197z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M260.805,12.377c0-0.139-0.002-0.219-0.002-0.358
				c0-0.203-0.055-0.456-0.238-0.456c-0.111,0-0.24,0.109-0.225,0.233c0.014,0.102,0.012,0.053,0.02,0.09
				c-0.092-0.017-0.033-0.011-0.088-0.011c-0.105,0-0.168,0.144-0.168,0.26c0,0.169,0.176,0.241,0.328,0.241
				C260.602,12.377,260.635,12.382,260.805,12.377z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M259.777,13.641c0-0.139,0-0.22,0-0.358
				c0-0.204-0.055-0.456-0.238-0.456c-0.111,0-0.238,0.102-0.221,0.226c0.014,0.102,0.016,0.072,0.016,0.098
				c-0.094-0.017-0.033-0.011-0.088-0.011c-0.105,0-0.17,0.144-0.17,0.26c0,0.17,0.178,0.241,0.33,0.241
				C259.578,13.64,259.607,13.645,259.777,13.641z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M258.768,14.915c0-0.139,0-0.22,0-0.358
				c0-0.203-0.055-0.456-0.238-0.456c-0.111,0-0.24,0.105-0.225,0.228c0.014,0.101,0.018,0.077,0.02,0.095
				c-0.092-0.017-0.033-0.011-0.09-0.011c-0.104,0-0.168,0.144-0.168,0.26c0,0.17,0.178,0.241,0.33,0.241
				C258.566,14.914,258.598,14.919,258.768,14.915z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M263.449,13.137c0-0.14-0.002-0.219-0.002-0.359
				c0-0.204-0.053-0.455-0.236-0.455c-0.113,0-0.238,0.098-0.223,0.221c0.014,0.102,0.014,0.093,0.018,0.102
				c-0.094-0.016-0.033-0.011-0.088-0.011c-0.107,0-0.17,0.143-0.17,0.259c0,0.17,0.178,0.242,0.33,0.242
				C263.248,13.136,263.279,13.14,263.449,13.137z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M262.473,14.37c0-0.139-0.002-0.219-0.002-0.359
				c0-0.203-0.053-0.455-0.236-0.455c-0.113,0-0.242,0.107-0.227,0.229c0.014,0.102,0.018,0.082,0.023,0.095
				c-0.096-0.017-0.035-0.011-0.09-0.011c-0.105,0-0.17,0.143-0.17,0.26c0,0.169,0.178,0.241,0.328,0.241
				C262.271,14.369,262.305,14.374,262.473,14.37z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M261.424,15.66c0-0.139-0.002-0.219-0.002-0.359
				c0-0.203-0.053-0.455-0.238-0.455c-0.113,0-0.236,0.101-0.223,0.224c0.014,0.102,0.012,0.083,0.02,0.1
				c-0.096-0.017-0.035-0.011-0.088-0.011c-0.107,0-0.172,0.143-0.172,0.26c0,0.169,0.178,0.24,0.332,0.24
				C261.223,15.658,261.254,15.664,261.424,15.66z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M260.436,16.908c0-0.139,0-0.22,0-0.359
				c0-0.203-0.055-0.456-0.238-0.456c-0.111,0-0.238,0.1-0.221,0.223c0.012,0.102,0.012,0.082,0.018,0.101
				c-0.096-0.016-0.035-0.011-0.088-0.011c-0.107,0-0.17,0.143-0.17,0.26c0,0.169,0.176,0.241,0.328,0.241
				C260.236,16.906,260.268,16.911,260.436,16.908z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M263.482,17.147c0-0.139-0.002-0.219-0.002-0.358
				c0-0.204-0.055-0.456-0.238-0.456c-0.111,0-0.252,0.104-0.232,0.226c0.016,0.098,0.014,0.057,0.027,0.098
				c-0.092-0.017-0.033-0.011-0.088-0.011c-0.104,0-0.17,0.144-0.17,0.26c0,0.169,0.178,0.24,0.332,0.24
				C263.281,17.146,263.312,17.15,263.482,17.147z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M257.689,24.058c0-0.128-0.002-0.203-0.002-0.331
				c0-0.187-0.051-0.42-0.225-0.42c-0.107,0-0.221,0.081-0.207,0.194c0.012,0.093-0.006,0.008,0.012,0.104
				c-0.088-0.016-0.033-0.011-0.084-0.011c-0.1,0-0.16,0.132-0.16,0.24c0,0.156,0.168,0.222,0.312,0.222
				C257.498,24.056,257.527,24.061,257.689,24.058z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M264.252,16.179c0-0.14,0-0.219,0-0.359
				c0-0.202-0.057-0.455-0.24-0.455c-0.111,0-0.24,0.102-0.225,0.224c0.014,0.102,0.012,0.056,0.021,0.099
				c-0.094-0.017-0.033-0.011-0.09-0.011c-0.104,0-0.168,0.143-0.168,0.26c0,0.169,0.176,0.241,0.33,0.241
				C264.049,16.178,264.082,16.183,264.252,16.179z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M255.977,13.987c0,0,1.354,0.051,1.443-1.81"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M257.238,12.432"/>
		</g>
		<g>
			<path fill="#005DA4" d="M264.959,16.22c0.414-0.31,0.949,0.007,0.949,0.007s0.494-2.74,1.68-4.441
				c1.188-1.7,3.904-1.478,3.904-1.478s-0.52,0.581-0.352,1.011c0,0-1.982-0.656-3.352,1.408c-1.371,2.063-1.576,3.958-1.668,4.049
				c-0.039,0.04-0.625-0.326-1.162-0.043v0.52c0.295,0.001,0.783,0.008,1.07,0.048c0.236,0.032,0.326,0.099,0.357,0.139
				c-0.01-0.052-0.01-0.179,0.076-0.436c0.316-0.949,1.172-1.663,1.172-1.663c0.906-0.721,0.639-0.432,1.67-1.01
				s0.949-1.382,0.949-1.382s0.166,1.052,0.742,1.691c0.578,0.64,1.672-0.083,1.672-0.083s-0.826,1.588-2.475,0.145
				c0,0,0.061,0.433-1.113,0.763c-0.736,0.206-1.742,0.911-2.07,1.539c-0.32,0.615-0.342,1.3-0.455,1.3
				c-0.021,0-0.816-0.718-1.596-0.641c-0.002,0.177-0.018,0.495-0.102,0.932c-0.758,4.054-2.594,6.902-7.039,7.995v-0.967
				c4.418-0.768,5.908-3.144,6.631-7.003c0.084-0.448,0.123-0.821,0.139-1.011v-0.079c-0.064-0.116-0.043-0.184,0-0.223v-0.34
				c-0.025-0.016-0.02-0.076,0-0.144l-0.002-2.829l-2.758,3.395l-1.463-0.021l4.221-5.117v-1.291
				c-0.115-0.056-0.285-0.138-0.492-0.232l-5.484,6.572h-0.795l0.004-0.845l5.188-6.207c-0.428-0.181-0.877-0.356-1.279-0.487
				l-3.852,4.489v-1.7l2.584-3.094c-1.4-0.244-2.701-0.23-2.701-0.23l0.002-0.552c3.051-0.052,5.693,0.803,6.738,1.167
				c-0.082-0.332-0.01-0.597-0.01-0.597c0.76,0.544,1.75,0.034,1.75,0.034c0.318,1.103,1.746,1.616,1.746,1.616l-0.441,0.546
				c0,0-1.213-0.882-1.488-1.552c-0.066-0.163-0.477,0.199-1.188-0.113c0,0,0.428,0.443,0.875,0.576c0,0-0.547,0.953,1.201,1.88
				l-0.312,0.709c-1.336-0.793-1.465-2.243-1.465-2.243c-0.078-0.046-0.146-0.095-0.207-0.146V16.22z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M251.766,20.229"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.5576" stroke-miterlimit="3.8637" d="
				M263.625,14.883"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.5576" stroke-miterlimit="3.8637" d="
				M263.348,15.399"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M262.494,22.054c0,0,1.418,0.051,1.512-1.792"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="none" d="M263.816,20.517"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" d="M257.744,7.797c0,0,0.572-4.317,1.305-6.493
				c0.006-0.017-0.701-0.392-1.305-0.387V7.797z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M257.75,0.918c-0.629,0.005-1.131,0.428-1.131,0.428
				c0.773,2.74,1.125,5.688,1.125,6.451L257.75,0.918z"/>
		</g>
		<g>
			<path fill="#005DA4" d="M261.754,22.397c-0.207-0.056-0.377-0.134-0.512-0.213c0.248-0.208-0.152,0.126-0.004,0.004l0.02,0.027
				c0.035,0.057,0.107,0.234,0.127,0.29c0.053,0.163,0.146,0.342,0.262,0.514c0.117-0.248,0.221-0.531,0.459-0.482
				c0.117,0.024,0.184,0.108,0.236,0.229l0.031,0.072c-0.062-0.037-0.088-0.083-0.156-0.098c-0.125-0.025-0.229,0.098-0.25,0.242
				c-0.01,0.063-0.008,0.101-0.012,0.166c0.154-0.067,0.25-0.097,0.408-0.064c0.148,0.031,0.111,0.074,0.154,0.238
				c0,0-0.051-0.003-0.172-0.028c-0.104-0.021-0.189,0.002-0.268,0.077c0.18,0.172-0.129,0.556-0.127,0.528
				c0.057-0.363,0.037-0.431-0.277-0.495c-0.176-0.037-0.289,0.072-0.467,0.037c-0.07-0.016-0.113-0.037-0.188-0.047
				c0.139-0.168,0.293-0.174,0.496-0.17c-0.057-0.306-0.193-0.434-0.373-0.635c-0.016-0.019-0.053-0.067-0.09-0.12
				c-0.078,0.206-0.191,0.491-0.293,0.668c-0.027,0.044-0.158-0.128-0.396-0.716c-0.037,0.085-0.088,0.18-0.109,0.211
				c-0.158,0.243-0.281,0.399-0.301,0.731c0.205-0.04,0.363-0.06,0.527,0.094c-0.074,0.024-0.115,0.054-0.188,0.082
				c-0.176,0.067-0.305-0.027-0.479,0.041c-0.314,0.121-0.592,0.449-0.49,0.821c0.008,0.028,0.035,0.031,0.045,0.055l0.006,0.07
				c-0.121-0.049-0.213-0.103-0.252-0.246c-0.074-0.274,0.113-0.454,0.275-0.666c-0.092-0.064-0.18-0.075-0.283-0.035
				c-0.121,0.046-0.191,0.123-0.248,0.258l-0.006-0.071c0.023-0.18,0.061-0.348,0.209-0.405c0.158-0.062,0.262-0.047,0.426-0.002
				c-0.012-0.068-0.016-0.107-0.033-0.173c-0.041-0.147-0.162-0.258-0.285-0.21c-0.068,0.026-0.088,0.079-0.146,0.129l0.021-0.081
				c0.039-0.137,0.096-0.236,0.213-0.281c0.238-0.092,0.379,0.188,0.527,0.429c0.098-0.199,0.172-0.404,0.205-0.585
				c0.012-0.061,0.064-0.259,0.094-0.325c-0.105,0.053-0.23,0.1-0.369,0.138c-0.611,0.164-1.365-0.82-1.195-0.787
				c0.434,0.083,0.953-0.181,0.697-0.131c-0.254,0.049-0.625-0.066-0.938-0.59c-0.312-0.525-0.242-1.164-0.156-1.033
				c0.301,0.463,1.137,0.64,0.98,0.558c-0.352-0.186-0.887-0.503-1.008-1.229c-0.17-1.018,0.326-1.477,0.326-1.477
				s0.951,0.098,1.066,2.197c0,0,0.027,0.033,0.111-0.098c0.088-0.131,0.199-0.115,0.355-0.247s0.213-0.328,0.213-0.508
				s-0.057-0.246-0.184-0.295s-0.426-0.229-0.426-0.229s0.609,0.049,0.426-0.066c-0.186-0.115-0.496-0.099-0.496-0.099l0.084-0.131
				c0,0,0.285-0.082,0.469-0.196c0.186-0.116,0.127-0.197,0.426-0.05c0.299,0.148,0.156,0.64,0.115,1.099
				c-0.035,0.368,0.096,0.515,0.148,0.559c0.053-0.044,0.184-0.191,0.148-0.559c-0.043-0.459-0.186-0.951,0.113-1.099
				c0.299-0.147,0.242-0.065,0.428,0.05c0.184,0.114,0.469,0.196,0.469,0.196l0.086,0.131c0,0-0.314-0.017-0.498,0.099
				c-0.186,0.115,0.426,0.066,0.426,0.066s-0.299,0.18-0.426,0.229c-0.129,0.049-0.186,0.115-0.186,0.295s0.057,0.376,0.215,0.508
				c0.154,0.131,0.27,0.115,0.354,0.247c0.086,0.131,0.115,0.098,0.115,0.098c0.111-2.099,1.064-2.197,1.064-2.197
				s0.496,0.459,0.326,1.477c-0.121,0.727-0.656,1.043-1.008,1.229c-0.156,0.083,0.678-0.094,0.98-0.558
				c0.084-0.131,0.156,0.508-0.158,1.033c-0.311,0.524-0.682,0.64-0.938,0.59c-0.254-0.049,0.266,0.214,0.697,0.131
				C263.117,21.577,262.365,22.562,261.754,22.397z"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.5576" stroke-miterlimit="3.8637" d="
				M251.955,15.118"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#000000" stroke-width="0.5576" stroke-miterlimit="3.8637" d="
				M252.234,15.64"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#005DA4" stroke-width="1.0448" stroke-miterlimit="3.8637" d="
				M255.576,12.818c0,0-0.779-0.41-1.807,0"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#005DA4" stroke-width="1.0448" stroke-miterlimit="3.8637" d="
				M253.787,12.748v1.36c0,0,0.062,0.81,0.885,1.01"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#005DA4" stroke-width="1.0448" stroke-miterlimit="3.8637" d="
				M255.557,12.768l0.01,1.36c0,0-0.037,0.74-0.932,0.99"/>
		</g>
		<g>
			
				<line fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#005DA4" stroke-width="1.0448" stroke-miterlimit="3.8637" x1="255.557" y1="13.429" x2="253.777" y2="13.429"/>
		</g>
		<g>
			
				<line fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#005DA4" stroke-width="1.0448" stroke-miterlimit="3.8637" x1="255.549" y1="14.147" x2="253.77" y2="14.147"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#FFFFFF" stroke-width="1.0448" stroke-miterlimit="3.8637" d="
				M261.654,20.04c0,0-0.783-0.402-1.822,0"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#FFFFFF" stroke-width="1.0448" stroke-miterlimit="3.8637" d="
				M259.85,19.971v1.332c0,0,0.064,0.793,0.895,0.99"/>
		</g>
		<g>
			
				<path fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#FFFFFF" stroke-width="1.0448" stroke-miterlimit="3.8637" d="
				M261.637,19.991l0.008,1.333c0,0-0.035,0.724-0.938,0.97"/>
		</g>
		<g>
			
				<line fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#FFFFFF" stroke-width="1.0448" stroke-miterlimit="3.8637" x1="261.637" y1="20.638" x2="259.84" y2="20.638"/>
		</g>
		<g>
			
				<line fill-rule="evenodd" clip-rule="evenodd" fill="none" stroke="#FFFFFF" stroke-width="1.0448" stroke-miterlimit="3.8637" x1="261.627" y1="21.342" x2="259.832" y2="21.342"/>
		</g>
		<g>
			<g>
				<path fill="#FFFFFF" d="M244.259,15.376c-0.581,0.437-1.113-0.247-1.113-0.247c-0.021,1.32-0.64,2.475-0.64,2.475
					s-0.825,1.525-2.021,1.484c-0.758-0.026-1.014-0.856-1.031-0.928c-0.205-0.825,0.434-1.433,0.434-1.433
					c0.697-0.845,2.05-2.172,2.248-2.568c0.268-0.537,0.508-2.939-1.301-3.176c-1.34-0.175-1.318-0.464-1.318-0.464
					c-0.207-0.928,1.195-0.567,1.195-0.567s-0.783-1.093-2.31,0.269s-0.227,2.537,0.474,2.454c0.701-0.082,1.65-0.721,2.125-0.247
					c0.475,0.474,0.762,1.402-0.64,2.847c-1.402,1.443-1.835,1.732-1.505,3.071c0.354,1.439,2.083,1.712,2.846,1.135
					C244.042,17.71,244.341,15.315,244.259,15.376z M240.069,11.739c-0.97,0.291-1.96,0.134-1.241-0.915c0,0,0,0.699,1.666,0.64
					c0.545-0.019,1.01,0.661,1.01,0.661S240.837,11.509,240.069,11.739z"/>
			</g>
		</g>
		<rect x="257.85" y="9.149" fill-rule="evenodd" clip-rule="evenodd" fill="#005DA4" width="0.111" height="17.388"/>
	</g>
	<g>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M416.434,16.972c-0.762-0.003-1.023-0.219-1.107-0.219
			c-0.25,0.711-0.879,2.59-0.879,2.805c-0.002,0.347,0.213,0.546,0.793,0.598c0.33,0.034,0.395,0.049,0.395,0.117
			c0,0.132-0.033,0.347-0.082,0.347c-0.629-0.001-1.209-0.085-1.838-0.089c-0.795-0.001-1.49,0.08-1.604,0.08
			c-0.051,0-0.051-0.232-0.049-0.381c0-0.032,0.033-0.065,0.164-0.082c0.58-0.081,0.828-0.164,0.979-0.609
			c1.035-3.191,1.719-5.811,2.605-9.051c-0.646,0.198-0.289,0.111-1.135,0.49l-0.115-0.463c0.664-0.347,0.588-0.376,1.418-0.655
			c0.418-1.835,0.484-1.935,1.096-1.933c0.133,0.001,0.447,0.001,0.447,0.217c-0.002,0.363-0.186,1.091-0.336,1.455
			c0.662-0.18,1.539-0.36,2.234-0.358c0.979,0.002,1.553,1.047,1.535,1.94C420.898,13.645,418.305,16.976,416.434,16.972
			L416.434,16.972z M415.695,15.363c-0.002,0.414,0.211,0.96,0.889,0.962c1.607,0.005,3.109-3.727,3.045-5.002
			c-0.029-0.842-0.557-1.341-1.318-1.343c-0.447-0.001-0.895,0.113-1.309,0.228L415.695,15.363L415.695,15.363z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M424.779,10.561c-0.002,0.431-0.135,1.125-0.338,1.903h0.033
			c0.582-0.975,1.848-3.206,2.773-3.204c0.432,0.002,0.908,0.269,0.908,0.748c-0.002,0.496-0.334,0.794-0.846,0.792
			c-0.15,0-0.283-0.067-0.396-0.167c-0.117-0.1-0.199-0.215-0.281-0.216c-0.547-0.002-1.895,2.758-2.262,3.601
			c-0.248,0.562-0.9,2.876-1.363,2.875c-0.215-0.001-0.68-0.101-0.68-0.333c0.002-0.132,0.42-1.24,0.852-2.579
			c0.318-0.975,0.635-1.95,0.637-2.497c0.002-0.38-0.064-0.91-0.66-0.912c-0.33-0.001-0.746,0.627-0.961,0.974
			c-0.117-0.049-0.281-0.166-0.348-0.232c0.316-0.678,1.148-2.066,1.941-2.063C424.5,9.253,424.781,10.032,424.779,10.561
			L424.779,10.561z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M431.947,9.273c1.604,0.004,2.709,1.298,2.705,2.87
			c-0.008,2.3-1.9,4.777-4.283,4.771c-1.67-0.005-2.527-1.431-2.523-3.002C427.852,11.744,429.629,9.268,431.947,9.273
			L431.947,9.273z M430.438,16.369c1.951,0.005,2.889-3.368,2.893-4.841c0.002-0.86-0.408-1.706-1.387-1.708
			c-1.818-0.005-2.854,3.054-2.857,4.543C429.084,15.238,429.295,16.365,430.438,16.369L430.438,16.369z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M440.518,9.579c-1.246,1.271-2.326,3.253-2.332,5.106
			c0,0.629,0.279,1.092,0.924,1.094c1.523,0.004,3.516-2.638,3.52-4.143c0.004-1.34-0.676-1.045-0.674-1.442
			c0-0.496,0.268-0.893,0.746-0.892c0.746,0.002,0.875,0.615,0.891,1.31c0.043,2.134-2.582,6.33-4.998,6.324
			c-1.074-0.003-1.486-1.063-1.484-1.941c0.004-1.439,1.268-3.389,2.197-4.561c-0.463,0-0.943-0.069-1.439-0.071
			c-0.531,0-1.672,0.112-1.674,0.906c0,0.365,0.445,0.381,0.445,0.747c-0.002,0.33-0.316,0.577-0.631,0.576
			c-0.381,0-0.561-0.299-0.561-0.663c0.002-0.976,1.115-2.214,1.578-2.528c0.166-0.115,0.414-0.114,0.596-0.114
			c0.48,0.001,0.959,0.07,1.439,0.07c0.447,0.002,0.912-0.063,1.322-0.062L440.518,9.579L440.518,9.579z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M444.781,10.915c0.283-0.529,1.576-1.584,2.221-1.6
			c0.547,0.001,0.828,0.25,0.826,0.78c-0.002,0.546-1.918,4.876-1.918,5.373c0,0.182,0.164,0.331,0.412,0.332
			c0.529,0.001,1.328-1.138,1.709-1.501c0.066,0,0.297,0.183,0.297,0.25c-0.564,0.875-1.859,2.41-2.984,2.407
			c-0.496-0.001-0.844-0.218-0.844-0.746c0.002-0.663,1.916-4.728,1.92-5.439c0-0.182-0.1-0.298-0.281-0.298
			c-0.281,0-0.762,0.412-1.012,0.691L444.781,10.915L444.781,10.915z M447.977,5.994c0.432,0.002,0.777,0.334,0.775,0.764
			c0,0.431-0.35,0.777-0.779,0.775c-0.432,0-0.762-0.349-0.758-0.78C447.215,6.324,447.547,5.993,447.977,5.994L447.977,5.994z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M456.73,14.753c-0.432,0.661-2.24,2.227-3.018,2.226
			c-0.281-0.001-0.66-0.151-0.66-0.5c0.002-0.679,2.098-4.908,2.102-5.785c0-0.248-0.23-0.465-0.578-0.465
			c-1.324-0.004-3.318,3.119-3.469,3.465c-0.115,0.265-0.516,0.942-0.648,1.323c-0.365,0.958-0.801,1.95-1.146,1.949
			c-0.215,0-0.629-0.118-0.629-0.382c0.002-0.149,1.115-2.778,1.268-3.141c0.182-0.446,0.717-1.917,0.717-2.348
			c0-0.198-0.131-0.447-0.395-0.447c-0.58-0.001-1.029,0.99-1.113,0.99c-0.049,0-0.312-0.182-0.312-0.283
			c0-0.147,1.098-2.031,2.041-2.028c0.629,0.001,0.744,0.481,0.742,1.011c-0.002,0.496-0.203,1.207-0.42,1.902l0.033,0.032
			c0.764-1.024,2.541-2.938,3.947-2.934c0.678,0.001,1.205,0.367,1.205,0.896c-0.004,0.662-0.367,1.555-0.852,2.662
			c-0.166,0.38-0.949,2.248-0.949,2.48c-0.002,0.115,0.082,0.198,0.23,0.198c0.48,0.002,1.342-0.79,1.641-1.12L456.73,14.753
			L456.73,14.753z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M462.635,15.531c0,0.016-0.018,0.016-0.018,0.033
			c-0.598,0.924-1.344,1.436-2.467,1.433c-1.426-0.005-2.365-1.082-2.361-2.423c0.006-2.516,1.885-5.223,4.432-5.215
			c0.613,0,1.754,0.235,1.75,1.03c0,0.414-0.248,0.661-0.662,0.66c-0.414-0.001-0.445-0.282-0.494-0.565
			c-0.049-0.297-0.148-0.579-0.709-0.581c-1.787-0.004-2.988,2.723-2.992,4.213c-0.002,0.991,0.375,1.919,1.566,1.923
			c0.664,0.002,1.227-0.294,1.674-0.757L462.635,15.531L462.635,15.531z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M464.35,10.969c0.283-0.529,1.576-1.584,2.223-1.599
			c0.547,0.001,0.826,0.25,0.824,0.779c0,0.547-1.916,4.876-1.918,5.374c0,0.182,0.164,0.331,0.414,0.331
			c0.527,0.001,1.326-1.137,1.709-1.501c0.064,0.001,0.295,0.184,0.295,0.249c-0.564,0.876-1.859,2.411-2.982,2.408
			c-0.496-0.001-0.846-0.217-0.844-0.748c0.002-0.661,1.916-4.726,1.92-5.438c0-0.182-0.1-0.297-0.283-0.299
			c-0.281,0-0.762,0.412-1.01,0.693L464.35,10.969L464.35,10.969z M467.547,6.049c0.43,0.001,0.777,0.333,0.775,0.763
			c-0.002,0.431-0.35,0.776-0.781,0.776c-0.43-0.001-0.76-0.35-0.758-0.78C466.785,6.377,467.115,6.048,467.547,6.049L467.547,6.049
			z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M473.072,9.388c0.943,0.002,1.887,0.287,1.881,1.379
			c-0.004,1.919-3.166,2.456-4.623,2.518c-0.051,0.381-0.135,0.745-0.135,1.125c-0.002,0.86,0.459,1.656,1.402,1.66
			c0.844,0,1.373-0.328,1.971-0.938c0.084,0.017,0.281,0.133,0.314,0.282c-0.664,1.007-1.658,1.617-2.85,1.614
			c-1.541-0.004-2.164-1.114-2.16-2.505C468.877,12.339,470.607,9.381,473.072,9.388L473.072,9.388z M473.006,9.851
			c-1.342-0.004-2.225,1.946-2.559,3.054c1.16-0.096,3.344-0.602,3.35-2.158C473.797,10.25,473.551,9.854,473.006,9.851
			L473.006,9.851z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M488.516,10.543c-0.035-2.409-1.582-3.98-2.723-4.645
			c-0.791-0.349-1.834-0.435-2.545-0.437c-1.357-0.003-2.004,0.094-2.008,1.153l-0.053,10.433l-1.48-0.004l0.025-8.334
			c0.021-2.265-0.109-2.91-0.723-2.912c-0.197-0.001-0.727,0.064-1.041,0.064c-0.066-0.001-0.066-0.249-0.066-0.332
			c0-0.1,0-0.149,0.281-0.214c1.109-0.229,3.758-0.403,5.182-0.399c0.91,0.003,1.77,0.088,2.58,0.305
			c2.248,0.618,4.363,3.001,4.342,5.278L488.516,10.543L488.516,10.543z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M493.643,15.24c-0.004,0.662-0.004,1.291,1.254,1.294
			c0.098,0,0.113,0.083,0.113,0.231c0,0.149,0,0.232-0.131,0.232c-0.58-0.002-1.158-0.086-1.738-0.087
			c-0.629-0.003-1.291,0.077-1.92,0.076c-0.066,0-0.066-0.032-0.066-0.132l0.002-0.149c0-0.166,0.033-0.183,0.363-0.198
			c0.729-0.047,0.863-0.295,0.865-1.189l0.01-3.674c0-0.314-0.148-0.513-0.494-0.613c-0.066-0.017-0.496-0.134-0.496-0.366
			c0-0.099,0.051-0.149,0.232-0.231l1.227-0.559c0.363-0.164,0.645-0.296,0.693-0.296c0.1,0,0.135,0.1,0.135,0.149l-0.039,1.704
			l0.033,0.034c0.533-0.678,1.297-1.884,2.305-1.88c0.596,0.001,0.943,0.284,0.941,0.895c-0.002,0.347-0.332,0.645-0.68,0.644
			c-0.447-0.002-0.611-0.3-1.109-0.301c-0.395-0.002-0.91,0.56-1.244,0.973l-0.248,0.313L493.643,15.24L493.643,15.24z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M498.379,12.453c-0.033,0.232-0.033,0.463-0.033,0.695
			c-0.004,1.44,1.1,2.882,2.605,2.887c0.613,0.001,1.043-0.229,1.873-0.972l0.297,0.217c-0.664,1.074-1.66,1.832-2.984,1.829
			c-1.686-0.004-3.055-1.63-3.051-3.468c0.006-1.952,1.336-4.182,3.502-4.176c1.473,0.003,2.514,1.116,2.51,2.489l-0.002,0.512
			L498.379,12.453L498.379,12.453z M501.26,11.998c0.215,0.001,0.465-0.312,0.467-0.595c0.002-0.81-0.609-1.391-1.42-1.393
			c-0.992-0.003-1.676,1.138-1.842,2.063L501.26,11.998L501.26,11.998z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M504.719,11.346c0.002-0.314-0.146-0.513-0.312-0.546
			l-0.547-0.135c-0.049-0.016-0.098-0.066-0.098-0.182c0-0.05,0.018-0.166,0.098-0.182c0.828-0.213,1.955-0.822,2.057-0.822
			c0.064,0,0.064,0.133,0.064,0.198l-0.004,1.142c0.779-0.609,1.66-1.335,2.719-1.333c1.439,0.003,2.049,0.816,2.045,2.207
			l-0.01,4.037c-0.002,0.712,0.543,0.713,1.09,0.714c0.033,0,0.064,0.034,0.064,0.116v0.298c0,0.033-0.031,0.049-0.082,0.049
			c-0.664-0.002-1.094-0.086-1.639-0.088c-0.596-0.001-1.176,0.08-1.77,0.079c-0.117,0-0.115-0.298-0.115-0.365
			c0-0.049,0.066-0.099,0.166-0.099c0.264,0.001,1.023,0.003,1.025-0.494l0.012-3.889c0.002-1.026-0.309-1.606-1.469-1.609
			c-0.695-0.003-1.557,0.409-2.037,0.887l-0.014,4.303c0,0.363,0,0.793,1.141,0.796c0.033,0,0.033,0.1,0.033,0.232
			c0,0.149-0.018,0.231-0.051,0.231c-0.646-0.001-1.373-0.085-1.721-0.087c-0.596-0.002-1.191,0.079-1.787,0.077
			c-0.115,0-0.148-0.05-0.148-0.116V16.62c0.002-0.198,0.051-0.198,0.281-0.197c0.729,0.002,0.994-0.096,0.996-0.874L504.719,11.346
			L504.719,11.346z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M513.074,11.038c0-0.545-0.229-0.546-0.791-0.548
			c-0.168-0.001-0.301-0.001-0.299-0.217c0-0.148,0.184-0.297,0.35-0.412c0.562-0.413,1.426-1.105,1.873-1.618
			c0.148,0.002,0.215,0.035,0.215,0.183c-0.002,0.431-0.051,0.894-0.055,1.308l2.086,0.006c0.199,0,0.199,0.034,0.199,0.364
			c-0.002,0.332-0.035,0.381-0.184,0.38l-2.137-0.005l-0.01,4.335c-0.004,0.711,0.178,1.374,1.021,1.376
			c0.545,0.001,0.961-0.345,1.176-0.84l0.281,0.231c-0.283,0.91-0.98,1.57-1.973,1.567c-0.91-0.002-1.77-0.501-1.766-1.51
			L513.074,11.038L513.074,11.038z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M519.691,10.858c0.777-0.611,1.658-1.336,2.717-1.333
			c1.439,0.004,2.049,0.816,2.045,2.207l-0.012,4.038c-0.002,0.711,0.543,0.713,1.092,0.714c0.033,0,0.064,0.034,0.064,0.117v0.297
			c0,0.032-0.033,0.05-0.084,0.05c-0.66-0.003-1.092-0.086-1.639-0.088c-0.594-0.001-1.176,0.08-1.77,0.078
			c-0.115,0-0.115-0.298-0.115-0.364c0-0.05,0.066-0.099,0.166-0.099c0.266,0.001,1.025,0.002,1.027-0.495l0.012-3.888
			c0.002-1.025-0.311-1.605-1.469-1.609c-0.697-0.001-1.559,0.409-2.039,0.888l-0.012,4.303c-0.002,0.363-0.002,0.794,1.141,0.797
			c0.033,0,0.033,0.099,0.031,0.231c0,0.149-0.018,0.231-0.049,0.231c-0.645-0.001-1.373-0.087-1.723-0.088
			c-0.594-0.001-1.189,0.08-1.785,0.078c-0.117,0-0.148-0.05-0.148-0.116v-0.149c0-0.199,0.049-0.198,0.281-0.198
			c0.729,0.002,0.992-0.096,0.996-0.875l0.023-8.935c0.004-1.042,0.004-1.109-0.641-1.375c-0.248-0.1-0.479-0.183-0.479-0.315
			c0-0.134,0.166-0.183,0.844-0.444l1.211-0.443c0.031-0.017,0.197-0.083,0.248-0.083c0.115,0,0.115,0.166,0.115,0.264
			c-0.002,0.796-0.037,1.606-0.041,2.4L519.691,10.858L519.691,10.858z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#171F69" d="M527.643,12.534c-0.031,0.232-0.035,0.464-0.035,0.696
			c-0.004,1.439,1.102,2.882,2.607,2.886c0.611,0.002,1.043-0.229,1.873-0.972l0.297,0.217c-0.666,1.073-1.66,1.833-2.984,1.829
			c-1.688-0.005-3.057-1.631-3.051-3.467c0.004-1.953,1.334-4.183,3.504-4.177c1.471,0.004,2.512,1.115,2.508,2.488l-0.004,0.514
			L527.643,12.534L527.643,12.534z M530.523,12.079c0.215,0.002,0.465-0.313,0.465-0.594c0.002-0.811-0.607-1.393-1.42-1.395
			c-0.992-0.001-1.672,1.139-1.842,2.065L530.523,12.079L530.523,12.079z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#386AB3" d="M474.879,19.89c1.59,1.115,3.529,1.766,5.619,1.772
			c5.439,0.015,9.861-4.384,9.879-9.824l-3.355-0.008c0.078,3.713-2.967,6.681-6.516,6.582c-1.4-0.038-2.697-0.479-3.76-1.229
			L474.879,19.89L474.879,19.89z"/>
	</g>
	<g>
		<path fill="#FCAF17" d="M23.965,69.988c0,0-0.983-0.852-1.067-1.333c-0.097-0.551,0.442-1.48,1.005-2.254
			c0.864,0.645,1.743,1.552,1.839,2.103c0.084,0.482-0.61,1.485-0.61,1.485h2.361c-0.009-0.008-0.95-0.934-0.95-1.417
			c0-0.55,0.756-1.448,1.524-2.18c0.768,0.731,1.523,1.629,1.523,2.18c0,0.482-0.94,1.408-0.949,1.417h2.36
			c0,0-0.694-1.003-0.61-1.485c0.096-0.551,0.975-1.458,1.839-2.103c0.563,0.774,1.102,1.703,1.005,2.254
			c-0.084,0.481-1.067,1.333-1.067,1.333h2.242c-0.14-0.312-0.604-0.963-0.316-1.616c0.35-0.793,2.014-2.101,2.597-1.962
			c-0.963,1.359-1.395,2.422-1.791,3.578c0.232,0.387,0.214,1.078-0.003,1.45H21.236c-0.217-0.372-0.235-1.062-0.003-1.45
			c-0.396-1.155-0.828-2.219-1.792-3.578c0.583-0.139,2.248,1.168,2.598,1.962c0.288,0.653-0.176,1.303-0.316,1.616H23.965z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#FCAF17" points="6.319,89.812 13.695,89.812 13.695,80.623 
			18.598,89.812 28.069,89.812 28.069,72.428 19.444,72.428 19.444,81.902 14.405,72.428 6.319,72.428 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" points="28.069,89.812 36.695,89.812 36.695,84.204 
			41.745,84.204 41.745,89.812 49.328,89.812 49.328,72.428 41.745,72.428 41.745,78.112 36.695,78.112 36.695,72.428 
			28.069,72.428 		"/>
		<path fill="#ED1B2F" d="M25.25,87.457l-0.042-0.033c-0.231,0.15-0.431,0.14-0.662-0.059c0.048-0.71,0.436-0.757,1.032-0.63
			c0.1,0.022,0.205,0.06,0.307,0.065c0.19,0.01,0.312-0.146,0.273-0.396c-0.058-0.379-0.085-0.611-0.09-0.834
			c-0.479,0.1-1.027-0.117-1.459,0.223l-0.042,0.034c-0.606-0.896-0.688-2.554,0.247-3.337c-0.06-0.161-0.263-0.372-0.509-0.627
			c-0.229-0.236-0.474-0.488-0.656-0.771c0.114-0.646,0.908-1.146,1.682-1.715c-0.247,0.745-0.125,1.218,0.251,1.926
			c0.149,0.279,0.315,0.53,0.44,0.754c0.121,0.216,0.16,0.432,0.15,0.614c0.11,0.187,0.421,0.592,0.658,0.592
			c0.17,0,0.267-0.131,0.267-0.31c0-0.988-1.461-1.658-1.461-2.915c0-0.881,0.55-1.289,1.065-1.289c0.498,0,0.693,0.374,0.596,0.708
			c0.354,0.148,0.263,0.532,0.183,0.856c-0.12,0.489-0.108,0.775,0.129,1.385c-0.2-0.021-0.666-0.65-0.883-1.148
			c-0.208-0.476-0.289-1.048,0.201-1.094c0.041-0.149-0.103-0.288-0.243-0.288c-0.372,0-0.601,0.323-0.601,0.855
			c0,1.066,1.529,1.73,1.529,2.942c0,0.558-0.421,0.875-0.793,0.875c-0.293,0-0.532-0.158-0.703-0.376
			c-0.055,0.795,0.526,1.046,1.253,0.976c-0.166,0.693-0.123,1.811,0.084,2.505c-0.264,0.074-0.587,0.321-0.647,0.611
			c0.144,0.232,0.19,0.511,0.009,0.759c-0.337,0.083-0.618-0.288-0.752-0.605l-0.075-0.016c-0.214,0.241-0.454,0.64-0.808,0.555
			C25.126,88.172,25.008,87.661,25.25,87.457z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M24.134,87.665c-0.04-0.111,0.226-0.617,0.514-0.617
			c0.172,0,0.226,0.412,0.147,0.463C24.756,87.536,24.429,87.488,24.134,87.665z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M25.204,88.758c-0.119-0.052-0.31-0.675-0.089-0.906
			c0.146-0.155,0.492,0.275,0.401,0.333C25.284,88.334,25.236,88.728,25.204,88.758z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M26.741,88.912c0.101-0.008,0.368-0.417,0.174-0.805
			c-0.071-0.142-0.576,0.005-0.486,0.112C26.565,88.382,26.776,88.645,26.741,88.912z"/>
		<path fill="#ED1B2F" d="M22.294,78.35c-0.167-0.515-0.267-1.222-0.758-1.361c0.258-0.301-0.022-0.754-0.07-0.722
			c-0.251,0.169-0.591,0.276-0.815,0.042c-0.047-0.352,0.241-0.551,0.525-0.645l-0.002-0.04c-0.261-0.152-0.463-0.49-0.374-0.816
			c0.231-0.157,0.524-0.08,0.69,0.078l0.027-0.025C21.391,74.604,21.213,74.2,21.443,74c0.185-0.135,0.926-0.129,0.697,0.719
			c-0.103,0.379-0.104,0.61,0.094,0.904c0.141,0.21,0.792,1.07,1.084,1.353c-0.039,0.025-0.078,0.05-0.116,0.078
			C22.779,77.346,22.385,77.751,22.294,78.35z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M21.001,73.708c0.315-0.068,0.803,0.145,0.774,0.356
			c-0.024,0.179-0.434,0.214-0.442,0.162C21.303,74.043,21.034,73.895,21.001,73.708z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.287,74.916c0.111-0.151,0.634-0.352,0.825-0.108
			c0.133,0.17-0.236,0.516-0.269,0.449C20.717,75.004,20.437,75.046,20.287,74.916z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.25,76.139c-0.043,0.04-0.03,0.442,0.635,0.297
			c0.145-0.032,0.015-0.552-0.152-0.479C20.677,75.982,20.422,76.261,20.25,76.139z"/>
		<path fill="#0099DA" d="M25.094,76.043c-0.164-0.164-0.403-0.203-0.644-0.203c-0.369,0-0.638,0.185-0.963,0.201
			c-0.308,0.015-0.509-0.112-0.611-0.298c-0.124-0.227-0.055-0.606,0.21-0.685c-0.072,0.263,0.019,0.655,0.516,0.655
			c0.298,0,0.484-0.077,0.829-0.077c0.323,0,0.604,0.145,0.727,0.291L25.094,76.043z"/>
		<path fill="#ED1B2F" d="M24.11,76.114l0.026-0.049c0.66,0.341,1.151,0.009,0.942-0.662c-0.292-0.22-0.807-0.02-1.004,0.062
			c-0.132-0.225-0.227-0.576-0.234-0.831c0.354-0.508,2.376-1.125,2.821-1.283c0.039,0.164-0.036,0.45-0.11,0.609
			c0.23-0.088,0.539-0.143,0.763-0.083c0.017,0.35-0.041,0.671-0.312,1.038c0.188,0.151,0.351,0.56,0.351,1.052
			c0,0.728-0.334,1.257-0.521,1.915c-0.063,0.222-0.077,0.377-0.059,0.604c-0.245-0.131-0.382-0.362-0.482-0.612
			c-0.153,0.379-0.59,0.807-1.062,1.156c-0.854,0.633-1.884,1.283-1.856,2.02c-0.205-0.184-0.335-0.45-0.418-0.682
			c-0.535,0.414-0.526,0.326-0.72,1.07c-0.052-0.103-0.208-0.307-0.356-0.295c-0.111,0.237-0.307,0.479-0.611,0.433
			c-0.24-0.274-0.094-0.719,0.125-0.882l-0.021-0.042c-0.27,0.036-0.704-0.092-0.792-0.396c0.041-0.278,0.42-0.363,0.623-0.357
			v-0.049c-0.263-0.089-0.533-0.431-0.601-0.653c0.296-0.599,0.763-0.359,1.018,0.087c0.162,0.28,0.236,0.332,0.424,0.309
			c0.171-0.021,0.361-0.229,0.534-0.396c-0.172-0.962,0.335-1.544,0.894-1.93c0.524-0.361,1.503-0.557,1.472-0.734
			c-0.283,0.042-0.617,0.018-0.765-0.081C24.024,76.347,24.042,76.248,24.11,76.114z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#FCAF17" d="M25.469,74.188c-0.268,0.089-0.583,0.199-0.839,0.331
			c0.22,0.104,0.456,0.177,0.579,0.146C25.361,74.629,25.381,74.356,25.469,74.188z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.129,79.198c0.075-0.13,0.598-0.419,0.808-0.194
			c0.146,0.156-0.16,0.521-0.206,0.446C20.585,79.211,20.295,79.265,20.129,79.198z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.736,81.534c-0.016,0.077,0.27,0.39,0.74,0.024
			c0.138-0.107-0.206-0.53-0.323-0.387C21.089,81.25,21.022,81.492,20.736,81.534z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.165,80.685c0.001-0.175,0.377-0.712,0.634-0.619
			c0.201,0.072,0.148,0.536,0.048,0.486C20.598,80.428,20.321,80.688,20.165,80.685z"/>
		<path fill="#ED1B2F" d="M21.874,82.733c0.456-0.773,1.417-0.964,2.352-0.595c0.111,0.125,0.188,0.22,0.222,0.312
			c-0.702,0.588-0.825,1.684-0.589,2.565c-0.401,0.276-0.761,0.503-1.049,0.928c-0.224-0.215-0.373-0.087-0.513-0.011
			c-0.001,0.289-0.148,0.739-0.498,0.705c-0.314-0.225-0.279-0.763-0.166-1.017l-0.046-0.046c-0.28,0.11-0.688,0.086-0.9-0.187
			c0.069-0.3,0.331-0.48,0.55-0.521l0.004-0.041c-0.267-0.058-0.339-0.34-0.405-0.554c0.119-0.13,0.268-0.203,0.468-0.203
			c0.369,0,0.541,0.213,0.667,0.43c0.048,0.083,0.156,0.377,0.273,0.377c0.333,0,0.487-0.328,0.567-0.496
			C22.39,84.035,21.881,83.291,21.874,82.733z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.349,84.328c0.024-0.099,0.559-0.321,0.787-0.139
			c0.136,0.108-0.042,0.407-0.173,0.418C20.917,84.61,20.622,84.359,20.349,84.328z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M20.376,85.854c-0.06-0.098,0.155-0.698,0.455-0.715
			c0.211-0.011,0.251,0.459,0.159,0.456C20.716,85.587,20.45,85.834,20.376,85.854z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M21.319,86.971c0.053,0.036,0.712,0.001,0.74-0.454
			c0.014-0.233-0.478-0.384-0.469-0.188C21.6,86.546,21.523,86.815,21.319,86.971z"/>
		<g>
			<polygon fill="#FCAF17" points="29.088,73.359 30.948,73.359 30.948,74.039 29.088,74.039 29.088,73.359 			"/>
			<path fill="#FCAF17" d="M30.018,73.699"/>
		</g>
		<g>
			<polygon fill="#FCAF17" points="33.193,73.359 35.055,73.359 35.055,74.039 33.193,74.039 33.193,73.359 			"/>
			<path fill="#FCAF17" d="M34.124,73.699"/>
		</g>
		<g>
			<polygon fill="#FCAF17" points="29.088,80.765 30.948,80.765 30.948,81.444 29.088,81.444 29.088,80.765 			"/>
			<path fill="#FCAF17" d="M30.018,81.104"/>
		</g>
		<g>
			<polygon fill="#FCAF17" points="33.193,80.765 35.055,80.765 35.055,81.444 33.193,81.444 33.193,80.765 			"/>
			<path fill="#FCAF17" d="M34.124,81.104"/>
		</g>
		<g>
			<polygon fill="#FCAF17" points="28.829,88.233 30.69,88.233 30.69,88.912 28.829,88.912 28.829,88.233 			"/>
			<path fill="#FCAF17" d="M29.759,88.572"/>
		</g>
		<path fill="#FCAF17" d="M29.641,77.367c-0.113-0.117-0.126-0.224-0.164-0.399c-0.036-0.176-0.091-0.396-0.314-0.682
			c-0.209,0.105-0.348,0.092-0.542,0.006c0.185-0.176,0.302-0.337,0.348-0.427c-0.15-0.055-0.333-0.138-0.445-0.226
			c0.113-0.174,0.285-0.247,0.48-0.297c-0.134-0.138-0.239-0.321-0.316-0.465c0.553-0.217,0.808,0.116,0.84,0.667
			c0.01,0.111,0.094,0.209,0.156,0.291c0.062,0.081,0.185,0.205,0.279,0.316l-0.028,0.232
			C29.893,76.727,29.831,77.131,29.641,77.367z"/>
		<path fill="#FCAF17" d="M30.068,78.09c-0.35,0.159-0.66,0.109-0.795-0.148c0.722-0.121,0.882-0.796,0.956-1.403
			c0.045-0.366,0.079-0.695,0.108-0.986c0.024-0.245,0.052-0.466,0.106-0.6c-0.157-0.178-0.103-0.479-0.113-0.647
			c0.209,0.01,0.455,0.107,0.612,0.262c0.181-0.055,0.48-0.059,0.688,0.002c0.176-0.189,0.476-0.255,0.709-0.221
			c-0.117,0.184-0.097,0.418-0.217,0.56c0.163,0.376,0.185,1.276,0.231,1.715c-0.078,0.689-0.694,1.286-1.193,1.656
			c0.004,0.107,0.036,0.208,0.034,0.316c-0.162,0.259-0.325,0.343-0.551,0.521c-0.188,0.146-0.407,0.34-0.606,0.753
			c0.107,0.301-0.02,0.505-0.318,0.628c-0.016-0.14-0.041-0.386-0.179-0.466c-0.11,0.146-0.288,0.271-0.483,0.283
			c-0.067-0.158-0.061-0.361,0.003-0.507c-0.166,0.041-0.334,0.073-0.496-0.006c0.095-0.569,0.442-0.563,0.87-0.574
			c0.04,0,0.139-0.001,0.169-0.035C29.803,79.002,30.068,78.09,30.068,78.09z"/>
		<path fill="#FCAF17" d="M33.34,79.662c-0.249,0.2-0.504,0.314-0.779,0.437c-0.025,0.139-0.079,0.297-0.219,0.348
			c-0.069-0.103-0.179-0.315-0.276-0.385c-0.043,0.212-0.182,0.393-0.336,0.525c-0.159-0.094-0.218-0.324-0.207-0.484
			c-0.133,0.102-0.292,0.186-0.44,0.235c-0.135-0.701,0.515-0.922,1.029-0.786c0.134-0.058,0.267-0.134,0.372-0.193
			c-0.12-0.146-0.229-0.383-0.185-0.567c0.278-0.078,0.69-0.536,1.004-0.609c0.019,0.19,0.131,0.43,0.24,0.597
			C33.215,78.973,33.232,79.415,33.34,79.662z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M31.885,74.988c0.046,0.112-0.325,0.354-0.397,0.408
			c-0.018-0.124-0.034-0.272-0.012-0.3C31.503,75.059,31.794,75.013,31.885,74.988z"/>
		<path fill="#0099DA" d="M31.09,76.275c-0.197-0.058-0.197-0.261-0.196-0.413c0.086-0.024,0.199,0.034,0.298,0.029
			c-0.012-0.143-0.106-0.211-0.193-0.274c0.01-0.035,0.022-0.068,0.035-0.093c0.188,0.028,0.273,0.032,0.463,0.017
			c0.014,0.028,0.025,0.071,0.028,0.096c-0.091,0.057-0.221,0.116-0.237,0.254c0.122,0.007,0.246-0.034,0.317-0.003
			c-0.008,0.151-0.014,0.341-0.21,0.392c0.07,0.331-0.083,0.593-0.173,0.633C31.122,76.854,31.009,76.6,31.09,76.275z"/>
		<path fill="#FCAF17" d="M30.097,85.594c-0.351,0.158-0.679,0.09-0.824-0.184c1.111-0.187,0.878-1.663,1.093-2.495
			c0.061-0.238,0.122-0.453,0.196-0.576c-0.123-0.177-0.025-0.543-0.014-0.665c0.206,0.043,0.434,0.187,0.566,0.364
			c0.188-0.025,0.483,0.019,0.679,0.113c0.203-0.16,0.515-0.19,0.741-0.118c-0.144,0.164-0.189,0.437-0.306,0.531
			c0.125,0.435,0.076,1.058,0.126,1.525c-0.078,0.689-0.694,1.286-1.193,1.656c0.004,0.107,0.036,0.208,0.034,0.316
			c-0.162,0.258-0.324,0.343-0.551,0.52c-0.188,0.146-0.398,0.333-0.602,0.732c0.087,0.326-0.024,0.526-0.323,0.65
			c-0.016-0.14-0.039-0.386-0.178-0.466c-0.131,0.146-0.289,0.271-0.484,0.282c-0.067-0.157-0.056-0.353,0.007-0.507
			c-0.169,0.042-0.338,0.073-0.5-0.006c0.095-0.569,0.442-0.563,0.87-0.573c0.04-0.001,0.139-0.002,0.169-0.035
			C29.803,86.471,30.097,85.594,30.097,85.594z"/>
		<path fill="#FCAF17" d="M33.062,87.161c-0.233,0.186-0.329,0.255-0.587,0.405c-0.009,0.138-0.064,0.346-0.211,0.399
			c-0.062-0.12-0.192-0.354-0.293-0.435c-0.048,0.212-0.187,0.395-0.34,0.526c-0.158-0.093-0.208-0.304-0.21-0.486
			c-0.13,0.097-0.288,0.188-0.437,0.238c-0.15-0.618,0.493-0.878,1.009-0.743c0.117-0.029,0.206-0.104,0.302-0.171
			c-0.155-0.19-0.214-0.417-0.153-0.657c0.353-0.145,0.703-0.548,1.057-0.572c-0.027,0.192-0.028,0.47,0.024,0.604
			C33.062,86.409,32.884,86.861,33.062,87.161z"/>
		<path fill="#FCAF17" d="M29.628,84.821c-0.098-0.111-0.115-0.218-0.151-0.386c-0.036-0.176-0.091-0.395-0.314-0.681
			c-0.209,0.104-0.348,0.092-0.542,0.005c0.083-0.087,0.291-0.339,0.351-0.44c-0.149-0.04-0.308-0.12-0.448-0.213
			c0.113-0.174,0.299-0.249,0.495-0.298c-0.115-0.138-0.255-0.303-0.351-0.456c0.509-0.254,0.831,0.134,0.871,0.691
			c0.008,0.08,0.047,0.14,0.094,0.199l0.052,0.065c0.065,0.085,0.176,0.192,0.27,0.303C29.91,84.054,29.844,84.543,29.628,84.821z"
			/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M30.678,74.998c-0.046,0.112,0.313,0.35,0.385,0.404
			c0.018-0.125,0.034-0.273,0.012-0.3C31.047,75.064,30.769,75.022,30.678,74.998z"/>
		<path fill="#FCAF17" d="M33.553,85.281c-0.685,0.047-1.357,0.815-2.052,0.577c0.488-0.371,1.065-0.949,1.145-1.612
			c0.253,0.074,0.375,0.021,0.662-0.025c0.31-0.049,0.681-0.099,1.04,0.147c0.398,0.065,0.729-0.166,0.729-0.396
			c0-0.258-0.171-0.315-0.381-0.315c-0.45,0-0.829,0.22-1.279,0.22c-0.449,0-0.816-0.302-0.816-0.911
			c0-0.638,0.569-0.962,1.088-0.802c0.198-0.412,0.641,0.008,1.202,0.007c0.266,0,0.479-0.083,0.727-0.308
			c0.074,0.253-0.215,0.581-0.674,0.782c-0.599,0.263-1.389,0.327-1.351-0.118c-0.278-0.113-0.576,0.116-0.576,0.427
			c0,0.258,0.161,0.469,0.409,0.469c0.425,0,0.819-0.208,1.312-0.208c0.357,0,0.804,0.162,0.804,0.747
			c0,0.639-0.646,0.862-0.971,0.875c0.042,0.49,0.227,0.618,0.652,0.663c0.022,0.449-0.156,0.958-0.327,1.362
			c0.088,0.167,0.125,0.29,0.107,0.524c-0.14-0.033-0.294-0.094-0.403-0.172c-0.058,0.206-0.212,0.442-0.417,0.548
			c-0.138-0.041-0.194-0.198-0.242-0.325c-0.113,0.106-0.312,0.222-0.479,0.206c-0.178-0.523,0.221-0.858,0.679-0.876
			c0.083-0.149,0.211-0.411,0.184-0.588c-0.259,0.068-0.42,0.188-0.6,0.39c-0.178-0.177-0.216-0.458-0.216-0.706
			C33.507,85.669,33.537,85.465,33.553,85.281z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M31.963,82.633c0.029,0.118-0.375,0.298-0.455,0.34
			c0-0.125,0.008-0.275,0.035-0.298C31.575,82.642,31.87,82.642,31.963,82.633z"/>
		<path fill="#0099DA" d="M30.974,83.786c-0.185-0.088-0.154-0.278-0.129-0.428c0.089-0.011,0.186,0.068,0.296,0.078
			c0.022-0.132-0.08-0.239-0.156-0.314c0.016-0.034,0.033-0.064,0.048-0.087c0.182,0.057,0.266,0.075,0.456,0.091
			c0.01,0.03,0.014,0.073,0.013,0.099c-0.099,0.042-0.232,0.086-0.271,0.221c0.131,0.03,0.247,0.008,0.313,0.05
			c-0.032,0.148-0.069,0.342-0.278,0.342c-0.127,0.282,0.009,0.47-0.065,0.607C31.009,84.355,30.837,84.102,30.974,83.786z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#0099DA" d="M30.769,82.449c-0.062,0.104,0.256,0.396,0.319,0.461
			c0.037-0.12,0.075-0.264,0.057-0.294C31.124,82.574,30.854,82.487,30.769,82.449z"/>
		<path fill="#FCAF17" d="M33.555,77.813c-0.673,0.044-1.355,0.807-2.038,0.583c0.485-0.373,1.048-0.946,1.121-1.602l-0.002-0.019
			c0.259,0.079,0.38,0.025,0.671-0.021c0.31-0.049,0.651-0.094,1.034,0.135c0.399,0.064,0.729-0.167,0.729-0.397
			c0-0.258-0.171-0.315-0.382-0.315c-0.45,0-0.829,0.219-1.279,0.219c-0.448,0-0.815-0.301-0.815-0.912
			c0-0.637,0.57-0.961,1.088-0.801c0.198-0.412,0.647,0,1.208-0.001c0.266,0,0.479-0.083,0.727-0.308
			c0.074,0.252-0.215,0.58-0.674,0.781c-0.599,0.263-1.395,0.335-1.356-0.109c-0.277-0.112-0.576,0.116-0.576,0.428
			c0,0.257,0.161,0.469,0.409,0.469c0.425,0,0.819-0.208,1.312-0.208c0.357,0,0.803,0.162,0.803,0.745
			c0,0.592-0.553,0.827-0.894,0.869c-0.022,0.008-0.05,0.013-0.081,0.014c0.073,0.505,0.737,0.596,1.123,0.637
			c0.023,0.463-0.193,0.992-0.372,1.4c0.091,0.178,0.105,0.317,0.09,0.517c-0.139-0.033-0.276-0.092-0.401-0.176
			c-0.064,0.218-0.229,0.455-0.419,0.552c-0.138-0.042-0.206-0.204-0.242-0.327c-0.141,0.113-0.299,0.234-0.479,0.208
			c-0.177-0.523,0.25-0.88,0.683-0.878c0.064-0.107,0.288-0.473,0.244-0.613c-0.194,0.023-0.424,0.12-0.611,0.352l-0.049,0.069
			C33.845,78.82,33.555,78.239,33.555,77.813z"/>
		<g>
			<g>
				<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#002157" points="54.488,89.812 55.579,89.812 55.579,84.68 
					55.538,83.875 58.888,89.812 60.416,89.812 60.416,82.612 59.306,82.612 59.306,87.776 59.347,88.651 55.924,82.612 
					54.488,82.612 				"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M64.652,89.935c1.528,0,2.659-0.968,2.659-2.903
					c0-1.843-0.836-2.923-2.587-2.923c-1.558,0-2.658,1.08-2.658,2.984C62.066,88.886,63.023,89.935,64.652,89.935z M64.713,89.069
					c-1.191,0-1.568-0.927-1.568-2.027c0-1.009,0.326-2.078,1.548-2.078c1.243,0,1.538,1.08,1.538,2.067
					C66.231,88.091,65.925,89.069,64.713,89.069z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M71.018,89.935c1.527,0,2.658-0.968,2.658-2.903
					c0-1.843-0.835-2.923-2.586-2.923c-1.559,0-2.659,1.08-2.659,2.984C68.431,88.886,69.388,89.935,71.018,89.935z M71.079,89.069
					c-1.191,0-1.568-0.927-1.568-2.027c0-1.009,0.325-2.078,1.547-2.078c1.242,0,1.538,1.08,1.538,2.067
					C72.596,88.091,72.291,89.069,71.079,89.069z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M75.163,89.812h1.06v-3.992
					c0.254-0.367,0.764-0.774,1.385-0.774c0.315,0,0.468,0.021,0.683,0.071l0.162-0.896c-0.132-0.041-0.356-0.091-0.683-0.091
					c-0.743,0-1.283,0.468-1.547,0.865v-0.744h-1.06V89.812z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M81.405,89.904c0.631,0,1.069-0.316,1.365-0.59v0.499h1.059
					v-7.679H82.77v2.098c-0.326-0.092-0.54-0.122-0.998-0.122c-1.508,0-2.75,0.978-2.75,2.913
					C79.022,89.466,80.367,89.904,81.405,89.904z M81.548,89.019c-0.835,0-1.457-0.55-1.457-1.966c0-1.11,0.469-2.088,1.691-2.088
					c0.479,0,0.754,0.082,0.988,0.153v3.402C82.536,88.672,82.016,89.019,81.548,89.019z"/>
				<rect x="85.143" y="86.452" fill-rule="evenodd" clip-rule="evenodd" fill="#002157" width="3.035" height="0.886"/>
				<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#002157" points="89.665,89.812 90.754,89.812 90.754,86.635 
					94.451,86.635 94.451,89.812 95.541,89.812 95.541,82.612 94.451,82.612 94.451,85.76 90.754,85.76 90.754,82.612 
					89.665,82.612 				"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M99.777,89.935c1.528,0,2.659-0.968,2.659-2.903
					c0-1.843-0.835-2.923-2.587-2.923c-1.558,0-2.658,1.08-2.658,2.984C97.19,88.886,98.148,89.935,99.777,89.935z M99.838,89.069
					c-1.192,0-1.568-0.927-1.568-2.027c0-1.009,0.326-2.078,1.548-2.078c1.243,0,1.538,1.08,1.538,2.067
					C101.356,88.091,101.05,89.069,99.838,89.069z"/>
				<rect x="103.922" y="82.134" fill-rule="evenodd" clip-rule="evenodd" fill="#002157" width="1.059" height="7.679"/>
				<rect x="106.845" y="82.134" fill-rule="evenodd" clip-rule="evenodd" fill="#002157" width="1.06" height="7.679"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M110.99,89.895c0.958,0,1.528-0.479,1.833-0.692
					c0.091,0.488,0.672,0.671,1.191,0.671c0.082,0,0.153,0,0.225-0.01l0.05-0.825c-0.265-0.02-0.509-0.091-0.509-0.438v-2.912
					c0-1.141-0.733-1.569-2.108-1.569c-0.845,0-1.559,0.214-1.915,0.367l0.214,0.804c0.326-0.082,0.937-0.255,1.466-0.255
					c0.896,0,1.304,0.163,1.304,0.938v0.621l-1.222,0.02c-0.968,0.01-2.21,0.306-2.21,1.681
					C109.31,89.344,109.931,89.895,110.99,89.895z M111.244,89.049c-0.529,0-0.896-0.213-0.896-0.845
					c0-0.509,0.438-0.855,1.202-0.875l1.191-0.052v1.284C112.528,88.651,111.835,89.049,111.244,89.049z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M115.848,89.812h1.059v-4.195
					c0.397-0.234,0.988-0.581,1.589-0.581c0.896,0,1.038,0.469,1.038,1.375v3.401h1.05v-3.554c0-1.05-0.102-2.149-1.772-2.149
					c-0.795,0-1.437,0.428-1.905,0.754v-0.611h-1.059V89.812z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M124.403,89.904c0.631,0,1.069-0.316,1.364-0.59v0.499h1.06
					v-7.679h-1.06v2.098c-0.326-0.092-0.539-0.122-0.998-0.122c-1.508,0-2.75,0.978-2.75,2.913
					C122.02,89.466,123.364,89.904,124.403,89.904z M124.545,89.019c-0.835,0-1.456-0.55-1.456-1.966c0-1.11,0.468-2.088,1.69-2.088
					c0.479,0,0.754,0.082,0.988,0.153v3.402C125.533,88.672,125.014,89.019,124.545,89.019z"/>
			</g>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M54.488,79.628h1.101v-6.325h1.15
					c1.08,0,1.548,0.52,1.548,1.508c0,1.009-0.673,1.497-1.793,1.497h-0.448v0.886h0.387c2.027,0,2.994-1.1,2.994-2.424
					c0-1.507-0.978-2.343-2.464-2.343h-2.475V79.628z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M60.599,79.628h1.059v-3.993
					c0.255-0.366,0.764-0.774,1.385-0.774c0.315,0,0.468,0.021,0.682,0.071l0.163-0.896c-0.133-0.04-0.356-0.091-0.683-0.091
					c-0.744,0-1.283,0.468-1.548,0.866v-0.744h-1.059V79.628z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M67.046,79.75c1.527,0,2.658-0.967,2.658-2.902
					c0-1.844-0.835-2.923-2.586-2.923c-1.558,0-2.659,1.08-2.659,2.985C64.458,78.701,65.416,79.75,67.046,79.75z M67.106,78.885
					c-1.191,0-1.568-0.926-1.568-2.027c0-1.007,0.325-2.077,1.548-2.077c1.242,0,1.538,1.08,1.538,2.068
					C68.624,77.907,68.319,78.885,67.106,78.885z"/>
				<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#002157" points="72.332,79.628 73.726,79.628 75.763,74.067 
					74.664,74.067 73.431,77.632 73.054,78.813 72.718,77.652 71.619,74.067 70.467,74.067 				"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M76.904,79.628h1.07v-5.561h-1.07V79.628z M77.423,73.151
					l0.815-0.815l-0.815-0.804l-0.794,0.804L77.423,73.151z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M79.827,79.628h1.059v-4.196
					c0.397-0.233,0.988-0.581,1.589-0.581c0.896,0,1.039,0.469,1.039,1.375v3.401h1.049v-3.554c0-1.049-0.102-2.149-1.772-2.149
					c-0.794,0-1.436,0.428-1.904,0.754v-0.611h-1.059V79.628z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M88.952,79.73c0.581,0,1.028-0.113,1.344-0.194l-0.162-0.835
					c-0.286,0.041-0.642,0.143-1.101,0.143c-1.527,0-1.945-0.642-1.945-2.027c0-1.354,0.703-2.006,1.649-2.006
					c0.611,0,0.948,0.122,1.284,0.265l0.305-0.814c-0.336-0.173-0.814-0.337-1.589-0.337c-1.68,0-2.739,1.121-2.739,2.903
					C85.999,78.875,86.864,79.73,88.952,79.73z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M91.65,79.628h1.069v-5.561H91.65V79.628z M92.169,73.151
					l0.814-0.815l-0.814-0.804l-0.794,0.804L92.169,73.151z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#002157" d="M96.946,79.75c0.846,0,1.548-0.163,1.854-0.264l-0.173-0.846
					c-0.346,0.082-1.039,0.224-1.436,0.224c-1.079,0-1.894-0.245-1.915-1.762h3.657v-0.377c0-1.803-0.642-2.801-2.129-2.801
					c-1.476,0-2.597,0.764-2.597,3.015C94.207,79.099,95.275,79.75,96.946,79.75z M95.296,76.359c0.081-1.089,0.621-1.66,1.385-1.66
					c0.784,0,1.151,0.672,1.14,1.66H95.296z"/>
			</g>
		</g>
	</g>
	<g>
		<path d="M243.011,72.989c-0.142,0-0.299,0-0.449-0.017v2.142h-0.763v-5.602c0.416-0.017,0.871-0.033,1.378-0.033
			c1.287,0,2,0.647,2,1.643C245.177,72.218,244.281,72.989,243.011,72.989 M243.094,70.109c-0.208,0-0.374,0-0.532,0.008v2.208
			c0.142,0.025,0.299,0.033,0.457,0.033c0.83-0.008,1.361-0.456,1.361-1.162C244.38,70.499,243.974,70.109,243.094,70.109"/>
		<path d="M248.01,73.264h-0.033v1.851h-0.756v-4.317c0.283-0.016,0.772-0.024,1.287-0.024c1.003,0,1.585,0.398,1.585,1.162
			c0,0.73-0.547,1.162-1.295,1.236c0.108,0.116,0.232,0.282,0.375,0.456l1.168,1.487h-0.945L248.01,73.264z M248.409,71.354
			c-0.183,0-0.308,0.009-0.432,0.025v1.353c0.132,0.008,0.299,0.017,0.457,0.017c0.523,0,0.862-0.291,0.862-0.739
			C249.296,71.571,248.957,71.354,248.409,71.354"/>
		<path d="M254.09,75.181c-1.404,0-2.061-0.905-2.061-2.183c0-1.428,1.014-2.267,2.191-2.267c1.27,0,2.084,0.756,2.084,2.184
			C256.305,74.359,255.309,75.181,254.09,75.181 M254.164,71.379c-0.707,0-1.328,0.54-1.328,1.552c0,0.88,0.357,1.594,1.303,1.594
			c0.754,0,1.352-0.515,1.352-1.545C255.49,71.936,254.977,71.379,254.164,71.379"/>
		<path d="M259.445,73.205c0.141,0.357,0.266,0.731,0.365,1.104h0.008c0.117-0.365,0.232-0.747,0.365-1.079l0.955-2.433h0.789
			l-1.693,4.317h-0.863l-1.678-4.317h0.84L259.445,73.205z"/>
		<rect x="263.73" y="70.798" width="0.756" height="4.316"/>
		<path d="M269.883,75.114l-1.627-2.531c-0.174-0.266-0.348-0.582-0.475-0.847h-0.006c0.016,0.275,0.033,0.564,0.033,1.029v2.35
			h-0.73v-4.316h0.994l1.604,2.49c0.182,0.274,0.357,0.572,0.506,0.863h0.008c-0.025-0.282-0.033-0.747-0.033-1.387l-0.008-1.966
			h0.738v4.316H269.883z"/>
		<path d="M275.182,75.172c-1.387,0-2.107-0.805-2.107-2.125c0-1.237,0.695-2.307,2.289-2.307c0.309,0,0.664,0.041,0.963,0.124
			l-0.074,0.672c-0.322-0.1-0.646-0.158-0.963-0.158c-0.938,0-1.412,0.689-1.412,1.593c0,0.997,0.525,1.535,1.463,1.535
			c0.34,0,0.697-0.083,0.961-0.207l0.066,0.664C276.02,75.098,275.613,75.172,275.182,75.172"/>
		<rect x="278.521" y="70.798" width="0.754" height="4.316"/>
		<polygon points="282.598,74.508 284.283,74.508 284.283,75.115 281.842,75.115 281.842,70.798 284.283,70.798 284.283,71.387 
			282.598,71.387 282.598,72.608 284.199,72.608 284.199,73.18 282.598,73.18 		"/>
		<polygon points="292.902,70.142 292.902,71.96 294.887,71.96 294.887,72.575 292.902,72.575 292.902,75.115 292.139,75.115 
			292.139,69.512 294.994,69.512 294.994,70.142 		"/>
		<polygon points="297.859,74.467 299.404,74.467 299.404,75.115 297.104,75.115 297.104,70.798 297.859,70.798 		"/>
		<polygon points="301.373,75.114 301.373,70.798 303.812,70.798 303.812,71.387 302.127,71.387 302.127,72.607 303.73,72.607 
			303.73,73.18 302.127,73.18 302.127,74.508 303.812,74.508 303.812,75.114 		"/>
		<path d="M307.201,73.205c0.143,0.357,0.268,0.731,0.365,1.104h0.01c0.115-0.365,0.232-0.747,0.363-1.079l0.955-2.433h0.789
			l-1.693,4.317h-0.861l-1.678-4.317h0.838L307.201,73.205z"/>
		<path d="M313.123,75.181c-1.402,0-2.059-0.905-2.059-2.183c0-1.428,1.012-2.267,2.191-2.267c1.27,0,2.082,0.756,2.082,2.184
			C315.338,74.359,314.344,75.181,313.123,75.181 M313.197,71.379c-0.705,0-1.328,0.54-1.328,1.552c0,0.88,0.357,1.594,1.305,1.594
			c0.754,0,1.352-0.515,1.352-1.545C314.525,71.936,314.012,71.379,313.197,71.379"/>
		<polygon points="317.492,75.114 317.492,70.798 318.246,70.798 318.246,74.466 319.791,74.466 319.791,75.114 		"/>
		<path d="M324.516,75.114l-0.34-0.905h-1.918l-0.34,0.905h-0.764l1.676-4.316h0.863l1.66,4.316H324.516z M323.461,72.3
			c-0.092-0.241-0.174-0.506-0.24-0.713h-0.008c-0.051,0.216-0.135,0.465-0.225,0.705l-0.531,1.361h1.527L323.461,72.3z"/>
		<path d="M330.121,75.114l-1.627-2.531c-0.176-0.266-0.35-0.582-0.475-0.847h-0.008c0.018,0.275,0.033,0.564,0.033,1.029v2.35
			h-0.73v-4.316h0.996l1.602,2.49c0.184,0.274,0.357,0.572,0.508,0.863h0.008c-0.025-0.282-0.033-0.747-0.033-1.387l-0.01-1.966
			h0.74v4.316H330.121z"/>
		<path d="M334.955,75.14c-0.514,0-0.904-0.018-1.254-0.025v-4.317c0.365,0,0.988-0.016,1.477-0.016c1.42,0,2.316,0.622,2.316,2.117
			C337.494,74.434,336.406,75.14,334.955,75.14 M335.07,71.387c-0.182,0-0.424,0.009-0.613,0.017v3.08
			c0.133,0.017,0.391,0.025,0.58,0.025c0.979,0,1.66-0.489,1.66-1.569C336.697,71.911,336.15,71.387,335.07,71.387"/>
		<rect x="224.607" y="73.186" fill="#FFC425" width="12.093" height="1.928"/>
		<path fill="#7AC143" d="M217.694,94.45c2.704,2.091,5.806,3.34,9.459,3.34c3.606,0,6.801-1.273,9.486-3.314v-2.86
			c-2.471,2.516-5.673,3.827-9.486,3.827c-3.886,0-6.581-1.317-9.459-3.837V94.45"/>
		<path fill="#006AB6" d="M218.051,89.479l4.438-4.224c0,0-2.539-1.143-4.166-1.755c-0.425-0.201-0.698-0.604-0.698-1.07v-2.271
			c0,0.461,0.264,0.794,0.702,1.003c3.314,1.567,7.052,3.536,7.052,3.536l-5.454,6.226
			C219.293,90.509,218.681,90.011,218.051,89.479"/>
		<path fill="#006AB6" d="M225.642,93.134c-0.984-0.185-1.672-0.419-2.471-0.666l2.053-3.684c0,0,2.351-4.533,7.307-4.479
			c0.468,0.005,1.748,0.096,1.748,0.096s0.307-2.194-4.432-2.416c-3.969-0.186-5.696-2.599-6.675-3.557
			c-1.142-1.117-4.4-2.546-4.771-2.697c-0.45-0.166-0.778-0.655-0.778-1.156v-2.777c0,0.503,0.284,0.828,0.781,1.041
			c0.308,0.152,4.553,2.491,5.753,3.559c1.096,0.974,3.062,3.636,5.997,3.634h0.238c1.361-0.004,4.23-1.068,5.587-1.766
			c0.208-0.096,0.604-0.277,0.715-0.674l0.002,1.786c0,0.473-0.299,0.531-0.709,0.715c-0.766,0.393-2.53,1.185-2.53,1.185
			c0.171,0.061,0.254,0.096,0.382,0.154c2.138,1.054,2.328,3.017,2.328,3.017l0.115,1.7c0,0-1.837-0.384-3.324-0.384
			c-4.09,0-5.954,4.152-5.954,4.152L225.642,93.134"/>
	</g>
	<g>
		<g>
			<path fill="#00AEEF" d="M466.91,96.875c-1.727-1.725-1.533-3.559-3.26-5.286c-1.727-1.726-3.359-1.321-5.107-3.081
				c-1.561-1.568-1.531-3.559-3.26-5.285c-1.445-1.447-3.309-1.892-4.174-2.057l-0.309,1.78c0.818,0.079,2.143,0.47,3.391,1.716
				c1.729,1.729,1.699,3.719,3.258,5.286c1.75,1.76,3.383,1.354,5.107,3.082c1.729,1.727,1.535,3.562,3.26,5.285
				c1.594,1.595,3.797,1.733,5.383,3.007l0.971-1.56C470.133,98.459,468.553,98.518,466.91,96.875z"/>
		</g>
		<g>
			<path fill="#98002E" d="M461.273,77.136c4.156,0,7.527,3.558,7.527,7.948c0,3.253-1.855,6.043-4.504,7.273
				c0.328,0.465,0.566,0.934,0.775,1.405c3.342-1.466,5.68-4.796,5.68-8.679c0-5.236-4.244-9.48-9.479-9.48
				c-3.979,0-7.377,2.452-8.783,5.926c0.533,0.185,1.131,0.446,1.715,0.826C455.258,79.311,458.023,77.136,461.273,77.136z"/>
		</g>
		<g>
			<path fill="#00AEEF" d="M454.723,78.245c-0.527-0.258-1.061-0.596-1.605-1.145c-1.561-1.568-1.533-3.559-3.26-5.285
				c-1.447-1.447-3.309-1.891-4.176-2.057l-0.307,1.781c0.818,0.079,2.143,0.469,3.389,1.715c1.729,1.729,1.699,3.72,3.26,5.287
				c0.51,0.512,1.01,0.839,1.504,1.09C453.881,79.131,454.281,78.667,454.723,78.245z"/>
			<path fill="#00AEEF" d="M466.742,88.356c-2.037-1.304-3.617-1.246-5.26-2.889c-1.725-1.725-1.531-3.559-3.26-5.285
				c-0.598-0.598-1.184-0.938-1.766-1.203c-0.461,0.406-0.871,0.869-1.229,1.379c0.629,0.273,1.258,0.621,1.902,1.264
				c1.727,1.729,1.533,3.561,3.26,5.287c1.594,1.594,3.797,1.732,5.383,3.007L466.742,88.356z"/>
		</g>
		<g>
			<path fill="#98002E" d="M477.406,93.719h-2.26l-2.986-9.105h1.949l2.221,7.611l2.223-7.611h1.857L477.406,93.719z"/>
			<path fill="#98002E" d="M487.441,88.51h-4.318c0-1.165,0.729-2.822,2.277-2.822C486.947,85.688,487.441,87.217,487.441,88.51z
				 M489.188,89.64v-0.548c0-2.566-1.092-4.661-3.805-4.661c-2.533,0-4.117,2.204-4.117,4.698c0,2.842,1.422,4.79,4.408,4.79
				c0.98,0,2.131-0.146,3.041-0.491l-0.109-1.422c-0.729,0.401-1.822,0.639-2.641,0.639c-1.768,0-2.824-1.33-2.824-3.005H489.188z"
				/>
			<path fill="#98002E" d="M495.928,86.234c-0.238-0.091-0.492-0.108-0.748-0.108c-1.783,0-2.258,1.838-2.258,3.259v4.335h-1.82
				v-7.012c0-0.692-0.02-1.402-0.092-2.094h1.713l0.055,1.748c0.381-0.966,1.311-1.931,2.477-1.931c0.254,0,0.51,0,0.764,0.073
				L495.928,86.234z"/>
			<path fill="#98002E" d="M497.512,82.737v-1.766h1.82v1.766H497.512z M497.512,93.719v-9.105h1.82v9.105H497.512z"/>
			<path fill="#98002E" d="M501.918,82.737v-1.766h1.84v1.766H501.918z M501.426,97.853c-0.473,0-0.945-0.036-1.4-0.146l0.107-1.402
				c0.201,0.072,0.439,0.109,0.656,0.109c1.021,0,1.129-0.764,1.129-1.603V84.614h1.84V95.03
				C503.758,96.614,503.193,97.853,501.426,97.853z"/>
			<path fill="#98002E" d="M508.42,93.919c-0.947,0-1.893-0.127-2.787-0.437l0.109-1.457c0.766,0.4,1.641,0.601,2.496,0.601
				c0.838,0,1.875-0.401,1.875-1.365c0-2.06-4.48-1.385-4.48-4.244c0-1.876,1.857-2.586,3.443-2.586c0.82,0,1.693,0.146,2.457,0.4
				l-0.107,1.329c-0.656-0.273-1.492-0.438-2.203-0.438c-0.803,0-1.785,0.22-1.785,1.24c0,1.583,4.48,1.11,4.48,4.188
				C511.918,93.064,510.113,93.919,508.42,93.919z"/>
			<path fill="#98002E" d="M515.941,93.919c-0.947,0-1.895-0.127-2.785-0.437l0.107-1.457c0.768,0.4,1.641,0.601,2.496,0.601
				c0.838,0,1.877-0.401,1.877-1.365c0-2.06-4.48-1.385-4.48-4.244c0-1.876,1.857-2.586,3.441-2.586c0.82,0,1.693,0.146,2.459,0.4
				l-0.109,1.329c-0.656-0.273-1.494-0.438-2.205-0.438c-0.801,0-1.783,0.22-1.783,1.24c0,1.583,4.479,1.11,4.479,4.188
				C519.438,93.064,517.637,93.919,515.941,93.919z"/>
			<path fill="#98002E" d="M526.924,88.51h-4.316c0-1.165,0.729-2.822,2.277-2.822C526.432,85.688,526.924,87.217,526.924,88.51z
				 M528.672,89.64v-0.548c0-2.566-1.092-4.661-3.807-4.661c-2.531,0-4.115,2.204-4.115,4.698c0,2.842,1.42,4.79,4.406,4.79
				c0.984,0,2.133-0.146,3.043-0.491l-0.109-1.422c-0.729,0.401-1.822,0.639-2.641,0.639c-1.768,0-2.822-1.33-2.822-3.005H528.672z"
				/>
			<path fill="#98002E" d="M530.584,93.719V80.588h1.822v13.131H530.584z"/>
		</g>
		<g>
			<path fill="#98002E" d="M417.379,86.555c0,0.559-0.141,1.293-0.836,1.293c-0.664,0-0.836-0.759-0.836-1.293
				c0-0.541,0.172-1.252,0.844-1.252C417.248,85.303,417.379,85.999,417.379,86.555z M418.523,86.555
				c0-1.036-0.434-2.003-1.609-2.003c-0.51,0-1.027,0.263-1.244,0.735l-0.023-0.658h-1.014c0.023,0.325,0.039,0.666,0.039,1.13
				v4.425h1.068v-2.298c0.191,0.456,0.664,0.711,1.15,0.711C418.084,88.597,418.523,87.6,418.523,86.555z"/>
			<path fill="#98002E" d="M421.865,85.542c-0.109-0.038-0.225-0.054-0.334-0.054c-0.719,0-0.959,0.688-0.959,1.291v1.732h-1.066
				v-3.016c0-0.286-0.008-0.573-0.039-0.859h1.006l0.023,0.75c0.178-0.424,0.562-0.842,1.09-0.842c0.109,0,0.209,0.007,0.311,0.038
				L421.865,85.542z"/>
			<path fill="#98002E" d="M425.416,86.555c0,0.65-0.217,1.315-0.891,1.315c-0.664,0-0.889-0.673-0.889-1.315
				c0-0.588,0.217-1.275,0.889-1.275C425.223,85.28,425.416,85.959,425.416,86.555z M426.561,86.555
				c0-1.283-0.783-2.003-2.035-2.003c-1.191,0-2.035,0.735-2.035,2.003c0,1.246,0.75,2.042,2.035,2.042
				C425.785,88.597,426.561,87.809,426.561,86.555z"/>
			<path fill="#98002E" d="M429.668,88.512h-1.338l-1.238-3.883h1.123l0.82,3.078l0.812-3.078h1.066L429.668,88.512z"/>
			<path fill="#98002E" d="M431.68,83.911v-0.859h1.068v0.859H431.68z M431.68,88.512v-3.883h1.068v3.883H431.68z"/>
			<path fill="#98002E" d="M436.438,88.512v-2.266c0-0.465-0.078-0.928-0.65-0.928c-0.604,0-0.773,0.541-0.773,1.051v2.143h-1.068
				v-3.016c0-0.286-0.008-0.58-0.039-0.867h1.008l0.014,0.65c0.256-0.488,0.721-0.728,1.262-0.728c0.936,0,1.314,0.558,1.314,1.446
				v2.514H436.438z"/>
			<path fill="#98002E" d="M440.537,88.597c-1.27,0-2.057-0.772-2.057-2.042c0-1.252,0.857-2.003,2.086-2.003
				c0.371,0,0.75,0.055,1.105,0.163l-0.045,0.758c-0.248-0.116-0.518-0.193-0.797-0.193c-0.766,0-1.207,0.533-1.207,1.275
				c0,0.721,0.418,1.315,1.184,1.315c0.293,0,0.572-0.062,0.836-0.192l0.039,0.758C441.309,88.559,440.924,88.597,440.537,88.597z"
				/>
			<path fill="#98002E" d="M442.617,83.911v-0.859h1.066v0.859H442.617z M442.617,88.512v-3.883h1.066v3.883H442.617z"/>
			<path fill="#98002E" d="M447.318,86.27h-1.6c0-0.457,0.248-1.075,0.842-1.075C447.148,85.195,447.318,85.782,447.318,86.27z
				 M448.295,86.842v-0.24c0-1.176-0.496-2.05-1.74-2.05c-1.123,0-1.896,0.851-1.896,2.003c0,1.285,0.703,2.042,2.004,2.042
				c0.463,0,0.998-0.054,1.432-0.208l-0.047-0.72c-0.326,0.179-0.797,0.263-1.168,0.263c-0.656,0-1.152-0.418-1.16-1.09H448.295z"/>
		</g>
	</g>
	<g>
		<g>
			<path fill="#C4122F" d="M52.733,151.036c0,0,0.072-0.072,0-0.175c-0.112-0.163-0.343-0.16-0.527-0.128
				c-0.184,0.031-0.312,0.191-0.599,0.088c-0.287-0.104-0.566-0.472-0.766-0.654c-0.199-0.185-0.319-0.287-0.495-0.448
				c-0.175-0.159-0.208-0.397-0.208-0.397c0.431,0.223,0.663-0.192,0.663-0.192c-0.383,0.072-0.502-0.239-0.502-0.239
				c0.383,0.191,0.607-0.096,0.607-0.096s-0.328-0.048-0.344-0.304c-0.02-0.319-0.247-0.399-0.247-0.399
				c0.398-0.135,0.208-0.519,0.208-0.519s-0.072,0.16-0.28,0.12c-0.119-0.023-0.255-0.12-0.407-0.271
				c-0.315-0.314-0.583-0.406-0.67-0.431c-0.088-0.024-0.144-0.032-0.248-0.056c-0.253-0.059-0.551-0.057-0.67-0.057
				s-0.319,0.017-0.319,0.017s0.192-0.225,0.782-0.415c0.591-0.191,0.831-0.503,0.831-0.503c0.151,0.128,0.304,0.199,0.63,0.344
				c0.328,0.144,0.423,0.502,0.423,0.502c0.151-0.12,0.071-0.303,0.071-0.303s0.176,0.056,0.487,0.319
				c0.311,0.264,0.048,0.463,0.191,0.678c0.144,0.216,0.383,0.032,0.383,0.032c0.023,0.088,0.022,0.351,0.35,0.343
				c0.327-0.008,0.265-0.383,0.265-0.383c0.302,0.111,0.479-0.199,0.398-0.415c-0.06-0.161-0.247-0.231-0.247-0.231
				c0.23-0.098,0.273-0.23,0.245-0.34c-0.023-0.088-0.093-0.163-0.149-0.194c-0.071-0.041-0.127-0.056-0.199-0.064
				c-0.136-0.015-0.353,0.007-0.353,0.007c-0.375-0.176-0.66-0.445-0.804-0.589s-0.271-0.288-0.343-0.376
				c-0.072-0.088-0.135-0.158-0.135-0.158c0.215,0,0.295-0.112,0.295-0.112c-0.208-0.048-0.215-0.248-0.215-0.248
				c0.287-0.016,0.367-0.382,0.367-0.382c-0.248,0.103-0.328-0.04-0.328-0.04c0.295-0.168,0.408-0.56,0.519-0.839
				c0.112-0.279,0.351-0.367,0.351-0.367c-0.144-0.12-0.327-0.08-0.327-0.08c0.2-0.512,0.539-0.736,0.62-0.786v-1.661
				c-0.088,0.076-0.143,0.173-0.143,0.173s-0.056-0.103-0.143-0.11c-0.088-0.009-0.247,0-0.319,0.254
				c-0.086,0.305,0.087,0.559,0.087,0.559s-0.04,0.056-0.063,0.136c-0.092,0.308-0.264,0.504-0.678,0.654
				c-0.416,0.152-0.727,0.552-0.727,0.552c0.064-0.144-0.024-0.312-0.024-0.312s-0.303,0.184-0.582,0.071
				c-0.28-0.111-0.344-0.398-0.2-0.502c0.143-0.104,0.534-0.016,0.534-0.016c0.213-0.257,0.109-0.413-0.041-0.47
				c-0.074-0.028-0.159-0.032-0.222-0.011c-0.149,0.05-0.624,0.104-0.735-0.414c-0.004-0.019-0.008-0.037-0.011-0.056
				c-0.005-0.027-0.009-0.055-0.012-0.08c-0.053-0.456,0.203-0.584,0.678-0.511c0.519,0.08,0.59-0.248,0.598-0.447
				s-0.055-0.295-0.016-0.398c0.04-0.104,0.032-0.19-0.239-0.216c-0.032-0.003-0.062-0.005-0.088-0.005
				c-0.042,0-0.077,0.003-0.107,0.007c-0.149,0.021-0.188,0.074-0.379-0.059c-0.157-0.107-0.358-0.095-0.519-0.056
				c-0.159,0.039-0.279,0.104-0.279,0.104c-0.026-0.083-0.064-0.152-0.111-0.208c-0.181-0.224-0.491-0.255-0.711-0.119
				c-0.277,0.17-0.596,0.063-0.596,0.063s-0.011,0.159,0.045,0.255c0.194,0.334,0.639,0.232,0.639,0.232s-0.128,0.048-0.24,0.096
				c-0.111,0.048-0.311,0.184-0.422,0.311c-0.264,0.301-0.104,0.631-0.288,0.814c-0.15,0.15-0.343,0.199-0.343,0.199
				c0.191,0.24,0.503,0.192,0.503,0.192c-0.081,0.502-0.487,0.622-0.487,0.622c0.248,0.224,0.495,0.144,0.495,0.144
				c-0.008,0.519-0.415,0.702-0.415,0.702c0.582,0.239,0.782-0.048,0.782-0.048c-0.041,0.511-0.504,0.606-0.504,0.606
				c0.368,0.28,0.624,0.16,0.624,0.16s0.167,0.15,0.2,0.422c0.026,0.227-0.136,0.456-0.136,0.456
				c0.279,0.159,0.479-0.008,0.479-0.008c-0.423,0.662-0.782,1.068-1.149,1.364c-0.595,0.479-1.293,0.646-1.671,0.687
				c-0.181,0.019-0.387-0.014-0.547-0.066c-0.159-0.054-0.287-0.182-0.373-0.32c-0.127-0.206-0.223-0.733,0.054-1.074
				c0.344-0.425,0.894-0.352,1.17-0.181c0.277,0.17,0.17,0.553,0.17,0.553c0.479-0.521,0.063-0.872,0.063-0.872
				c0.926-0.319,0.82-1.267,0.49-1.67c-0.274-0.337-0.708-0.39-0.708-0.39c0.042-0.165,0.063-0.345,0.053-0.436
				c-0.011-0.091-0.032-0.17-0.075-0.234c-0.029-0.045-0.07-0.095-0.119-0.139c-0.043-0.038-0.092-0.07-0.146-0.091
				c-0.359-0.129-0.618,0.037-0.905-0.021c-0.237-0.048-0.352-0.282-0.352-0.282s-0.074,0.128-0.069,0.34
				c0.006,0.262,0.154,0.384,0.154,0.384c-0.649-0.165-0.707-1.006-0.707-1.006s-0.102,0.31-0.096,0.649
				c0.015,0.958,0.617,1.341,1.666,1.171c0.922-0.15,1.128,0.426,1.138,0.681c0.011,0.255-0.101,0.378-0.122,0.404
				c-0.022,0.026-0.027,0.032-0.064,0.074c-0.367,0.42-0.92,0.27-1.339,0.402c-0.161,0.051-0.3,0.151-0.3,0.151
				c-0.047-0.378-0.382-0.34-0.51-0.335s-0.213,0.048-0.213,0.048s0.256,0.039,0.335,0.318c0.106,0.379-0.309,0.814-0.117,1.544
				c0.093,0.356,0.256,0.648,0.857,0.878c0.601,0.229,1.444-0.043,1.444-0.043c-0.375,0.159-0.463,0.543-0.543,0.838
				c-0.08,0.296-0.375,0.232-0.375,0.232c0.207,0.286,0.495,0.222,0.495,0.222s-0.04,0.072-0.072,0.152
				c-0.099,0.246-0.128,0.591-0.128,0.591c-0.231-0.455-0.495-0.287-0.726-0.327c-0.387-0.067-0.24-0.392-0.24-0.392
				s-0.239,0.048-0.294,0.24c-0.057,0.191,0.095,0.279,0.095,0.279s-0.111-0.016-0.175-0.008c-0.064,0.008-0.215,0.017-0.304,0.176
				c-0.099,0.181-0.087,0.551-0.191,0.853c-0.078,0.227-0.328,0.32-0.328,0.32c0.184,0.2,0.375,0.072,0.375,0.072
				c-0.088,0.374-0.447,0.478-0.447,0.478c0.167,0.176,0.447,0.041,0.447,0.041c-0.072,0.406-0.407,0.446-0.407,0.446
				c0.288,0.224,0.495,0.023,0.495,0.023s0.096,0.512,0.224,0.734c0.285,0.499,0.822,0.288,1.181,0.352
				c0.269,0.048,0.606,0.128,0.742-0.223c0.171-0.443-0.271-0.423-0.271-0.423s0.056-0.12-0.017-0.184
				c-0.26-0.232-0.638,0.039-0.638,0.039c-0.232-0.16-0.359-0.502-0.336-0.727c0.08-0.748,0.375-0.678,0.687-0.479
				s0.766,0.087,0.766,0.087s-0.104,0.112-0.112,0.328c-0.008,0.216,0.224,0.406,0.224,0.406c-0.017-0.415,0.256-0.639,0.256-0.639
				c-0.104,0.408,0.167,0.528,0.167,0.528s-0.008-0.28,0.2-0.408s0.143-0.303,0.143-0.303c0.264,0.199,0.527-0.048,0.527-0.048
				c-0.184-0.039-0.311-0.112-0.367-0.255c-0.072-0.185,0.199-0.264,0.263-0.839c0.057-0.507-0.047-0.87-0.047-0.87
				c1.237,0.016,1.356,0.359,1.388,0.56c0.032,0.199-0.064,0.319-0.016,0.519c0.048,0.2,0.135,0.311,0.135,0.646
				s-0.287,0.319-0.287,0.319s0.056,0.055,0.144,0.087c0.243,0.089,0.431-0.04,0.431-0.04c-0.072,0.232,0.016,0.479,0.271,0.567
				c0.256,0.088,0.392,0.096,0.487,0.255c0.096,0.16-0.016,0.28-0.016,0.28c0.343-0.04,0.263-0.375,0.263-0.375
				c0.391,0.23,0.28,0.519,0.28,0.519c0.264-0.071,0.216-0.36,0.216-0.36c0.255,0.112,0.231,0.473,0.231,0.473
				c0.224-0.063,0.224-0.271,0.224-0.271s0.167,0.063,0.503,0.255s0.655,0.04,0.989,0.08c0.148,0.017,0.511,0.127,0.607-0.199
				C53.183,151.046,52.733,151.036,52.733,151.036z"/>
		</g>
		<g>
			<path fill="#EEBFB3" d="M45.777,143.898c-0.367,0.42-0.92,0.27-1.339,0.402c0,0,0.279-0.04,0.558-0.032
				c0.279,0.009,0.498-0.062,0.623-0.163C45.726,144.018,45.777,143.898,45.777,143.898z"/>
			<path fill="#EEBFB3" d="M45.133,141.504c-0.359-0.129-0.618,0.037-0.905-0.021c-0.237-0.048-0.352-0.282-0.352-0.282
				s0.051,0.244,0.167,0.32c0.12,0.08,0.294,0.088,0.526,0.032C44.891,141.476,45.133,141.504,45.133,141.504z"/>
			<path fill="#EEBFB3" d="M43.962,141.925c-0.649-0.165-0.707-1.006-0.707-1.006s-0.03,0.517,0.188,0.818
				c0.144,0.199,0.375,0.273,0.671,0.265c0.295-0.007,0.398-0.023,0.542,0.017c0,0-0.144-0.08-0.343-0.08
				C44.114,141.938,43.962,141.925,43.962,141.925z"/>
			<path fill="#EEBFB3" d="M45.934,146.862c-0.375,0.159-0.463,0.543-0.543,0.838c-0.08,0.296-0.375,0.232-0.375,0.232
				s0.453,0.198,0.541-0.344C45.645,147.046,45.934,146.862,45.934,146.862z"/>
			<path fill="#EEBFB3" d="M45.311,148.897c0,0,0.029-0.345,0.128-0.591c0,0-0.096,0.344-0.008,0.887
				C45.431,149.193,45.351,149.065,45.311,148.897z"/>
			<path fill="#EEBFB3" d="M43.971,148.69c-0.064,0.008-0.215,0.017-0.304,0.176c-0.099,0.181-0.087,0.551-0.191,0.853
				c-0.078,0.227-0.328,0.32-0.328,0.32s0.318-0.018,0.401-0.233c0.084-0.216,0.082-0.565,0.146-0.789
				C43.775,148.742,43.971,148.69,43.971,148.69z"/>
			<path fill="#EEBFB3" d="M43.583,150.067c-0.017,0.018-0.037,0.032-0.06,0.044c-0.088,0.374-0.447,0.478-0.447,0.478
				s0.227,0.007,0.411-0.237C43.587,150.221,43.583,150.067,43.583,150.067z"/>
			<path fill="#EEBFB3" d="M43.116,151.076c0,0,0.335-0.04,0.407-0.446c0.022-0.012,0.042-0.023,0.059-0.038
				c0,0-0.02,0.177-0.115,0.308C43.336,151.078,43.116,151.076,43.116,151.076z"/>
			<path fill="#EEBFB3" d="M49.585,139.49c-0.149,0.021-0.188,0.074-0.379-0.059c-0.157-0.107-0.358-0.095-0.519-0.056
				c0,0,0.26-0.036,0.433,0.103c0.08,0.063,0.15,0.12,0.254,0.104C49.478,139.566,49.585,139.49,49.585,139.49z"/>
			<path fill="#EEBFB3" d="M48.297,139.272c-0.181-0.224-0.491-0.255-0.711-0.119c-0.277,0.17-0.596,0.063-0.596,0.063
				s0.282,0.218,0.619,0.023C47.969,139.032,48.297,139.272,48.297,139.272z"/>
			<path fill="#EEBFB3" d="M46.38,141.124c0,0,0.193-0.049,0.343-0.199c0.184-0.184,0.024-0.514,0.288-0.814
				c0.111-0.127,0.311-0.263,0.422-0.311c0,0-0.306,0.184-0.39,0.471c-0.085,0.287-0.051,0.577-0.277,0.724
				C46.585,141.111,46.38,141.124,46.38,141.124"/>
			<path fill="#EEBFB3" d="M46.396,141.938c0,0,0.407-0.12,0.487-0.622c0,0,0.032,0.206-0.047,0.365
				C46.719,141.916,46.396,141.938,46.396,141.938z"/>
			<path fill="#EEBFB3" d="M46.477,142.784c0,0,0.38-0.085,0.456-0.326c0.063-0.202-0.041-0.376-0.041-0.376
				C46.884,142.601,46.477,142.784,46.477,142.784"/>
			<path fill="#EEBFB3" d="M46.755,143.343c0,0,0.463-0.096,0.504-0.606c0,0,0.083,0.143-0.008,0.354
				C47.159,143.302,46.755,143.343,46.755,143.343z"/>
			<path fill="#EEBFB3" d="M47.378,143.503c0,0,0.167,0.15,0.2,0.422c0.026,0.227-0.136,0.456-0.136,0.456s0.25-0.164,0.229-0.451
				C47.652,143.643,47.378,143.503,47.378,143.503z"/>
			<path fill="#EEBFB3" d="M47.921,144.373c-0.423,0.662-0.782,1.068-1.149,1.364c-0.595,0.479-1.293,0.646-1.671,0.687
				c0,0,1.036,0.016,1.788-0.614C47.675,145.148,47.921,144.373,47.921,144.373z"/>
			<path fill="#EEBFB3" d="M51.457,141.643c-0.092,0.308-0.264,0.504-0.678,0.654c-0.416,0.152-0.727,0.552-0.727,0.552
				s0.279-0.281,0.694-0.425c0.415-0.145,0.541-0.285,0.629-0.438C51.463,141.835,51.457,141.643,51.457,141.643z"/>
			<path fill="#EEBFB3" d="M52.39,146.264c-0.136-0.015-0.353,0.007-0.353,0.007c-0.375-0.176-0.66-0.445-0.804-0.589
				c0,0,0.185,0.283,0.405,0.454c0.219,0.172,0.347,0.255,0.347,0.255C52.152,146.267,52.39,146.264,52.39,146.264z"/>
			<path fill="#EEBFB3" d="M47.274,147.988c0,0,0.161-0.071,0.169-0.326c0.007-0.224-0.135-0.351-0.135-0.351
				c0.088-0.384,0.414-0.545,0.414-0.545s-0.369,0.072-0.52,0.512c0,0,0.095,0.11,0.119,0.351
				C47.345,147.868,47.274,147.988,47.274,147.988z"/>
			<path fill="#EEBFB3" d="M50.243,147.692c-0.119-0.023-0.255-0.12-0.407-0.271c-0.315-0.314-0.583-0.406-0.67-0.431
				c0,0,0.283,0.147,0.521,0.429C49.981,147.771,50.243,147.692,50.243,147.692z"/>
		</g>
		<g>
			<path fill="#DA7669" d="M45.398,141.733c-0.029-0.045-0.07-0.095-0.119-0.139c-0.043-0.038-0.092-0.07-0.146-0.091
				c0,0-0.243-0.028-0.564,0.05c-0.231,0.056-0.406,0.048-0.526-0.032c-0.116-0.076-0.167-0.32-0.167-0.32s-0.058,0.386,0.269,0.466
				c0.328,0.08,0.489-0.07,0.743,0.096c0.184,0.12,0.191,0.304,0.191,0.304s0.049-0.231-0.104-0.384
				c-0.096-0.096-0.335-0.088-0.335-0.088s0.313-0.05,0.487-0.008C45.295,141.627,45.398,141.733,45.398,141.733z"/>
			<path fill="#DA7669" d="M44.657,142.019c-0.144-0.04-0.247-0.023-0.542-0.017c-0.295,0.009-0.527-0.065-0.671-0.265
				c-0.218-0.302-0.188-0.818-0.188-0.818s-0.123,0.485,0.029,0.819c0.151,0.336,0.367,0.517,0.767,0.527
				c0.319,0.008,0.502-0.009,0.766,0.144c0,0-0.12-0.176-0.343-0.223c-0.224-0.048-0.439,0.008-0.671-0.104
				c0,0,0.271,0.048,0.463,0.024c0.192-0.024,0.415-0.008,0.662,0.198c0,0-0.016-0.071-0.079-0.143
				C44.785,142.091,44.657,142.019,44.657,142.019z"/>
			<path fill="#DA7669" d="M45.841,143.824c-0.022,0.026-0.027,0.032-0.064,0.074c0,0-0.051,0.119-0.158,0.207
				c-0.125,0.102-0.344,0.172-0.623,0.163c-0.279-0.008-0.558,0.032-0.558,0.032c-0.161,0.051-0.3,0.151-0.3,0.151
				s0.192-0.115,0.419-0.131c0.292-0.021,0.579,0.027,0.771-0.021c0.219-0.055,0.34-0.108,0.439-0.283
				C45.838,143.89,45.841,143.824,45.841,143.824z"/>
			<path fill="#DA7669" d="M46.309,146.56c0,0-0.067,0.087-0.163,0.167c-0.097,0.08-0.211,0.136-0.211,0.136
				s-0.289,0.184-0.377,0.727c-0.088,0.542-0.541,0.344-0.541,0.344s0.335,0.198,0.535-0.032c0.199-0.232,0.099-0.469,0.254-0.728
				C45.953,146.925,46.221,146.774,46.309,146.56z"/>
			<path fill="#DA7669" d="M45.511,148.154c0,0-0.04,0.072-0.072,0.152c0,0-0.096,0.345-0.008,0.887c0,0,0.12,0.168,0.256,0.287
				c0,0-0.181-0.287-0.216-0.846C45.455,148.379,45.511,148.154,45.511,148.154z"/>
			<path fill="#DA7669" d="M43.148,150.039c0,0,0.318-0.018,0.401-0.233c0.084-0.216,0.082-0.565,0.146-0.789
				c0.08-0.274,0.275-0.326,0.275-0.326c0.063-0.008,0.175,0.008,0.175,0.008s-0.214-0.007-0.323,0.171
				c-0.111,0.185-0.131,0.563-0.156,0.794C43.643,149.896,43.439,150.095,43.148,150.039z"/>
			<path fill="#DA7669" d="M43.077,150.589c0,0,0.227,0.007,0.411-0.237c0.1-0.131,0.096-0.284,0.096-0.284
				c0.021-0.02,0.038-0.043,0.052-0.065c0,0,0.037,0.188-0.096,0.38C43.38,150.613,43.077,150.589,43.077,150.589z"/>
			<path fill="#DA7669" d="M43.116,151.076c0,0,0.22,0.002,0.351-0.177c0.096-0.131,0.115-0.308,0.115-0.308
				c0.022-0.019,0.041-0.038,0.056-0.06c0,0,0.034,0.194-0.115,0.372C43.36,151.1,43.116,151.076,43.116,151.076z"/>
			<path fill="#DA7669" d="M49.78,139.488c-0.032-0.003-0.062-0.005-0.088-0.005c-0.042,0-0.077,0.003-0.107,0.007
				c0,0-0.108,0.076-0.212,0.092c-0.104,0.017-0.174-0.04-0.254-0.104c-0.173-0.139-0.433-0.103-0.433-0.103
				c-0.159,0.039-0.279,0.104-0.279,0.104c-0.026-0.083-0.064-0.152-0.111-0.208c0,0-0.329-0.24-0.688-0.032
				c-0.337,0.194-0.619-0.023-0.619-0.023s0.133,0.271,0.556,0.136s0.694-0.159,0.838,0.199c0,0,0.247-0.107,0.455-0.096
				c0.288,0.016,0.232,0.214,0.455,0.2c0.128-0.009,0.191-0.04,0.288-0.088C49.677,139.521,49.78,139.488,49.78,139.488z"/>
			<path fill="#DA7669" d="M46.884,141.316c0,0,0.032,0.206-0.047,0.365c-0.118,0.234-0.44,0.257-0.44,0.257s0.37,0.057,0.498-0.21
				C47.012,141.483,46.884,141.316,46.884,141.316z"/>
			<path fill="#DA7669" d="M46.38,141.124c0,0,0.205-0.013,0.386-0.13c0.226-0.146,0.192-0.437,0.277-0.724
				c0.084-0.287,0.39-0.471,0.39-0.471c0.112-0.048,0.24-0.096,0.24-0.096s-0.386,0.184-0.503,0.545
				c-0.117,0.362-0.075,0.702-0.372,0.809C46.545,141.148,46.38,141.124,46.38,141.124z"/>
			<path fill="#DA7669" d="M46.892,142.082c0,0,0.104,0.174,0.041,0.376c-0.076,0.241-0.456,0.326-0.456,0.326
				s0.438,0.036,0.535-0.301C47.096,142.187,46.892,142.082,46.892,142.082z"/>
			<path fill="#DA7669" d="M46.755,143.343c0,0,0.404-0.041,0.496-0.253c0.092-0.211,0.008-0.354,0.008-0.354l0.028-0.04
				c0,0,0.156,0.223,0.048,0.439C47.207,143.391,46.755,143.343,46.755,143.343z"/>
			<path fill="#DA7669" d="M47.378,143.503c0,0,0.274,0.14,0.293,0.427c0.02,0.287-0.229,0.451-0.229,0.451s0.323-0.151,0.307-0.472
				C47.733,143.591,47.378,143.503,47.378,143.503z"/>
			<path fill="#DA7669" d="M47.921,144.373c0,0-0.246,0.775-1.033,1.437c-0.752,0.63-1.788,0.614-1.788,0.614
				c-0.181,0.019-0.387-0.014-0.547-0.066c0,0,0.713,0.324,1.71-0.068c0.755-0.298,1.276-0.947,1.468-1.298
				c0.208-0.381,0.253-0.674,0.253-0.674S47.96,144.349,47.921,144.373z"/>
			<path fill="#DA7669" d="M51.433,140.948c-0.086,0.305,0.087,0.559,0.087,0.559s-0.04,0.056-0.063,0.136
				c0,0,0.006,0.192-0.082,0.344c-0.088,0.152-0.214,0.293-0.629,0.438c-0.415,0.144-0.694,0.425-0.694,0.425s0.279-0.2,0.718-0.328
				s0.676-0.307,0.79-0.686c0.048-0.16,0.127-0.272,0.127-0.272s-0.12-0.103-0.191-0.278
				C51.425,141.108,51.433,140.948,51.433,140.948z"/>
			<path fill="#DA7669" d="M52.589,146.328c-0.071-0.041-0.127-0.056-0.199-0.064c0,0-0.238,0.003-0.405,0.127
				c0,0-0.128-0.083-0.347-0.255c-0.22-0.171-0.405-0.454-0.405-0.454c-0.144-0.144-0.271-0.288-0.343-0.376
				c0,0,0.092,0.304,0.392,0.623c0.298,0.319,0.546,0.471,0.546,0.471s-0.063,0.052-0.056,0.359c0,0,0.158-0.266,0.38-0.371
				C52.402,146.268,52.589,146.328,52.589,146.328z"/>
			<path fill="#DA7669" d="M47.722,146.767c0,0-0.326,0.161-0.414,0.545c0,0,0.143,0.127,0.135,0.351
				c-0.008,0.255-0.169,0.326-0.169,0.326s0.235-0.001,0.264-0.344c0.016-0.191-0.136-0.335-0.136-0.335s0.031-0.127,0.087-0.239
				S47.722,146.767,47.722,146.767z"/>
			<path fill="#DA7669" d="M50.523,147.572c0,0-0.072,0.16-0.28,0.12c0,0-0.262,0.078-0.557-0.273
				c-0.238-0.281-0.521-0.429-0.521-0.429c-0.088-0.024-0.144-0.032-0.248-0.056c0,0,0.34,0.052,0.663,0.479
				c0.295,0.392,0.501,0.392,0.646,0.392C50.427,147.805,50.523,147.572,50.523,147.572z"/>
			<path fill="#DA7669" d="M47.522,140.845c0,0-0.017,0.216,0.128,0.304c0.143,0.088,0.143,0.327-0.041,0.471
				c0,0,0.096-0.191,0.032-0.319C47.578,141.172,47.418,141.108,47.522,140.845z"/>
			<path fill="#DA7669" d="M47.841,141.906c0,0,0.096,0.192,0.304,0.28c0.207,0.087,0.159,0.278,0.095,0.438
				c0,0,0.023-0.208-0.088-0.296C48.041,142.241,47.865,142.225,47.841,141.906z"/>
			<path fill="#DA7669" d="M48,142.721c0,0,0.016,0.255,0.359,0.398c0.343,0.144,0.327,0.384,0.231,0.574
				c0,0,0.048-0.271-0.183-0.382C48.176,143.199,47.993,143.119,48,142.721z"/>
			<path fill="#DA7669" d="M48.591,142.657c0,0,0.264,0.414,0.798,0.303c0,0-0.072,0.094-0.167,0.119c0,0-0.28-0.023-0.431-0.16
				C48.639,142.784,48.591,142.657,48.591,142.657z"/>
			<path fill="#DA7669" d="M49.054,143.653c0,0,0.458-0.253,0.623,0.208c0.12,0.336,0.359,0.336,0.359,0.336
				s-0.279,0.128-0.454-0.224C49.381,143.574,49.054,143.653,49.054,143.653z"/>
			<path fill="#DA7669" d="M48.424,143.861c0,0,0,0.191,0.311,0.296c0.311,0.104,0.248,0.271,0.208,0.431
				c0,0,0.023-0.19-0.167-0.295C48.583,144.189,48.352,144.205,48.424,143.861z"/>
		</g>
		<g>
			<path fill="#C4122F" d="M48.601,139.623c0,0-0.017,0.312-0.282,0.479c0,0,0.221,0.033,0.373-0.021
				c0.151-0.055,0.057-0.168,0.015-0.217s-0.002-0.142,0.142-0.06c0.066,0.038,0.131-0.055,0.131-0.055
				S48.814,139.623,48.601,139.623z"/>
			<path fill="#C4122F" d="M48.997,140.022c0,0-0.065,0.192-0.429,0.192c0,0,0.305,0.133,0.467,0.019
				C49.138,140.16,48.997,140.022,48.997,140.022z"/>
		</g>
		<g>
			<path fill="#023F88" d="M33.414,176.293v-0.296l3.306-5.32H34.38l-0.397,1.074h-0.334v-1.479h4.173v0.261l-3.306,5.312h2.448
				l0.578-1.075h0.308l-0.154,1.523H33.414z"/>
			<path fill="#023F88" d="M38.268,171.688v-0.21h2.288v0.21l-0.722,0.286v2.758c0,0.836,0.404,1.229,1.232,1.229
				c0.818,0,1.213-0.384,1.213-1.191v-2.796l-0.722-0.286v-0.21h2.006v0.21l-0.709,0.286v2.681c0,0.778-0.201,1.191-0.69,1.479
				c-0.336,0.181-0.683,0.257-1.261,0.257c-1.344,0-1.916-0.467-1.916-1.552v-2.922L38.268,171.688z"/>
			<path fill="#023F88" d="M44.196,176.293v-0.219l0.719-0.275v-3.824l-0.719-0.286v-0.21h2.286v0.21l-0.708,0.286v3.824
				l0.708,0.275v0.219H44.196z"/>
			<path fill="#023F88" d="M48.975,171.898h0.767c0.643,0,1.017,0.163,1.324,0.585c0.259,0.346,0.383,0.788,0.383,1.374
				c0,0.672-0.163,1.153-0.537,1.537c-0.345,0.355-0.662,0.47-1.267,0.47h-0.67V171.898z M49.713,176.293
				c0.757,0,1.294-0.143,1.735-0.456c0.611-0.442,0.954-1.183,0.954-2.066c0-0.672-0.201-1.21-0.61-1.651
				c-0.478-0.507-0.91-0.641-1.965-0.641h-2.43v0.21l0.719,0.286v3.824l-0.719,0.275v0.219H49.713z"/>
			<path fill="#023F88" d="M55.722,168.56v2.378l0.768,0.315v0.224h-2.384v-0.224l0.768-0.315v-4.942l-0.768-0.315v-0.224h2.384
				v0.224l-0.768,0.315v2.116h2.806v-2.116l-0.758-0.315v-0.224h2.375v0.224l-0.758,0.315v4.942l0.758,0.315v0.224H57.77v-0.224
				l0.758-0.315v-2.378H55.722z"/>
			<path fill="#023F88" d="M63.041,166.982c0.92,0,1.486,0.808,1.486,2.106c0,1.259-0.566,2.057-1.448,2.057
				c-0.902,0-1.468-0.817-1.468-2.115C61.611,167.742,62.139,166.982,63.041,166.982z M62.992,171.573
				c1.478,0,2.479-1.062,2.479-2.629c0-1.452-0.915-2.391-2.344-2.391c-1.467,0-2.459,1.073-2.459,2.641
				C60.667,170.637,61.582,171.573,62.992,171.573z"/>
			<path fill="#023F88" d="M66.167,171.477v-0.219l0.719-0.276v-3.824l-0.719-0.285v-0.21h2.287v0.21l-0.709,0.285v3.939h1.255
				l0.47-0.903h0.297l-0.125,1.283H66.167z"/>
			<path fill="#023F88" d="M70.491,171.477v-0.219l0.719-0.276v-3.824l-0.719-0.285v-0.21h2.286v0.21l-0.709,0.285v3.939h1.256
				l0.469-0.903h0.298l-0.125,1.283H70.491z"/>
			<path fill="#023F88" d="M76.909,167.519l0.096,0.249l0.115,0.335l0.402,1.131H76.23L76.909,167.519z M77.617,169.566l0.497,1.415
				l-0.592,0.276v0.219h2.17v-0.219l-0.65-0.276l-1.635-4.365h-0.564l-1.818,4.365l-0.643,0.276v0.219h1.763v-0.219l-0.584-0.276
				l0.527-1.415H77.617z"/>
			<path fill="#023F88" d="M80.16,171.477v-0.221l0.719-0.278v-3.812l-0.719-0.287v-0.211h1.445l2.652,3.438v-2.94l-0.708-0.287
				v-0.211h1.903v0.211l-0.718,0.287v4.358h-0.382l-2.996-3.927v3.38l0.707,0.278v0.221H80.16z"/>
			<path fill="#023F88" d="M87.84,167.081h0.767c0.642,0,1.016,0.163,1.323,0.586c0.26,0.346,0.384,0.788,0.384,1.374
				c0,0.673-0.163,1.152-0.537,1.537c-0.345,0.354-0.662,0.471-1.265,0.471H87.84V167.081z M88.578,171.477
				c0.758,0,1.294-0.143,1.736-0.457c0.611-0.441,0.954-1.181,0.954-2.065c0-0.672-0.2-1.21-0.61-1.652
				c-0.478-0.507-0.909-0.64-1.964-0.64h-2.431v0.21l0.719,0.285v3.824l-0.719,0.276v0.219H88.578z"/>
			<path fill="#023F88" d="M29.122,165.759c0.118-0.052,0.268-0.078,0.432-0.078c0.495,0,0.825,0.388,0.825,0.972
				c0,0.636-0.361,1.009-0.973,1.009c-0.099,0-0.176-0.005-0.284-0.017V165.759z M29.446,167.891c0.824,0,1.421-0.582,1.421-1.383
				c0-0.646-0.417-1.137-0.963-1.137c-0.154,0-0.484,0.114-0.783,0.273v-0.32l-0.896,0.202v0.118l0.438,0.135v2.927l-0.438,0.16
				v0.129h1.438v-0.129l-0.541-0.16v-0.856C29.225,167.881,29.312,167.891,29.446,167.891z"/>
			<path fill="#023F88" d="M31.475,167.863v-0.127l0.434-0.181v-1.771l-0.434-0.124v-0.119l0.897-0.207v0.326l0.046-0.026
				c0.341-0.175,0.573-0.263,0.717-0.263c0.098,0,0.175,0.025,0.263,0.077v0.568h-0.356l-0.155-0.305
				c-0.057,0-0.103-0.005-0.128-0.005c-0.119,0-0.264,0.03-0.387,0.077v1.771l0.536,0.181v0.127H31.475z"/>
			<path fill="#023F88" d="M35.105,165.574c0.455,0,0.717,0.418,0.717,1.137c0,0.631-0.248,0.998-0.671,0.998
				c-0.45,0-0.717-0.409-0.717-1.102C34.434,165.951,34.681,165.574,35.105,165.574z M35.084,167.939
				c0.728,0,1.248-0.566,1.248-1.348c0-0.744-0.474-1.249-1.176-1.249c-0.738,0-1.232,0.541-1.232,1.342
				C33.924,167.425,34.403,167.939,35.084,167.939z"/>
			<path fill="#023F88" d="M37.908,167.918l-0.868-2.253l-0.314-0.139v-0.13h1.182v0.13l-0.356,0.139l0.417,1.169
				c0.062,0.171,0.104,0.314,0.155,0.521l0.618-1.659l-0.345-0.17v-0.13h1v0.13l-0.299,0.17l-0.974,2.222H37.908z"/>
			<path fill="#023F88" d="M39.987,167.863v-0.127l0.434-0.181v-1.776l-0.434-0.134v-0.113l0.896-0.196v2.22l0.434,0.181v0.127
				H39.987z M40.343,164.511c0-0.177,0.104-0.27,0.304-0.27c0.216,0,0.314,0.083,0.314,0.264c0,0.19-0.098,0.279-0.309,0.279
				C40.447,164.784,40.343,164.695,40.343,164.511z"/>
			<path fill="#023F88" d="M42.032,167.863v-0.127l0.434-0.181v-1.771l-0.434-0.135v-0.113l0.897-0.202v0.289
				c0.031-0.009,0.057-0.019,0.072-0.024c0.025-0.01,0.113-0.041,0.252-0.093c0.236-0.094,0.391-0.135,0.535-0.135
				c0.201,0,0.375,0.077,0.51,0.218c0.144,0.154,0.191,0.299,0.191,0.588v1.379l0.438,0.181v0.127h-1.309v-0.127l0.412-0.181v-1.28
				c0-0.398-0.196-0.568-0.648-0.568c-0.15,0-0.319,0.016-0.453,0.036v1.812l0.386,0.181v0.127H42.032z"/>
			<path fill="#023F88" d="M47.505,165.482v0.531H47.19l-0.227-0.459c-0.051-0.005-0.077-0.005-0.108-0.005
				c-0.506,0-0.893,0.443-0.893,1.043c0,0.29,0.088,0.554,0.248,0.734c0.176,0.202,0.387,0.284,0.723,0.284
				c0.165,0,0.232-0.004,0.505-0.051l0.052-0.011l0.031,0.166l-0.052,0.015l-0.263,0.079c-0.237,0.071-0.449,0.107-0.64,0.107
				c-0.64,0-1.088-0.502-1.088-1.211c0-0.801,0.556-1.336,1.387-1.336C47.061,165.37,47.257,165.405,47.505,165.482z"/>
			<path fill="#023F88" d="M48.274,167.863v-0.127l0.434-0.181v-1.776l-0.434-0.134v-0.113l0.897-0.196v2.22l0.434,0.181v0.127
				H48.274z M48.63,164.511c0-0.177,0.104-0.27,0.304-0.27c0.216,0,0.314,0.083,0.314,0.264c0,0.19-0.098,0.279-0.31,0.279
				C48.734,164.784,48.63,164.695,48.63,164.511z"/>
			<path fill="#023F88" d="M50.763,166.406c0.046-0.558,0.248-0.831,0.615-0.831c0.335,0,0.479,0.217,0.49,0.729L50.763,166.406z
				 M52.326,165.998c-0.103-0.376-0.463-0.628-0.902-0.628c-0.682,0-1.181,0.566-1.181,1.331c0,0.725,0.458,1.216,1.135,1.216
				c0.237,0,0.655-0.089,0.963-0.207l-0.026-0.166c-0.216,0.036-0.453,0.063-0.592,0.063c-0.269,0-0.496-0.073-0.655-0.208
				c-0.217-0.186-0.305-0.423-0.31-0.848h1.625C52.372,166.236,52.362,166.148,52.326,165.998z"/>
		</g>
		<g>
			<path fill="#DDB10A" d="M55.835,151.79c-1.988-0.521-3.498-2.226-3.757-3.898c-0.328,0.008-0.327-0.255-0.35-0.343
				c0,0-0.24,0.184-0.383-0.032c-0.144-0.215,0.12-0.414-0.191-0.678c-0.312-0.264-0.487-0.319-0.487-0.319s0.08,0.183-0.071,0.303
				c0,0-0.096-0.358-0.423-0.502c-0.327-0.145-0.479-0.216-0.63-0.344c0,0-0.24,0.312-0.831,0.503
				c-0.589,0.19-0.782,0.415-0.782,0.415s0.2-0.017,0.319-0.017s0.417-0.002,0.67,0.057c0.104,0.023,0.16,0.031,0.248,0.056
				c0.087,0.024,0.355,0.116,0.67,0.431c0.151,0.151,0.288,0.248,0.407,0.271c0.208,0.04,0.28-0.12,0.28-0.12
				s0.191,0.384-0.208,0.519c0,0,0.228,0.08,0.247,0.399c0.016,0.256,0.344,0.304,0.344,0.304s-0.224,0.287-0.607,0.096
				c0,0,0.12,0.312,0.502,0.239c0,0-0.231,0.415-0.663,0.192c0,0,0.032,0.238,0.208,0.397c0.176,0.161,0.296,0.264,0.495,0.448
				c0.2,0.183,0.479,0.551,0.766,0.654c0.287,0.104,0.415-0.057,0.599-0.088c0.184-0.032,0.415-0.035,0.527,0.128
				c0.072,0.103,0,0.175,0,0.175s0.449,0.01,0.319,0.456c-0.096,0.326-0.459,0.216-0.607,0.199c-0.334-0.04-0.654,0.111-0.989-0.08
				s-0.503-0.255-0.503-0.255s0,0.208-0.224,0.271c0,0,0.024-0.36-0.231-0.473c0,0,0.048,0.289-0.216,0.36
				c0,0,0.111-0.288-0.28-0.519c0,0,0.08,0.335-0.263,0.375c0,0,0.112-0.12,0.016-0.28c-0.096-0.159-0.231-0.167-0.487-0.255
				c-0.255-0.088-0.343-0.335-0.271-0.567c0,0-0.188,0.129-0.431,0.04c-0.088-0.032-0.144-0.087-0.144-0.087
				s0.287,0.017,0.287-0.319s-0.087-0.446-0.135-0.646c-0.048-0.199,0.048-0.319,0.016-0.519c-0.032-0.2-0.151-0.544-1.388-0.56
				c0,0,0.104,0.363,0.047,0.87c-0.064,0.575-0.335,0.654-0.263,0.839c0.056,0.143,0.183,0.216,0.367,0.255
				c0,0-0.263,0.247-0.527,0.048c0,0,0.064,0.175-0.143,0.303s-0.2,0.408-0.2,0.408s-0.271-0.12-0.167-0.528
				c0,0-0.272,0.224-0.256,0.639c0,0-0.231-0.19-0.224-0.406c0.008-0.216,0.112-0.328,0.112-0.328s-0.455,0.112-0.766-0.087
				s-0.606-0.27-0.687,0.479c-0.023,0.225,0.104,0.566,0.336,0.727c0,0,0.378-0.271,0.638-0.039
				c0.072,0.063,0.017,0.184,0.017,0.184s0.442-0.021,0.271,0.423c-0.135,0.351-0.473,0.271-0.742,0.223
				c-0.359-0.063-0.896,0.147-1.181-0.352c-0.128-0.223-0.224-0.734-0.224-0.734s-0.208,0.2-0.495-0.023c0,0,0.335-0.04,0.407-0.446
				c0,0-0.279,0.135-0.447-0.041c0,0,0.359-0.104,0.447-0.478c0,0-0.191,0.128-0.375-0.072c0,0,0.25-0.094,0.328-0.32
				c0.104-0.302,0.092-0.672,0.191-0.853c0.088-0.159,0.239-0.168,0.304-0.176c0.063-0.008,0.175,0.008,0.175,0.008
				s-0.151-0.088-0.095-0.279c0.056-0.192,0.294-0.24,0.294-0.24s-0.147,0.324,0.24,0.392c0.231,0.04,0.495-0.128,0.726,0.327
				c0,0,0.029-0.345,0.128-0.591c0.032-0.08,0.072-0.152,0.072-0.152s-0.288,0.064-0.495-0.222c0,0,0.295,0.063,0.375-0.232
				c0.08-0.295,0.167-0.679,0.543-0.838c0,0-0.844,0.271-1.444,0.043c-0.601-0.229-0.764-0.521-0.857-0.878
				c-0.192-0.729,0.223-1.165,0.117-1.544c-0.079-0.279-0.335-0.318-0.335-0.318s0.085-0.043,0.213-0.048s0.463-0.043,0.51,0.335
				c0,0,0.139-0.101,0.3-0.151c0.418-0.133,0.972,0.018,1.339-0.402c0.037-0.042,0.042-0.048,0.064-0.074
				c0.021-0.026,0.133-0.149,0.122-0.404c-0.01-0.255-0.216-0.831-1.138-0.681c-1.048,0.17-1.651-0.213-1.666-1.171
				c-0.006-0.34,0.096-0.649,0.096-0.649s0.058,0.841,0.707,1.006c0,0-0.148-0.122-0.154-0.384c-0.005-0.212,0.069-0.34,0.069-0.34
				s0.115,0.234,0.352,0.282c0.287,0.058,0.546-0.108,0.905,0.021c0.054,0.021,0.103,0.053,0.146,0.091
				c0.049,0.044,0.09,0.094,0.119,0.139c0.043,0.064,0.064,0.144,0.075,0.234c0.01,0.091-0.011,0.271-0.053,0.436
				c0,0,0.433,0.053,0.708,0.39c0.33,0.403,0.436,1.351-0.49,1.67c0,0,0.415,0.352-0.063,0.872c0,0,0.106-0.383-0.17-0.553
				c-0.277-0.171-0.826-0.244-1.17,0.181c-0.277,0.341-0.181,0.868-0.054,1.074c0.085,0.139,0.213,0.267,0.373,0.32
				c0.16,0.053,0.366,0.085,0.547,0.066c0.378-0.04,1.076-0.208,1.671-0.687c0.367-0.296,0.727-0.702,1.149-1.364
				c0,0-0.199,0.167-0.479,0.008c0,0,0.162-0.229,0.136-0.456c-0.032-0.271-0.2-0.422-0.2-0.422s-0.255,0.12-0.624-0.16
				c0,0,0.463-0.096,0.504-0.606c0,0-0.2,0.287-0.782,0.048c0,0,0.407-0.184,0.415-0.702c0,0-0.248,0.08-0.495-0.144
				c0,0,0.407-0.12,0.487-0.622c0,0-0.312,0.048-0.503-0.192c0,0,0.193-0.049,0.343-0.199c0.184-0.184,0.024-0.514,0.288-0.814
				c0.111-0.127,0.311-0.263,0.422-0.311c0.112-0.048,0.24-0.096,0.24-0.096s-0.445,0.102-0.639-0.232
				c-0.056-0.096-0.045-0.255-0.045-0.255s0.319,0.106,0.596-0.063c0.22-0.136,0.53-0.104,0.711,0.119
				c0.046,0.056,0.084,0.125,0.111,0.208c0,0,0.12-0.065,0.279-0.104c0.161-0.039,0.362-0.052,0.519,0.056
				c0.191,0.133,0.23,0.08,0.379,0.059c0.03-0.004,0.065-0.007,0.107-0.007c0.026,0,0.056,0.002,0.088,0.005
				c0.271,0.025,0.279,0.111,0.239,0.216c-0.039,0.104,0.024,0.199,0.016,0.398s-0.08,0.527-0.598,0.447
				c-0.475-0.073-0.731,0.055-0.678,0.511l0.012,0.08c0.003,0.019,0.007,0.037,0.011,0.056c0.111,0.519,0.585,0.464,0.735,0.414
				c0.063-0.021,0.148-0.018,0.222,0.011c0.15,0.057,0.254,0.213,0.041,0.47c0,0-0.391-0.089-0.534,0.016
				c-0.144,0.104-0.08,0.391,0.2,0.502c0.279,0.112,0.582-0.071,0.582-0.071s0.088,0.168,0.024,0.312c0,0,0.311-0.399,0.727-0.552
				c0.415-0.15,0.586-0.347,0.678-0.654c0.023-0.08,0.063-0.136,0.063-0.136s-0.173-0.254-0.087-0.559
				c0.072-0.254,0.231-0.263,0.319-0.254c0.087,0.008,0.143,0.11,0.143,0.11s0.055-0.097,0.143-0.173v-1.005
				c0,0,0.973-0.209,2.701-0.327h0.004c0.27-0.018,0.557-0.033,0.862-0.047c0.468-0.02,0.977-0.031,1.524-0.031h-0.001v-11.096
				H40.25v33.718h16.877v-9.883l-0.079-0.002C56.632,151.951,56.221,151.892,55.835,151.79z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#DDB10A" d="M42.135,153.689c0.066-0.023,0.136-0.044,0.219-0.063l0,0
				l-0.27-1.059c0.063,0.051,0.129,0.074,0.212,0.079l-0.058-0.225c-0.03-0.134,0.179-0.229,0.521-0.271
				c0.342-0.042,0.517-0.106,0.521-0.271l-0.006-0.021c-0.062-0.231-0.656-0.146-0.995-0.096c-0.18,0.027-0.415,0.091-0.572,0.138
				l-0.125,0.038l0.24,0.933l0.219,0.854L42.135,153.689z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#DDB10A" d="M67.054,151.796c-0.01,0.183-0.207,0.243-0.62,0.291
				c-0.503,0.06-0.609,0.227-0.556,0.335l0.047,0.184c-0.056-0.005-0.116-0.021-0.18-0.056l0.21,0.83l0,0l0,0
				c-1.481-0.074-4.491,0.298-8.848,0.298c-4.456,0-6.968-0.438-8.465-0.313l0.001-0.001l0.056-0.22H48.7l0.115-0.457
				c0.037-0.074-0.061-0.155-0.236-0.211l0.02-0.077c0.054-0.108-0.101-0.244-0.532-0.312c-0.316-0.05-0.562-0.03-0.629-0.283l0,0
				c0-0.167,0.161-0.247,0.425-0.29c1.012-0.163,4.927,0.402,9.212,0.402c0.229,0,0.543-0.003,0.774-0.006
				c4.07-0.053,8.089-0.531,8.819-0.396C66.961,151.567,67.054,151.694,67.054,151.796L67.054,151.796z"/>
			<path fill="#DDB10A" d="M42.695,154.208c0.022,0.054,0.093,0.096,0.191,0.123c0.131,0.037,0.308,0.047,0.478,0.013
				c0.296-0.059,1.341-0.378,2.048-0.378s1.947,0.353,2.131,0.388c0.185,0.036,0.525,0.026,0.589-0.146l0,0l0.446-1.732l0.02-0.077
				c-0.087,0.127-0.323,0.174-0.616,0.15c-0.51-0.043-1.583-0.342-2.57-0.342c-0.986,0-2.172,0.285-2.506,0.339
				c-0.334,0.055-0.602,0.012-0.668-0.124l0.058,0.225L42.695,154.208z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#DDB10A" d="M66.333,154.208l-0.408-1.603l-0.047-0.184l0,0
				c0.076,0.155,0.303,0.164,0.604,0.127c0.509-0.062,1.584-0.342,2.57-0.342c0.988,0,2.172,0.285,2.507,0.339
				c0.334,0.055,0.618-0.021,0.669-0.124l-0.013,0.081l-0.452,1.749c-0.076,0.101-0.32,0.168-0.662,0.092
				c-0.295-0.064-1.342-0.378-2.05-0.378c-0.707,0-1.946,0.353-2.13,0.388c-0.129,0.024-0.335,0.028-0.469-0.031
				C66.397,154.296,66.352,154.259,66.333,154.208"/>
			<path fill="#DDB10A" d="M71.186,151.879c0.002-0.017,0.002-0.007,0.005-0.021c0.062-0.231,0.657-0.146,0.996-0.096
				c0.191,0.029,0.445,0.1,0.601,0.146c0.041,0.013,0.071,0.021,0.095,0.029l-0.043,0.17l0,0l-0.415,1.617l0,0
				c-0.087-0.035-0.173-0.063-0.28-0.09v-0.001l0.242-0.942l0,0c0.032-0.064-0.038-0.134-0.172-0.188l0.013-0.081
				c0.03-0.134-0.18-0.229-0.522-0.271c-0.319-0.039-0.493-0.098-0.517-0.24L71.186,151.879L71.186,151.879z"/>
			<g>
				<g>
					<path fill="#F1D99E" d="M57.074,151.916c0.254,0,0.519-0.002,0.774-0.006c4.045-0.058,8.094-0.531,8.819-0.396
						c0,0-0.25-0.011-1.495,0.073c-0.738,0.05-3.327,0.373-7.997,0.457c-2.808,0.051-7.688-0.47-9.049-0.479
						c-0.623-0.004-0.689,0.238-0.689,0.238c0-0.167,0.161-0.247,0.425-0.29C48.874,151.351,52.789,151.916,57.074,151.916z"/>
				</g>
				<path fill="#F1D99E" d="M42.695,154.208l-0.399-1.562l-0.058-0.225c0.066,0.136,0.334,0.179,0.668,0.124
					c0.334-0.054,1.521-0.339,2.506-0.339c0.986,0,2.06,0.299,2.57,0.342c0.293,0.023,0.529-0.023,0.616-0.15
					c0,0-0.066,0.359-0.845,0.217c-0.482-0.089-1.176-0.257-1.854-0.302c-0.994-0.065-2.118,0.133-2.655,0.302
					c-0.538,0.168-0.67,0.276-0.67,0.276L42.695,154.208z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M43.279,151.879l-0.006-0.021
					c-0.062-0.231-0.656-0.146-0.995-0.096c-0.18,0.027-0.415,0.091-0.572,0.138l-0.125,0.038l0.24,0.933l0.219,0.854l-0.202-1.706
					c0.35-0.148,1.035-0.251,1.223-0.24C43.217,151.789,43.279,151.879,43.279,151.879z"/>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M66.333,154.208l-0.408-1.603l-0.047-0.184l0,0
					c0.076,0.155,0.303,0.164,0.604,0.127c0.509-0.062,1.584-0.342,2.57-0.342c0.988,0,2.172,0.285,2.507,0.339
					c0.334,0.055,0.618-0.021,0.669-0.124c0,0,0.048,0.354-0.837,0.177c-0.48-0.096-1.178-0.233-1.854-0.285
					c-0.981-0.074-2.083,0.163-2.655,0.314c-0.34,0.09-0.631,0.215-0.631,0.215L66.333,154.208z"/>
				<path fill="#F1D99E" d="M71.191,151.857c-0.003,0.015-0.003,0.005-0.005,0.021c0,0,0.052-0.096,0.304-0.104
					c0.546-0.018,1.394,0.162,1.394,0.162c-0.024-0.008-0.055-0.017-0.095-0.029c-0.156-0.047-0.41-0.117-0.601-0.146
					C71.848,151.712,71.253,151.626,71.191,151.857z"/>
			</g>
			<path fill="#DDB10A" d="M52.037,146.271c-0.375-0.176-0.66-0.445-0.804-0.589s-0.271-0.288-0.343-0.376
				c-0.072-0.088-0.135-0.158-0.135-0.158c0.215,0,0.295-0.112,0.295-0.112c-0.208-0.048-0.215-0.248-0.215-0.248
				c0.287-0.016,0.367-0.382,0.367-0.382c-0.248,0.103-0.328-0.04-0.328-0.04c0.295-0.168,0.408-0.56,0.519-0.839
				c0.112-0.279,0.351-0.367,0.351-0.367c-0.144-0.12-0.327-0.08-0.327-0.08c0.2-0.512,0.539-0.736,0.62-0.786v1.38V146.271z"/>
		</g>
		
			<linearGradient id="SVGID_5_" gradientUnits="userSpaceOnUse" x1="10931.1172" y1="10850.6816" x2="10966.3984" y2="10897.502" gradientTransform="matrix(0.25 0 0 0.25 -2679.7544 -2574)">
			<stop  offset="0" style="stop-color:#F1D99E"/>
			<stop  offset="1" style="stop-color:#DDB10A"/>
		</linearGradient>
		<path fill="url(#SVGID_5_)" d="M57.128,139.222c1.067,0,1.985,0.045,2.744,0.104c1.518,0.121,2.374,0.302,2.374,0.302v4.046
			l0.001,2.587c-0.137-0.025-0.358-0.021-0.505,0.067c-0.068,0.04-0.121,0.098-0.142,0.179c-0.089,0.345,0.24,0.374,0.24,0.374
			s-0.36,0.112-0.28,0.416c0.014,0.052,0.033,0.094,0.056,0.127c0.126,0.187,0.36,0.096,0.36,0.096s-0.013,0.162,0.067,0.272
			c0.034,0.047,0.085,0.083,0.162,0.095c-0.25,1.631-1.688,3.285-3.597,3.857c-0.055,0.018-0.109,0.032-0.163,0.047
			c-0.193,0.051-0.391,0.091-0.591,0.119s-0.406,0.046-0.613,0.05l-0.101,0.002h-0.013l-0.079-0.002
			c-0.416-0.008-0.828-0.067-1.213-0.169c-1.988-0.521-3.498-2.226-3.757-3.898c0.327-0.008,0.265-0.383,0.265-0.383
			c0.302,0.111,0.479-0.199,0.398-0.415c-0.06-0.161-0.247-0.231-0.247-0.231c0.23-0.098,0.273-0.23,0.245-0.34
			c-0.023-0.088-0.093-0.163-0.149-0.194c-0.071-0.041-0.127-0.056-0.199-0.064c-0.136-0.015-0.353,0.007-0.353,0.007
			c-0.007-0.003,0.006,0.003,0,0v-2.598v-4.046c0,0,0.973-0.209,2.701-0.327h0.004c0.27-0.018,0.557-0.033,0.862-0.047
			C56.071,139.233,56.58,139.222,57.128,139.222z"/>
		<path fill="#C4122F" d="M59.879,139.326c-0.759-0.06-1.685-0.104-2.751-0.104c-0.548,0-1.057,0.012-1.524,0.031
			c-0.305,0.014-0.592,0.029-0.862,0.047c-0.223-0.041-0.411-0.085-0.567-0.127c-0.495-0.13-0.675-0.255-0.675-0.255l0.102-0.062
			c0.284-0.146,1.227-0.516,3.494-0.534c2.215-0.019,3.221,0.452,3.504,0.604c0.089,0.05,0.144,0.091,0.144,0.091
			S60.489,139.182,59.879,139.326z"/>
		<path fill="#C4122F" d="M62.31,147.887c-0.042,0.005-0.078,0.004-0.11-0.001h0.005c-0.076-0.012-0.128-0.048-0.162-0.095
			c-0.08-0.11-0.067-0.272-0.067-0.272s-0.233,0.091-0.36-0.096c-0.022-0.033-0.042-0.075-0.056-0.127
			c-0.08-0.304,0.28-0.416,0.28-0.416s-0.329-0.029-0.24-0.374c0.021-0.081,0.073-0.139,0.142-0.179
			c0.146-0.087,0.363-0.093,0.501-0.067c0.022,0.003,0.042,0.009,0.06,0.014c0,0,0.682-0.407,1.078-0.878
			c0.127-0.151,0.207-0.247,0.207-0.247s-0.128,0.119-0.335,0.016c0,0,0.263-0.04,0.311-0.343c0,0-0.367-0.023-0.478-0.352
			c0,0,0.2,0.016,0.367-0.07c0,0-0.288-0.176-0.415-0.616c-0.128-0.438-0.287-0.574-0.455-0.622c0,0,0.168-0.088,0.312-0.072
			c0,0-0.07-0.419-0.646-0.826v-1.662c0.061,0.037,0.118,0.103,0.167,0.214c0,0,0.151-0.198,0.327-0.063
			c0.056,0.043,0.098,0.11,0.125,0.19c0.056,0.172,0.04,0.402-0.069,0.575c0,0,0.044,0.12,0.132,0.267
			c0.079,0.131,0.192,0.283,0.339,0.389c0.245,0.175,0.432,0.21,0.627,0.343c0.054,0.037,0.108,0.08,0.163,0.136
			c0.152,0.152,0.232,0.231,0.232,0.231s-0.08-0.151-0.008-0.327c0,0,0.054,0.033,0.138,0.063c0.134,0.05,0.343,0.093,0.525-0.016
			c0.165-0.098,0.237-0.247,0.212-0.361c-0.02-0.09-0.1-0.159-0.245-0.165c-0.082-0.003-0.163,0.002-0.229,0.01
			c-0.086,0.01-0.146,0.022-0.146,0.022s-0.191-0.187-0.056-0.376c0.06-0.083,0.137-0.114,0.26-0.12
			c0.041-0.002,0.087-0.002,0.139,0c0.208,0.009,0.747-0.018,0.694-0.622c-0.003-0.037-0.008-0.079-0.016-0.122
			c-0.008-0.041-0.02-0.082-0.039-0.121c-0.056-0.118-0.172-0.215-0.424-0.211c-0.116,0.002-0.249,0.019-0.349,0.017
			c-0.15-0.004-0.255-0.036-0.34-0.105c-0.053-0.043-0.089-0.106-0.104-0.197c-0.011-0.064-0.01-0.145,0.003-0.241
			c0.032-0.231,0.016-0.335-0.008-0.423c-0.024-0.088,0.064-0.136,0.24-0.112c0.174,0.024,0.399,0.128,0.59-0.008
			c0.117-0.083,0.204-0.133,0.37-0.116c0.058,0.006,0.126,0.021,0.208,0.044c0.068,0.021,0.146,0.046,0.237,0.08
			c0,0-0.009-0.325,0.359-0.382c0.343-0.054,0.38,0.16,0.782,0.183c0.083,0.006,0.182,0.002,0.303-0.013c0,0-0.01,0.122-0.081,0.241
			c-0.094,0.157-0.296,0.306-0.729,0.142c0,0,0.505,0.17,0.533,0.681c0.032,0.585,0.148,0.734,0.319,0.841
			c0,0-0.106,0.171-0.298,0.064c0,0,0.021,0.542,0.394,0.681c0,0-0.149,0.245-0.426,0.064c0,0-0.063,0.595,0.298,0.744
			c0,0-0.234,0.192-0.447-0.011c0,0,0.188,0.379-0.352,0.841c-0.373,0.318-0.351,0.628-0.351,0.628s-0.234-0.054-0.33-0.373
			c0,0-0.373,0.416-0.075,0.862c0,0-0.298,0.011-0.394-0.34c0,0,0.032,0.244-0.17,0.361c-0.203,0.117-0.128,0.404-0.128,0.404
			s-0.308-0.085-0.266-0.426c0,0-0.325-0.086-0.421,0.378c0,0,0.096-0.191,0.319-0.176c0,0,0.08,0.292,0.365,0.415
			c0.026,0.011,0.053,0.021,0.082,0.028c0.024,0.007,0.049,0.012,0.076,0.017c0.063,0.009,0.134,0.011,0.212,0.003
			c0,0-0.282-0.335-0.048-0.654c0,0,0.208,0.384,0.686,0.224c0,0-0.188-0.176-0.207-0.384c-0.016-0.175,0.048-0.335,0.048-0.335
			s0.095,0.128,0.247,0.225c0,0,0.087,0.163,0.24,0.396c0.105,0.159,0.242,0.35,0.404,0.542c0.196,0.234,0.43,0.47,0.689,0.648
			c0.702,0.487,1.962,0.695,2.458,0.2c0.352-0.351,0.304-1.07-0.016-1.293c-0.492-0.346-1.047-0.319-1.214,0.087
			c-0.039,0.094-0.056,0.208-0.047,0.344c0,0-0.055-0.04-0.112-0.113c-0.024-0.032-0.049-0.07-0.069-0.113
			c-0.037-0.077-0.06-0.174-0.047-0.284c0.013-0.101,0.057-0.213,0.148-0.336c0,0-0.215-0.07-0.407-0.262
			c-0.19-0.19-0.36-0.497-0.279-0.967c0.083-0.476,0.447-0.689,0.697-0.781c0.142-0.052,0.245-0.064,0.245-0.064
			s-0.288-0.559,0.175-0.862c0.387-0.253,0.885,0.084,1.197-0.123c0.062-0.041,0.116-0.104,0.161-0.195c0,0,0.07,0.158,0.069,0.342
			c0,0.121-0.032,0.253-0.133,0.36c0,0,0.181-0.022,0.362-0.197c0.145-0.141,0.291-0.379,0.34-0.785c0,0,0.093,0.249,0.103,0.574
			c0.007,0.295-0.052,0.653-0.311,0.95c-0.471,0.543-1.191,0.312-1.596,0.264c-0.742-0.088-1.262,0.806-0.59,1.285
			c0.223,0.159,0.463,0.184,0.686,0.208c0.224,0.023,0.543,0.031,0.814,0.23c0,0-0.048-0.503,0.726-0.279
			c0,0-0.157,0.02-0.263,0.144c-0.076,0.087-0.126,0.227-0.08,0.447c0.112,0.534,0.404,1.333-0.343,1.963
			c-0.663,0.56-1.804,0.168-1.804,0.168s0.287,0.144,0.343,0.638c0.034,0.299,0.178,0.374,0.286,0.387
			c0.072,0.009,0.13-0.011,0.13-0.011s-0.031,0.051-0.087,0.105c-0.08,0.077-0.211,0.163-0.385,0.126c0,0,0.232,0.278,0.288,0.742
			c0,0,0.029-0.085,0.129-0.163c0.071-0.056,0.178-0.108,0.335-0.128c0.057-0.006,0.12-0.008,0.191-0.004
			c0.303,0.016,0.399-0.216,0.312-0.399c0,0,0.177,0.045,0.262,0.161c0.057,0.077,0.073,0.186-0.031,0.334c0,0,0.129-0.01,0.28,0.07
			c0.037,0.02,0.074,0.042,0.111,0.072c0.029,0.024,0.053,0.051,0.073,0.08c0.211,0.31-0.042,0.881,0.396,1.103
			c0.029,0.015,0.062,0.028,0.098,0.039c0,0-0.017,0.023-0.046,0.05c-0.065,0.059-0.192,0.135-0.345,0.03
			c0,0,0.072,0.333,0.358,0.456c0.03,0.013,0.062,0.023,0.096,0.03c0,0-0.022,0.019-0.06,0.038
			c-0.081,0.041-0.232,0.089-0.378-0.014c0,0,0.031,0.295,0.297,0.418c0.031,0.016,0.064,0.027,0.101,0.036
			c0,0-0.021,0.019-0.059,0.04c-0.09,0.054-0.271,0.124-0.436-0.023c0,0-0.08,0.511-0.407,0.878
			c-0.327,0.367-0.669,0.176-0.981,0.192c-0.183,0.009-0.398,0.049-0.567-0.016c-0.12-0.044-0.216-0.142-0.263-0.337
			c-0.04-0.167,0.128-0.318,0.319-0.302c0,0-0.111-0.097,0.009-0.208c0.065-0.062,0.193-0.085,0.326-0.068
			c0.109,0.015,0.221,0.055,0.304,0.124c0,0,0.457-0.366,0.295-1.03c-0.012-0.051-0.029-0.093-0.049-0.126
			c-0.097-0.166-0.274-0.153-0.446-0.081c-0.208,0.087-0.511,0.287-0.862,0.151c0,0,0.18,0.216,0.082,0.475
			c-0.034,0.087-0.097,0.179-0.209,0.268c0,0,0.047-0.228-0.082-0.446c-0.038-0.063-0.091-0.128-0.166-0.185
			c0,0,0.068,0.176-0.005,0.337c-0.03,0.067-0.084,0.134-0.178,0.183c0,0,0.125-0.189-0.063-0.312
			c-0.113-0.072-0.303-0.112-0.272-0.406c0,0-0.208,0.206-0.526-0.064c0,0,0.125,0,0.233-0.06c0.044-0.024,0.087-0.059,0.117-0.108
			c0.104-0.167-0.098-0.323-0.211-0.71c-0.118-0.402-0.066-0.658-0.012-0.901l0.03-0.137c0,0-0.262,0.064-0.438-0.159
			c-0.114-0.145-0.096-0.359-0.096-0.359s-0.224,0.232-0.048,0.535c0,0-0.295,0.032-0.551,0.151
			c-0.255,0.12-0.319,0.222-0.239,0.551c0.08,0.328-0.007,0.439-0.087,0.727c-0.067,0.234-0.079,0.517,0.168,0.56
			c0.021,0.006,0.045,0.008,0.071,0.008c0,0-0.022,0.021-0.063,0.048c-0.096,0.064-0.293,0.153-0.52,0.007
			c0,0,0.091,0.24-0.095,0.455c-0.216,0.247-0.791,0.128-0.654,0.639c0,0-0.018-0.002-0.043-0.011
			c-0.036-0.011-0.088-0.032-0.134-0.076c-0.056-0.054-0.103-0.139-0.103-0.272c0,0-0.217,0.116-0.266,0.321
			c-0.012,0.052-0.014,0.11,0.002,0.175c0,0-0.06-0.019-0.116-0.071c-0.055-0.052-0.107-0.137-0.092-0.273
			c0,0-0.149,0.067-0.211,0.254c-0.019,0.055-0.03,0.119-0.028,0.193c0,0-0.102-0.016-0.17-0.101
			c-0.03-0.037-0.055-0.087-0.062-0.154c0,0-0.155,0.031-0.351,0.176c-0.239,0.176-0.399,0.205-0.886,0.176
			c-0.207-0.014-0.381,0.028-0.526,0.014c-0.122-0.014-0.224-0.069-0.304-0.237c-0.175-0.369,0.335-0.456,0.335-0.456
			s-0.093-0.212,0.152-0.287c0.092-0.028,0.177-0.029,0.257-0.018c0.24,0.034,0.436,0.188,0.645,0.106
			c0.511-0.2,0.576-0.493,0.95-0.791c0.151-0.12,0.27-0.221,0.361-0.318c0.126-0.135,0.195-0.261,0.214-0.424
			c0,0-0.208,0.224-0.575-0.056c0,0,0.383-0.071,0.4-0.312c0,0-0.352,0.176-0.583-0.136c0,0,0.14,0,0.263-0.071
			c0.191-0.112,0.048-0.495,0.303-0.6c0,0-0.383-0.079-0.208-0.534c0,0,0.054,0.104,0.191,0.13c0.041,0.008,0.089,0.009,0.145-0.002
			c0.376-0.072,0.474-0.582,0.958-0.75c0.157-0.055,0.331-0.076,0.483-0.081c0.226-0.009,0.403,0.017,0.403,0.017l-0.144-0.111
			c0,0,0.176-0.032,0.335,0c0,0-0.072-0.141-0.383-0.247c-0.231-0.08-0.638-0.312-0.582-1.118c0,0-0.088,0.471-0.63,0.694
			c-0.381,0.157-0.581,0.282-0.71,0.447c-0.056,0.07-0.098,0.148-0.136,0.239c0,0-0.05-0.039-0.074-0.127
			c-0.011-0.044-0.017-0.099-0.006-0.168c0,0-0.315,0.122-0.471,0.319c-0.248,0.312-0.048,0.602-0.24,0.742
			c-0.069,0.05-0.145,0.056-0.207,0.046c-0.078-0.013-0.136-0.046-0.136-0.046S62.563,147.854,62.31,147.887z"/>
		<path fill="#C4122F" d="M65.703,139.622c0,0,0.018,0.312,0.283,0.48c0,0-0.222,0.032-0.373-0.021
			c-0.151-0.055-0.057-0.168-0.015-0.217c0.042-0.049,0.001-0.142-0.142-0.061c-0.066,0.038-0.131-0.054-0.131-0.054
			S65.491,139.622,65.703,139.622z"/>
		<path fill="#C4122F" d="M65.309,140.022c0,0,0.065,0.192,0.429,0.192c0,0-0.305,0.132-0.466,0.018
			C65.167,140.159,65.309,140.022,65.309,140.022z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M47.56,152.335c-0.566-0.101-1.383-0.28-2.148-0.28
			c-0.763,0-1.645,0.171-2.16,0.273l0.027-0.449c-0.005,0.165-0.18,0.229-0.521,0.271c-0.341,0.042-0.55,0.138-0.521,0.271
			c0.066,0.136,0.334,0.179,0.668,0.124c0.334-0.054,1.521-0.339,2.506-0.339c0.986,0,2.06,0.299,2.57,0.342
			c0.293,0.023,0.529-0.023,0.616-0.15c0.054-0.108-0.101-0.244-0.532-0.312c-0.316-0.05-0.562-0.03-0.629-0.283L47.56,152.335z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M72.787,151.908l0.033-0.134
			c-0.122-0.039-0.395-0.128-0.633-0.164c-0.349-0.053-0.972-0.147-1.001,0.113l0.005,0.134c0.062-0.231,0.657-0.146,0.996-0.096
			C72.378,151.791,72.632,151.861,72.787,151.908L72.787,151.908z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M43.273,151.857c0,0,0.026-0.062,0.006-0.132
			c-0.06-0.213-0.652-0.168-1.001-0.115c-0.239,0.036-0.48,0.102-0.603,0.14l0.03,0.149c0.157-0.047,0.393-0.11,0.572-0.138
			C42.617,151.712,43.211,151.626,43.273,151.857z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M67.054,151.644c-0.009-0.101-0.093-0.229-0.387-0.283
			c-0.679-0.126-4.277,0.283-8.052,0.381c-0.056,0.018-0.112,0.033-0.17,0.049c-0.194,0.052-0.394,0.092-0.597,0.12
			c4.043-0.058,8.094-0.531,8.819-0.396l0,0c0.294,0.054,0.387,0.181,0.387,0.282C67.054,151.796,67.063,151.755,67.054,151.644z"/>
		<path fill="#C4122F" d="M71.186,151.879l0.004,0.031c0.024,0.143,0.198,0.201,0.517,0.24c0.342,0.042,0.552,0.138,0.522,0.271
			c-0.052,0.103-0.335,0.179-0.669,0.124c-0.334-0.054-1.519-0.339-2.507-0.339c-0.986,0-2.061,0.279-2.57,0.342
			c-0.302,0.037-0.529,0.028-0.604-0.127c-0.053-0.108,0.053-0.275,0.556-0.335c0.414-0.048,0.61-0.108,0.62-0.291l-0.094,0.522
			c0.565-0.104,1.336-0.264,2.092-0.264c0.764,0,1.646,0.171,2.16,0.273L71.186,151.879z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M42.354,153.626l-0.27-1.059
			c0.063,0.051,0.129,0.074,0.212,0.079l0.399,1.562c-0.115-0.026-0.205-0.085-0.229-0.144L42.354,153.626z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M66.333,154.208l-0.408-1.603
			c-0.056-0.005-0.116-0.021-0.18-0.056l0.396,1.573c0.03,0.081,0.124,0.127,0.233,0.147
			C66.356,154.252,66.341,154.232,66.333,154.208z"/>
		<path fill="#C4122F" d="M58.444,151.79c0.054-0.015,0.108-0.029,0.163-0.047c1.909-0.572,3.347-2.227,3.597-3.857l0,0l0.001,0.002
			c0.025-0.167,0.039-0.334,0.039-0.499c0-0.001,0.003-0.001,0.003-0.002l-0.002-3.714v-4.046c0,0-0.855-0.181-2.374-0.302
			c-0.758-0.059-1.677-0.104-2.744-0.104h-0.001v-11.096h16.846v33.718H57.127v-8.166h-0.021c4.357,0,7.367-0.372,8.848-0.298l0,0
			l-0.21-0.83c0.064,0.034,0.125,0.051,0.18,0.056l0.408,1.603c0.019,0.051,0.064,0.088,0.12,0.114
			c0.133,0.06,0.34,0.056,0.469,0.031c0.185-0.035,1.423-0.388,2.13-0.388c0.708,0,1.755,0.313,2.05,0.378
			c0.342,0.076,0.586,0.009,0.662-0.092l0.452-1.749c0.134,0.055,0.204,0.124,0.172,0.188l0,0l-0.242,0.942v0.001
			c0.107,0.026,0.192,0.055,0.28,0.09l0.415-1.617l0.043-0.17c-0.024-0.008-0.055-0.017-0.095-0.029
			c-0.156-0.047-0.41-0.117-0.601-0.146c-0.339-0.05-0.934-0.136-0.996,0.096c-0.003,0.015-0.003,0.005-0.005,0.021l0,0l0.004,0.031
			c0.024,0.143,0.198,0.201,0.517,0.24c0.342,0.042,0.551,0.138,0.522,0.271c-0.052,0.103-0.335,0.179-0.67,0.124
			c-0.334-0.054-1.519-0.339-2.506-0.339c-0.986,0-2.061,0.279-2.57,0.342c-0.302,0.037-0.529,0.028-0.604-0.127
			c-0.053-0.108,0.053-0.275,0.556-0.335c0.414-0.048,0.61-0.108,0.62-0.291l0,0c0-0.102-0.093-0.229-0.387-0.282
			c-0.725-0.135-4.776,0.339-8.819,0.396C58.05,151.882,58.25,151.842,58.444,151.79L58.444,151.79z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M55.835,151.79c-0.056-0.015-0.112-0.03-0.168-0.047
			c-3.713-0.097-6.905-0.527-7.805-0.382c-0.265,0.043-0.379,0.129-0.425,0.291c-0.022,0.079,0,0.151,0,0.151
			c0-0.167,0.161-0.247,0.425-0.29c0.962-0.154,4.55,0.348,8.583,0.397C56.237,151.883,56.033,151.842,55.835,151.79z"/>
		<g>
			<path fill="#E59E90" d="M65.941,139.474c0,0,0.088-0.345,0.428-0.318c0.17,0.014,0.208,0.048,0.41,0.106
				c0.202,0.058,0.304,0.013,0.304,0.013c-0.402-0.022-0.439-0.236-0.782-0.183C65.932,139.148,65.941,139.474,65.941,139.474z"/>
			<path fill="#E59E90" d="M70.019,144.901c0.32,0.223,0.368,0.942,0.016,1.293c-0.496,0.495-1.756,0.287-2.458-0.2
				c-0.259-0.179-0.493-0.414-0.689-0.648c0,0,0.38,0.715,1.296,1.045c0.914,0.33,1.55,0.222,1.851-0.053
				c0.255-0.234,0.286-0.458,0.298-0.724C70.354,145.146,70.019,144.901,70.019,144.901z"/>
			<path fill="#E59E90" d="M64.741,141.612c0.041-0.002,0.087-0.002,0.139,0c0.208,0.009,0.747-0.018,0.694-0.622
				c0,0,0.099,0.286-0.082,0.521c-0.085,0.11-0.32,0.176-0.522,0.144C64.848,141.637,64.741,141.612,64.741,141.612z"/>
			<path fill="#E59E90" d="M65.497,139.35c-0.166-0.017-0.253,0.033-0.37,0.116c-0.191,0.136-0.416,0.032-0.59,0.008
				c-0.176-0.023-0.265,0.024-0.24,0.112c0.024,0.088,0.04,0.191,0.008,0.423c-0.013,0.097-0.014,0.177-0.003,0.241
				c0,0,0.009-0.207,0.067-0.312c0.059-0.106,0.026-0.208,0.005-0.277c-0.022-0.069-0.011-0.17,0.271-0.106
				c0.282,0.064,0.412,0.118,0.526-0.026C65.316,139.346,65.497,139.35,65.497,139.35z"/>
			<path fill="#E59E90" d="M63.894,142.515c-0.195-0.133-0.382-0.168-0.627-0.343c-0.146-0.105-0.26-0.258-0.339-0.389
				c0,0,0.011,0.188,0.267,0.421c0.088,0.079,0.288,0.183,0.407,0.215C63.723,142.451,63.894,142.515,63.894,142.515z"/>
			<path fill="#E59E90" d="M70.306,141.426c-0.312,0.207-0.81-0.13-1.197,0.123c-0.463,0.304-0.175,0.862-0.175,0.862
				s0.064,0,0.133,0.037c0,0-0.229-0.34-0.069-0.639c0.159-0.298,0.463-0.328,0.788-0.239
				C70.158,141.672,70.306,141.426,70.306,141.426z"/>
			<path fill="#E59E90" d="M68.688,142.476c-0.25,0.092-0.614,0.306-0.697,0.781c-0.081,0.47,0.089,0.776,0.279,0.967
				c0,0-0.36-0.481-0.183-1.067C68.248,142.624,68.688,142.476,68.688,142.476z"/>
			<path fill="#E59E90" d="M68.577,145.105c-0.037-0.077-0.06-0.174-0.047-0.284c0.013-0.101,0.057-0.213,0.148-0.336
				c0,0,0.036,0.021,0.08,0.036c0,0-0.089,0.081-0.147,0.228C68.547,144.909,68.577,145.105,68.577,145.105z"/>
			<path fill="#E59E90" d="M70.937,144.183c-0.774-0.224-0.726,0.279-0.726,0.279c-0.271-0.199-0.59-0.207-0.814-0.23
				c0,0,0.655,0.06,0.898,0.422c0,0-0.099-0.307,0.1-0.434C70.574,144.104,70.937,144.183,70.937,144.183z"/>
			<path fill="#E59E90" d="M69.988,148.197c0.088,0.184-0.008,0.415-0.312,0.399c0,0,0.263,0.059,0.355-0.111
				C70.111,148.337,69.988,148.197,69.988,148.197z"/>
			<path fill="#E59E90" d="M67.09,148.365c-0.055,0.243-0.106,0.499,0.012,0.901c0.114,0.387,0.315,0.543,0.211,0.71
				c-0.03,0.05-0.073,0.084-0.117,0.108c0,0,0.125-0.021,0.197-0.132c0.108-0.169-0.064-0.344-0.231-0.758
				C66.995,148.78,67.09,148.365,67.09,148.365z"/>
			<path fill="#E59E90" d="M65.57,146.903c-0.152,0.005-0.326,0.026-0.483,0.081c-0.484,0.168-0.582,0.678-0.958,0.75
				c-0.056,0.011-0.104,0.01-0.145,0.002c0,0,0.208,0.118,0.448-0.105c0.24-0.225,0.395-0.467,0.682-0.595
				C65.403,146.908,65.57,146.903,65.57,146.903z"/>
			<path fill="#E59E90" d="M64.001,148.141c-0.255,0.104-0.112,0.487-0.303,0.6c-0.123,0.071-0.263,0.071-0.263,0.071
				s0.309,0.031,0.379-0.123c0.056-0.124,0.044-0.256,0.076-0.372C63.921,148.2,64.001,148.141,64.001,148.141z"/>
			<path fill="#E59E90" d="M63.979,149.738c-0.091,0.098-0.21,0.198-0.361,0.318c-0.374,0.298-0.438,0.591-0.95,0.791
				c-0.209,0.081-0.405-0.072-0.645-0.106c0,0,0.254,0.121,0.397,0.178s0.272,0.095,0.567-0.119c0.295-0.217,0.367-0.424,0.63-0.647
				C63.881,149.93,63.979,149.738,63.979,149.738z"/>
			<path fill="#E59E90" d="M63.379,145.396c-0.396,0.471-1.078,0.878-1.078,0.878c-0.017-0.005-0.037-0.01-0.059-0.014
				c-0.138-0.025-0.355-0.02-0.501,0.067c0,0,0.345-0.109,0.577,0.051c0,0,0.255-0.096,0.526-0.336
				C63.116,145.804,63.379,145.396,63.379,145.396z"/>
			<path fill="#E59E90" d="M69.74,150.352c0.162,0.664-0.295,1.03-0.295,1.03c-0.083-0.069-0.195-0.109-0.304-0.124
				c0,0,0.208,0.076,0.312,0.212c0,0,0.153-0.11,0.279-0.384C69.875,150.775,69.74,150.352,69.74,150.352z"/>
			<path fill="#E59E90" d="M71.104,140.95c-0.05,0.406-0.195,0.645-0.34,0.785c-0.181,0.175-0.362,0.197-0.362,0.197
				s-0.05,0.06-0.149,0.131c0,0,0.495-0.057,0.686-0.462C71.133,141.195,71.104,140.95,71.104,140.95z"/>
			<path fill="#E59E90" d="M66.935,148.006c0,0-0.176-0.288,0.076-0.535c0,0-0.06-0.239-0.427-0.402c0,0,0.223,0.147,0.331,0.395
				C66.915,147.463,66.655,147.755,66.935,148.006z"/>
		</g>
		<g>
			<path fill="#CF4D4A" d="M67.09,148.365c0,0-0.096,0.415,0.072,0.83c0.167,0.414,0.34,0.589,0.231,0.758
				c-0.072,0.111-0.197,0.132-0.197,0.132s0.221-0.012,0.301-0.18c0.08-0.168,0.047-0.312-0.152-0.718
				c-0.181-0.37-0.161-0.531-0.137-0.819c0.024-0.287,0.02-0.498-0.047-0.682c0,0-0.005,0.375-0.042,0.542L67.09,148.365z"/>
			<path fill="#CF4D4A" d="M70.937,144.183c0,0-0.363-0.079-0.542,0.037c-0.199,0.127-0.1,0.434-0.1,0.434
				c-0.243-0.362-0.898-0.422-0.898-0.422s0.562,0.036,0.998,0.662c0,0-0.155-0.44,0.044-0.606
				C70.613,144.139,70.937,144.183,70.937,144.183z"/>
			<path fill="#CF4D4A" d="M64.741,141.612c0,0,0.107,0.024,0.229,0.043c0.202,0.032,0.437-0.033,0.522-0.144
				c0.181-0.235,0.082-0.521,0.082-0.521c-0.003-0.037-0.008-0.079-0.016-0.122c0,0,0.172,0.311,0.035,0.627
				c-0.117,0.272-0.479,0.272-0.612,0.224C64.848,141.672,64.741,141.612,64.741,141.612z"/>
			<path fill="#CF4D4A" d="M64.406,140.447c-0.053-0.043-0.089-0.106-0.104-0.197c0,0,0.009-0.207,0.067-0.312
				c0.059-0.106,0.026-0.208,0.005-0.277c-0.022-0.069-0.011-0.17,0.271-0.106c0.282,0.064,0.412,0.118,0.526-0.026
				c0.145-0.182,0.325-0.178,0.325-0.178c0.058,0.006,0.126,0.021,0.208,0.044c0,0-0.271-0.053-0.383,0.102
				c-0.112,0.154-0.17,0.288-0.5,0.16c-0.33-0.128-0.404-0.075-0.361,0.048c0.042,0.122,0.012,0.162-0.064,0.34
				C64.289,140.293,64.406,140.447,64.406,140.447z"/>
			<path fill="#CF4D4A" d="M65.941,139.474c0,0,0.088-0.345,0.428-0.318c0.17,0.014,0.208,0.048,0.41,0.106
				c0.202,0.058,0.304,0.013,0.304,0.013c0.083,0.006,0.182,0.002,0.303-0.013c0,0-0.354,0.224-0.708,0.058
				C66.167,139.081,65.941,139.474,65.941,139.474z"/>
			<path fill="#CF4D4A" d="M62.796,141.517c0,0,0.044,0.12,0.132,0.267c0,0,0.011,0.188,0.267,0.421
				c0.088,0.079,0.288,0.183,0.407,0.215c0.12,0.032,0.292,0.096,0.292,0.096c0.054,0.037,0.108,0.08,0.163,0.136
				c0,0-0.127-0.071-0.287-0.111s-0.542-0.128-0.766-0.383C62.757,141.874,62.796,141.517,62.796,141.517z"/>
			<path fill="#CF4D4A" d="M70.306,141.426c0,0-0.148,0.246-0.521,0.145c-0.324-0.089-0.628-0.059-0.788,0.239
				c-0.16,0.299,0.069,0.639,0.069,0.639s0.053,0.021,0.128,0.069c0,0-0.259-0.399-0.064-0.702c0.165-0.256,0.5-0.154,0.719-0.123
				C70.231,141.749,70.306,141.426,70.306,141.426z"/>
			<path fill="#CF4D4A" d="M68.678,144.485c0,0-0.215-0.07-0.407-0.262c0,0-0.36-0.481-0.183-1.067
				c0.16-0.532,0.601-0.681,0.601-0.681c0.142-0.052,0.245-0.064,0.245-0.064s-0.646,0.161-0.771,0.819
				C67.997,144.098,68.678,144.485,68.678,144.485z"/>
			<path fill="#CF4D4A" d="M68.758,144.521c0,0-0.089,0.081-0.147,0.228c-0.064,0.16-0.034,0.356-0.034,0.356
				c0.021,0.043,0.045,0.081,0.069,0.113c0,0-0.083-0.209,0.02-0.441c0.088-0.196,0.208-0.231,0.208-0.231
				S68.81,144.538,68.758,144.521z"/>
			<path fill="#CF4D4A" d="M69.988,148.197c0,0,0.123,0.14,0.044,0.288c-0.093,0.17-0.355,0.111-0.355,0.111
				c-0.071-0.004-0.134-0.002-0.191,0.004c0,0,0.151,0.02,0.291,0.047c0.135,0.028,0.278-0.027,0.314-0.162
				C70.135,148.325,69.988,148.197,69.988,148.197z"/>
			<path fill="#CF4D4A" d="M70.019,144.901c0,0,0.335,0.244,0.314,0.713c-0.012,0.266-0.042,0.489-0.298,0.724
				c-0.301,0.274-0.937,0.383-1.851,0.053c-0.916-0.33-1.296-1.045-1.296-1.045c-0.162-0.192-0.299-0.383-0.404-0.542
				c0,0,0.271,0.752,0.909,1.238c0.913,0.696,2.158,0.771,2.606,0.476c0.399-0.264,0.451-0.698,0.403-1.022
				C70.347,145.122,70.019,144.901,70.019,144.901z"/>
			<path fill="#CF4D4A" d="M63.985,147.736c0,0,0.208,0.118,0.448-0.105c0.24-0.225,0.395-0.467,0.682-0.595
				c0.288-0.128,0.455-0.133,0.455-0.133c0.226-0.009,0.403,0.017,0.403,0.017s-0.362-0.033-0.743,0.132
				c-0.338,0.148-0.451,0.387-0.654,0.583C64.253,147.945,63.985,147.736,63.985,147.736z"/>
			<path fill="#CF4D4A" d="M64.001,148.141c0,0-0.08,0.06-0.112,0.176c-0.031,0.116-0.02,0.248-0.076,0.372
				c-0.07,0.154-0.379,0.123-0.379,0.123s0.292,0.063,0.431-0.083c0.076-0.081,0.081-0.276,0.095-0.372
				c0.024-0.159,0.108-0.207,0.108-0.207S64.029,148.149,64.001,148.141z"/>
			<path fill="#CF4D4A" d="M63.618,149.259c0,0,0.383-0.071,0.4-0.312c0,0,0.043-0.024,0.063-0.044
				C64.081,148.903,64.137,149.22,63.618,149.259z"/>
			<path fill="#CF4D4A" d="M64.193,149.314c-0.019,0.163-0.088,0.289-0.214,0.424c0,0-0.098,0.191-0.361,0.414
				c-0.263,0.224-0.334,0.431-0.63,0.647c-0.295,0.214-0.423,0.176-0.567,0.119s-0.397-0.178-0.397-0.178s0.294,0.17,0.429,0.265
				c0.136,0.096,0.344,0.111,0.663-0.15c0.319-0.264,0.415-0.544,0.678-0.719C64.303,149.798,64.193,149.314,64.193,149.314z"/>
			<path fill="#CF4D4A" d="M63.379,145.396c0,0-0.264,0.408-0.535,0.646c-0.271,0.24-0.526,0.336-0.526,0.336
				c-0.232-0.16-0.577-0.051-0.577-0.051s0.329-0.102,0.568,0.219c0,0,0.316-0.124,0.583-0.384
				C63.187,145.874,63.379,145.396,63.379,145.396z"/>
			<path fill="#CF4D4A" d="M69.74,150.352c0,0,0.136,0.424-0.008,0.734c-0.126,0.273-0.279,0.384-0.279,0.384
				c-0.104-0.136-0.312-0.212-0.312-0.212s0.232,0.148,0.32,0.324c0,0,0.213-0.148,0.328-0.456
				C69.916,150.783,69.74,150.352,69.74,150.352z"/>
			<path fill="#CF4D4A" d="M71.104,140.95c0,0,0.028,0.245-0.165,0.651c-0.191,0.405-0.686,0.462-0.686,0.462
				c-0.046,0.034-0.104,0.07-0.172,0.104c0,0,0.496,0.061,0.794-0.331C71.163,141.458,71.104,140.95,71.104,140.95z"/>
			<path fill="#CF4D4A" d="M66.583,147.068c0,0,0.367,0.008,0.555,0.418c0,0-0.3,0.148-0.204,0.52c0,0-0.176-0.288,0.076-0.535
				C67.011,147.471,66.951,147.231,66.583,147.068z"/>
			<path fill="#CF4D4A" d="M65.341,142.708c0,0,0.083,0.267-0.175,0.4c-0.249,0.129-0.316,0.264-0.316,0.264
				s0.117-0.061,0.349-0.176C65.412,143.089,65.433,142.909,65.341,142.708z"/>
			<path fill="#CF4D4A" d="M64.997,143.558c0,0,0.063,0.427-0.279,0.492c-0.343,0.065-0.446,0.203-0.446,0.203
				s0.299-0.089,0.469-0.078C65.046,144.194,65.124,143.888,64.997,143.558z"/>
			<path fill="#CF4D4A" d="M65.968,141.772c0,0,0.247,0.146,0.093,0.481c-0.133,0.29-0.144,0.452-0.144,0.452
				s0.112-0.148,0.208-0.319C66.265,142.137,66.241,141.866,65.968,141.772z"/>
			<path fill="#CF4D4A" d="M66.359,142.139c0,0,0.252,0.398-0.017,0.646c-0.199,0.182-0.199,0.445-0.199,0.445
				s0.123-0.221,0.332-0.416C66.646,142.653,66.624,142.365,66.359,142.139z"/>
			<path fill="#CF4D4A" d="M65.771,142.761c0,0,0.156,0.292-0.157,0.505c-0.266,0.18-0.227,0.377-0.227,0.377
				s0.088-0.17,0.301-0.287C65.901,143.238,65.933,142.973,65.771,142.761z"/>
			<path fill="#CF4D4A" d="M66.368,140.964c0,0,0.21,0.146,0.176,0.42s0.054,0.423,0.054,0.423s-0.01-0.148,0.038-0.377
				C66.688,141.174,66.536,140.999,66.368,140.964z"/>
			<path fill="#CF4D4A" d="M66.441,140.216c0,0,0.234,0.031,0.214,0.249c-0.019,0.218,0.087,0.28,0.087,0.28
				s-0.02-0.115-0.001-0.263C66.764,140.323,66.667,140.216,66.441,140.216z"/>
		</g>
		<g>
			<path fill="#C4122F" d="M49.478,152.841c-0.1-0.288-0.19-0.543-0.29-0.824c-0.034-0.019-0.067-0.036-0.101-0.054
				c0-0.011,0-0.021,0-0.032c0.112,0.01,0.218,0.019,0.331,0.028c0,0.011,0,0.021,0,0.031c-0.035,0.013-0.065,0.024-0.1,0.037
				c0.062,0.183,0.12,0.356,0.181,0.539c0.01,0.031,0.02,0.062,0.031,0.094c0.003,0.012,0.006,0.023,0.01,0.034
				c0.08-0.221,0.154-0.419,0.234-0.631c-0.033-0.019-0.066-0.035-0.098-0.052c0-0.012,0-0.021,0-0.032
				c0.096,0.008,0.188,0.015,0.283,0.022c0,0.01,0,0.021,0,0.031c-0.033,0.012-0.063,0.023-0.097,0.036
				c-0.11,0.261-0.211,0.505-0.322,0.777C49.52,152.845,49.5,152.843,49.478,152.841z"/>
			<path fill="#C4122F" d="M49.977,152.866c0-0.01,0-0.021,0-0.031c0.033-0.011,0.064-0.021,0.097-0.031c0-0.178,0-0.346,0-0.519
				c-0.033-0.016-0.064-0.03-0.097-0.046c0-0.009,0-0.018,0-0.028c0.105,0.008,0.205,0.015,0.31,0.022c0,0.009,0,0.018,0,0.027
				c-0.033,0.011-0.063,0.021-0.097,0.032c0,0.173,0,0.341,0,0.52c0.032,0.015,0.064,0.03,0.097,0.046c0,0.01,0,0.021,0,0.031
				C50.181,152.882,50.082,152.874,49.977,152.866z"/>
			<path fill="#C4122F" d="M51.009,152.727c0,0.062,0,0.121,0,0.184c-0.081,0.019-0.155,0.025-0.232,0.021
				c-0.121-0.01-0.192-0.041-0.255-0.11c-0.059-0.067-0.086-0.144-0.087-0.245c0.004-0.172,0.087-0.282,0.235-0.313
				c0.049-0.01,0.088-0.011,0.149-0.007c0.079,0.005,0.144,0.016,0.19,0.033c0,0.05,0,0.098,0,0.148
				c-0.014,0-0.026-0.002-0.04-0.002c-0.015-0.039-0.029-0.075-0.045-0.114c-0.025-0.002-0.048-0.005-0.073-0.008
				c-0.109-0.006-0.163,0.008-0.213,0.055c-0.052,0.051-0.075,0.113-0.076,0.213c0.004,0.179,0.085,0.276,0.246,0.291
				c0.031-0.001,0.06-0.003,0.091-0.005c0-0.05,0-0.098,0-0.146c-0.032-0.016-0.065-0.03-0.098-0.045c0-0.011,0-0.021,0-0.031
				c0.099,0.007,0.193,0.013,0.291,0.018c0,0.011,0,0.021,0,0.031C51.065,152.704,51.038,152.715,51.009,152.727z"/>
			<path fill="#C4122F" d="M51.2,152.953c0-0.01,0-0.021,0-0.032c0.033-0.012,0.064-0.021,0.097-0.033c0-0.183,0-0.354,0-0.526
				c-0.032-0.015-0.064-0.028-0.097-0.043c0-0.011,0-0.019,0-0.028c0.104,0.006,0.205,0.012,0.31,0.018c0,0.009,0,0.019,0,0.027
				c-0.034,0.012-0.064,0.022-0.096,0.034c0,0.172,0,0.343,0,0.526c0.032,0.015,0.064,0.03,0.096,0.046c0,0.01,0,0.021,0,0.032
				C51.405,152.967,51.305,152.96,51.2,152.953z"/>
			<path fill="#C4122F" d="M51.654,152.982c0-0.01,0-0.021,0-0.032c0.033-0.012,0.064-0.023,0.097-0.034c0-0.186,0-0.356,0-0.529
				c-0.033-0.015-0.064-0.029-0.097-0.044c0-0.009,0-0.018,0-0.027c0.104,0.006,0.205,0.011,0.31,0.017c0,0.009,0,0.018,0,0.027
				c-0.032,0.012-0.063,0.021-0.096,0.033c0,0.179,0,0.355,0,0.547c0.058,0.004,0.113,0.006,0.17,0.01
				c0.021-0.044,0.042-0.085,0.063-0.127c0.014,0,0.026,0.001,0.041,0.002c-0.006,0.062-0.012,0.123-0.017,0.188
				C51.965,153.002,51.813,152.993,51.654,152.982z"/>
			<path fill="#C4122F" d="M52.573,152.473c0.005,0.012,0.009,0.022,0.013,0.034c0.005,0.016,0.011,0.03,0.016,0.046
				c0.019,0.054,0.036,0.105,0.055,0.16c-0.06-0.003-0.117-0.006-0.175-0.008C52.512,152.624,52.542,152.55,52.573,152.473z
				 M52.67,152.762c0.022,0.069,0.044,0.137,0.067,0.209c-0.027,0.012-0.053,0.025-0.081,0.037c0,0.011,0,0.022,0,0.034
				c0.099,0.005,0.195,0.01,0.294,0.015c0-0.011,0-0.022,0-0.033c-0.03-0.016-0.059-0.031-0.088-0.047
				c-0.077-0.228-0.146-0.422-0.222-0.619c-0.026-0.001-0.051-0.002-0.077-0.004c-0.084,0.191-0.162,0.378-0.247,0.595
				c-0.029,0.012-0.058,0.023-0.086,0.037c0,0.01,0,0.021,0,0.032c0.081,0.005,0.158,0.009,0.238,0.014c0-0.011,0-0.023,0-0.033
				c-0.026-0.016-0.053-0.031-0.079-0.046c0.024-0.068,0.047-0.134,0.071-0.2C52.533,152.755,52.599,152.758,52.67,152.762z"/>
			<path fill="#C4122F" d="M53.21,152.993c0-0.197,0-0.378,0-0.557c-0.047-0.004-0.093-0.004-0.14-0.006
				c-0.017,0.035-0.033,0.069-0.05,0.105c-0.015,0-0.028,0-0.042-0.001c0-0.055,0-0.104,0-0.158
				c0.197,0.008,0.385,0.016,0.581,0.021c0,0.054,0,0.104,0,0.159c-0.013,0-0.026-0.001-0.039-0.001
				c-0.015-0.038-0.028-0.074-0.044-0.11c-0.05-0.004-0.099-0.004-0.149-0.006c0,0.18,0,0.36,0,0.559
				c0.035,0.016,0.069,0.031,0.104,0.047c0,0.011,0,0.023,0,0.034c-0.109-0.005-0.213-0.01-0.322-0.016c0-0.011,0-0.022,0-0.034
				C53.142,153.019,53.175,153.006,53.21,152.993z"/>
			<path fill="#C4122F" d="M53.872,152.755c0,0.095,0,0.187,0,0.285c0.073,0.003,0.142,0.005,0.215,0.008
				c0.019-0.034,0.042-0.072,0.061-0.106c0.014,0.001,0.026,0.001,0.04,0.002c-0.005,0.056-0.011,0.11-0.017,0.169
				c-0.173-0.008-0.34-0.015-0.514-0.021c0-0.011,0-0.024,0-0.034c0.033-0.014,0.064-0.026,0.097-0.039c0-0.194,0-0.371,0-0.547
				c-0.033-0.013-0.064-0.026-0.097-0.04c0-0.01,0-0.019,0-0.028c0.172,0.006,0.337,0.011,0.51,0.016c0,0.048,0,0.096,0,0.146
				c-0.014,0-0.027,0-0.04,0c-0.016-0.036-0.031-0.07-0.047-0.105c-0.071-0.002-0.138-0.004-0.208-0.006c0,0.084,0,0.167,0,0.255
				c0.057,0.002,0.112,0.003,0.169,0.006c0.012-0.028,0.024-0.057,0.035-0.086c0.014,0,0.027,0.001,0.041,0.001
				c0,0.075,0,0.148,0,0.227c-0.014,0-0.027-0.001-0.041-0.001c-0.011-0.03-0.023-0.063-0.035-0.093
				C53.984,152.759,53.929,152.757,53.872,152.755z"/>
			<path fill="#C4122F" d="M54.908,152.492c0.035,0,0.069,0.002,0.104,0.002c0.089,0.003,0.135,0.023,0.179,0.083
				c0.035,0.05,0.051,0.107,0.052,0.195c-0.001,0.101-0.021,0.168-0.073,0.229c-0.049,0.055-0.086,0.07-0.171,0.069
				c-0.031-0.001-0.06-0.002-0.091-0.003C54.908,152.862,54.908,152.676,54.908,152.492z M55.008,153.14
				c0.105,0.003,0.172-0.018,0.235-0.066c0.084-0.072,0.127-0.179,0.129-0.312c-0.001-0.101-0.026-0.169-0.083-0.232
				c-0.067-0.071-0.119-0.087-0.266-0.091c-0.112-0.002-0.218-0.004-0.329-0.006c0,0.008,0,0.018,0,0.027
				c0.033,0.013,0.063,0.026,0.097,0.039c0,0.178,0,0.357,0,0.555c-0.032,0.015-0.064,0.027-0.097,0.042c0,0.01,0,0.024,0,0.035
				C54.8,153.134,54.901,153.137,55.008,153.14z"/>
			<path fill="#C4122F" d="M55.734,152.803c0,0.096,0,0.191,0,0.293c0.073,0.002,0.142,0.003,0.215,0.004
				c0.019-0.034,0.042-0.076,0.061-0.111c0.014,0,0.027,0.001,0.04,0.001c-0.005,0.058-0.011,0.114-0.017,0.174
				c-0.173-0.002-0.339-0.006-0.514-0.009c0-0.012,0-0.025,0-0.036c0.033-0.015,0.065-0.028,0.098-0.043c0-0.2,0-0.381,0-0.56
				c-0.033-0.014-0.065-0.027-0.098-0.04c0-0.01,0-0.018,0-0.027c0.172,0.002,0.337,0.004,0.51,0.006c0,0.049,0,0.097,0,0.147
				c-0.014,0-0.027,0-0.041,0c-0.016-0.035-0.031-0.07-0.047-0.105c-0.071-0.001-0.138-0.001-0.208-0.002c0,0.085,0,0.169,0,0.259
				c0.058,0.001,0.112,0.002,0.169,0.003c0.012-0.029,0.024-0.06,0.035-0.088c0.014,0,0.026,0.001,0.04,0.001c0,0.076,0,0.15,0,0.23
				c-0.014-0.001-0.026,0-0.04-0.001c-0.011-0.029-0.023-0.063-0.035-0.094C55.847,152.805,55.792,152.803,55.734,152.803z"/>
			<path fill="#C4122F" d="M56.527,152.501c0.128,0.006,0.198,0.1,0.201,0.297c-0.003,0.192-0.074,0.314-0.196,0.317
				c-0.126-0.006-0.197-0.132-0.2-0.328C56.336,152.592,56.401,152.504,56.527,152.501z M56.521,153.187
				c0.206-0.004,0.331-0.171,0.336-0.409c-0.005-0.219-0.119-0.327-0.318-0.333c-0.206,0.004-0.329,0.127-0.334,0.365
				C56.209,153.029,56.323,153.179,56.521,153.187z"/>
			<path fill="#C4122F" d="M57.838,153.097c0.02-0.041,0.044-0.092,0.064-0.133c0.013,0,0.025,0,0.04,0
				c-0.004,0.06-0.008,0.117-0.013,0.178c-0.068,0.023-0.144,0.039-0.213,0.039c-0.131,0-0.199-0.028-0.263-0.103
				c-0.059-0.071-0.085-0.153-0.085-0.264c0.005-0.253,0.132-0.364,0.38-0.37c0.069,0,0.131,0.006,0.187,0.019
				c0,0.052,0,0.101,0,0.154c-0.015,0-0.031,0-0.046,0c-0.013-0.039-0.027-0.077-0.04-0.115c-0.024-0.001-0.048-0.001-0.072-0.002
				c-0.102,0.002-0.16,0.022-0.207,0.071c-0.05,0.056-0.072,0.123-0.073,0.229c0.003,0.201,0.081,0.307,0.247,0.31
				C57.774,153.105,57.806,153.101,57.838,153.097z"/>
			<path fill="#C4122F" d="M58.396,152.494c0.128,0.001,0.199,0.096,0.202,0.294c-0.003,0.192-0.074,0.317-0.197,0.324
				c-0.125-0.004-0.195-0.129-0.198-0.327C58.204,152.589,58.271,152.499,58.396,152.494z M58.389,153.183
				c0.207-0.01,0.331-0.181,0.337-0.419c-0.005-0.22-0.118-0.325-0.318-0.327c-0.205,0.008-0.328,0.134-0.333,0.374
				C58.079,153.032,58.192,153.181,58.389,153.183z"/>
			<path fill="#C4122F" d="M58.867,153.157c0-0.01,0-0.024,0-0.035c0.033-0.017,0.066-0.031,0.098-0.048c0-0.204,0-0.387,0-0.567
				c-0.034-0.013-0.064-0.024-0.098-0.037c0-0.009,0-0.018,0-0.027c0.067-0.002,0.13-0.002,0.197-0.004
				c0.124,0.154,0.236,0.307,0.36,0.486c0-0.152,0-0.29,0-0.429c-0.032-0.012-0.063-0.023-0.096-0.036c0-0.01,0-0.018,0-0.027
				c0.087-0.002,0.17-0.004,0.258-0.006c0,0.01,0,0.018,0,0.027c-0.033,0.014-0.064,0.026-0.096,0.041c0,0.207,0,0.418,0,0.655
				c-0.018,0-0.035,0.001-0.052,0.002c-0.14-0.22-0.268-0.403-0.408-0.587c0,0.162,0,0.326,0,0.508
				c0.033,0.014,0.065,0.028,0.096,0.043c0,0.011,0,0.025,0,0.036C59.038,153.154,58.955,153.156,58.867,153.157z"/>
			<path fill="#C4122F" d="M59.937,152.771c0,0.091,0,0.181,0,0.276c0.034,0.014,0.069,0.028,0.103,0.042c0,0.011,0,0.024,0,0.036
				c-0.108,0.004-0.209,0.007-0.317,0.011c0-0.011,0-0.025,0-0.036c0.033-0.017,0.066-0.032,0.098-0.049c0-0.202,0-0.384,0-0.563
				c-0.033-0.013-0.064-0.024-0.098-0.037c0-0.01,0-0.018,0-0.026c0.164-0.006,0.32-0.01,0.484-0.015c0,0.047,0,0.092,0,0.141
				c-0.014,0-0.026,0.001-0.04,0.001c-0.014-0.032-0.027-0.063-0.042-0.097c-0.064,0.002-0.125,0.004-0.188,0.006
				c0,0.086,0,0.17,0,0.261c0.05-0.001,0.099-0.003,0.15-0.005c0.011-0.029,0.023-0.06,0.036-0.089
				c0.013-0.001,0.026-0.001,0.04-0.001c0,0.076,0,0.15,0,0.23c-0.014,0-0.027,0.001-0.04,0.001
				c-0.012-0.029-0.025-0.062-0.036-0.092C60.036,152.768,59.987,152.769,59.937,152.771z"/>
			<path fill="#C4122F" d="M60.33,153.113c0-0.011,0-0.025,0-0.036c0.032-0.016,0.065-0.032,0.097-0.049c0-0.2,0-0.382,0-0.561
				c-0.033-0.012-0.064-0.023-0.097-0.035c0-0.009,0-0.019,0-0.028c0.104-0.003,0.205-0.007,0.309-0.011c0,0.01,0,0.019,0,0.028
				c-0.032,0.015-0.063,0.028-0.095,0.041c0,0.18,0,0.36,0,0.561c0.032,0.014,0.063,0.026,0.096,0.041c0,0.011,0,0.024,0,0.035
				C60.534,153.104,60.434,153.109,60.33,153.113z"/>
			<path fill="#C4122F" d="M60.997,152.437c0.035-0.002,0.069-0.004,0.104-0.004c0.089-0.004,0.136,0.014,0.179,0.07
				c0.036,0.048,0.051,0.104,0.052,0.191c0,0.101-0.021,0.168-0.072,0.232c-0.049,0.059-0.087,0.077-0.171,0.082
				c-0.031,0.002-0.06,0.003-0.091,0.005C60.997,152.808,60.997,152.62,60.997,152.437z M61.097,153.077
				c0.105-0.006,0.173-0.032,0.234-0.085c0.084-0.078,0.128-0.186,0.129-0.316c-0.001-0.1-0.026-0.167-0.083-0.228
				c-0.067-0.065-0.119-0.079-0.266-0.073c-0.112,0.004-0.218,0.009-0.33,0.013c0,0.01,0,0.019,0,0.029
				c0.034,0.01,0.064,0.021,0.098,0.033c0,0.18,0,0.359,0,0.558c-0.032,0.018-0.065,0.033-0.098,0.05c0,0.011,0,0.024,0,0.035
				C60.89,153.088,60.991,153.083,61.097,153.077z"/>
			<path fill="#C4122F" d="M61.824,152.691c0,0.094,0,0.187,0,0.285c0.073-0.005,0.143-0.01,0.216-0.014
				c0.019-0.035,0.042-0.075,0.061-0.111c0.013,0,0.026-0.002,0.04-0.002c-0.005,0.056-0.011,0.11-0.017,0.168
				c-0.173,0.01-0.339,0.021-0.513,0.031c0-0.011,0-0.023,0-0.034c0.033-0.017,0.065-0.033,0.098-0.05
				c0-0.195-0.001-0.373-0.001-0.55c-0.032-0.012-0.063-0.022-0.097-0.034c0-0.01,0-0.019,0-0.028
				c0.172-0.009,0.338-0.018,0.509-0.025c0,0.05,0,0.098,0,0.146c-0.014,0.001-0.027,0.002-0.04,0.003
				c-0.016-0.034-0.03-0.066-0.046-0.101c-0.07,0.003-0.139,0.007-0.209,0.01c0,0.084,0,0.168,0,0.257
				c0.058-0.003,0.112-0.007,0.17-0.009c0.012-0.029,0.024-0.06,0.035-0.089c0.014,0,0.026-0.001,0.04-0.002
				c0,0.075,0,0.147,0,0.226c-0.014,0.001-0.026,0.002-0.04,0.002c-0.011-0.029-0.023-0.06-0.035-0.089
				C61.936,152.685,61.881,152.688,61.824,152.691z"/>
			<path fill="#C4122F" d="M62.283,153.006c0-0.01,0-0.023,0-0.034c0.032-0.016,0.065-0.031,0.097-0.049c0-0.191,0-0.366,0-0.543
				c-0.033-0.011-0.064-0.022-0.097-0.034c0-0.009,0-0.018,0-0.027c0.066-0.004,0.129-0.007,0.195-0.011
				c0.124,0.15,0.237,0.292,0.361,0.455c0-0.143,0-0.275,0-0.41c-0.033-0.011-0.063-0.021-0.096-0.032c0-0.01,0-0.019,0-0.028
				c0.087-0.006,0.17-0.011,0.258-0.016c0,0.01,0,0.018,0,0.028c-0.033,0.015-0.064,0.029-0.097,0.044c0,0.201,0,0.402,0,0.62
				c-0.018,0.002-0.034,0.003-0.051,0.004c-0.14-0.193-0.268-0.363-0.408-0.538c0,0.157,0,0.314,0,0.484
				c0.033,0.012,0.063,0.023,0.096,0.035c0,0.011,0,0.024,0,0.034C62.453,152.994,62.37,153,62.283,153.006z"/>
			<path fill="#C4122F" d="M63.326,152.856c0-0.191,0-0.37,0-0.551c-0.048,0.003-0.094,0.006-0.141,0.009
				c-0.017,0.039-0.034,0.075-0.05,0.114c-0.014,0-0.027,0-0.042,0.002c0-0.054,0-0.106,0-0.16c0.196-0.013,0.384-0.026,0.581-0.039
				c0,0.054,0,0.105,0,0.16c-0.013,0.001-0.025,0.003-0.039,0.003c-0.016-0.037-0.029-0.07-0.044-0.107
				c-0.051,0.004-0.098,0.007-0.149,0.011c0,0.181,0,0.358,0,0.549c0.035,0.012,0.069,0.021,0.104,0.033c0,0.011,0,0.021,0,0.032
				c-0.109,0.009-0.213,0.017-0.322,0.026c0-0.011,0-0.022,0-0.033C63.257,152.889,63.291,152.872,63.326,152.856z"/>
			<path fill="#C4122F" d="M63.986,152.552c0,0.09,0,0.177,0,0.268c0.073-0.005,0.143-0.012,0.215-0.019
				c0.021-0.034,0.041-0.069,0.061-0.104c0.014-0.001,0.027-0.002,0.04-0.003c-0.005,0.052-0.011,0.103-0.017,0.155
				c-0.173,0.015-0.34,0.029-0.514,0.045c0-0.011,0-0.022,0-0.032c0.033-0.016,0.065-0.032,0.098-0.048c0-0.183,0-0.354,0-0.528
				c-0.033-0.011-0.064-0.021-0.098-0.032c0-0.01,0-0.02,0-0.028c0.172-0.013,0.337-0.024,0.51-0.038c0,0.051,0,0.098,0,0.147
				c-0.014,0.001-0.027,0.003-0.04,0.004c-0.016-0.035-0.03-0.066-0.046-0.101c-0.071,0.006-0.139,0.011-0.21,0.016
				c0,0.086,0,0.167,0,0.252c0.058-0.004,0.113-0.009,0.171-0.013c0.011-0.029,0.023-0.058,0.035-0.086
				c0.014,0,0.027-0.002,0.041-0.003c0,0.072,0,0.142,0,0.216c-0.014,0.001-0.026,0.002-0.041,0.003
				c-0.012-0.028-0.023-0.055-0.035-0.084C64.099,152.543,64.044,152.547,63.986,152.552z"/>
			<path fill="#C4122F" d="M64.479,152.811c0-0.054,0-0.105,0-0.159c0.014-0.001,0.027-0.001,0.041-0.003
				c0.017,0.039,0.033,0.076,0.05,0.114c0.03,0.002,0.057,0.004,0.087,0.005c0.089-0.01,0.131-0.047,0.133-0.117
				c-0.001-0.049-0.015-0.066-0.085-0.105c-0.034-0.019-0.066-0.035-0.1-0.054c-0.094-0.053-0.118-0.083-0.119-0.157
				c0.003-0.111,0.078-0.181,0.211-0.194c0.047-0.004,0.11-0.002,0.173,0.006c0.005,0.001,0.01,0.001,0.016,0.002
				c0,0.052,0,0.101,0,0.151c-0.014,0.001-0.026,0.002-0.04,0.003c-0.017-0.037-0.032-0.07-0.048-0.107
				c-0.026,0-0.05,0.001-0.077,0.001c-0.09,0.009-0.13,0.04-0.131,0.101c0,0.04,0.011,0.053,0.079,0.09
				c0.038,0.021,0.073,0.04,0.11,0.061c0.113,0.061,0.133,0.088,0.134,0.171c-0.003,0.115-0.086,0.191-0.232,0.208
				c-0.043,0.004-0.107,0-0.188-0.014C64.488,152.812,64.484,152.811,64.479,152.811z"/>
		</g>
		<g>
			<path fill="#DDB10A" d="M57.095,138.322c-2.267,0.019-3.21,0.389-3.494,0.534l-0.102,0.062c0,0-0.041-0.143-0.111-0.452
				l-0.282-0.27l0.139-0.391c-0.067-0.247-0.111-0.423-0.181-0.628c-0.161-0.478-0.398-0.573-0.564-0.659l0,0
				c0,0,0.034-0.038,0.062-0.056c-0.291-0.292-0.582-0.526-0.582-0.526c0.08,0.029,0.182,0.047,0.366-0.031
				c0.167-0.071,0.347-0.019,0.374,0.133c0.049-0.034,0.107-0.051,0.164-0.048c0.1,0.001,0.202,0.053,0.252,0.152
				c0.187,0.369-0.102,0.576-0.102,0.576c0.104,0.093,0.337,0.112,0.393-0.074c0.061-0.203,0.031-0.354,0.025-0.462
				c-0.002,0.001,0.042-0.018,0.042-0.018c0.148,0.198,0.347,0.292,0.46,0.327c0.182,0.056,0.357-0.096,0.396-0.297h0
				c-0.384,0.053-0.566-0.045-0.689-0.282c-0.083-0.161-0.073-0.46,0.173-0.518l0,0c-0.167-0.061-0.211-0.387-0.032-0.54
				c0.206-0.175,0.135-0.529,0.135-0.529c0.115,0.111,0.239,0.237,0.479,0.294c0.339,0.082,0.445,0.297,0.336,0.463
				c0.259-0.03,0.424,0.163,0.422,0.438c0,0,0.021,0.399-0.476,0.581c0.039,0.052,0.088,0.102,0.154,0.14
				c0.491,0.29,0.717-0.329,0.781-0.548h0.071c0,0.001-0.001,0-0.002,0.001c0.125,0.176,0.468,0.598,0.849,0.473
				c0.142-0.047,0.233-0.138,0.291-0.244c-0.242-0.032-0.432-0.085-0.58-0.284c-0.259-0.35-0.103-0.83,0.225-0.846
				c-0.229-0.234-0.054-0.563,0.177-0.652c0.285-0.11,0.462-0.459,0.462-0.459s0,0.338,0.393,0.473
				c0.361,0.124,0.458,0.481,0.143,0.649c0.387,0.036,0.497,0.41,0.363,0.649c-0.16,0.396-0.67,0.454-0.67,0.454
				c0.053,0.084,0.115,0.144,0.164,0.179c0.156,0.111,0.389,0.111,0.608-0.085c0.133-0.119,0.211-0.229,0.255-0.307l0.083,0.013
				c0.078,0.228,0.293,0.706,0.677,0.501c0.038-0.024,0.104-0.075,0.167-0.146c-0.151-0.061-0.271-0.148-0.339-0.281
				c-0.009-0.019-0.018-0.039-0.025-0.06c-0.142-0.307,0.073-0.717,0.411-0.659c-0.107-0.114-0.08-0.378,0.234-0.414
				c0.135-0.016,0.342-0.074,0.53-0.228c0,0-0.008,0.294,0.147,0.418c0.23,0.184,0.169,0.469-0.035,0.539
				c0.314,0.132,0.233,0.687-0.344,0.758c-0.052,0.009-0.182,0.013-0.182,0.013c0.037,0.306,0.239,0.402,0.421,0.353
				c0.145-0.04,0.307-0.174,0.394-0.253l0.058,0.019c-0.006,0.065-0.002,0.239,0.065,0.381c0.072,0.151,0.299,0.255,0.476,0.088
				c-0.028-0.008-0.073-0.039-0.073-0.039c-0.331-0.248,0.017-0.918,0.308-0.672c0.018-0.104,0.109-0.157,0.218-0.155
				c0.073,0,0.125,0.02,0.156,0.033c0.24,0.102,0.402,0.043,0.402,0.043s-0.231,0.173-0.513,0.572l0,0
				c0.046,0.021,0.079,0.047,0.079,0.047c-0.103,0.036-0.267,0.144-0.372,0.355c-0.119,0.243-0.247,0.55-0.343,0.854l0.067,0.291
				l-0.2,0.238c-0.059,0.222-0.062,0.445-0.106,0.713c0,0-0.054-0.041-0.144-0.091c0.003-0.002,0,0,0,0
				C60.316,138.774,59.31,138.304,57.095,138.322"/>
		</g>
		<g>
			<path fill="#F1D99E" d="M58.464,135.708c0.078,0.228,0.293,0.706,0.677,0.501c0.038-0.024,0.104-0.075,0.167-0.146
				c0,0-0.117,0.299-0.377,0.301C58.46,136.368,58.464,135.708,58.464,135.708z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M55.702,135.695c0.125,0.176,0.468,0.598,0.849,0.473
				c0.142-0.047,0.233-0.138,0.291-0.244c0,0-0.082,0.386-0.436,0.386C55.779,136.31,55.702,135.695,55.702,135.695z"/>
			<path fill="#F1D99E" d="M61.046,136.697c-0.331-0.248,0.017-0.918,0.308-0.672c0.018-0.104,0.109-0.157,0.218-0.155
				c0.073,0,0.125,0.02,0.156,0.033c0.24,0.102,0.402,0.043,0.402,0.043s-0.127,0.099-0.345,0.058
				c-0.121-0.022-0.308-0.067-0.375,0.177C61.196,135.906,60.947,136.395,61.046,136.697z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M57.125,133.683c0,0-0.177,0.349-0.462,0.459
				c-0.231,0.089-0.406,0.418-0.177,0.652c-0.328,0.016-0.483,0.496-0.225,0.846c0.148,0.199,0.338,0.252,0.58,0.284
				c0,0,0.195-0.533-0.249-0.948c0,0,0.237,0.04,0.408,0.115c0.087-0.379,0.122-0.966,0.124-1.247
				C57.111,133.751,57.125,133.683,57.125,133.683z"/>
			<path fill="#F1D99E" d="M53.825,137.997l-0.438-0.137l-0.038-0.149c-0.015-0.052-0.029-0.104-0.045-0.158
				c0.106-0.035,1.948-0.64,3.775-0.649c2.223-0.014,3.753,0.489,3.753,0.489c-0.838-0.368-2.196-0.658-3.742-0.658
				c-1.507,0-2.777,0.278-3.851,0.596c-0.008-0.024-0.015-0.048-0.021-0.071c-0.096-0.318-0.209-0.49-0.319-0.603
				c-0.192-0.194-0.398-0.138-0.398-0.138c0.166,0.086,0.403,0.182,0.564,0.659c0.07,0.205,0.114,0.381,0.181,0.628l-0.139,0.391
				l0.282,0.27c0.07,0.31,0.111,0.452,0.111,0.452l0.102-0.062c-0.004-0.081-0.023-0.199-0.053-0.346
				c0.149-0.188,0.309-0.376,0.468-0.56L53.825,137.997z"/>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M55.71,137.648c-0.042-0.009-0.086-0.021-0.134-0.026
					c0.002,0.01,0.006,0.018,0.008,0.026c0.017,0.178-0.131,0.328-0.356,0.369c-0.227,0.031-0.415-0.065-0.455-0.241
					c-0.003-0.023-0.003-0.046-0.001-0.068c-0.022,0.007-0.063,0.017-0.098,0.026c-0.002,0.026-0.001,0.053,0.003,0.079
					c0.033,0.231,0.29,0.354,0.579,0.313C55.542,138.073,55.75,137.876,55.71,137.648z"/>
			</g>
			<path fill="#F1D99E" d="M57.7,137.526C57.702,137.527,57.704,137.528,57.7,137.526c-0.209,0.109-0.381,0.221-0.58,0.335
				c-0.204-0.112-0.396-0.212-0.611-0.319c0.001-0.001,0.002-0.002,0.003-0.002l-0.218,0.027c0.079,0.025,0.566,0.309,0.85,0.475
				c0.276-0.169,0.739-0.454,0.825-0.485L57.7,137.526z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M58.658,137.666c-0.033,0.223,0.171,0.402,0.445,0.453
				c0.275,0.038,0.515-0.084,0.543-0.31c0.001-0.014,0.003-0.031,0.003-0.044c-0.028-0.038-0.068-0.073-0.117-0.104
				c0.008,0.034,0.012,0.07,0.007,0.106c-0.037,0.177-0.21,0.273-0.427,0.245c-0.215-0.04-0.361-0.189-0.35-0.367
				c0.003-0.016,0.008-0.03,0.013-0.045C58.731,137.618,58.691,137.641,58.658,137.666z"/>
			<path fill="#F1D99E" d="M61.119,136.736c0.097-0.091,0.172-0.251,0.171-0.528c0,0,0.125,0.11,0.113,0.234
				c-0.087,0.088-0.172,0.188-0.249,0.304c-0.113,0.169-0.349,0.233-0.531,0.078c-0.196-0.167-0.044-0.557-0.044-0.557
				c-0.006,0.065-0.002,0.239,0.065,0.381C60.715,136.8,60.943,136.903,61.119,136.736z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M54.351,136.195c-0.039,0.201-0.214,0.353-0.396,0.297
				c-0.113-0.035-0.312-0.129-0.46-0.327c0,0,0.085,0.427,0.477,0.469C54.298,136.669,54.346,136.326,54.351,136.195z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#F1D99E" d="M53.802,134.855c-0.18,0.153-0.135,0.479,0.032,0.54
				c-0.246,0.058-0.256,0.356-0.173,0.518c0.123,0.237,0.306,0.335,0.689,0.282c0,0,0.062-0.604-0.366-0.685
				c0,0,0.137-0.075,0.304-0.006c-0.087-0.513-0.229-0.892-0.302-1.069c-0.04-0.063-0.049-0.109-0.049-0.109
				S54.008,134.681,53.802,134.855z"/>
			<path fill="#F1D99E" d="M60.496,138.388c-0.054-0.081-0.109-0.167-0.165-0.253c-0.083-0.13-0.174-0.283-0.257-0.354l0.263,0.083
				l0.216,0.328L60.496,138.388z"/>
			<path fill="#F1D99E" d="M59.308,136.063c0.252-0.427,0.056-0.776,0.056-0.776c0.118,0.028,0.249,0.134,0.299,0.196
				c0.159-0.433,0.457-1.062,0.457-1.062c-0.188,0.153-0.396,0.212-0.53,0.228c-0.314,0.036-0.342,0.3-0.234,0.414
				c-0.338-0.058-0.553,0.353-0.411,0.659c0.007,0.021,0.016,0.041,0.025,0.06C59.037,135.915,59.157,136.003,59.308,136.063z"/>
			<path fill="#F1D99E" d="M52.064,135.997c0,0,0.263,0.18,0.606,0.43c-0.035,0.004-0.062,0.011-0.108,0.036
				c-0.291-0.292-0.582-0.526-0.582-0.526L52.064,135.997z"/>
		</g>
		<g>
			<path fill="#6F1C2F" d="M45.963,143.42c-0.01-0.255-0.216-0.831-1.138-0.681c-1.048,0.17-1.651-0.213-1.666-1.171
				c0,0,0.077,1.089,1.186,1.032c0.694-0.035,1.207-0.227,1.533,0.304C45.942,143.008,45.963,143.42,45.963,143.42z"/>
			<path fill="#6F1C2F" d="M45.474,141.968c0.01,0.091-0.011,0.271-0.053,0.436c0,0-0.182-0.019-0.356-0.003
				c0,0,0.183-0.047,0.271-0.167C45.423,142.114,45.474,141.968,45.474,141.968z"/>
			<path fill="#6F1C2F" d="M44.928,142.305c0,0-0.016-0.071-0.079-0.143c-0.064-0.071-0.192-0.144-0.192-0.144
				s-0.144-0.08-0.343-0.08c-0.2,0-0.352-0.014-0.352-0.014s-0.148-0.122-0.154-0.384c0,0,0.051,0.237,0.337,0.245
				c0.288,0.009,0.514,0.004,0.663,0.16C44.984,142.13,44.928,142.305,44.928,142.305z"/>
			<path fill="#6F1C2F" d="M44.18,146.037c-0.127-0.206-0.223-0.733,0.054-1.074c0.344-0.425,0.894-0.352,1.17-0.181
				c0.277,0.17,0.17,0.553,0.17,0.553c0.479-0.521,0.063-0.872,0.063-0.872c0.926-0.319,0.82-1.267,0.49-1.67
				c0,0,0.298,0.616,0.032,1.063c-0.266,0.447-0.628,0.49-0.777,0.512c0,0,0.181,0.073,0.117,0.318c0,0-0.063-0.224-0.489-0.234
				s-0.894,0.096-1.054,0.628S44.18,146.037,44.18,146.037z"/>
			<path fill="#6F1C2F" d="M44.138,144.452c-0.047-0.378-0.382-0.34-0.51-0.335c0,0,0.223,0.016,0.297,0.165
				c0.075,0.148,0.032,0.361,0.032,0.361C44.053,144.505,44.138,144.452,44.138,144.452z"/>
			<path fill="#6F1C2F" d="M45.934,146.862c0,0-0.844,0.271-1.444,0.043c-0.601-0.229-0.764-0.521-0.857-0.878
				c0,0,0.242,0.579,0.904,0.739c0.663,0.16,1.206,0.04,1.771-0.207c0,0-0.067,0.087-0.163,0.167
				C46.049,146.807,45.934,146.862,45.934,146.862z"/>
			<path fill="#6F1C2F" d="M45.511,148.154c0,0-0.288,0.064-0.495-0.222c0,0,0.415,0.358,0.758-0.104
				C45.774,147.828,45.726,148.123,45.511,148.154z"/>
			<path fill="#6F1C2F" d="M44.585,148.57c-0.387-0.067-0.24-0.392-0.24-0.392s-0.167,0.08-0.136,0.264
				C44.242,148.626,44.585,148.57,44.585,148.57z"/>
			<path fill="#6F1C2F" d="M43.636,150.002c-0.015,0.022-0.032,0.046-0.052,0.065c-0.017,0.018-0.037,0.032-0.06,0.044
				c0,0-0.191,0.128-0.375-0.072c0,0,0.303,0.176,0.543-0.171C43.691,149.868,43.676,149.936,43.636,150.002z"/>
			<path fill="#6F1C2F" d="M43.639,150.532c-0.016,0.021-0.034,0.041-0.056,0.06c-0.018,0.015-0.037,0.026-0.059,0.038
				c0,0-0.279,0.135-0.447-0.041c0,0,0.355,0.132,0.643-0.271C43.719,150.317,43.709,150.435,43.639,150.532z"/>
			<path fill="#6F1C2F" d="M43.611,151.1c0,0-0.208,0.2-0.495-0.023c0,0,0.383,0.151,0.635-0.327
				C43.751,150.749,43.751,151.02,43.611,151.1z"/>
			<path fill="#6F1C2F" d="M45.471,151.356c0.072,0.063,0.017,0.184,0.017,0.184s0.442-0.021,0.271,0.423
				c-0.135,0.351-0.473,0.271-0.742,0.223c-0.359-0.063-0.896,0.147-1.181-0.352c0,0,0.34,0.312,0.755,0.216
				c0,0,0.155-0.224-0.074-0.44c0,0,0.373,0.026,0.373,0.365c0,0,0.378,0.209,0.612,0.086c0.234-0.123,0.218-0.437-0.16-0.5
				c0,0,0.08-0.048,0.106-0.106C45.474,151.396,45.471,151.356,45.471,151.356z"/>
			<path fill="#6F1C2F" d="M52.733,150.861c0.072,0.103,0,0.175,0,0.175s0.45,0.01,0.319,0.456
				c-0.096,0.326-0.459,0.216-0.607,0.199c-0.334-0.04-0.654,0.111-0.989-0.08s-0.503-0.255-0.503-0.255s0,0.208-0.224,0.271
				c0,0,0.024-0.36-0.231-0.473c0,0,0.048,0.289-0.216,0.36c0,0,0.111-0.288-0.28-0.519c0,0,0.08,0.335-0.263,0.375
				c0,0,0.112-0.12,0.016-0.28c-0.096-0.159-0.231-0.167-0.487-0.255c-0.255-0.088-0.343-0.335-0.271-0.567
				c0,0-0.188,0.129-0.431,0.04c0,0,0.359,0.032,0.503-0.398c0,0-0.125,0.553,0.303,0.654c0.335,0.079,0.447,0.176,0.511,0.352
				c0,0,0.127-0.112,0.031-0.352c0,0,0.415,0.176,0.383,0.446c0,0,0.175-0.127,0.127-0.303c0,0,0.383,0.271,0.335,0.543
				c0,0,0.159-0.112,0.144-0.319c0,0,0.317,0.024,0.534,0.354c0.152,0.232,0.431,0.333,0.567,0.157
				c0.12-0.155-0.064-0.32-0.064-0.32s0.355-0.009,0.387,0.34c0,0,0.407,0.119,0.503-0.088c0.095-0.208-0.112-0.336-0.388-0.364
				c0,0,0.14-0.012,0.199-0.059C52.706,150.904,52.733,150.861,52.733,150.861z"/>
			<path fill="#6F1C2F" d="M50.842,150.167c-0.199-0.185-0.319-0.287-0.495-0.448c-0.175-0.159-0.208-0.397-0.208-0.397
				c0.431,0.223,0.663-0.192,0.663-0.192c-0.383,0.072-0.502-0.239-0.502-0.239c0.383,0.191,0.607-0.096,0.607-0.096
				s-0.328-0.048-0.344-0.304c-0.02-0.319-0.247-0.399-0.247-0.399c0.398-0.135,0.208-0.519,0.208-0.519s0.049,0.305-0.256,0.402
				c-0.266,0.085-0.479-0.117-0.479-0.117s0.085,0.276,0.447,0.255c0,0,0.204,0.08,0.191,0.325
				c-0.016,0.314,0.128,0.388,0.128,0.388s-0.357,0.006-0.49-0.398c0,0,0.011,0.282,0.133,0.373c0,0-0.08,0.303,0.218,0.431
				c0,0-0.383,0.117-0.521-0.352c0,0-0.362,0.41,0.027,0.691c0.25,0.182,0.415,0.271,0.553,0.362
				C50.613,150.023,50.842,150.167,50.842,150.167z"/>
			<path fill="#6F1C2F" d="M47.674,139.704c0,0-0.445,0.102-0.639-0.232c0,0,0.12,0.192,0.495,0.08s0.583-0.016,0.663,0.12
				C48.192,139.672,47.977,139.608,47.674,139.704z"/>
			<path fill="#6F1C2F" d="M48.783,141.196c-0.004-0.019-0.008-0.037-0.011-0.056c-0.005-0.027-0.009-0.055-0.012-0.08
				c-0.053-0.456,0.203-0.584,0.678-0.511c0.519,0.08,0.59-0.248,0.598-0.447s-0.055-0.295-0.016-0.398c0,0-0.104,0.066-0.253,0.023
				c0,0,0.234,0.234,0.032,0.606c0,0-0.255-0.106-0.447,0.064c0,0-0.546-0.114-0.67,0.17c-0.106,0.244-0.154,0.749,0.118,0.989
				c0.305,0.271,0.718,0.053,0.718,0.053C49.368,141.66,48.894,141.715,48.783,141.196z"/>
			<path fill="#6F1C2F" d="M46.884,141.316c0,0-0.312,0.048-0.503-0.192c0,0,0.408,0.222,0.823-0.12
				C47.203,141.004,47.127,141.308,46.884,141.316z"/>
			<path fill="#6F1C2F" d="M46.892,142.082c0,0-0.248,0.08-0.495-0.144c0,0,0.455,0.237,0.849-0.274
				C47.245,141.664,47.24,141.989,46.892,142.082z"/>
			<path fill="#6F1C2F" d="M47.259,142.736c0,0-0.2,0.287-0.782,0.048c0,0,0.598,0.115,0.886-0.407
				C47.363,142.377,47.357,142.627,47.259,142.736z"/>
			<path fill="#6F1C2F" d="M47.378,143.503c0,0-0.255,0.12-0.624-0.16c0,0,0.597,0.28,0.927-0.264
				C47.682,143.079,47.618,143.415,47.378,143.503z"/>
			<path fill="#6F1C2F" d="M47.921,144.373c0,0-0.199,0.167-0.479,0.008c0,0,0.502,0,0.694-0.495
				C48.137,143.886,48.117,144.249,47.921,144.373z"/>
			<path fill="#6F1C2F" d="M51.751,140.694c0.087,0.008,0.143,0.11,0.143,0.11s-0.058,0.131-0.021,0.392c0,0-0.127-0.106-0.08-0.267
				C51.842,140.771,51.751,140.694,51.751,140.694z"/>
			<path fill="#6F1C2F" d="M52.739,146.522c0.029,0.109-0.014,0.242-0.245,0.34c0,0-0.142-0.037-0.269-0.059
				c0,0,0.162-0.069,0.304-0.102c0.165-0.037,0.186-0.175,0.186-0.175L52.739,146.522z"/>
			<path fill="#6F1C2F" d="M47.609,141.619c0,0,0.096-0.191,0.032-0.319c-0.063-0.128-0.224-0.191-0.12-0.455
				c0,0-0.197,0.217-0.056,0.424C47.569,141.42,47.609,141.491,47.609,141.619z"/>
			<path fill="#6F1C2F" d="M48.24,142.625c0,0,0.023-0.208-0.088-0.296c-0.112-0.088-0.288-0.104-0.312-0.423
				c0,0-0.096,0.216,0.064,0.367S48.145,142.433,48.24,142.625z"/>
			<path fill="#6F1C2F" d="M48.591,143.693c0,0,0.048-0.271-0.183-0.382c-0.232-0.112-0.416-0.192-0.408-0.591
				c0,0-0.104,0.247,0,0.455c0.104,0.207,0.255,0.167,0.399,0.271C48.543,143.551,48.591,143.693,48.591,143.693z"/>
			<path fill="#6F1C2F" d="M50.036,144.197c0,0-0.279,0.128-0.454-0.224c-0.2-0.399-0.527-0.32-0.527-0.32s0.207,0.032,0.319,0.208
				c0.111,0.176,0.102,0.254,0.247,0.352C49.836,144.356,50.036,144.197,50.036,144.197z"/>
			<path fill="#6F1C2F" d="M48.942,144.588c0,0,0.023-0.19-0.167-0.295c-0.192-0.104-0.423-0.088-0.351-0.432
				c0,0-0.162,0.311,0.064,0.456c0.111,0.07,0.226,0.047,0.327,0.119C48.871,144.476,48.942,144.588,48.942,144.588z"/>
			<path fill="#6F1C2F" d="M48.591,142.657c0,0,0.048,0.127,0.2,0.262c0.151,0.137,0.431,0.16,0.431,0.16s-0.343,0.136-0.527-0.063
				C48.512,142.816,48.591,142.657,48.591,142.657z"/>
			<path fill="#6F1C2F" d="M64.598,139.911c0,0,0.144-0.149,0.298-0.165c0,0-0.202-0.054-0.277,0.016
				C64.545,139.831,64.598,139.911,64.598,139.911z"/>
			<path fill="#6F1C2F" d="M64.001,148.141c0,0-0.383-0.079-0.208-0.534c0,0,0,0.559,0.579,0.34
				C64.373,147.946,64.289,148.185,64.001,148.141z"/>
			<path fill="#6F1C2F" d="M64.018,148.947c0,0-0.352,0.176-0.583-0.136c0,0,0.322,0.162,0.534,0.023
				c0.24-0.154,0.256-0.358,0.256-0.358S64.253,148.812,64.018,148.947z"/>
			<path fill="#6F1C2F" d="M61.6,146.506c-0.089,0.345,0.24,0.374,0.24,0.374s0.136-0.048,0.247-0.048c0,0-0.167-0.008-0.319-0.08
				C61.615,146.681,61.6,146.506,61.6,146.506z"/>
			<path fill="#6F1C2F" d="M61.56,147.296c0.014,0.052,0.033,0.094,0.056,0.127c0.126,0.187,0.36,0.096,0.36,0.096
				s0.215-0.144,0.215-0.431c0,0-0.136,0.351-0.383,0.311C61.56,147.358,61.56,147.296,61.56,147.296z"/>
			<path fill="#6F1C2F" d="M63.451,144.399c0,0-0.288-0.176-0.415-0.616c-0.128-0.438-0.287-0.574-0.455-0.622
				c0,0,0.168-0.088,0.312-0.072c0,0-0.07-0.419-0.646-0.826v-0.193c0,0,0.158-0.046,0.217-0.115c0,0,0.08,0.154-0.069,0.303
				c0,0,0.616,0.096,0.813,1.059c0,0-0.101-0.08-0.266-0.101c0,0,0.139,0.059,0.239,0.399c0.102,0.34,0.24,0.563,0.527,0.596
				C63.709,144.21,63.613,144.338,63.451,144.399z"/>
			<path fill="#6F1C2F" d="M67.386,139.262c0,0-0.01,0.122-0.081,0.241c-0.094,0.157-0.296,0.306-0.729,0.142
				c0,0,0.505,0.17,0.533,0.681c0.032,0.585,0.148,0.734,0.319,0.841c0,0-0.106,0.171-0.298,0.064c0,0,0.021,0.542,0.394,0.681
				c0,0-0.149,0.245-0.426,0.064c0,0-0.063,0.595,0.298,0.744c0,0-0.234,0.192-0.447-0.011c0,0,0.188,0.379-0.352,0.841
				c-0.373,0.318-0.351,0.628-0.351,0.628s-0.234-0.054-0.33-0.373c0,0-0.373,0.416-0.075,0.862c0,0-0.298,0.011-0.394-0.34
				c0,0,0.032,0.244-0.17,0.361c-0.203,0.117-0.128,0.404-0.128,0.404s-0.308-0.085-0.266-0.426c0,0-0.325-0.086-0.421,0.378
				c0,0-0.047-0.133-0.016-0.229c0.032-0.097,0.085-0.128,0.085-0.128c-0.511-0.16-0.948,0.46-0.948,0.46s-0.128,0.119-0.335,0.016
				c0,0,0.263-0.04,0.311-0.343c0,0-0.367-0.023-0.478-0.352c0,0,0.343,0.293,0.726-0.037c0,0,0.011,0.096-0.042,0.202
				c0,0,0.266-0.275,0.564-0.181c0.298,0.096,0.564,0.031,0.681-0.105c0,0-0.085,0.244,0.085,0.351c0,0,0.007-0.152,0.085-0.224
				c0.128-0.116,0.234-0.287,0.16-0.479c0,0,0.139,0.043,0.181,0.16c0,0,0-0.628,0.458-0.734c0,0-0.075,0.233,0.095,0.341
				c0,0-0.074-0.234,0.235-0.426c0.308-0.191,0.596-0.468,0.34-1.001c0,0,0.17,0.214,0.404,0.139c0,0-0.309-0.202-0.255-0.83
				c0,0,0.117,0.214,0.361,0.096c0,0-0.298-0.117-0.309-0.819c0,0,0.118,0.139,0.277,0.075c0,0-0.234-0.245-0.255-0.734
				c-0.022-0.489-0.49-0.628-0.671-0.66c0,0,0.149-0.231,0.553-0.106C67.205,139.634,67.386,139.262,67.386,139.262z"/>
			<path fill="#6F1C2F" d="M62.741,140.751c-0.176-0.135-0.327,0.063-0.327,0.063s0.056,0.148,0.023,0.403
				c0,0,0.155-0.067,0.104-0.299C62.491,140.698,62.741,140.751,62.741,140.751z"/>
			<path fill="#6F1C2F" d="M70.402,141.933c0.101-0.107,0.132-0.239,0.133-0.36c0.001-0.184-0.069-0.342-0.069-0.342
				s0.133,0.856-1.006,0.91c0,0-0.016-0.251,0.335-0.256c0,0-0.233-0.166-0.42,0.011c-0.186,0.175-0.122,0.499,0.021,0.739
				c0,0-0.491-0.15-0.915,0.245c-0.229,0.212-0.257,0.447-0.176,0.739c0.079,0.287,0.404,0.404,0.404,0.404
				c-0.672-0.479-0.151-1.373,0.59-1.285c0.405,0.048,1.125,0.279,1.596-0.264c0.258-0.297,0.318-0.655,0.311-0.95
				c-0.01-0.325-0.103-0.574-0.103-0.574s0.148,0.668-0.292,1.132c-0.528,0.553-1.309,0.228-1.309,0.228
				c0.241-0.007,0.434-0.069,0.579-0.142c0.068-0.034,0.125-0.07,0.172-0.104C70.353,141.992,70.402,141.933,70.402,141.933z"/>
			<path fill="#6F1C2F" d="M69.988,148.197c0,0,0.177,0.045,0.262,0.161c0.057,0.077,0.073,0.186-0.031,0.334
				c0,0-0.04,0.077-0.21,0.072c0,0,0.191-0.059,0.207-0.256C70.231,148.312,69.988,148.197,69.988,148.197z"/>
			<path fill="#6F1C2F" d="M68.734,148.149c0.173,0.037,0.305-0.049,0.385-0.126c0.056-0.055,0.087-0.105,0.087-0.105
				s-0.058,0.02-0.13,0.011c-0.108-0.013-0.252-0.088-0.286-0.387c-0.056-0.494-0.343-0.638-0.343-0.638s1.141,0.392,1.804-0.168
				c0.747-0.63,0.455-1.429,0.343-1.963c-0.046-0.221,0.004-0.36,0.08-0.447c0.109-0.127,0.263-0.144,0.263-0.144
				s-0.598-0.047-0.456,0.606c0.145,0.654,0.328,1.261-0.295,1.772c-0.622,0.511-1.923,0.239-2.258-0.04
				c0,0,0.502,0.295,0.631,0.671c0.127,0.374-0.152,0.686,0.287,0.789c0,0-0.231,0.119-0.439-0.079c0,0,0.439,0.375,0.359,0.981
				c0,0,0-0.319-0.304-0.559c0,0,0.24,0.327,0.16,0.679c0,0-0.024-0.216-0.199-0.328c0,0,0.191,0.208,0.071,0.774
				c0,0,0.231-0.102,0.383-0.263c0.127-0.137,0.144-0.296,0.144-0.296C68.966,148.428,68.734,148.149,68.734,148.149z"/>
			<path fill="#6F1C2F" d="M62.204,147.886c-0.076-0.012-0.128-0.048-0.162-0.095c0,0,0.132,0.104,0.315-0.041
				c0.218-0.171,0.167-0.534,0.167-0.534c0.104,0.151,0.063,0.287,0.063,0.287s0.216,0.063,0.295-0.12
				c0.097-0.223-0.104-0.351,0.08-0.646c0.183-0.295,0.798-0.486,0.798-0.486c-0.087,0.128-0.12,0.279-0.12,0.279
				s-0.315,0.122-0.471,0.319c-0.248,0.312-0.048,0.602-0.24,0.742c-0.069,0.05-0.145,0.056-0.207,0.046
				c-0.078-0.013-0.136-0.046-0.136-0.046s-0.025,0.263-0.279,0.296c-0.042,0.005-0.078,0.004-0.11-0.001H62.204z"/>
			<path fill="#6F1C2F" d="M68.487,151.836c0.047,0.195,0.143,0.293,0.263,0.337c0.169,0.064,0.384,0.024,0.567,0.016
				c0.312-0.017,0.655,0.175,0.981-0.192c0.328-0.367,0.407-0.878,0.407-0.878c0.164,0.147,0.345,0.077,0.436,0.023
				c0.038-0.021,0.059-0.04,0.059-0.04c-0.037-0.009-0.07-0.021-0.101-0.036c-0.266-0.123-0.297-0.418-0.297-0.418
				c0.146,0.103,0.297,0.055,0.378,0.014c0.038-0.02,0.06-0.038,0.06-0.038c-0.034-0.007-0.066-0.018-0.096-0.03
				c-0.287-0.123-0.358-0.456-0.358-0.456c0.152,0.104,0.279,0.028,0.345-0.03c0.029-0.026,0.046-0.05,0.046-0.05
				c-0.036-0.011-0.068-0.024-0.098-0.039c-0.438-0.222-0.185-0.793-0.396-1.103c-0.021-0.029-0.044-0.056-0.073-0.08
				c0,0,0.152,0.104,0.056,0.6c-0.092,0.475,0.159,0.59,0.159,0.59c-0.215-0.007-0.295-0.176-0.295-0.176
				c0.08,0.4,0.295,0.559,0.295,0.559c-0.224,0.064-0.352-0.088-0.352-0.088c0.08,0.439,0.32,0.567,0.32,0.567
				c-0.231,0.089-0.375-0.087-0.375-0.087s0,0.51-0.16,0.916c-0.16,0.408-0.566,0.296-0.566,0.296c-0.176-0.271,0-0.406,0-0.406
				c-0.28,0.032-0.344,0.398-0.344,0.398c-0.199,0.016-0.583,0.04-0.67-0.2c-0.087-0.238,0.296-0.238,0.296-0.238
				c-0.16-0.111-0.16-0.239-0.16-0.239c-0.12,0.111-0.009,0.208-0.009,0.208C68.615,151.518,68.447,151.669,68.487,151.836z"/>
			<path fill="#6F1C2F" d="M68.805,144.988c0.166-0.407,0.722-0.433,1.214-0.087c0,0-0.466-0.639-1.077-0.315
				c-0.379,0.2-0.184,0.746-0.184,0.746C68.749,145.197,68.767,145.082,68.805,144.988z"/>
			<path fill="#6F1C2F" d="M64.193,149.314c0,0-0.208,0.224-0.575-0.056c0,0,0.327,0.124,0.523-0.048
				c0.188-0.164,0.216-0.332,0.224-0.411C64.365,148.8,64.396,149.163,64.193,149.314z"/>
			<path fill="#6F1C2F" d="M67.489,150.209c-0.031,0.294,0.159,0.334,0.272,0.406c0.189,0.122,0.063,0.312,0.063,0.312
				c0.094-0.049,0.148-0.115,0.178-0.183c0.073-0.161,0.005-0.337,0.005-0.337c0.075,0.057,0.128,0.121,0.166,0.185
				c0.129,0.219,0.082,0.446,0.082,0.446c0.112-0.089,0.175-0.181,0.209-0.268c0.099-0.259-0.082-0.475-0.082-0.475
				c0.351,0.136,0.654-0.064,0.862-0.151c0.172-0.072,0.35-0.085,0.446,0.081c0.02,0.033,0.037,0.075,0.049,0.126
				c0,0-0.072-0.478-0.375-0.375c-0.153,0.053-0.375,0.192-0.646,0.216c-0.271,0.024-0.654-0.079-0.654-0.079
				c0.176,0.175,0.152,0.286,0.152,0.286s-0.056-0.12-0.216-0.128c-0.215-0.011-0.192-0.198-0.192-0.198
				c-0.167,0.144-0.071,0.351-0.071,0.351c-0.239-0.057-0.144-0.406-0.144-0.406c-0.215,0.334-0.63,0.127-0.63,0.127
				C67.282,150.415,67.489,150.209,67.489,150.209z"/>
			<path fill="#6F1C2F" d="M65.341,142.708c0,0,0.017,0.223-0.236,0.313c-0.246,0.09-0.255,0.351-0.255,0.351
				s0.067-0.135,0.316-0.264C65.424,142.975,65.341,142.708,65.341,142.708z"/>
			<path fill="#6F1C2F" d="M65.614,143.266c0.313-0.213,0.157-0.505,0.157-0.505s0.058,0.203-0.225,0.404
				c-0.282,0.2-0.159,0.478-0.159,0.478S65.349,143.445,65.614,143.266z"/>
			<path fill="#6F1C2F" d="M64.65,143.938c-0.278,0.07-0.378,0.315-0.378,0.315s0.103-0.138,0.446-0.203
				c0.342-0.065,0.279-0.492,0.279-0.492S64.929,143.866,64.65,143.938z"/>
			<path fill="#6F1C2F" d="M65.917,142.706c0,0,0.011-0.162,0.144-0.452c0.154-0.336-0.093-0.481-0.093-0.481
				s0.094,0.205-0.007,0.373C65.782,142.443,65.917,142.706,65.917,142.706z"/>
			<path fill="#6F1C2F" d="M66.144,143.229c0,0,0-0.264,0.199-0.445c0.269-0.247,0.017-0.646,0.017-0.646s0.087,0.303-0.129,0.511
				C65.961,142.907,66.144,143.229,66.144,143.229z"/>
			<path fill="#6F1C2F" d="M66.368,140.964c0,0,0.119,0.129,0.059,0.374c-0.086,0.339,0.171,0.469,0.171,0.469
				s-0.088-0.149-0.054-0.423S66.368,140.964,66.368,140.964z"/>
			<path fill="#6F1C2F" d="M66.441,140.216c0,0,0.149,0.062,0.124,0.269c-0.026,0.207,0.178,0.261,0.178,0.261
				s-0.106-0.062-0.087-0.28C66.675,140.247,66.441,140.216,66.441,140.216z"/>
			<path fill="#6F1C2F" d="M63.958,143.396c0.349,0.191,0.559-0.072,0.559-0.072c-0.695,0.076-0.7-0.496-0.7-0.496
				S63.652,143.229,63.958,143.396z"/>
			<path fill="#6F1C2F" d="M64.1,143.88c0,0-0.413,0.08-0.505-0.268c0,0-0.114,0.257,0.133,0.357
				C63.857,144.036,64.1,143.88,64.1,143.88z"/>
			<path fill="#6F1C2F" d="M64.289,142.882c0,0-0.08-0.151-0.008-0.327c0,0,0.013,0.386,0.396,0.471
				C64.678,143.025,64.422,143.1,64.289,142.882z"/>
			<path fill="#6F1C2F" d="M65.156,142.241c-0.02-0.09-0.1-0.159-0.245-0.165c-0.082-0.003-0.163,0.002-0.229,0.01
				c-0.086,0.01-0.146,0.022-0.146,0.022s0.05-0.119,0.313-0.112C65.134,142.005,65.156,142.241,65.156,142.241z"/>
			<path fill="#6F1C2F" d="M47.618,147.788c0.067-0.297-0.104-0.447-0.104-0.447c0.128-0.511,0.399-0.687,0.399-0.687
				c-0.383,0.008-0.591,0.168-0.774,0.487s0.04,0.934,0.04,0.934S47.538,148.139,47.618,147.788z M49.74,141.621
				c0.15,0.057,0.254,0.213,0.041,0.47c0,0-0.391-0.089-0.534,0.016c-0.144,0.104-0.08,0.391,0.2,0.502
				c0.279,0.112,0.582-0.071,0.582-0.071s0.088,0.168,0.024,0.312c0,0-0.024,0.056-0.056,0.104c0,0,0.224-0.088,0.383,0.144
				c0.16,0.231,0.359,0.247,0.511,0.136c0,0,0.064,0.367-0.287,0.479c0,0,0.104,0.144,0.359,0.08c0,0,0.087-0.535,0.486-0.599
				c0,0-0.167-0.145-0.414-0.008c0,0,0.087-0.703,0.87-0.935c0,0-0.08-0.167-0.04-0.318c0,0,0.062,0.092,0.174,0.123v0.239
				c-0.082,0.05-0.42,0.274-0.62,0.786c0,0,0.183-0.04,0.327,0.08c0,0-0.239,0.088-0.351,0.367
				c-0.111,0.279-0.224,0.671-0.519,0.839c0,0,0.08,0.143,0.328,0.04c0,0-0.08,0.366-0.367,0.382c0,0,0.008,0.2,0.215,0.248
				c0,0-0.08,0.112-0.295,0.112c0,0-0.296-0.344-0.743-0.264c0,0,0.192,0.207,0.016,0.43c0,0-0.005-0.258-0.239-0.191
				c-0.335,0.096-0.415-0.095-0.415-0.095s-0.084,0.578,0.575,0.877c0.526,0.239,0.542,0.527,0.542,0.527s0.144-0.096,0.112-0.288
				c0,0,0.488,0.214,0.734,0.511c0.267,0.324-0.003,0.584,0.191,0.719c0.092,0.063,0.192,0.004,0.192,0.004
				s-0.008-0.123,0.064-0.194c0,0-0.029,0.401,0.272,0.474c0.231,0.057,0.271-0.164,0.271-0.164s-0.155-0.087-0.187-0.426
				c0,0,0.151,0.271,0.383,0.243c0.231-0.027,0.219-0.216,0.219-0.216c0.08,0.216-0.096,0.526-0.398,0.415
				c0,0,0.062,0.375-0.265,0.383c-0.328,0.008-0.327-0.255-0.35-0.343c0,0-0.24,0.184-0.383-0.032
				c-0.144-0.215,0.12-0.414-0.191-0.678c-0.312-0.264-0.487-0.319-0.487-0.319s0.08,0.183-0.071,0.303c0,0-0.096-0.358-0.423-0.502
				c-0.327-0.145-0.479-0.216-0.63-0.344c0,0-0.24,0.312-0.831,0.503c-0.589,0.19-0.782,0.415-0.782,0.415s0.2-0.017,0.319-0.017
				c0,0-0.439,0.272-0.566,0.623c0,0,0.255-0.207,0.526-0.239c0,0-0.191,0.175-0.319,0.446c0,0,0.256-0.239,0.559-0.303
				c0,0-0.224,0.191-0.352,0.399c0,0,0.319-0.256,0.542-0.288c0,0-0.255,0.191-0.367,0.432c0,0,0.334-0.24,0.574-0.304
				c0,0-0.24,0.208-0.319,0.446c0,0,0.208-0.207,0.495-0.238c0,0-0.128,0.191-0.255,0.446c-0.128,0.256-0.176,0.439-0.176,0.439
				c-0.032-0.2-0.151-0.544-1.388-0.56c0,0,0.104,0.363,0.047,0.87c-0.064,0.575-0.335,0.654-0.263,0.839
				c0.056,0.143,0.183,0.216,0.367,0.255c0,0-0.263,0.247-0.527,0.048c0,0,0.064,0.175-0.143,0.303s-0.2,0.408-0.2,0.408
				s-0.271-0.12-0.167-0.528c0,0-0.272,0.224-0.256,0.639c0,0-0.231-0.19-0.224-0.406c0.008-0.216,0.112-0.328,0.112-0.328
				s-0.455,0.112-0.766-0.087s-0.606-0.27-0.687,0.479c0,0-0.027-0.296,0.012-0.438c0,0-0.071,0.146-0.131,0.361
				c0,0-0.004-0.295,0.056-0.489c0,0-0.124,0.159-0.176,0.394c0,0-0.004-0.442,0.128-0.646c0.131-0.203,0.179-0.299,0.486-0.039
				c0.308,0.26,0.659,0.451,1.27,0.147c0,0,0.08,0.156-0.032,0.318c0,0,0.247-0.074,0.239-0.37c0,0,0.191,0.104,0.1,0.379
				c0,0,0.275-0.107,0.176-0.438c0,0,0.068,0.096,0.235,0.063c0,0-0.231-0.224-0.08-0.494c0.152-0.272,0.289-0.495,0.121-1.382
				c-0.149-0.788,0.285-1.158,0.563-1.374c0.28-0.215,0.447-0.446,0.472-0.836c0,0,0.129,0.32,0.082,0.496
				c0,0,0.127-0.393,0.19-0.672c0,0,0.095,0.395,0.022,0.587c0,0,0.257-0.442,0.321-0.811c0,0,0.084,0.427-0.054,0.714
				c0,0,0.397-0.177,0.557-0.58c0,0-0.138,0.096-0.287,0.031c0,0,0.117-0.042,0.138-0.139c0.021-0.096-0.015-0.149-0.085-0.181
				c-0.117-0.054-0.095-0.223-0.095-0.223s-0.118,0.137-0.319-0.011c0,0,0.223,0.053,0.33-0.267c0,0,0.011,0.202,0.159,0.298
				c0.15,0.096,0.139,0.234,0.139,0.234s0.256-0.255,0.149-0.639c0,0,0.107,0.245,0.341,0.224c0.234-0.021,0.319,0.139,0.319,0.139
				s0.139-0.319-0.18-0.479c0,0,0.234-0.096,0.478,0.085c0.245,0.182,0.511,0.075,0.628-0.17c0,0-0.361,0.128-0.542-0.341
				c0,0,0.382,0.149,0.479-0.266c0,0-0.383,0.159-0.542-0.287c0,0,0.33,0.191,0.468-0.16c0,0-0.193,0.098-0.33-0.148
				c-0.16-0.288-0.436-0.203-0.436-0.203s0.159-0.169,0.021-0.383c0,0-0.298,0.203-0.639,0.012
				c-0.341-0.192-0.256-0.585-0.256-0.585s-0.127,0.021-0.213,0.085c0,0,0.139-0.28,0.5-0.299c0.213-0.011,0.384,0.054,0.384,0.054
				C49.86,141.823,49.74,141.621,49.74,141.621z"/>
			<path fill="#6F1C2F" d="M61.28,151.502c0.081,0.168,0.182,0.224,0.304,0.237c0.145,0.015,0.32-0.027,0.526-0.014
				c0.486,0.029,0.646,0,0.886-0.176c0.196-0.145,0.351-0.176,0.351-0.176c0.007,0.067,0.031,0.117,0.062,0.154
				c0.068,0.085,0.17,0.101,0.17,0.101c-0.002-0.074,0.009-0.139,0.028-0.193c0.062-0.187,0.211-0.254,0.211-0.254
				c-0.016,0.137,0.037,0.222,0.092,0.273c0.056,0.053,0.116,0.071,0.116,0.071c-0.016-0.064-0.015-0.123-0.002-0.175
				c0.049-0.205,0.266-0.321,0.266-0.321c0,0.134,0.047,0.219,0.103,0.272c0.046,0.044,0.098,0.065,0.134,0.076
				c0.026,0.009,0.043,0.011,0.043,0.011c-0.136-0.511,0.438-0.392,0.654-0.639c0.186-0.215,0.095-0.455,0.095-0.455
				c0.226,0.146,0.423,0.058,0.52-0.007c0.041-0.026,0.063-0.048,0.063-0.048c-0.025,0-0.049-0.002-0.071-0.008
				c-0.247-0.043-0.235-0.325-0.168-0.56c0.08-0.287,0.167-0.398,0.087-0.727c-0.08-0.329-0.016-0.431,0.239-0.551
				c0.255-0.119,0.551-0.151,0.551-0.151c-0.176-0.303,0.048-0.535,0.048-0.535s-0.018,0.215,0.096,0.359
				c0.176,0.224,0.438,0.159,0.438,0.159c0.037-0.167,0.042-0.542,0.042-0.542c-0.06,0.304-0.17,0.438-0.17,0.438
				s-0.197-0.012-0.281-0.23c-0.1-0.264,0.092-0.42,0.092-0.42c-0.16-0.266-0.556-0.53-0.556-0.53
				c0.532-0.171,0.905,0.277,0.905,0.277c0.01-0.331-0.277-0.533-0.628-0.777c-0.351-0.245-0.373-0.564-0.373-0.564
				c-0.021,0.17,0.011,0.394,0.011,0.394c-0.181-0.245-0.309-0.606-0.309-0.606c-0.042,0.224,0.053,0.532,0.053,0.532
				c-0.266-0.267-0.383-0.724-0.383-0.724c-0.042,0.288,0.064,0.585,0.064,0.585c-0.33-0.287-0.281-0.731-0.281-0.731
				c-0.026-0.005-0.051-0.01-0.076-0.017c-0.029-0.008-0.056-0.018-0.082-0.028c0,0-0.042,0.348-0.828,0.733
				c-0.67,0.331-0.598,0.807-0.598,0.807c0.038-0.091,0.08-0.169,0.136-0.239c0.129-0.165,0.33-0.29,0.71-0.447
				c0.542-0.224,0.63-0.694,0.63-0.694c-0.056,0.807,0.351,1.038,0.582,1.118c0.311,0.106,0.383,0.247,0.383,0.247
				c-0.16-0.032-0.335,0-0.335,0l0.144,0.111c0.255,0.176,0.582,0.551,0.582,0.551c-0.231-0.159-0.415-0.171-0.415-0.171
				c0.248,0.158,0.343,0.446,0.343,0.446c-0.299-0.275-0.555-0.308-0.555-0.308c0.248,0.172,0.383,0.456,0.383,0.456
				c-0.299-0.312-0.583-0.353-0.583-0.353c0.312,0.224,0.391,0.492,0.391,0.492c-0.235-0.275-0.602-0.38-0.602-0.38
				c0.283,0.185,0.375,0.475,0.375,0.475c-0.223-0.242-0.561-0.344-0.561-0.344c0.297,0.191,0.361,0.446,0.361,0.446
				c-0.234-0.074-0.33,0.149-0.16,0.49c0.17,0.34,0.075,0.606-0.107,0.84c-0.181,0.234-0.032,0.479-0.032,0.479
				c-0.18,0.021-0.309-0.192-0.309-0.192c0.266,0.617-0.053,0.713-0.34,0.725c-0.287,0.01-0.33,0.287-0.33,0.287
				c-0.149-0.117-0.054-0.287-0.054-0.287c-0.383,0.106-0.405,0.414-0.405,0.414c-0.138-0.127-0.084-0.244-0.084-0.244
				c-0.372,0.17-0.362,0.531-0.362,0.531c-0.191-0.117-0.095-0.276-0.095-0.276c-0.192,0.032-0.405,0.159-0.575,0.395
				c-0.169,0.234-0.467,0.138-0.467,0.138c-0.171-0.224-0.021-0.394-0.021-0.394c-0.373,0-0.383,0.394-0.383,0.394
				s-0.458,0.043-0.49-0.224c-0.032-0.267,0.373-0.267,0.373-0.267c-0.213-0.105-0.085-0.281-0.085-0.281
				c-0.245,0.075-0.152,0.287-0.152,0.287S61.105,151.133,61.28,151.502z"/>
		</g>
		<g>
			<path fill="#B58D24" d="M60.053,136.642c0.354-0.033,0.468-0.393,0.468-0.393c-0.087,0.079-0.25,0.213-0.394,0.253
				c-0.182,0.05-0.384-0.047-0.421-0.353C59.706,136.149,59.624,136.683,60.053,136.642z"/>
			<path fill="#B58D24" d="M57.916,136.283c0.433-0.106,0.464-0.588,0.464-0.588c-0.044,0.077-0.123,0.188-0.255,0.307
				c-0.22,0.196-0.452,0.196-0.608,0.085c-0.049-0.035-0.111-0.095-0.164-0.179C57.353,135.908,57.404,136.41,57.916,136.283z"/>
			<path fill="#B58D24" d="M55.298,136.418c0.414-0.188,0.334-0.724,0.334-0.724c-0.063,0.219-0.29,0.838-0.781,0.548
				c-0.065-0.038-0.115-0.088-0.154-0.14C54.698,136.103,54.86,136.616,55.298,136.418z"/>
			<path fill="#B58D24" d="M53.475,136.812c0.187-0.153-0.022-0.63-0.022-0.63c0.006,0.108,0.036,0.259-0.025,0.462
				c-0.056,0.187-0.29,0.167-0.393,0.074C53.035,136.719,53.25,136.998,53.475,136.812z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#B58D24" d="M53.035,136.719c0,0,0.288-0.207,0.102-0.576
				c-0.05-0.1-0.152-0.151-0.252-0.152c-0.056-0.003-0.114,0.014-0.164,0.048c-0.027-0.151-0.208-0.204-0.374-0.133
				c-0.184,0.078-0.286,0.061-0.366,0.031c0,0,0.148,0.134,0.422,0.044c0.275-0.089,0.235,0.157,0.235,0.157s0.366-0.18,0.444,0.135
				C53.161,136.586,53.035,136.719,53.035,136.719z"/>
			<path fill="#B58D24" d="M60.232,135.379c0.204-0.07,0.265-0.355,0.035-0.539c-0.155-0.124-0.147-0.418-0.147-0.418
				s-0.157,0.172,0.085,0.49c0.22,0.291-0.152,0.396-0.152,0.396s0.399,0.22,0.139,0.601c-0.159,0.23-0.486,0.24-0.486,0.24
				s0.13-0.004,0.182-0.013C60.465,136.065,60.546,135.511,60.232,135.379z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#B58D24" d="M55.174,135.521c0.002-0.275-0.164-0.469-0.422-0.438
				c0.108-0.166,0.003-0.381-0.336-0.463c-0.239-0.057-0.364-0.183-0.479-0.294c0,0,0.009,0.046,0.049,0.109
				c0.059,0.095,0.185,0.229,0.449,0.312c0.393,0.124,0.125,0.404,0.125,0.404s0.499-0.065,0.471,0.393
				c-0.024,0.395-0.332,0.559-0.332,0.559C55.195,135.921,55.174,135.521,55.174,135.521z"/>
			<path fill="#B58D24" d="M57.469,134.278c0.344,0.105,0.192,0.493-0.013,0.56c0,0,0.509,0.007,0.41,0.487
				c-0.092,0.452-0.514,0.583-0.514,0.583s0.51-0.059,0.67-0.454c0.133-0.239,0.023-0.613-0.363-0.649
				c0.315-0.168,0.219-0.525-0.143-0.649c-0.393-0.135-0.393-0.473-0.393-0.473S57.1,134.164,57.469,134.278z"/>
			<path fill="#B58D24" d="M54.016,137.951c-0.072-0.021-0.201-0.065-0.334-0.114c-0.121-0.045-0.246-0.092-0.333-0.126l0.038,0.149
				l0.438,0.137L54.016,137.951z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#B58D24" d="M59.65,137.766c0.002-0.207-0.169-0.387-0.438-0.435
				c-0.29-0.037-0.52,0.101-0.554,0.324c0,0.004,0,0.007,0,0.011c0.033-0.025,0.073-0.048,0.118-0.065
				c0.049-0.148,0.216-0.236,0.423-0.21c0.179,0.032,0.302,0.14,0.334,0.271C59.582,137.692,59.622,137.728,59.65,137.766z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#B58D24" d="M57.7,137.526l0.268,0.03c-0.281-0.179-0.544-0.339-0.841-0.512
				c-0.292,0.177-0.554,0.339-0.833,0.522l0.218-0.027c0.2-0.122,0.406-0.231,0.615-0.349
				C57.333,137.303,57.506,137.411,57.7,137.526z"/>
			<g>
				<path fill-rule="evenodd" clip-rule="evenodd" fill="#B58D24" d="M55.127,137.321c-0.264,0.048-0.439,0.216-0.454,0.413
					c0.035-0.01,0.076-0.02,0.098-0.026c0.015-0.148,0.152-0.275,0.356-0.312c0.225-0.029,0.404,0.066,0.449,0.226
					c0.047,0.006,0.092,0.018,0.134,0.026C55.669,137.421,55.429,137.282,55.127,137.321z"/>
			</g>
			<path fill="#B58D24" d="M60.337,137.863l0.216,0.328l-0.058,0.196c-0.03,0.107-0.053,0.195-0.069,0.26
				c-0.393-0.152-1.404-0.448-3.344-0.448c-2.531,0-3.531,0.683-3.581,0.718l-0.002,0.001l0.102-0.062
				c0.284-0.146,1.227-0.516,3.494-0.534c2.215-0.019,3.221,0.452,3.504,0.604l0.12-0.678l0.219-0.211l-0.089-0.296
				c0.08-0.259,0.177-0.529,0.315-0.78c0.036-0.065,0.057-0.115,0.106-0.188c0.192-0.28,0.426-0.208,0.426-0.208
				s-0.034-0.025-0.079-0.047c-0.034-0.018-0.076-0.033-0.117-0.037c0.341-0.422,0.629-0.535,0.629-0.535s-0.377,0.143-0.728,0.496
				c-0.087,0.088-0.172,0.188-0.249,0.304c-0.038,0.057-0.074,0.118-0.108,0.182c-0.042,0.081-0.083,0.166-0.121,0.252
				c-0.392-0.141-1.998-0.669-3.79-0.634c-2.587,0.049-3.896,0.784-3.896,0.784c1.073-0.317,2.344-0.596,3.851-0.596
				c1.546,0,2.904,0.29,3.742,0.658l0.003-0.004c-0.031,0.078-0.062,0.156-0.092,0.232c-0.196,0.046-0.57,0.145-0.669,0.159
				L60.337,137.863z"/>
		</g>
		<g>
			<path fill="#6F1C2F" d="M61.501,136.481c0.041,0.004,0.083,0.02,0.117,0.037c0.282-0.399,0.513-0.572,0.513-0.572
				S61.842,136.06,61.501,136.481z"/>
			<path fill="#6F1C2F" d="M61.271,136.773c-0.05,0.072-0.071,0.122-0.106,0.188c-0.138,0.251-0.235,0.521-0.315,0.78l0.089,0.296
				l-0.219,0.211l-0.12,0.678c-0.284-0.151-1.29-0.622-3.504-0.604c-2.267,0.019-3.21,0.389-3.494,0.534l-0.102,0.062
				c0,0,0.181,0.125,0.675,0.255c0.156,0.042,0.344,0.086,0.567,0.127c0.271-0.018,0.561-0.033,0.867-0.047
				c-1.091-0.121-1.603-0.31-1.603-0.31s1.197-0.526,3.501-0.405l-0.745,0.106l0.766,0.085l-0.792,0.096l0.814,0.118l-0.804,0.063
				l0.798,0.139l-0.798,0.037l0.188,0.039c0.064,0,0.128,0,0.194,0c1.067,0,1.992,0.045,2.751,0.104
				c0.61-0.145,0.864-0.31,0.864-0.31c0.045-0.268,0.047-0.491,0.106-0.713l0.2-0.238l-0.067-0.291
				c0.096-0.304,0.224-0.61,0.343-0.854c0.104-0.212,0.269-0.319,0.372-0.355C61.697,136.565,61.463,136.493,61.271,136.773z"/>
		</g>
		<g>
			<path fill="#511D2F" d="M48.601,139.623c0,0-0.017,0.312-0.282,0.479c0,0,0.221,0.033,0.373-0.021
				c0.151-0.055,0.057-0.168,0.015-0.217s-0.002-0.142,0.142-0.06c0.066,0.038,0.131-0.055,0.131-0.055
				S48.814,139.623,48.601,139.623z"/>
			<path fill="#511D2F" d="M48.997,140.022c0,0-0.065,0.192-0.429,0.192c0,0,0.305,0.133,0.467,0.019
				C49.138,140.16,48.997,140.022,48.997,140.022z"/>
			<path fill="#511D2F" d="M70.764,141.735c-0.181,0.175-0.362,0.197-0.362,0.197c0.101-0.107,0.132-0.239,0.133-0.36
				c0,0,0.099-0.063,0.154-0.19c0,0,0.048,0.104,0.056,0.183C70.754,141.645,70.764,141.735,70.764,141.735z"/>
			<path fill="#511D2F" d="M64.747,140.553c0.1,0.002,0.232-0.015,0.349-0.017c0.251-0.004,0.368,0.093,0.424,0.211
				c0,0-0.283-0.113-0.56-0.06c-0.179,0.035-0.248-0.046-0.248-0.046L64.747,140.553z"/>
			<path fill="#511D2F" d="M65.156,142.241c-0.02-0.09-0.1-0.159-0.245-0.165c-0.082-0.003-0.163,0.002-0.229,0.01
				c0,0-0.011,0.102,0.095,0.176c0,0,0.107-0.031,0.213-0.031C65.098,142.23,65.156,142.241,65.156,142.241z"/>
			<path fill="#511D2F" d="M63.267,142.172c-0.146-0.105-0.26-0.258-0.339-0.389c-0.087-0.146-0.132-0.267-0.132-0.267
				c0.109-0.173,0.125-0.403,0.069-0.575c0,0,0.226,0.052,0.189,0.363c-0.021,0.181-0.128,0.329-0.128,0.329s0.085,0.171,0.16,0.288
				C63.161,142.039,63.267,142.172,63.267,142.172z"/>
			<path fill="#511D2F" d="M71.208,141.524c0.007,0.295-0.052,0.653-0.311,0.95c-0.471,0.543-1.191,0.312-1.596,0.264
				c-0.742-0.088-1.262,0.806-0.59,1.285c0,0-0.245-0.311-0.041-0.719c0.168-0.335,0.527-0.471,1.158-0.374
				c0.63,0.095,1.221,0,1.468-0.56c0.249-0.559,0.024-1.293,0.024-1.293C71.295,141.318,71.208,141.524,71.208,141.524z"/>
			<path fill="#511D2F" d="M70.019,144.901c-0.492-0.346-1.047-0.319-1.214,0.087c0,0-0.015,0.231,0.166,0.349
				c0,0-0.037-0.318,0.235-0.446C69.545,144.73,70.019,144.901,70.019,144.901z"/>
			<path fill="#511D2F" d="M70.674,144.326c-0.076,0.087-0.126,0.227-0.08,0.447c0.112,0.534,0.404,1.333-0.343,1.963
				c-0.663,0.56-1.804,0.168-1.804,0.168s0.287,0.144,0.343,0.638c0.034,0.299,0.178,0.374,0.286,0.387c0,0-0.094-0.154-0.109-0.347
				c-0.017-0.191-0.144-0.414-0.288-0.526c0,0,1.166,0.431,1.82-0.191c0.654-0.623,0.462-1.437,0.304-1.899
				c-0.083-0.238,0.063-0.526,0.335-0.605c0,0-0.112-0.049-0.224-0.064S70.674,144.326,70.674,144.326z"/>
			<path fill="#511D2F" d="M69.15,148.729c-0.1,0.078-0.129,0.163-0.129,0.163c-0.055-0.464-0.288-0.742-0.288-0.742
				c0.173,0.037,0.305-0.049,0.385-0.126c0,0,0.087,0.09,0.306,0.065c0,0-0.236,0.288-0.495,0.208c0,0,0.112,0.159,0.16,0.271
				S69.15,148.729,69.15,148.729z"/>
			<path fill="#511D2F" d="M70.499,148.763c-0.151-0.08-0.28-0.07-0.28-0.07c0.104-0.148,0.087-0.257,0.031-0.334
				c0,0,0.158,0.044,0.227,0.172C70.546,148.657,70.499,148.763,70.499,148.763z"/>
			<path fill="#511D2F" d="M68.75,152.173c0.169,0.064,0.384,0.024,0.567,0.016c0.312-0.017,0.655,0.175,0.981-0.192
				c0.328-0.367,0.407-0.878,0.407-0.878c0.164,0.147,0.345,0.077,0.436,0.023c0,0,0.115,0.12,0.283,0.112
				c0,0-0.216,0.208-0.496,0.031c0,0-0.154,0.544-0.371,0.776c-0.215,0.231-0.431,0.295-0.73,0.234
				c-0.187-0.037-0.432-0.079-0.678-0.056C68.898,152.264,68.75,152.173,68.75,152.173z"/>
			<path fill="#511D2F" d="M71.099,151.065c-0.266-0.123-0.297-0.418-0.297-0.418c0.146,0.103,0.297,0.055,0.378,0.014
				c0,0,0.125,0.098,0.276,0.122c0,0-0.199,0.159-0.447,0.031c0,0,0.008,0.048,0.023,0.112
				C71.049,150.991,71.099,151.065,71.099,151.065z"/>
			<path fill="#511D2F" d="M71.144,150.593c-0.287-0.123-0.358-0.456-0.358-0.456c0.152,0.104,0.279,0.028,0.345-0.03
				c0,0,0.109,0.118,0.269,0.118c0,0-0.184,0.199-0.398,0.055c0,0,0,0.057,0.031,0.145
				C71.064,150.512,71.144,150.593,71.144,150.593z"/>
			<path fill="#511D2F" d="M71.079,150.018c-0.438-0.222-0.185-0.793-0.396-1.103c0,0,0.288,0.109,0.277,0.6
				C70.953,149.905,71.079,150.018,71.079,150.018z"/>
			<path fill="#511D2F" d="M69.691,150.226c-0.097-0.166-0.274-0.153-0.446-0.081c-0.208,0.087-0.511,0.287-0.862,0.151
				c0,0,0.18,0.216,0.082,0.475c0,0,0.039,0.077,0.03,0.148c0,0,0.239-0.216,0.104-0.447c0,0,0.473,0.069,0.679-0.08
				C69.54,150.201,69.691,150.226,69.691,150.226z"/>
			<path fill="#511D2F" d="M68.174,150.592c-0.038-0.063-0.091-0.128-0.166-0.185c0,0,0.068,0.176-0.005,0.337
				c0,0,0.021,0.056,0.021,0.135c0,0,0.064-0.04,0.112-0.136C68.168,150.677,68.174,150.592,68.174,150.592z"/>
			<path fill="#511D2F" d="M65.838,150.289c-0.096,0.064-0.293,0.153-0.52,0.007c0,0,0.091,0.24-0.095,0.455
				c-0.216,0.247-0.791,0.128-0.654,0.639c0,0-0.018-0.002-0.043-0.011c0,0,0.027,0.147,0.179,0.187c0,0-0.112-0.264,0.191-0.424
				c0.304-0.158,0.599-0.096,0.662-0.454c0.022-0.121-0.031-0.248-0.031-0.248c0.335,0.176,0.59-0.056,0.59-0.056
				C65.965,150.384,65.838,150.289,65.838,150.289z"/>
			<path fill="#511D2F" d="M63.409,151.528c-0.03-0.037-0.055-0.087-0.062-0.154c0,0-0.155,0.031-0.351,0.176
				c-0.239,0.176-0.399,0.205-0.886,0.176c-0.207-0.014-0.381,0.028-0.526,0.014c0,0,0.219,0.04,0.348,0.029
				c0.14-0.012,0.391,0.024,0.638,0.017c0.248-0.008,0.451-0.048,0.575-0.123C63.293,151.57,63.409,151.528,63.409,151.528z"/>
			<path fill="#511D2F" d="M63.91,151.455c-0.055-0.052-0.107-0.137-0.092-0.273c0,0-0.149,0.067-0.211,0.254
				c0,0,0.012,0.218,0.196,0.305c0,0,0-0.079,0.024-0.15C63.85,151.518,63.91,151.455,63.91,151.455z"/>
			<path fill="#511D2F" d="M64.392,151.303c-0.056-0.054-0.103-0.139-0.103-0.272c0,0-0.217,0.116-0.266,0.321
				c0,0,0.058-0.05,0.106-0.058c0,0-0.063,0.2,0.143,0.327c0,0,0.009-0.104,0.032-0.184
				C64.329,151.357,64.392,151.303,64.392,151.303z"/>
			<path fill="#511D2F" d="M65.83,150.233c-0.247-0.043-0.235-0.325-0.168-0.56c0.08-0.287,0.167-0.398,0.087-0.727
				c-0.08-0.329-0.016-0.431,0.239-0.551c0.255-0.119,0.551-0.151,0.551-0.151c-0.176-0.303,0.048-0.535,0.048-0.535
				s-0.018,0.215,0.096,0.359c0.176,0.224,0.438,0.159,0.438,0.159l-0.03,0.137c0,0-0.538,0.014-0.95,0.239
				c-0.234,0.127-0.212,0.255-0.18,0.446c0.032,0.192,0.042,0.331-0.075,0.691C65.768,150.104,65.83,150.233,65.83,150.233z"/>
			<path fill="#511D2F" d="M66.165,146.809c0,0-0.072-0.141-0.383-0.247c-0.231-0.08-0.638-0.312-0.582-1.118
				c0,0-0.088,0.471-0.63,0.694c-0.381,0.157-0.581,0.282-0.71,0.447c0,0-0.088,0.271,0.087,0.423c0,0-0.008-0.367,0.479-0.526
				c0.47-0.154,0.543-0.336,0.543-0.336s0.119,0.368,0.542,0.424C65.896,146.619,66.165,146.809,66.165,146.809z"/>
			<path fill="#511D2F" d="M62.932,147.591c0.191-0.141-0.008-0.431,0.24-0.742c0.156-0.197,0.471-0.319,0.471-0.319
				c-0.011,0.069-0.005,0.124,0.006,0.168c0,0-0.318,0.159-0.397,0.351c-0.08,0.192-0.041,0.398-0.088,0.519
				c-0.055,0.144-0.223,0.104-0.223,0.104L62.932,147.591z"/>
			<path fill="#511D2F" d="M62.725,147.637c-0.078-0.013-0.136-0.046-0.136-0.046s-0.025,0.263-0.279,0.296
				c0,0,0.215,0.066,0.328-0.057C62.725,147.734,62.725,147.637,62.725,147.637z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#511D2F" d="M67.812,142.039c-0.458-0.166-0.479-0.59-0.48-0.662
				c0.004,0.001,0.008,0.002,0.012,0.002c0.276,0.054,0.33-0.128,0.33-0.128s-0.335-0.165-0.341-0.67
				c-0.005-0.506-0.33-0.708-0.33-0.708c0.495,0.032,0.437-0.399,0.437-0.399c-0.075,0.032-0.134,0.029-0.134,0.029
				c-0.094,0.157-0.296,0.306-0.729,0.142c0,0,0.505,0.17,0.533,0.681c0.032,0.585,0.148,0.734,0.319,0.841
				c0,0-0.106,0.171-0.298,0.064c0,0,0.021,0.542,0.394,0.681c0,0-0.149,0.245-0.426,0.064c0,0-0.063,0.595,0.298,0.744
				c0,0-0.234,0.192-0.447-0.011c0,0,0.188,0.379-0.352,0.841c-0.373,0.318-0.351,0.628-0.351,0.628s-0.234-0.054-0.33-0.373
				c0,0-0.373,0.416-0.075,0.862c0,0-0.298,0.011-0.394-0.34c0,0,0.032,0.244-0.17,0.361c-0.203,0.117-0.128,0.404-0.128,0.404
				s-0.308-0.085-0.266-0.426c0,0-0.325-0.086-0.421,0.378c0,0,0.096-0.191,0.319-0.176c0,0,0.08,0.292,0.365,0.415
				c0.026,0.011,0.053,0.021,0.082,0.028c0.024,0.007,0.049,0.012,0.076,0.017c0.063,0.009,0.134,0.011,0.212,0.003
				c0,0-0.282-0.335-0.048-0.654c0,0,0.208,0.384,0.686,0.224c0,0-0.188-0.176-0.207-0.384c-0.016-0.175,0.048-0.335,0.048-0.335
				s0.095,0.128,0.247,0.225c0,0,0.087,0.163,0.24,0.396c0.105,0.159,0.242,0.35,0.404,0.542c0.196,0.234,0.43,0.47,0.689,0.648
				c0,0-0.452-0.449-0.702-0.769c-0.251-0.319-0.469-0.74-0.469-0.74c0.202,0.064,0.395,0.011,0.395,0.011
				c-0.107-0.068-0.373-0.457,0.122-0.855c0.495-0.399,0.229-0.761,0.229-0.761c0.292,0.229,0.51,0,0.51,0
				c-0.441-0.219-0.318-0.724-0.318-0.724C67.747,142.251,67.812,142.039,67.812,142.039z"/>
			<path fill="#511D2F" d="M65.703,139.622c0,0,0.018,0.312,0.283,0.48c0,0-0.222,0.032-0.373-0.021
				c-0.151-0.055-0.057-0.168-0.015-0.217c0.042-0.049,0.001-0.142-0.142-0.061c-0.066,0.038-0.131-0.054-0.131-0.054
				S65.491,139.622,65.703,139.622z"/>
			<path fill="#511D2F" d="M65.309,140.022c0,0,0.065,0.192,0.429,0.192c0,0-0.305,0.132-0.466,0.018
				C65.167,140.159,65.309,140.022,65.309,140.022z"/>
		</g>
		<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M57.889,150.443c0,0-0.041-0.09-0.016-0.177
			c0.054-0.188,0.339-0.194,0.339-0.194c-0.08-0.078-0.077-0.188-0.027-0.273c0.036-0.052,0.146-0.1,0.147-0.1
			c0.188-0.057,0.336,0.104,0.336,0.104c0.218-0.456,0.37-0.75,0.471-0.952c0.101-0.201-0.507-0.304-0.507-0.304
			c0.108,0.155,0.024,0.291,0.024,0.291c-0.057-0.207-0.369-0.213-0.369-0.213c0.1,0.104,0.059,0.255,0.059,0.255
			c-0.08-0.108-0.051-0.095-0.226-0.174c-0.122-0.055-0.113-0.226-0.113-0.226c-0.181,0.142-0.444,0.045-0.444,0.045
			s0.436-0.115,0.236-0.529c-0.089-0.186-0.113-0.462-0.004-0.756c0.053-0.145,0.093-0.179,0.132-0.28
			c-0.199,0.107-0.434,0.16-0.603,0.197c-0.354,0.077-0.524,0.132-0.388,0.391c0.146,0.275-0.15,0.371,0.168,0.639
			c0,0-0.152,0.082-0.285-0.017c0.056,0.209,0.377,0.605-0.008,0.734c-0.228,0.077-0.462,0.308-0.399,0.56
			c0,0-0.17-0.028-0.183-0.231c0,0-0.198,0.144-0.199,0.409c0,0-0.16-0.026-0.126-0.229c0,0-0.267,0.126-0.281,0.406
			c0,0-0.127-0.076-0.127-0.242c0,0-0.195-0.033-0.278,0.062c0,0,0.189,0.085,0.042,0.329c-0.03,0.045-0.062,0.089-0.114,0.126
			c-0.154,0.087-0.333-0.08-0.333-0.08s-0.057,0.321-0.336,0.243c-0.056-0.018-0.092-0.041-0.134-0.077
			c-0.107-0.124,0.004-0.315,0.004-0.315s-0.22,0.028-0.288-0.124c-0.021-0.048-0.024-0.111-0.013-0.168
			c0.043-0.236,0.279-0.241,0.279-0.241s-0.137-0.144-0.117-0.269c0.014-0.056,0.053-0.096,0.116-0.127
			c0.232-0.099,0.463,0.226,0.463,0.226s0.709-0.509,0.958-0.706c0.166-0.132-0.013-0.575,0-0.745c0,0-0.113,0.03-0.291,0.027
			c0,0,0.251-0.188,0.237-0.479c0,0-0.087,0.237-0.303,0.222c0,0,0.114-0.077,0.069-0.285c-0.04-0.181,0.066-0.311,0.066-0.311
			s-0.233-0.053-0.201-0.298c0,0,0.29,0.18,0.39-0.014c0.087-0.169,0.333-0.4,0.686-0.493c0.24-0.062,0.622-0.109,0.79-0.117
			c-0.209-0.336-0.613-0.454-0.747-0.847c-0.253,0.222-0.589,0.324-0.773,0.375c-0.33,0.093-0.432,0.324-0.432,0.324
			c-0.08-0.085-0.01-0.257-0.01-0.257s-0.226,0.078-0.326,0.169c-0.337,0.31-0.077,0.492-0.267,0.687
			c-0.05,0.051-0.114,0.091-0.186,0.079c-0.1-0.013-0.17-0.105-0.17-0.105s-0.04,0.355-0.372,0.24
			c-0.081-0.027-0.133-0.071-0.17-0.123c-0.074-0.13,0.023-0.289,0.023-0.289s-0.333,0.108-0.397-0.143
			c-0.008-0.052-0.004-0.132,0.001-0.178c0.058-0.232,0.341-0.234,0.341-0.234c-0.231-0.074-0.279-0.397-0.009-0.501
			c0.232-0.088,0.472,0.129,0.472,0.129c0.692-0.243,1.188-0.702,1.188-0.702c-0.127,0-0.204-0.077-0.204-0.077
			s0.286-0.165,0.358-0.362c-0.194-0.023-0.326-0.16-0.326-0.16c0.086-0.017,0.168-0.063,0.241-0.122
			c-0.231-0.169-0.418-0.458-0.539-0.613c-0.178-0.229-0.471-0.268-0.471-0.268c0.077-0.177,0.242-0.215,0.242-0.215
			c-0.203-0.331-0.61-0.56-0.61-0.56s-0.191,0.254-0.407,0.126c-0.004-0.002-0.067-0.046-0.112-0.122
			c-0.047-0.113,0.01-0.232,0.01-0.232s-0.342-0.011-0.381-0.22c-0.003-0.062,0-0.113,0.026-0.169
			c0.089-0.188,0.33-0.121,0.33-0.121c-0.102-0.081-0.142-0.303-0.074-0.439c0.026-0.05,0.074-0.091,0.14-0.107
			c0.209-0.033,0.392,0.256,0.392,0.256c-0.018-0.089,0.062-0.232,0.178-0.234c0.063,0.004,0.107,0.031,0.167,0.097
			c0.187,0.229-0.027,0.582-0.027,0.582c0.191,0.19,0.356,0.293,0.902,0.56c0.312,0.151,0.639,0.445,0.862,0.668
			c0.188,0.052,0.275,0.032,0.275,0.032c-0.203-0.111-0.13-0.296-0.13-0.296c0.654,0.306,0.727-0.253,0.727-0.253
			c-0.18-0.091-0.476-0.008-0.476-0.008c-0.184-0.358,0.123-0.453,0.123-0.453c0.019-0.055,0.048-0.119,0.096-0.184
			c0,0,0.01,0.086,0.036,0.184h0.004c0,0,0.443,0.117,0.637-0.33c0.012-0.027,0.022-0.058,0.032-0.089
			c0.001-0.004,0.002-0.007,0.004-0.011c0.126-0.41-0.303-0.438-0.425-0.41c-0.18,0.043-0.261,0.021-0.261,0.021
			c-0.042,0.103-0.071,0.194-0.071,0.194c-0.062-0.081-0.071-0.194-0.071-0.194c-0.356-0.143-0.228-0.684-0.228-0.684
			s-0.059-0.177,0.004-0.208c0.063-0.032,0.41-0.069,0.591-0.028c0.18,0.042,0.37-0.142,0.655-0.075
			c0.206,0.049,0.362,0.145,0.362,0.145c0.046-0.13,0.329-0.472,0.659-0.257c0.273,0.177,0.562,0.078,0.562,0.078
			c-0.066,0.668-0.697,0.455-0.697,0.455c0.195,0.07,0.296,0.212,0.296,0.545s0.292,0.417,0.292,0.417
			c-0.125,0.166-0.292,0.082-0.292,0.082c0.028,0.543,0.334,0.585,0.334,0.585c-0.167,0.18-0.362,0.056-0.362,0.056
			c0,0.472,0.223,0.569,0.223,0.569c-0.223,0.208-0.402,0.014-0.402,0.014c0.065,0.117,0.096,0.225,0.056,0.436
			c-0.043,0.224,0.131,0.277,0.131,0.277c-0.153,0.139-0.304,0.045-0.362-0.009c-0.185,0.242-0.044,0.593-0.044,0.593
			c-0.3,0.022-0.306-0.266-0.306-0.266s-0.15,0.399-0.059,0.863c0.09,0.465,0.373,0.855,0.785,1.066
			c0.528,0.269,1.542,0.341,1.778-0.188c0.217-0.49,0.064-0.993-0.436-0.993c-0.5,0-0.571,0.426-0.571,0.426
			c-0.163-0.253-0.035-0.462,0.054-0.564c-0.276-0.084-0.531-0.372-0.503-0.732c0.053-0.694,0.707-0.785,0.707-0.785
			c-0.14-0.668,0.311-0.823,0.698-0.745c0.388,0.077,0.512-0.218,0.512-0.218c0.14,0.325-0.092,0.574-0.092,0.574
			c0.465-0.078,0.589-0.808,0.589-0.808c0.218,1.165-0.434,1.586-1.203,1.438c-0.686-0.133-0.893,0.201-0.921,0.522
			c-0.031,0.349,0.295,0.546,0.716,0.58c0.42,0.033,0.558,0.176,0.558,0.176c0.148-0.295,0.463-0.189,0.463-0.189
			s-0.245,0.299-0.204,0.543c0.033,0.199,0.341,0.924-0.51,1.437c-0.312,0.189-0.709,0.245-1.072,0.173
			c0.211,0.511-0.464,0.912-0.004,1.157c0,0-0.186,0.111-0.327-0.012l-0.043,0.214c0,0,0.292-0.051,0.56,0.086
			c0.51,0.258,0.708,0.053,0.708,0.053c-0.004,0.223-0.176,0.351-0.176,0.351c0.58,0.1,0.485,0.367,0.218,0.669
			c-0.252,0.287-0.293,0.543-0.175,0.672c0,0-0.163,0.009-0.206-0.193c0,0-0.233,0.238-0.071,0.448c0,0-0.121-0.008-0.196-0.141
			c0,0-0.234,0.238-0.063,0.393c0,0-0.145,0.006-0.193-0.123c0,0-0.089,0.096-0.13,0.199c0,0,0.197,0.097,0.148,0.257
			c-0.048,0.156-0.26,0.217-0.481,0.068c0,0-0.066,0.32-0.325,0.314c-0.084-0.002-0.124-0.014-0.193-0.068
			c-0.06-0.068-0.057-0.163-0.057-0.163S57.983,150.672,57.889,150.443z M57.27,140.825c-0.108-0.044-0.037-0.16-0.037-0.16
			s0.089,0.153,0.432,0.086C57.665,140.751,57.439,140.894,57.27,140.825z M57.534,140.683c-0.151-0.019-0.087-0.123-0.054-0.173
			c0.033-0.051-0.05-0.129-0.173-0.032c-0.058,0.045-0.132-0.022-0.132-0.022s0.13-0.135,0.331-0.175c0,0,0.105,0.281,0.344,0.357
			C57.85,140.638,57.685,140.702,57.534,140.683z"/>
		<g>
			<path fill="#C4122F" d="M54.688,135.356c0,0-0.225,0.022-0.321,0.18l0.203,0.422C54.57,135.958,54.458,135.521,54.688,135.356z"
				/>
			<path fill="#C4122F" d="M59.687,135.589c0,0,0.079-0.101,0.341-0.045c0,0-0.288,0.09-0.314,0.437L59.687,135.589z"/>
			<path fill="#C4122F" d="M57.608,135.02c0,0-0.246-0.082-0.449,0.09l0.08,0.578C57.238,135.688,57.272,135.127,57.608,135.02z"/>
			<path fill="#C4122F" d="M52.898,136.656c-0.11-0.235-0.08-0.474-0.08-0.474c-0.147,0.109-0.147,0.244-0.147,0.244
				C52.758,136.478,52.85,136.597,52.898,136.656z"/>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#C4122F" d="M57.127,137.191c-0.209,0.117-0.416,0.227-0.615,0.349
				c-0.001,0-0.001,0.001-0.003,0.002c0.216,0.107,0.408,0.207,0.611,0.319c0.199-0.114,0.371-0.226,0.58-0.335
				c-0.008-0.004,0.008,0.004,0,0C57.506,137.411,57.333,137.303,57.127,137.191z"/>
			<g>
				<g>
					<path fill="#FFFFFF" d="M57.127,137.507c0.001-0.064,0.003-0.125,0.003-0.189c-0.118,0.065-0.222,0.125-0.335,0.191
						C56.909,137.507,57.013,137.507,57.127,137.507z"/>
				</g>
			</g>
			<path fill="#C4122F" d="M53.257,138.166l0.257,0.204c0.104-0.133,0.197-0.242,0.311-0.373c-0.153-0.043-0.288-0.097-0.438-0.137
				L53.257,138.166z"/>
			<path fill="#C4122F" d="M60.553,138.191l0.269-0.172l-0.108-0.279c0,0-0.246,0.088-0.376,0.123L60.553,138.191z"/>
		</g>
		<g>
			<g>
				<g>
					<path fill-rule="evenodd" clip-rule="evenodd" fill="#023F88" d="M57.382,141.435c-0.15-0.116-0.408-0.256-0.788-0.094
						c-0.582,0.248-0.723,0.135-0.736-0.168c0,0-0.246,0.332-0.056,0.535c0.3,0.319,0.691-0.089,0.948-0.197
						c0.2-0.084,0.415-0.043,0.597,0.036c0.012-0.027,0.022-0.058,0.032-0.089L57.382,141.435z"/>
					<path fill="#023F88" d="M54.418,149.014c-0.084-0.101-0.257-0.118-0.359-0.035c-0.061,0.05-0.09,0.124-0.085,0.197
						c0.011-0.023,0.028-0.046,0.049-0.062c0.136-0.104,0.243-0.005,0.243-0.005C54.386,149.148,54.418,149.014,54.418,149.014z"/>
					<path fill="#023F88" d="M54.147,149.567c-0.132-0.014-0.25,0.08-0.264,0.21c-0.01,0.077,0.021,0.151,0.076,0.2
						c-0.008-0.025-0.01-0.052-0.007-0.079c0.012-0.164,0.167-0.17,0.167-0.17C54.195,149.699,54.147,149.567,54.147,149.567z"/>
					<path fill="#023F88" d="M54.422,150.086c-0.11,0.071-0.141,0.218-0.069,0.327c0.043,0.065,0.114,0.102,0.188,0.105
						c-0.022-0.014-0.042-0.033-0.057-0.057c-0.07-0.105,0.022-0.225,0.022-0.225C54.554,150.146,54.422,150.086,54.422,150.086z"/>
					<path fill="#023F88" d="M55.186,149.901c0.115,0.063,0.156,0.208,0.091,0.322c-0.039,0.067-0.107,0.109-0.18,0.119
						c0.021-0.017,0.04-0.037,0.053-0.061c0.083-0.156-0.039-0.227-0.039-0.227C55.057,149.986,55.186,149.901,55.186,149.901z"/>
					<path fill="#023F88" d="M58.36,149.735c-0.08-0.114-0.237-0.142-0.351-0.062c-0.069,0.048-0.105,0.124-0.107,0.202
						c0.015-0.024,0.034-0.045,0.058-0.062c0.122-0.087,0.232-0.01,0.232-0.01C58.296,149.814,58.36,149.735,58.36,149.735z"/>
					<path fill="#023F88" d="M58.017,150.251c-0.138-0.024-0.269,0.063-0.296,0.201c-0.015,0.082,0.011,0.163,0.064,0.22
						c-0.006-0.027-0.007-0.056-0.001-0.084c0.031-0.14,0.155-0.16,0.155-0.16C58.014,150.36,58.017,150.251,58.017,150.251z"/>
					<path fill="#023F88" d="M58.473,150.539c-0.112,0.08-0.16,0.255-0.079,0.369c0.048,0.067,0.125,0.104,0.202,0.105
						c-0.024-0.015-0.048-0.032-0.062-0.057c-0.074-0.137,0.003-0.227,0.003-0.227C58.592,150.616,58.473,150.539,58.473,150.539z"
						/>
					<path fill="#023F88" d="M59.227,150.288c0.116,0.077,0.158,0.255,0.08,0.372c-0.047,0.069-0.121,0.108-0.199,0.112
						c0.023-0.016,0.044-0.036,0.06-0.061c0.087-0.135-0.014-0.24-0.014-0.24C59.127,150.341,59.227,150.288,59.227,150.288z"/>
					<path fill="#023F88" d="M54.296,141.105c0.066-0.122,0.021-0.274-0.102-0.341c-0.074-0.039-0.158-0.037-0.228-0.005
						c0.027,0.002,0.053,0.013,0.08,0.024c0.148,0.06,0.095,0.218,0.095,0.218C54.187,141.115,54.296,141.105,54.296,141.105z"/>
					<path fill="#023F88" d="M53.653,141.044c-0.037-0.134-0.176-0.212-0.31-0.174c-0.08,0.022-0.14,0.081-0.167,0.154
						c0.021-0.018,0.046-0.034,0.075-0.039c0.173-0.029,0.221,0.088,0.221,0.088C53.584,141.127,53.653,141.044,53.653,141.044z"/>
					<path fill="#023F88" d="M53.335,141.65c-0.107-0.088-0.266-0.071-0.354,0.037c-0.053,0.064-0.067,0.147-0.047,0.223
						c0.007-0.026,0.019-0.053,0.038-0.075c0.112-0.121,0.241-0.058,0.241-0.058C53.325,141.75,53.335,141.65,53.335,141.65z"/>
					<path fill="#023F88" d="M53.752,142.218c-0.065,0.122-0.244,0.185-0.366,0.119c-0.074-0.04-0.119-0.11-0.129-0.187
						c0.016,0.021,0.039,0.04,0.064,0.054c0.176,0.097,0.25-0.028,0.25-0.028C53.684,142.138,53.752,142.218,53.752,142.218z"/>
					<path fill="#023F88" d="M53.725,145.324c-0.069-0.121-0.223-0.163-0.344-0.095c-0.073,0.042-0.117,0.114-0.125,0.191
						c0.016-0.022,0.037-0.043,0.063-0.056c0.153-0.076,0.258,0.043,0.258,0.043C53.696,145.425,53.725,145.324,53.725,145.324z"/>
					<path fill="#023F88" d="M53.478,145.904c-0.134-0.038-0.274,0.038-0.313,0.172c-0.023,0.08-0.005,0.162,0.043,0.224
						c-0.004-0.027-0.003-0.057,0.006-0.084c0.055-0.156,0.185-0.143,0.185-0.143C53.489,146.008,53.478,145.904,53.478,145.904z"/>
					<path fill="#023F88" d="M53.861,146.398c-0.128,0.056-0.187,0.204-0.131,0.33c0.033,0.077,0.101,0.129,0.177,0.146
						c-0.02-0.02-0.041-0.042-0.049-0.069c-0.05-0.156,0.059-0.246,0.059-0.246C53.947,146.435,53.861,146.398,53.861,146.398z"/>
					<path fill="#023F88" d="M54.574,146.327c0.082,0.111,0.057,0.279-0.055,0.362c-0.067,0.049-0.151,0.06-0.225,0.036
						c0.217-0.052,0.149-0.271,0.149-0.271C54.466,146.343,54.574,146.327,54.574,146.327z"/>
					<path fill="#023F88" d="M62.739,140.917c0.074-0.168,0.042-0.384-0.091-0.485c-0.081-0.062-0.178-0.07-0.262-0.035
						c0.031,0.007,0.063,0.02,0.09,0.042c0.143,0.12,0.099,0.309,0.099,0.309C62.591,140.9,62.739,140.917,62.739,140.917z"/>
					<path fill="#023F88" d="M62.252,151.406c-0.16-0.118-0.382-0.083-0.498,0.077c-0.069,0.096-0.083,0.215-0.051,0.319
						c0.009-0.038,0.03-0.097,0.058-0.127c0.136-0.152,0.326-0.082,0.326-0.082C62.268,151.56,62.252,151.406,62.252,151.406z"/>
					<path fill="#023F88" d="M61.623,151.232c-0.184-0.07-0.389,0.021-0.46,0.207c-0.042,0.11-0.025,0.229,0.034,0.321
						c-0.001-0.039-0.006-0.099,0.013-0.137c0.085-0.164,0.276-0.132,0.276-0.132C61.633,151.407,61.623,151.232,61.623,151.232z"/>
					<path fill="#023F88" d="M61.786,150.845c-0.129-0.131-0.353-0.127-0.468-0.01c-0.07,0.069-0.097,0.165-0.083,0.256
						c0.012-0.031,0.05-0.086,0.077-0.107c0.139-0.114,0.321,0.012,0.321,0.012C61.75,150.979,61.786,150.845,61.786,150.845z"/>
					<path fill="#023F88" d="M68.922,151.307c-0.102-0.099-0.322-0.109-0.421-0.007c-0.06,0.062-0.077,0.18-0.032,0.257
						c0,0,0.005-0.055,0.04-0.093c0.115-0.128,0.295,0.028,0.295,0.028C68.924,151.436,68.922,151.307,68.922,151.307z"/>
					<path fill="#023F88" d="M62.759,147.605c0,0,0.095,0.135,0.014,0.266c-0.022,0.034-0.043,0.065-0.071,0.089
						c0.103-0.014,0.195-0.076,0.247-0.179c0.053-0.105,0.059-0.279-0.095-0.458C62.791,147.396,62.75,147.509,62.759,147.605z"/>
					<path fill="#023F88" d="M62.202,147.789c0,0,0.068,0.179-0.073,0.288c-0.029,0.022-0.06,0.04-0.093,0.048
						c0.093,0.034,0.196,0.021,0.277-0.047c0.098-0.083,0.171-0.253,0.096-0.506C62.254,147.65,62.233,147.713,62.202,147.789z"/>
					<path fill="#023F88" d="M61.673,147.454c0.036-0.065,0.094-0.149,0.029-0.271c-0.207,0.083-0.311,0.266-0.289,0.401
						c0.019,0.111,0.091,0.201,0.188,0.249c-0.021-0.031-0.036-0.067-0.043-0.107C61.525,147.505,61.673,147.454,61.673,147.454z"/>
					<path fill="#023F88" d="M61.782,146.43c-0.239-0.062-0.425,0.062-0.478,0.202c-0.038,0.104-0.019,0.215,0.042,0.3
						c-0.003-0.036,0-0.075,0.015-0.111c0.057-0.138,0.245-0.153,0.245-0.153C61.713,146.619,61.788,146.563,61.782,146.43z"/>
					<path fill="#023F88" d="M64.523,140.495c0,0,0.003,0.218,0.117,0.367c0,0,0.023-0.086,0.061-0.19
						c0.013-0.038,0.028-0.079,0.045-0.119c0.019-0.044,0.038-0.087,0.059-0.125C64.805,140.428,64.615,140.361,64.523,140.495z"/>
					<path fill="#023F88" d="M64.609,141.749c0.01-0.075,0.04-0.205,0.13-0.333c0,0,0.012,0.089,0.04,0.198
						c0.015,0.058,0.058,0.176,0.058,0.176C64.726,141.835,64.609,141.749,64.609,141.749z"/>
					<path fill="#023F88" d="M69.528,151.801c-0.197-0.075-0.398-0.002-0.451,0.164c-0.032,0.099-0.001,0.209,0.071,0.298
						c-0.006-0.036-0.001-0.086,0.012-0.12c0.059-0.164,0.271-0.084,0.271-0.084C69.575,151.996,69.528,151.801,69.528,151.801z"/>
					<path fill="#023F88" d="M68.839,151.752c0,0-0.415-0.157-0.527,0.146c-0.038,0.101-0.005,0.247,0.091,0.316
						c-0.008-0.038-0.008-0.103,0.002-0.14c0.035-0.116,0.186-0.133,0.303-0.069C68.708,152.006,68.866,151.93,68.839,151.752z"/>
					<path fill="#023F88" d="M65.571,141.166c0.005-0.043,0.008-0.082,0.008-0.118c-0.154-0.127-0.492-0.204-0.917-0.001
						c-0.353,0.169-0.63,0.272-0.757,0.038c0,0,0.255-0.166,0.141-0.439c-0.126-0.302-0.479-0.245-0.593,0.017
						c-0.186,0.42,0.063,0.942,0.649,0.887c0.37-0.035,0.599-0.379,1.031-0.412C65.299,141.123,65.453,141.142,65.571,141.166z"/>
					<path fill="#023F88" d="M51.531,140.911c-0.074-0.166-0.042-0.383,0.091-0.485c0.081-0.062,0.177-0.07,0.261-0.034
						c-0.032,0.007-0.062,0.021-0.09,0.042c-0.109,0.084-0.145,0.172-0.099,0.308S51.531,140.911,51.531,140.911z"/>
					<path fill="#023F88" d="M51.503,147.64c-0.015,0.085,0.006,0.177,0.064,0.246c0.027,0.03,0.058,0.053,0.091,0.068
						c-0.103,0.012-0.208-0.025-0.282-0.112c-0.077-0.09-0.125-0.257-0.02-0.47C51.459,147.445,51.531,147.509,51.503,147.64z"/>
					<path fill="#023F88" d="M52.059,147.91c0.01,0.101,0.063,0.19,0.147,0.234c0.033,0.017,0.067,0.024,0.102,0.024
						c-0.083,0.056-0.186,0.066-0.28,0.018c-0.114-0.059-0.229-0.233-0.212-0.495C51.985,147.729,52.046,147.812,52.059,147.91z"/>
					<path fill="#023F88" d="M52.625,147.462c-0.09-0.067-0.094-0.15-0.029-0.272c0.206,0.083,0.311,0.265,0.288,0.401
						c-0.019,0.111-0.091,0.201-0.188,0.249c0.021-0.032,0.036-0.067,0.042-0.107C52.757,147.625,52.709,147.521,52.625,147.462z"/>
					<path fill="#023F88" d="M52.485,146.425c0.237-0.062,0.423,0.062,0.476,0.202c0.038,0.104,0.019,0.215-0.042,0.3
						c0.002-0.037-0.002-0.074-0.016-0.111c-0.034-0.093-0.115-0.157-0.209-0.177C52.572,146.616,52.479,146.559,52.485,146.425z"/>
					<path fill="#023F88" d="M45.24,151.368c0.173-0.129,0.4-0.14,0.509-0.023c0.066,0.069,0.074,0.169,0.033,0.265
						c-0.006-0.031-0.022-0.06-0.045-0.085c-0.134-0.153-0.34-0.022-0.34-0.022C45.276,151.442,45.24,151.368,45.24,151.368z"/>
					<path fill="#023F88" d="M45.315,151.779c0.225-0.088,0.476-0.023,0.527,0.147c0.031,0.103,0.004,0.246-0.092,0.316
						c0.008-0.039,0.008-0.077-0.003-0.113c-0.063-0.209-0.303-0.12-0.303-0.12C45.261,151.945,45.315,151.779,45.315,151.779z"/>
					<path fill="#023F88" d="M44.651,151.875c0.198-0.076,0.398-0.003,0.45,0.162c0.032,0.101,0,0.212-0.072,0.299
						c0,0,0.008-0.063-0.017-0.135c-0.062-0.187-0.246-0.131-0.246-0.131C44.63,152.001,44.651,151.875,44.651,151.875z"/>
					<path fill="#023F88" d="M52.127,151.412c0,0,0.291-0.175,0.498,0.077c0.075,0.092,0.084,0.215,0.051,0.319
						c-0.045-0.21-0.232-0.262-0.383-0.209C52.292,151.6,52.128,151.599,52.127,151.412z"/>
					<path fill="#023F88" d="M52.653,151.205c0,0,0.34-0.086,0.483,0.192c0.055,0.105,0.008,0.264-0.058,0.336
						c0.028-0.246-0.144-0.311-0.309-0.284C52.77,151.449,52.609,151.382,52.653,151.205z"/>
					<path fill="#023F88" d="M52.514,150.832c0,0,0.275-0.169,0.468,0.03c0.068,0.071,0.081,0.173,0.059,0.263
						c-0.051-0.161-0.246-0.197-0.383-0.116C52.658,151.009,52.514,150.991,52.514,150.832z"/>
					<path fill="#023F88" d="M49.67,141.729c-0.01-0.076-0.04-0.205-0.128-0.334c0,0-0.012,0.09-0.04,0.199
						c-0.015,0.057-0.058,0.175-0.058,0.175C49.539,141.829,49.67,141.729,49.67,141.729z"/>
					<path fill="#023F88" d="M49.757,140.475c0,0-0.004,0.218-0.117,0.368c0,0-0.023-0.086-0.061-0.19
						c-0.028-0.081-0.063-0.172-0.103-0.244C49.477,140.408,49.666,140.341,49.757,140.475z"/>
					<path fill="#023F88" d="M48.772,141.141c-0.005-0.027-0.009-0.055-0.012-0.08c0.193-0.12,0.541-0.252,0.965-0.048
						c0.352,0.168,0.627,0.272,0.753,0.038c0,0-0.253-0.166-0.139-0.439c0.125-0.302,0.476-0.245,0.59,0.017
						c0.184,0.419-0.064,0.942-0.647,0.887c-0.368-0.035-0.596-0.379-1.026-0.413C49.071,141.087,48.895,141.113,48.772,141.141z"/>
					<path fill-rule="evenodd" clip-rule="evenodd" fill="#023F88" d="M59.199,137.391c-0.208-0.026-0.375,0.062-0.423,0.21
						c-0.005,0.015-0.01,0.029-0.013,0.045c-0.011,0.178,0.135,0.327,0.35,0.367c0.217,0.028,0.39-0.068,0.427-0.245
						c0.004-0.036,0.001-0.072-0.007-0.106C59.501,137.53,59.378,137.423,59.199,137.391z"/>
					<path fill-rule="evenodd" clip-rule="evenodd" fill="#023F88" d="M55.127,137.396c-0.204,0.036-0.341,0.163-0.356,0.312
						c-0.002,0.022-0.002,0.045,0.001,0.068c0.041,0.176,0.228,0.272,0.455,0.241c0.225-0.041,0.373-0.191,0.356-0.369
						c-0.001-0.009-0.005-0.017-0.008-0.026C55.531,137.463,55.352,137.367,55.127,137.396z"/>
				</g>
				<path fill="#FFFFFF" d="M54.948,137.632c-0.007-0.057,0.042-0.107,0.118-0.121c0.077-0.009,0.139,0.024,0.149,0.081
					c0.006,0.058-0.042,0.106-0.117,0.12C55.022,137.722,54.96,137.689,54.948,137.632z"/>
				<path fill="#FFFFFF" d="M59.07,137.691c-0.074-0.014-0.123-0.063-0.117-0.122c0.01-0.059,0.071-0.093,0.146-0.083
					c0.074,0.013,0.121,0.065,0.114,0.124C59.202,137.668,59.143,137.701,59.07,137.691z"/>
			</g>
			<g>
				<g>
					<path fill="#FFFFFF" d="M60.579,136.268c0.084-0.001,0.182-0.089,0.249-0.231c0.072-0.169,0.058-0.323-0.033-0.369
						c-0.097-0.037-0.216,0.06-0.291,0.229c-0.064,0.159-0.055,0.3,0.018,0.354L60.579,136.268z"/>
					<path fill="#FFFFFF" d="M58.464,135.707c0.121-0.021,0.229-0.153,0.277-0.354c0.046-0.237-0.025-0.44-0.172-0.48
						c-0.152-0.027-0.293,0.13-0.343,0.368c-0.037,0.222,0.023,0.398,0.143,0.454L58.464,135.707z"/>
					<path fill="#FFFFFF" d="M55.704,135.693c0.134-0.044,0.196-0.238,0.148-0.479c-0.057-0.237-0.198-0.389-0.342-0.354
						c-0.139,0.048-0.201,0.256-0.147,0.492c0.052,0.193,0.157,0.32,0.27,0.342L55.704,135.693z"/>
					<path fill="#FFFFFF" d="M53.495,136.165c0.073-0.055,0.077-0.197,0.004-0.356c-0.084-0.166-0.209-0.256-0.302-0.215
						c-0.089,0.051-0.095,0.206-0.016,0.37c0.078,0.146,0.184,0.229,0.271,0.219L53.495,136.165z"/>
				</g>
				<g>
					<path fill="#8E97C3" d="M60.642,136.014c-0.025-0.01-0.041-0.03-0.05-0.057c-0.003,0.006-0.006,0.01-0.008,0.015
						c-0.035,0.08-0.027,0.15,0.017,0.17c0.047,0.016,0.107-0.027,0.146-0.104c0.013-0.028,0.019-0.054,0.021-0.078
						C60.731,136.004,60.685,136.025,60.642,136.014z"/>
					<path fill="#8E97C3" d="M53.456,135.89c-0.015-0.038-0.036-0.066-0.058-0.088c0.027,0.092,0.004,0.175-0.055,0.2
						c-0.021,0.007-0.042,0.004-0.062-0.004c0.04,0.075,0.096,0.115,0.145,0.096C53.477,136.068,53.49,135.983,53.456,135.89z"/>
					<path fill="#8E97C3" d="M55.757,135.32c-0.006-0.084-0.034-0.151-0.073-0.188c0.006,0.021,0.01,0.045,0.01,0.069
						c-0.003,0.118-0.068,0.203-0.157,0.211c-0.014,0-0.026-0.005-0.038-0.009c0.023,0.098,0.077,0.159,0.141,0.156
						C55.714,135.549,55.763,135.451,55.757,135.32z"/>
					<path fill="#BB8A38" d="M58.58,135.196c-0.002,0.01-0.002,0.021-0.006,0.031c-0.037,0.107-0.115,0.169-0.19,0.152
						c-0.013-0.004-0.022-0.012-0.032-0.02c-0.015,0.094,0.013,0.17,0.074,0.19c0.071,0.016,0.146-0.046,0.181-0.153
						C58.632,135.313,58.62,135.237,58.58,135.196z"/>
				</g>
			</g>
		</g>
		<g>
			<path fill="#6F1C2F" d="M72.84,152.107l-0.415,1.617c-0.087-0.035-0.173-0.063-0.28-0.09l0.242-0.943l0,0
				c0.032-0.064-0.038-0.134-0.172-0.188l-0.452,1.749c-0.076,0.101-0.32,0.168-0.662,0.092c-0.295-0.064-1.342-0.378-2.05-0.378
				c-0.707,0-1.946,0.353-2.13,0.388c-0.129,0.024-0.335,0.028-0.469-0.031l0.04,0.156c0.064,0.171,0.404,0.181,0.589,0.146
				c0.184-0.036,1.424-0.388,2.131-0.388c0.706,0,1.751,0.319,2.048,0.378s0.618-0.014,0.668-0.136l0.171-0.669
				c0.252,0.077,0.486,0.168,0.486,0.168l0.447-1.801C72.97,152.151,72.906,152.129,72.84,152.107z"/>
			<path fill="#6F1C2F" d="M42.886,154.331c0.131,0.037,0.308,0.047,0.478,0.013c0.296-0.059,1.341-0.378,2.048-0.378
				s1.947,0.353,2.131,0.388c0.185,0.036,0.525,0.026,0.589-0.146l0.446-1.732c0.175,0.056,0.273,0.137,0.236,0.211l-0.115,0.457
				h-0.002l-0.057,0.221c1.498-0.124,4.01,0.313,8.465,0.313c4.357,0,7.367-0.372,8.848-0.298l0.061,0.242
				c-1.668-0.091-4.597,0.319-8.909,0.319c-4.661,0-7.248-0.479-8.539-0.287l-0.208,0.819c-0.063,0.172-0.405,0.18-0.589,0.146
				c-0.184-0.036-1.424-0.388-2.131-0.388c-0.708,0-1.753,0.319-2.049,0.378c-0.295,0.058-0.617-0.013-0.667-0.136L42.886,154.331z"
				/>
		</g>
	</g>
	<g>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#E93B34" points="299.365,149.575 301.123,149.575 301.123,151.334 
			299.365,151.334 299.365,149.575 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#E93B34" points="302.588,149.575 304.373,149.575 304.373,151.334 
			302.588,151.334 302.588,149.575 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#E93B34" points="299.365,152.826 301.123,152.826 301.123,154.584 
			299.365,154.584 299.365,152.826 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#E93B34" points="302.588,152.826 304.373,152.826 304.373,154.584 
			302.588,154.584 302.588,152.826 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.124,149.496 221.364,149.496 221.364,150.749 221.63,150.749 
			221.63,151.014 220.378,151.014 220.378,150.749 221.124,150.749 221.124,150.241 220.618,150.241 220.618,150.001 
			221.124,150.001 221.124,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,148.005 228.876,148.005 228.876,148.244 228.637,148.244 
			228.637,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.37,148.244 228.637,148.244 228.637,148.51 228.37,148.51 
			228.37,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.373,157.755 228.37,157.755 228.37,158.021 226.373,158.021 
			226.373,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,150.749 228.876,150.749 228.876,151.014 228.637,151.014 
			228.637,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,151.254 228.876,151.254 228.876,151.494 228.637,151.494 
			228.637,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,157.755 233.378,157.755 233.378,158.021 233.139,158.021 
			233.139,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.116,156.501 229.382,156.501 229.382,156.768 229.116,156.768 
			229.116,156.501 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.876,155.996 229.116,155.996 229.116,156.501 228.876,156.501 
			228.876,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.126,153.013 232.366,153.013 232.366,153.252 232.126,153.252 
			232.126,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,155.756 228.876,155.756 228.876,155.996 228.637,155.996 
			228.637,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.382,156.768 229.889,156.768 229.889,157.009 229.382,157.009 
			229.382,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.632,157.247 232.872,157.247 232.872,157.515 232.632,157.515 
			232.632,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.872,157.515 233.139,157.515 233.139,157.755 232.872,157.755 
			232.872,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,142.996 231.14,142.996 231.14,143.236 230.875,143.236 
			230.875,142.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.889,146.006 230.128,146.006 230.128,146.246 229.889,146.246 
			229.889,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.368,144.008 230.635,144.008 230.635,144.247 230.368,144.247 
			230.368,144.008 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.622,145.74 229.889,145.74 229.889,146.006 229.622,146.006 
			229.622,145.74 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.38,142.489 231.62,142.489 231.62,142.756 231.38,142.756 
			231.38,142.489 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.368,142.489 230.635,142.489 230.635,142.756 230.368,142.756 
			230.368,142.489 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,148.244 238.147,148.244 238.147,148.51 237.88,148.51 
			237.88,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,148.51 237.88,148.51 237.88,148.75 237.641,148.75 
			237.641,148.51 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,151.494 238.147,151.494 238.147,151.76 237.88,151.76 
			237.88,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,150.749 237.88,150.749 237.88,151.014 237.641,151.014 
			237.641,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,151.254 237.88,151.254 237.88,151.494 237.641,151.494 
			237.641,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,157.755 233.378,157.755 233.378,158.021 233.139,158.021 
			233.139,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.135,156.501 237.375,156.501 237.375,156.768 237.135,156.768 
			237.135,156.501 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.375,155.996 237.641,155.996 237.641,156.501 237.375,156.501 
			237.375,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.375,155.996 237.641,155.996 237.641,156.501 237.375,156.501 
			237.375,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,155.756 237.88,155.756 237.88,155.996 237.641,155.996 
			237.641,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.628,156.768 237.135,156.768 237.135,157.009 236.628,157.009 
			236.628,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.618,157.247 233.885,157.247 233.885,157.515 233.618,157.515 
			233.618,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.378,157.515 233.618,157.515 233.618,157.755 233.378,157.755 
			233.378,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.137,146.006 235.882,146.006 235.882,146.246 235.137,146.246 
			235.137,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.376,142.996 235.643,142.996 235.643,143.236 235.376,143.236 
			235.376,142.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.389,146.006 236.628,146.006 236.628,146.246 236.389,146.246 
			236.389,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,144.008 236.122,144.008 236.122,144.247 235.882,144.247 
			235.882,144.008 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.628,145.74 236.895,145.74 236.895,146.006 236.628,146.006 
			236.628,145.74 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.87,142.489 235.137,142.489 235.137,142.756 234.87,142.756 
			234.87,142.489 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,142.489 236.122,142.489 236.122,142.756 235.882,142.756 
			235.882,142.489 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,148.75 238.147,148.75 238.147,151.254 237.88,151.254 
			237.88,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,151.76 231.887,151.76 231.887,152 228.637,152 228.637,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,153.492 233.378,153.492 233.378,157.515 233.139,157.515 
			233.139,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.126,150.749 232.366,150.749 232.366,151.014 232.126,151.014 
			232.126,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.366,151.014 232.632,151.014 232.632,151.254 232.366,151.254 
			232.366,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.632,151.254 232.872,151.254 232.872,151.494 232.632,151.494 
			232.632,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.872,151.494 233.139,151.494 233.139,151.76 232.872,151.76 
			232.872,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,151.76 233.378,151.76 233.378,152 233.139,152 233.139,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.618,152.268 233.885,152.268 233.885,152.507 233.618,152.507 
			233.618,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.378,152 233.618,152 233.618,152.268 233.378,152.268 233.378,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.885,152.507 234.124,152.507 234.124,152.746 233.885,152.746 
			233.885,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.63,151.76 237.88,151.76 237.88,152 234.63,152 234.63,151.76 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.38,145.74 235.137,145.74 235.137,146.006 231.38,146.006 
			231.38,145.74 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.632,144.994 233.885,144.994 233.885,145.232 232.632,145.232 
			232.632,144.994 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.87,144.487 236.895,144.487 236.895,144.754 234.87,144.754 
			234.87,144.487 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.122,144.247 237.375,144.247 237.375,144.487 236.122,144.487 
			236.122,144.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.622,144.487 231.62,144.487 231.62,144.754 229.622,144.754 
			229.622,144.487 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.116,144.247 230.368,144.247 230.368,144.487 229.116,144.487 
			229.116,144.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.635,146.006 231.38,146.006 231.38,146.246 230.635,146.246 
			230.635,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,144.994 231.14,144.994 231.14,145.232 231.62,145.232 
			231.62,145.5 231.14,145.5 231.14,145.74 230.875,145.74 230.875,145.5 230.635,145.5 230.635,145.232 230.875,145.232 
			230.875,144.994 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.126,142.729 232.392,142.729 232.392,143.742 232.126,143.742 
			232.126,142.729 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.872,141.983 233.618,141.983 233.618,142.249 232.872,142.249 
			232.872,141.983 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,142.756 233.378,142.756 233.378,142.996 233.618,142.996 
			233.618,143.236 233.378,143.236 233.378,143.502 233.139,143.502 233.139,143.236 232.872,143.236 232.872,142.996 
			233.139,142.996 233.139,142.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,148.005 237.88,148.005 237.88,148.244 237.641,148.244 
			237.641,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.135,148.51 237.375,148.51 237.375,148.75 237.135,148.75 
			237.135,148.51 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.895,148.244 237.135,148.244 237.135,148.51 236.895,148.51 
			236.895,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.895,149.496 237.135,149.496 237.135,149.764 236.895,149.764 
			236.895,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.135,149.256 237.375,149.256 237.375,149.496 237.135,149.496 
			237.135,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,150.749 236.122,150.749 236.122,151.014 235.882,151.014 
			235.882,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.63,151.014 235.376,151.014 235.376,151.254 234.63,151.254 
			234.63,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.376,150.508 235.643,150.508 235.643,151.014 235.376,151.014 
			235.376,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.643,151.014 236.895,151.014 236.895,151.254 235.643,151.254 
			235.643,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.895,150.241 237.135,150.241 237.135,151.014 236.895,151.014 
			236.895,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,150.001 236.122,150.001 236.122,150.241 235.882,150.241 
			235.882,150.001 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.643,150.241 235.882,150.241 235.882,150.508 235.643,150.508 
			235.643,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.122,150.241 236.389,150.241 236.389,150.508 236.122,150.508 
			236.122,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.389,150.508 236.628,150.508 236.628,151.014 236.389,151.014 
			236.389,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.628,149.496 236.895,149.496 236.895,150.241 236.628,150.241 
			236.628,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.122,149.496 236.389,149.496 236.389,150.001 236.122,150.001 
			236.122,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.643,149.496 235.882,149.496 235.882,149.764 235.643,149.764 
			235.643,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.389,148.244 236.628,148.244 236.628,149.496 236.389,149.496 
			236.389,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,148.99 236.122,148.99 236.122,149.496 235.882,149.496 
			235.882,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.137,148.75 235.882,148.75 235.882,148.99 235.137,148.99 
			235.137,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.63,148.005 234.87,148.005 234.87,148.75 234.63,148.75 
			234.63,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.87,148.244 235.643,148.244 235.643,148.51 234.87,148.51 
			234.87,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.137,147.497 235.376,147.497 235.376,147.737 235.137,147.737 
			235.137,147.497 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,147.497 236.122,147.497 236.122,147.737 235.882,147.737 
			235.882,147.497 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.643,147.258 235.882,147.258 235.882,147.497 235.643,147.497 
			235.643,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.122,147.258 236.389,147.258 236.389,147.497 236.122,147.497 
			236.122,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.882,146.991 236.628,146.991 236.628,147.258 235.882,147.258 
			235.882,146.991 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.628,147.258 236.895,147.258 236.895,148.244 236.628,148.244 
			236.628,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.895,148.75 237.135,148.75 237.135,149.256 236.895,149.256 
			236.895,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.137,149.764 235.643,149.764 235.643,150.001 235.137,150.001 
			235.137,149.764 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.87,150.001 235.137,150.001 235.137,151.014 234.87,151.014 
			234.87,150.001 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.135,147.258 237.375,147.258 237.375,148.244 237.135,148.244 
			237.135,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.366,153.759 232.632,153.759 232.632,153.997 232.366,153.997 
			232.366,153.759 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.126,153.492 232.366,153.492 232.366,153.759 232.126,153.759 
			232.126,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.366,154.504 232.632,154.504 232.632,154.744 232.366,154.744 
			232.366,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.14,155.996 231.38,155.996 231.38,156.263 231.14,156.263 
			231.14,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.635,155.756 230.875,155.756 230.875,156.263 230.635,156.263 
			230.635,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,156.263 232.126,156.263 232.126,156.501 230.875,156.501 
			230.875,156.263 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.126,155.517 232.366,155.517 232.366,156.263 232.126,156.263 
			232.126,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.14,155.25 231.38,155.25 231.38,155.517 231.14,155.517 
			231.14,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,155.517 231.14,155.517 231.14,155.756 230.875,155.756 
			230.875,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.38,155.517 231.62,155.517 231.62,155.756 231.38,155.756 
			231.38,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.62,155.756 231.887,155.756 231.887,156.263 231.62,156.263 
			231.62,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.38,154.744 231.62,154.744 231.62,155.25 231.38,155.25 
			231.38,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,154.744 231.14,154.744 231.14,155.01 230.875,155.01 
			230.875,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.62,153.492 231.887,153.492 231.887,154.744 231.62,154.744 
			231.62,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.14,154.264 231.38,154.264 231.38,154.744 231.14,154.744 
			231.14,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.368,153.997 231.14,153.997 231.14,154.264 230.368,154.264 
			230.368,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.622,153.997 229.889,153.997 229.889,154.264 229.622,154.264 
			229.622,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.116,154.264 230.368,154.264 230.368,154.504 229.116,154.504 
			229.116,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.116,153.759 229.382,153.759 229.382,154.264 229.116,154.264 
			229.116,153.759 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.876,153.997 229.116,153.997 229.116,154.264 228.876,154.264 
			228.876,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.889,153.252 230.128,153.252 230.128,153.997 229.889,153.997 
			229.889,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.382,152.507 229.622,152.507 229.622,152.746 229.382,152.746 
			229.382,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.889,152.239 230.128,152.239 230.128,152.507 229.889,152.507 
			229.889,152.239 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.622,152.239 229.889,152.239 229.889,153.252 229.622,153.252 
			229.622,152.239 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.128,153.492 230.875,153.492 230.875,153.759 230.128,153.759 
			230.128,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.635,153.013 230.875,153.013 230.875,153.252 230.635,153.252 
			230.635,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,153.013 231.14,153.013 231.14,153.492 230.875,153.492 
			230.875,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.368,152.746 230.635,152.746 230.635,153.013 230.368,153.013 
			230.368,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.14,152.746 231.38,152.746 231.38,153.013 231.14,153.013 
			231.14,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.875,152.507 231.14,152.507 231.14,152.746 230.875,152.746 
			230.875,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.38,152.507 231.62,152.507 231.62,152.746 231.38,152.746 
			231.38,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.14,152.268 231.887,152.268 231.887,152.507 231.14,152.507 
			231.14,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.126,153.997 232.366,153.997 232.366,154.504 232.126,154.504 
			232.126,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.368,155.01 230.875,155.01 230.875,155.25 230.368,155.25 
			230.368,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.128,155.25 230.368,155.25 230.368,156.263 230.128,156.263 
			230.128,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.887,154.744 232.366,154.744 232.366,155.01 231.887,155.01 
			231.887,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.887,155.01 232.126,155.01 232.126,155.517 231.887,155.517 
			231.887,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.382,156.263 230.635,156.263 230.635,156.501 229.382,156.501 
			229.382,156.263 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.622,155.996 229.889,155.996 229.889,156.263 229.622,156.263 
			229.622,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.889,157.009 232.632,157.009 232.632,157.247 229.889,157.247 
			229.889,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.885,157.009 236.628,157.009 236.628,157.247 233.885,157.247 
			233.885,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.37,152 228.637,152 228.637,155.756 228.37,155.756 228.37,152 		
			"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,152 238.147,152 238.147,155.756 237.88,155.756 237.88,152 		
			"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.366,153.252 233.139,153.252 233.139,153.492 232.366,153.492 
			232.366,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.378,153.252 234.124,153.252 234.124,153.492 233.378,153.492 
			233.378,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.37,148.99 228.637,148.99 228.637,151.76 228.37,151.76 
			228.37,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.87,145.232 235.376,145.232 235.376,144.994 235.643,144.994 
			235.643,145.232 235.882,145.232 235.882,145.5 235.643,145.5 235.643,145.74 235.376,145.74 235.376,145.5 234.87,145.5 
			234.87,145.232 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.628,145.232 237.135,145.232 237.135,145.74 236.895,145.74 
			236.895,145.5 236.628,145.5 236.628,145.232 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.895,144.754 237.375,144.754 237.375,145.232 237.135,145.232 
			237.135,144.994 236.895,144.994 236.895,144.754 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.868,146.751 224.107,146.751 224.107,146.991 223.868,146.991 
			223.868,146.751 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.36,146.751 225.625,146.751 225.625,147.497 225.36,147.497 
			225.36,146.751 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.36,147.737 225.625,147.737 225.625,148.005 225.36,148.005 
			225.36,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.373,147.737 226.613,147.737 226.613,148.005 226.373,148.005 
			226.373,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.132,148.005 226.373,148.005 226.373,148.51 226.132,148.51 
			226.132,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.613,148.99 226.878,148.99 226.878,149.496 226.613,149.496 
			226.613,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.118,148.99 227.384,148.99 227.384,149.256 227.118,149.256 
			227.118,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.384,148.75 227.864,148.75 227.864,148.99 227.384,148.99 
			227.384,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.864,148.005 228.13,148.005 228.13,148.75 227.864,148.75 
			227.864,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.12,146.006 225.12,145.74 224.881,145.74 224.881,146.006 
			225.12,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.625,144.994 225.865,144.994 225.865,145.232 225.625,145.232 
			225.625,144.994 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.107,144.754 224.613,144.754 224.613,144.994 224.107,144.994 
			224.107,144.754 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.868,144.994 224.107,144.994 224.107,145.232 223.868,145.232 
			223.868,144.994 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,146.991 223.628,146.991 223.628,147.258 223.362,147.258 
			223.362,146.991 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.628,147.258 223.868,147.258 223.868,148.005 223.628,148.005 
			223.628,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,148.99 223.628,148.99 223.628,149.496 223.362,149.496 
			223.362,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.628,149.496 223.868,149.496 223.868,150.241 223.628,150.241 
			223.628,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.628,150.508 223.868,150.508 223.868,151.254 223.628,151.254 
			223.628,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,150.241 223.628,150.241 223.628,150.749 223.362,150.749 
			223.362,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,151.254 223.628,151.254 223.628,151.494 223.362,151.494 
			223.362,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,152.268 223.628,152.268 223.628,152.507 223.362,152.507 
			223.362,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.122,151.494 223.362,151.494 223.362,151.76 223.122,151.76 
			223.122,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.628,151.76 223.868,151.76 223.868,152.268 223.628,152.268 
			223.628,151.76 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.122,152.507 223.362,152.507 223.362,152.746 223.122,152.746 
			223.122,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.856,151.76 223.122,151.76 223.122,152 222.856,152 222.856,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.616,152 222.882,152 222.882,152.268 222.616,152.268 222.616,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.376,152.268 222.616,152.268 222.616,152.507 222.376,152.507 
			222.376,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.11,152.507 222.376,152.507 222.376,152.746 222.11,152.746 
			222.11,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.87,152.746 222.11,152.746 222.11,153.013 221.87,153.013 
			221.87,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.376,153.013 222.616,153.013 222.616,153.252 222.376,153.252 
			222.376,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.616,152.746 223.122,152.746 223.122,153.013 222.616,153.013 
			222.616,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.63,153.013 221.87,153.013 221.87,153.252 221.63,153.252 
			221.63,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.364,153.252 221.63,153.252 221.63,153.519 221.364,153.519 
			221.364,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,153.492 221.364,153.492 221.364,153.759 220.112,153.759 
			220.112,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.605,153.492 219.872,153.492 219.872,153.759 219.605,153.759 
			219.605,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.872,153.759 220.112,153.759 220.112,153.997 219.872,153.997 
			219.872,153.759 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.872,152.507 220.112,152.507 220.112,153.519 219.872,153.519 
			219.872,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.365,152.507 219.605,152.507 219.605,153.519 219.365,153.519 
			219.365,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.872,155.996 220.112,155.996 220.112,156.501 219.872,156.501 
			219.872,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.605,152.268 219.872,152.268 219.872,152.507 219.605,152.507 
			219.605,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,152.268 220.378,152.268 220.378,152.507 220.112,152.507 
			220.112,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,151.76 220.378,151.76 220.378,152 220.112,152 220.112,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="219.872,152 220.112,152 220.112,152.268 219.872,152.268 219.872,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,152 220.618,152 220.618,152.268 220.378,152.268 220.378,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,151.494 220.618,151.494 220.618,151.76 220.378,151.76 
			220.378,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.618,151.76 220.858,151.76 220.858,152 220.618,152 220.618,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,151.014 220.378,151.014 220.378,151.494 220.112,151.494 
			220.112,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.858,152 221.364,152 221.364,152.268 220.858,152.268 220.858,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.364,151.76 221.87,151.76 221.87,152 221.364,152 221.364,151.76 		
			"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.87,150.241 222.11,150.241 222.11,150.508 221.87,150.508 
			221.87,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.63,149.256 221.87,149.256 221.87,150.749 221.63,150.749 
			221.63,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,150.241 220.618,150.241 220.618,150.508 220.378,150.508 
			220.378,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.618,149.256 221.124,149.256 221.124,149.496 220.618,149.496 
			220.618,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,148.005 220.618,148.005 220.618,149.256 220.378,149.256 
			220.378,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.858,148.244 221.124,148.244 221.124,148.75 220.858,148.75 
			220.858,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.364,147.737 221.63,147.737 221.63,148.51 221.364,148.51 
			221.364,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.858,147.497 221.124,147.497 221.124,147.737 220.858,147.737 
			220.858,147.497 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.618,147.737 220.858,147.737 220.858,148.005 220.618,148.005 
			220.618,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,153.997 220.378,153.997 220.378,154.504 220.112,154.504 
			220.112,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,154.504 220.618,154.504 220.618,154.744 220.378,154.744 
			220.378,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.618,154.264 221.124,154.264 221.124,154.504 220.618,154.504 
			220.618,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.858,155.01 221.124,155.01 221.124,155.25 220.858,155.25 
			220.858,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.124,153.997 221.364,153.997 221.364,154.264 221.124,154.264 
			221.124,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.124,154.504 221.364,154.504 221.364,155.01 221.124,155.01 
			221.124,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,155.25 220.858,155.25 220.858,155.517 220.378,155.517 
			220.378,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.124,155.25 221.63,155.25 221.63,155.517 221.124,155.517 
			221.124,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.858,155.517 221.124,155.517 221.124,155.756 220.858,155.756 
			220.858,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.618,155.756 220.858,155.756 220.858,156.263 220.618,156.263 
			220.618,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,155.517 220.378,155.517 220.378,155.996 220.112,155.996 
			220.112,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.107,150.241 224.374,150.241 224.374,150.508 224.107,150.508 
			224.107,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.613,150.749 224.881,150.749 224.881,151.014 224.613,151.014 
			224.613,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.374,151.014 224.613,151.014 224.613,151.254 224.374,151.254 
			224.374,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.881,150.508 225.12,150.508 225.12,150.749 224.881,150.749 
			224.881,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.374,150.508 224.613,150.508 224.613,150.749 224.374,150.749 
			224.374,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.112,156.501 220.378,156.501 220.378,156.768 220.112,156.768 
			220.112,156.501 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.378,156.768 220.618,156.768 220.618,157.515 220.378,157.515 
			220.378,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="220.618,157.515 220.858,157.515 220.858,157.755 220.618,157.755 
			220.618,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.11,157.515 221.87,157.515 221.87,157.247 222.882,157.247 
			222.882,157.515 222.376,157.515 222.376,157.755 222.882,157.755 222.882,158.021 220.858,158.021 220.858,157.755 
			222.11,157.755 222.11,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.63,157.009 221.87,157.009 221.87,157.247 221.63,157.247 
			221.63,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.364,156.263 221.63,156.263 221.63,157.009 221.364,157.009 
			221.364,156.263 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.63,155.996 221.87,155.996 221.87,156.263 221.63,156.263 
			221.63,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.87,155.756 222.376,155.756 222.376,155.996 221.87,155.996 
			221.87,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.376,155.517 222.616,155.517 222.616,155.756 222.376,155.756 
			222.376,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.856,157.515 223.122,157.515 223.122,157.755 222.856,157.755 
			222.856,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.122,157.755 223.362,157.755 223.362,158.021 223.122,158.021 
			223.122,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.856,157.009 223.362,157.009 223.362,157.247 222.856,157.247 
			222.856,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.616,155.25 222.882,155.25 222.882,155.517 222.616,155.517 
			222.616,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.856,155.517 223.868,155.517 223.868,155.756 222.856,155.756 
			222.856,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.107,154.264 224.374,154.264 224.374,154.504 224.107,154.504 
			224.107,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.868,155.756 224.107,155.756 224.107,155.996 223.868,155.996 
			223.868,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.868,155.25 224.107,155.25 224.107,155.517 223.868,155.517 
			223.868,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,155.01 223.868,155.01 223.868,155.25 223.362,155.25 
			223.362,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.616,154.264 222.882,154.264 222.882,154.744 222.616,154.744 
			222.616,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.376,153.997 222.616,153.997 222.616,154.264 222.376,154.264 
			222.376,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.63,155.01 221.87,155.01 221.87,155.25 221.63,155.25 
			221.63,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.374,154.504 224.613,154.504 224.613,154.744 224.374,154.744 
			224.374,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.881,155.25 225.12,155.25 225.12,155.517 224.881,155.517 
			224.881,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.613,154.744 224.881,154.744 224.881,155.25 224.613,155.25 
			224.613,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.12,155.517 225.36,155.517 225.36,155.756 225.12,155.756 
			225.12,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.36,155.756 225.625,155.756 225.625,155.996 225.36,155.996 
			225.36,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.625,155.996 225.865,155.996 225.865,156.501 225.625,156.501 
			225.625,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.36,156.501 225.625,156.501 225.625,156.768 225.36,156.768 
			225.36,156.501 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.132,157.515 226.373,157.515 226.373,157.755 226.132,157.755 
			226.132,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,157.755 228.876,157.755 228.876,158.021 228.637,158.021 
			228.637,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.37,157.515 228.637,157.515 228.637,157.755 228.37,157.755 
			228.37,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.876,157.247 229.116,157.247 229.116,157.755 228.876,157.755 
			228.876,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.37,157.009 228.876,157.009 228.876,157.247 228.37,157.247 
			228.37,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.116,157.247 229.382,157.247 229.382,157.515 229.116,157.515 
			229.116,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.384,157.009 227.625,157.009 227.625,157.247 227.384,157.247 
			227.384,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.625,157.247 227.864,157.247 227.864,157.755 227.625,157.755 
			227.625,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.118,156.768 227.384,156.768 227.384,157.009 227.118,157.009 
			227.118,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.132,155.996 226.373,155.996 226.373,156.768 226.132,156.768 
			226.132,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.878,155.25 227.118,155.25 227.118,156.768 226.878,156.768 
			226.878,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.118,155.01 227.384,155.01 227.384,155.25 227.118,155.25 
			227.118,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.384,155.25 227.864,155.25 227.864,155.517 227.384,155.517 
			227.384,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.864,154.744 228.13,154.744 228.13,155.756 227.864,155.756 
			227.864,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.384,154.504 227.864,154.504 227.864,154.744 227.384,154.744 
			227.384,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.373,153.997 226.613,153.997 226.613,154.264 226.373,154.264 
			226.373,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.613,154.264 227.384,154.264 227.384,154.504 226.613,154.504 
			226.613,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.878,154.264 226.613,154.264 226.613,154.504 226.878,154.504 
			226.878,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.865,153.759 226.373,153.759 226.373,153.997 225.865,153.997 
			225.865,153.759 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.625,153.492 225.865,153.492 225.865,153.759 225.625,153.759 
			225.625,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.12,153.252 225.625,153.252 225.625,153.519 225.12,153.519 
			225.12,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.132,152 226.613,152 226.613,152.268 226.132,152.268 226.132,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.613,152.268 226.878,152.268 226.878,152.507 226.613,152.507 
			226.613,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.878,152 227.118,152 227.118,152.268 226.878,152.268 226.878,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.118,152.268 228.13,152.268 228.13,152.507 227.118,152.507 
			227.118,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.13,152 228.37,152 228.37,152.268 228.13,152.268 228.13,152 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.13,152.507 228.37,152.507 228.37,152.746 228.13,152.746 
			228.13,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.36,150.241 225.12,150.241 225.12,150.508 225.36,150.508 
			225.36,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.625,151.254 225.865,151.254 225.865,151.494 225.625,151.494 
			225.625,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.132,150.241 226.373,150.241 226.373,150.508 226.132,150.508 
			226.132,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.12,148.99 225.625,148.99 225.625,149.256 225.12,149.256 
			225.12,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.373,150.508 226.613,150.508 226.613,150.749 226.373,150.749 
			226.373,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.613,150.749 227.118,150.749 227.118,151.014 226.613,151.014 
			226.613,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.118,151.014 227.384,151.014 227.384,151.254 227.118,151.254 
			227.118,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.864,151.014 228.13,151.014 228.13,151.76 227.864,151.76 
			227.864,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.384,151.254 227.625,151.254 227.625,151.494 227.384,151.494 
			227.384,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.625,151.494 227.864,151.494 227.864,151.76 227.625,151.76 
			227.625,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.13,150.749 228.37,150.749 228.37,151.014 228.13,151.014 
			228.13,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.13,149.764 228.37,149.764 228.37,150.001 228.13,150.001 
			228.13,149.764 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.13,149.256 228.37,149.256 228.37,149.496 228.13,149.496 
			228.13,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.613,150.001 227.118,150.001 227.118,150.241 227.384,150.241 
			227.384,150.508 226.613,150.508 226.613,150.001 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.118,149.764 227.625,149.764 227.625,150.001 227.118,150.001 
			227.118,149.764 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.625,149.496 228.13,149.496 228.13,149.764 227.625,149.764 
			227.625,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.373,148.75 226.878,148.75 226.878,148.99 227.118,148.99 
			227.118,148.244 226.878,148.244 226.878,148.51 226.373,148.51 226.373,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="226.132,149.256 226.132,149.496 225.865,149.496 225.865,150.001 
			226.132,150.001 226.132,150.241 225.625,150.241 225.625,149.256 226.132,149.256 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M225.12,146.991v0.506h0.24v0.24h-0.24v0.268h-0.239v0.239h-0.507v-0.239h-0.267
			v-1.014H225.12L225.12,146.991z M224.613,148.005h0.268v-0.508h-0.268v-0.239h-0.239v0.479h0.239V148.005L224.613,148.005z"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.868,157.247 223.868,157.515 224.107,157.515 224.107,158.021 
			223.628,158.021 223.628,157.755 223.362,157.755 223.362,157.247 223.868,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.622,157.515 229.622,158.021 229.116,158.021 229.116,157.755 
			229.382,157.755 229.382,157.515 229.622,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.124,148.75 221.63,148.75 221.63,148.51 221.87,148.51 
			221.87,148.99 221.63,148.99 221.63,149.256 221.364,149.256 221.364,148.99 221.124,148.99 221.124,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="221.87,146.751 221.63,146.751 221.63,147.258 221.124,147.258 
			221.124,147.497 221.63,147.497 221.63,147.737 221.87,147.737 221.87,146.751 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,145.232 223.868,145.232 223.868,145.5 223.628,145.5 
			223.628,145.74 223.362,145.74 223.362,146.991 223.122,146.991 223.122,145.74 222.856,145.74 222.856,145.5 223.362,145.5 
			223.362,145.232 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.107,146.006 224.107,146.246 223.868,146.246 223.868,146.486 
			223.628,146.486 223.628,146.006 224.107,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.107,148.75 224.107,149.256 223.868,149.256 223.868,148.99 
			223.628,148.99 223.628,148.75 224.107,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.12,150.241 225.625,150.241 225.625,150.749 225.36,150.749 
			225.36,150.508 225.12,150.508 225.12,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.865,145.5 225.865,146.006 225.625,146.006 225.625,145.74 
			225.36,145.74 225.36,145.5 224.881,145.5 224.881,145.232 224.613,145.232 224.613,144.994 225.12,144.994 225.12,145.232 
			225.625,145.232 225.625,145.5 225.865,145.5 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.12,145.74 225.12,146.246 224.613,146.246 224.613,146.751 
			224.107,146.751 224.107,146.486 224.374,146.486 224.374,146.246 224.613,146.246 224.613,146.006 224.881,146.006 
			224.881,145.74 225.12,145.74 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,155.01 245.633,155.01 245.633,155.25 245.393,155.25 
			245.393,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="227.864,157.247 228.37,157.247 228.37,157.515 227.864,157.515 
			227.864,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.37,142.489 229.116,142.489 229.116,142.756 229.382,142.756 
			229.382,143.236 229.622,143.236 229.622,143.502 229.889,143.502 229.889,144.008 229.622,144.008 229.622,144.247 
			229.382,144.247 229.382,144.008 229.622,144.008 229.622,143.502 229.116,143.502 229.116,142.756 228.637,142.756 
			228.637,142.996 228.876,142.996 228.876,143.502 229.116,143.502 229.116,144.247 228.876,144.247 228.876,143.502 
			228.637,143.502 228.637,142.996 228.37,142.996 228.37,142.489 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.128,142.756 230.368,142.756 230.368,143.502 230.635,143.502 
			230.635,143.742 230.128,143.742 230.128,142.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.635,142.249 231.38,142.249 231.38,142.489 230.635,142.489 
			230.635,142.249 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.116,144.754 229.622,144.754 229.622,144.994 229.382,144.994 
			229.382,145.232 229.116,145.232 229.116,144.754 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="229.382,145.232 229.889,145.232 229.889,145.5 229.622,145.5 
			229.622,145.74 229.382,145.74 229.382,145.232 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.366,143.742 232.872,143.742 232.872,144.008 232.366,144.008 
			232.366,143.742 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="232.392,142.249 232.872,142.249 232.872,142.489 232.632,142.489 
			232.632,142.996 232.392,142.996 232.392,142.249 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.618,142.249 234.124,142.249 234.124,142.756 234.391,142.756 
			234.391,143.742 234.124,143.742 234.124,142.996 233.885,142.996 233.885,142.489 233.618,142.489 233.618,142.249 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.618,143.742 234.124,143.742 234.124,144.008 233.618,144.008 
			233.618,143.742 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.137,142.249 235.882,142.249 235.882,142.489 235.137,142.489 
			235.137,142.249 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.389,142.756 236.122,142.756 236.122,143.502 235.882,143.502 
			235.882,143.742 236.389,143.742 236.389,142.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.147,142.489 237.375,142.489 237.375,142.756 237.135,142.756 
			237.135,143.236 236.895,143.236 236.895,143.502 236.628,143.502 236.628,144.008 236.895,144.008 236.895,144.247 
			237.135,144.247 237.135,144.008 236.895,144.008 236.895,143.502 237.375,143.502 237.375,142.756 237.88,142.756 
			237.88,142.996 237.641,142.996 237.641,143.502 237.375,143.502 237.375,144.247 237.641,144.247 237.641,143.502 
			237.88,143.502 237.88,142.996 238.147,142.996 238.147,142.489 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="224.613,151.494 224.881,151.494 224.881,151.76 225.865,151.76 
			225.865,151.494 226.132,151.494 226.132,152 224.613,152 224.613,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,153.997 223.362,155.01 222.856,155.01 222.882,154.744 
			223.122,154.744 223.122,153.997 223.362,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.625,156.768 226.132,156.768 226.132,157.515 225.865,157.515 
			225.865,157.009 225.625,157.009 225.625,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,152.746 223.868,152.746 223.868,152.507 224.107,152.507 
			224.107,152.268 224.374,152.268 224.374,152 224.613,152 224.613,152.268 224.881,152.268 224.881,152.507 224.374,152.507 
			224.374,153.013 225.12,153.013 225.12,153.252 224.374,153.252 224.374,153.013 223.868,153.013 223.868,153.252 
			223.628,153.252 223.628,153.759 223.868,153.759 223.868,153.997 224.107,153.997 224.107,154.264 223.628,154.264 
			223.628,153.997 223.362,153.997 223.362,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="222.11,150.508 222.376,150.508 222.376,151.494 222.11,151.494 
			222.11,151.76 221.87,151.76 221.87,151.494 221.63,151.494 221.63,151.254 222.11,151.254 222.11,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="223.362,147.258 223.122,147.258 223.122,148.99 223.362,148.99 
			223.362,148.75 223.628,148.75 223.628,148.51 223.362,148.51 223.362,148.244 223.628,148.244 223.628,148.005 223.362,148.005 
			223.362,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="225.625,146.486 225.865,146.513 225.865,146.006 226.132,146.006 
			226.132,147.258 226.373,147.258 226.373,147.737 226.132,147.737 226.132,147.497 225.865,147.497 225.865,146.751 
			225.625,146.751 225.625,146.486 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="230.635,143.742 231.38,143.742 231.38,143.502 231.62,143.502 
			231.62,142.729 231.887,142.729 231.887,143.742 231.62,143.742 231.62,144.008 231.887,144.008 231.887,144.247 232.126,144.247 
			232.126,144.008 232.366,144.008 232.392,144.247 234.124,144.247 234.124,144.008 234.391,144.008 234.391,144.247 
			234.63,144.247 234.63,144.008 234.87,144.008 234.87,143.742 234.63,143.742 234.63,142.756 234.87,142.756 234.87,143.502 
			235.137,143.502 235.137,143.742 235.882,143.742 235.882,144.008 235.137,144.008 235.137,144.247 234.897,144.247 
			234.87,144.487 231.62,144.487 231.62,144.247 231.38,144.247 231.38,144.008 230.635,144.008 230.635,143.742 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="234.87,146.991 234.391,146.991 234.391,147.258 234.124,147.258 
			234.124,147.497 234.391,147.497 234.391,148.005 234.63,148.005 234.63,147.258 234.87,147.258 234.87,146.991 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.885,148.51 234.124,148.51 234.124,149.017 234.391,148.99 
			234.391,148.75 234.63,148.75 234.63,149.017 235.137,148.99 235.137,149.256 233.885,149.256 233.885,148.99 233.618,148.99 
			233.618,148.75 233.885,148.75 233.885,148.51 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="235.376,147.737 235.376,148.005 235.643,148.005 235.643,148.244 
			235.882,148.244 235.882,147.737 235.376,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.13,148.005 228.637,148.005 228.637,146.751 233.139,146.751 
			233.139,150.241 233.378,150.241 233.378,146.751 237.88,146.751 237.88,148.005 238.387,148.005 238.387,147.737 238.12,147.737 
			238.147,146.486 236.389,146.486 236.389,146.246 235.882,146.246 235.882,146.486 230.635,146.486 230.635,146.246 
			230.128,146.246 230.128,146.486 228.37,146.486 228.37,147.737 228.13,147.737 228.13,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,148.51 228.876,148.51 228.876,148.75 230.368,148.75 
			230.368,146.751 230.635,146.751 230.635,148.99 228.637,148.99 228.637,148.51 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="228.637,149.496 230.635,149.496 230.635,151.76 230.368,151.76 
			230.368,149.735 228.637,149.764 228.637,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,149.496 231.14,149.496 231.14,151.76 231.38,151.76 
			231.38,149.735 233.139,149.764 233.139,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.139,148.99 231.14,148.99 231.14,146.751 231.38,146.751 
			231.38,148.75 233.139,148.75 233.139,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="231.887,153.492 232.126,153.492 232.126,150.508 234.391,150.508 
			234.391,152.746 234.124,152.746 234.124,153.252 234.391,153.252 234.391,153.013 234.63,153.013 234.63,150.241 
			231.887,150.241 231.887,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.378,154.771 235.376,154.771 235.376,157.009 235.137,157.009 
			235.137,155.01 233.378,155.01 233.378,154.771 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,154.771 235.882,154.771 235.882,157.009 236.122,157.009 
			236.122,155.01 237.88,155.01 237.88,154.771 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,154.264 235.882,154.264 235.882,152 236.122,152 
			236.122,153.997 237.88,153.997 237.88,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="233.378,154.264 235.403,154.264 235.403,152 235.137,152 
			235.137,153.997 233.378,153.997 233.378,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,149.496 245.126,149.496 245.126,150.749 244.887,150.749 
			244.887,151.014 246.139,151.014 246.139,150.749 245.393,150.749 245.393,150.241 245.899,150.241 245.899,150.001 
			245.393,150.001 245.393,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.126,153.492 246.378,153.492 246.378,153.759 245.126,153.759 
			245.126,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.645,153.492 246.885,153.492 246.885,153.759 246.645,153.759 
			246.645,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.378,153.759 246.645,153.759 246.645,153.997 246.378,153.997 
			246.378,153.759 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.378,152.507 246.645,152.507 246.645,153.519 246.378,153.519 
			246.378,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.885,152.507 247.151,152.507 247.151,153.519 246.885,153.519 
			246.885,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.645,152.268 246.885,152.268 246.885,152.507 246.645,152.507 
			246.645,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.139,152.268 246.378,152.268 246.378,152.507 246.139,152.507 
			246.139,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.139,151.76 246.378,151.76 246.378,152 246.139,152 246.139,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.378,152 246.645,152 246.645,152.268 246.378,152.268 246.378,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.899,152 246.139,152 246.139,152.268 245.899,152.268 245.899,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.899,151.494 246.139,151.494 246.139,151.76 245.899,151.76 
			245.899,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.633,151.76 245.899,151.76 245.899,152 245.633,152 245.633,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.139,151.014 246.378,151.014 246.378,151.494 246.139,151.494 
			246.139,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.126,152 245.633,152 245.633,152.268 245.126,152.268 245.126,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,151.76 245.126,151.76 245.126,152 244.647,152 244.647,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.381,150.241 244.647,150.241 244.647,150.508 244.381,150.508 
			244.381,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,149.256 244.887,149.256 244.887,150.749 244.647,150.749 
			244.647,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.899,150.241 246.139,150.241 246.139,150.508 245.899,150.508 
			245.899,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,149.256 245.899,149.256 245.899,149.496 245.393,149.496 
			245.393,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.899,148.005 246.139,148.005 246.139,149.256 245.899,149.256 
			245.899,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,148.244 245.633,148.244 245.633,148.75 245.393,148.75 
			245.393,148.244 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.887,147.737 245.126,147.737 245.126,148.51 244.887,148.51 
			244.887,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,147.497 245.633,147.497 245.633,147.737 245.393,147.737 
			245.393,147.497 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.633,147.737 245.899,147.737 245.899,148.005 245.633,148.005 
			245.633,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.139,153.997 246.378,153.997 246.378,154.504 246.139,154.504 
			246.139,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.899,154.504 246.139,154.504 246.139,154.744 245.899,154.744 
			245.899,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,154.264 245.899,154.264 245.899,154.504 245.393,154.504 
			245.393,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,148.75 244.887,148.75 244.887,148.51 244.647,148.51 
			244.647,148.99 244.887,148.99 244.887,149.256 245.126,149.256 245.126,148.99 245.393,148.99 245.393,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,146.751 244.887,146.751 244.887,147.258 245.393,147.258 
			245.393,147.497 244.887,147.497 244.887,147.737 244.647,147.737 244.647,146.751 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.381,150.508 244.141,150.508 244.141,151.494 244.381,151.494 
			244.381,151.76 244.647,151.76 244.647,151.494 244.887,151.494 244.887,151.254 244.381,151.254 244.381,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,157.755 240.146,157.755 240.146,158.021 238.12,158.021 
			238.12,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.382,146.751 242.622,146.751 242.622,146.991 242.382,146.991 
			242.382,146.751 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,146.751 241.131,146.751 241.131,147.497 240.891,147.497 
			240.891,146.751 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,147.737 241.131,147.737 241.131,148.005 240.891,148.005 
			240.891,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.878,147.737 240.146,147.737 240.146,148.005 239.878,148.005 
			239.878,147.737 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.119,148.005 240.385,148.005 240.385,148.51 240.119,148.51 
			240.119,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.639,148.99 239.878,148.99 239.878,149.496 239.639,149.496 
			239.639,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.132,148.99 239.372,148.99 239.372,149.256 239.132,149.256 
			239.132,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.626,148.75 239.132,148.75 239.132,148.99 238.626,148.99 
			238.626,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.387,148.005 238.626,148.005 238.626,148.75 238.387,148.75 
			238.387,148.005 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.37,146.006 241.37,145.74 241.637,145.74 241.637,146.006 
			241.37,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.624,144.994 240.891,144.994 240.891,145.232 240.624,145.232 
			240.624,144.994 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.877,144.754 242.382,144.754 242.382,144.994 241.877,144.994 
			241.877,144.754 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.382,144.994 242.622,144.994 242.622,145.232 242.382,145.232 
			242.382,144.994 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.889,146.991 243.129,146.991 243.129,147.258 242.889,147.258 
			242.889,146.991 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,147.258 242.889,147.258 242.889,148.005 242.622,148.005 
			242.622,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.889,148.99 243.129,148.99 243.129,149.496 242.889,149.496 
			242.889,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,149.496 242.889,149.496 242.889,150.241 242.622,150.241 
			242.622,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,150.508 242.889,150.508 242.889,151.254 242.622,151.254 
			242.622,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.889,150.241 243.129,150.241 243.129,150.749 242.889,150.749 
			242.889,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.889,151.254 243.129,151.254 243.129,151.494 242.889,151.494 
			242.889,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.889,152.268 243.129,152.268 243.129,152.507 242.889,152.507 
			242.889,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,151.494 243.396,151.494 243.396,151.76 243.129,151.76 
			243.129,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,151.76 242.889,151.76 242.889,152.268 242.622,152.268 
			242.622,151.76 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,152.507 243.396,152.507 243.396,152.746 243.129,152.746 
			243.129,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.396,151.76 243.634,151.76 243.634,152 243.396,152 243.396,151.76 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.634,152 243.874,152 243.874,152.268 243.634,152.268 243.634,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.874,152.268 244.141,152.268 244.141,152.507 243.874,152.507 
			243.874,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.141,152.507 244.381,152.507 244.381,152.746 244.141,152.746 
			244.141,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.381,152.746 244.647,152.746 244.647,153.013 244.381,153.013 
			244.381,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.874,153.013 244.141,153.013 244.141,153.252 243.874,153.252 
			243.874,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.396,152.746 243.874,152.746 243.874,153.013 243.396,153.013 
			243.396,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,153.013 244.887,153.013 244.887,153.252 244.647,153.252 
			244.647,153.013 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.887,153.252 245.126,153.252 245.126,153.519 244.887,153.519 
			244.887,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.378,155.996 246.645,155.996 246.645,156.501 246.378,156.501 
			246.378,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,155.01 245.633,155.01 245.633,155.25 245.393,155.25 
			245.393,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.126,153.997 245.393,153.997 245.393,154.264 245.126,154.264 
			245.126,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.126,154.504 245.393,154.504 245.393,155.01 245.126,155.01 
			245.126,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.633,155.25 246.139,155.25 246.139,155.517 245.633,155.517 
			245.633,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.887,155.25 245.393,155.25 245.393,155.517 244.887,155.517 
			244.887,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.393,155.517 245.633,155.517 245.633,155.756 245.393,155.756 
			245.393,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.633,155.756 245.899,155.756 245.899,156.263 245.633,156.263 
			245.633,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.139,155.517 246.378,155.517 246.378,155.996 246.139,155.996 
			246.139,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.142,150.241 242.382,150.241 242.382,150.508 242.142,150.508 
			242.142,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.637,150.749 241.877,150.749 241.877,151.014 241.637,151.014 
			241.637,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.877,151.014 242.142,151.014 242.142,151.254 241.877,151.254 
			241.877,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.37,150.508 241.637,150.508 241.637,150.749 241.37,150.749 
			241.37,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.877,150.508 242.142,150.508 242.142,150.749 241.877,150.749 
			241.877,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="246.139,156.501 246.378,156.501 246.378,156.768 246.139,156.768 
			246.139,156.501 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.899,156.768 246.139,156.768 246.139,157.515 245.899,157.515 
			245.899,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.381,157.515 244.647,157.515 244.647,157.247 243.634,157.247 
			243.634,157.515 244.141,157.515 244.141,157.755 243.634,157.755 243.634,158.021 245.633,158.021 245.633,157.755 
			244.381,157.755 244.381,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,157.009 244.887,157.009 244.887,157.247 244.647,157.247 
			244.647,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.887,156.263 245.126,156.263 245.126,157.009 244.887,157.009 
			244.887,156.263 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,155.996 244.887,155.996 244.887,156.263 244.647,156.263 
			244.647,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.141,155.756 244.647,155.756 244.647,155.996 244.141,155.996 
			244.141,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.874,155.517 244.141,155.517 244.141,155.756 243.874,155.756 
			243.874,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,157.755 243.396,157.755 243.396,158.021 243.129,158.021 
			243.129,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,157.009 243.634,157.009 243.634,157.247 243.129,157.247 
			243.129,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.634,155.25 243.874,155.25 243.874,155.517 243.634,155.517 
			243.634,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,155.517 243.634,155.517 243.634,155.756 242.622,155.756 
			242.622,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.142,154.264 242.382,154.264 242.382,154.504 242.142,154.504 
			242.142,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.382,155.756 242.622,155.756 242.622,155.996 242.382,155.996 
			242.382,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.382,155.25 242.622,155.25 242.622,155.517 242.382,155.517 
			242.382,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,155.01 243.129,155.01 243.129,155.25 242.622,155.25 
			242.622,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.634,154.264 243.874,154.264 243.874,154.744 243.634,154.744 
			243.634,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.874,153.997 244.141,153.997 244.141,154.264 243.874,154.264 
			243.874,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="244.647,155.01 244.887,155.01 244.887,155.25 244.647,155.25 
			244.647,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.877,154.504 242.142,154.504 242.142,154.744 241.877,154.744 
			241.877,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.37,155.25 241.637,155.25 241.637,155.517 241.37,155.517 
			241.37,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.637,154.744 241.877,154.744 241.877,155.25 241.637,155.25 
			241.637,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.131,155.517 241.37,155.517 241.37,155.756 241.131,155.756 
			241.131,155.517 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,155.756 241.131,155.756 241.131,155.996 240.891,155.996 
			240.891,155.756 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.624,155.996 240.891,155.996 240.891,156.501 240.624,156.501 
			240.624,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,156.501 241.131,156.501 241.131,156.768 240.891,156.768 
			240.891,156.501 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.119,157.515 240.385,157.515 240.385,157.755 240.119,157.755 
			240.119,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,157.755 237.88,157.755 237.88,158.021 237.641,158.021 
			237.641,157.755 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.88,157.515 238.12,157.515 238.12,157.755 237.88,157.755 
			237.88,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.375,157.247 237.641,157.247 237.641,157.755 237.375,157.755 
			237.375,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.641,157.009 238.12,157.009 238.12,157.247 237.641,157.247 
			237.641,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="237.135,157.247 237.375,157.247 237.375,157.515 237.135,157.515 
			237.135,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.892,157.009 239.132,157.009 239.132,157.247 238.892,157.247 
			238.892,157.009 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.626,157.247 238.892,157.247 238.892,157.755 238.626,157.755 
			238.626,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.132,156.768 239.372,156.768 239.372,157.009 239.132,157.009 
			239.132,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.119,155.996 240.385,155.996 240.385,156.768 240.119,156.768 
			240.119,155.996 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.372,155.25 239.639,155.25 239.639,156.768 239.372,156.768 
			239.372,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.132,155.01 239.372,155.01 239.372,155.25 239.132,155.25 
			239.132,155.01 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.626,155.25 239.132,155.25 239.132,155.517 238.626,155.517 
			238.626,155.25 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.387,154.744 238.626,154.744 238.626,155.756 238.387,155.756 
			238.387,154.744 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.626,154.504 239.132,154.504 239.132,154.744 238.626,154.744 
			238.626,154.504 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.878,153.997 240.146,153.997 240.146,154.264 239.878,154.264 
			239.878,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.132,154.264 239.878,154.264 239.878,154.504 239.132,154.504 
			239.132,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.639,154.264 239.878,154.264 239.878,154.504 239.639,154.504 
			239.639,154.264 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.119,153.759 240.624,153.759 240.624,153.997 240.119,153.997 
			240.119,153.759 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.624,153.492 240.891,153.492 240.891,153.759 240.624,153.759 
			240.624,153.492 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,153.252 241.37,153.252 241.37,153.519 240.891,153.519 
			240.891,153.252 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.878,152 240.385,152 240.385,152.268 239.878,152.268 239.878,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.639,152.268 239.878,152.268 239.878,152.507 239.639,152.507 
			239.639,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.372,152 239.639,152 239.639,152.268 239.372,152.268 239.372,152 
					"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.387,152.268 239.372,152.268 239.372,152.507 238.387,152.507 
			238.387,152.268 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,152 238.387,152 238.387,152.268 238.12,152.268 238.12,152 		
			"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,152.507 238.387,152.507 238.387,152.746 238.12,152.746 
			238.12,152.507 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.131,150.241 241.37,150.241 241.37,150.508 241.131,150.508 
			241.131,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.624,151.254 240.891,151.254 240.891,151.494 240.624,151.494 
			240.624,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.119,150.241 240.385,150.241 240.385,150.508 240.119,150.508 
			240.119,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,148.99 241.37,148.99 241.37,149.256 240.891,149.256 
			240.891,148.99 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.878,150.508 240.119,150.508 240.119,150.749 239.878,150.749 
			239.878,150.508 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.372,150.749 239.878,150.749 239.878,151.014 239.372,151.014 
			239.372,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.132,151.014 239.372,151.014 239.372,151.254 239.132,151.254 
			239.132,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.387,151.014 238.626,151.014 238.626,151.76 238.387,151.76 
			238.387,151.014 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.892,151.254 239.132,151.254 239.132,151.494 238.892,151.494 
			238.892,151.254 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.626,151.494 238.892,151.494 238.892,151.76 238.626,151.76 
			238.626,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,150.749 238.387,150.749 238.387,151.014 238.12,151.014 
			238.12,150.749 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,149.764 238.387,149.764 238.387,150.001 238.12,150.001 
			238.12,149.764 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,149.256 238.387,149.256 238.387,149.496 238.12,149.496 
			238.12,149.256 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="239.878,150.001 239.372,150.001 239.372,150.241 239.132,150.241 
			239.132,150.508 239.878,150.508 239.878,150.001 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.892,149.764 239.372,149.764 239.372,150.001 238.892,150.001 
			238.892,149.764 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.387,149.496 238.892,149.496 238.892,149.764 238.387,149.764 
			238.387,149.496 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.146,148.75 239.639,148.75 239.639,148.99 239.372,148.99 
			239.372,148.244 239.639,148.244 239.639,148.51 240.146,148.51 240.146,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.385,149.256 240.385,149.496 240.624,149.496 240.624,150.001 
			240.385,150.001 240.385,150.241 240.891,150.241 240.891,149.256 240.385,149.256 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M242.382,146.991v1.014h-0.24v0.239h-0.505v-0.239h-0.267v-0.268h-0.239v-0.24
			h0.239v-0.506H242.382L242.382,146.991z M241.877,147.737h0.265v-0.479h-0.265v0.239h-0.24v0.508h0.24V147.737L241.877,147.737z"
			/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.622,157.247 242.622,157.515 242.382,157.515 242.382,158.021 
			242.889,158.021 242.889,157.755 243.129,157.755 243.129,157.247 242.622,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="236.868,157.515 236.868,158.021 237.375,158.021 237.375,157.755 
			237.135,157.755 237.135,157.515 236.868,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,145.232 242.622,145.232 242.622,145.5 242.889,145.5 
			242.889,145.74 243.129,145.74 243.129,146.991 243.396,146.991 243.396,145.74 243.634,145.74 243.634,145.5 243.129,145.5 
			243.129,145.232 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.382,146.006 242.382,146.246 242.622,146.246 242.622,146.486 
			242.889,146.486 242.889,146.006 242.382,146.006 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="242.382,148.75 242.382,149.256 242.622,149.256 242.622,148.99 
			242.889,148.99 242.889,148.75 242.382,148.75 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.37,150.241 240.891,150.241 240.891,150.749 241.131,150.749 
			241.131,150.508 241.37,150.508 241.37,150.241 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.624,145.5 240.624,146.006 240.891,146.006 240.891,145.74 
			241.131,145.74 241.131,145.5 241.637,145.5 241.637,145.232 241.877,145.232 241.877,144.994 241.37,144.994 241.37,145.232 
			240.891,145.232 240.891,145.5 240.624,145.5 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.37,145.74 241.37,146.246 241.877,146.246 241.877,146.751 
			242.382,146.751 242.382,146.486 242.142,146.486 242.142,146.246 241.877,146.246 241.877,146.006 241.637,146.006 
			241.637,145.74 241.37,145.74 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="238.12,157.247 238.626,157.247 238.626,157.515 238.12,157.515 
			238.12,157.247 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="241.877,151.494 241.637,151.494 241.637,151.76 240.624,151.76 
			240.624,151.494 240.385,151.494 240.385,152 241.877,152 241.877,151.494 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,153.997 243.129,155.01 243.634,155.01 243.634,154.744 
			243.396,154.744 243.396,153.997 243.129,153.997 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,156.768 240.385,156.768 240.385,157.515 240.624,157.515 
			240.624,157.009 240.891,157.009 240.891,156.768 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,152.746 242.622,152.746 242.622,152.507 242.382,152.507 
			242.382,152.268 242.142,152.268 242.142,152 241.877,152 241.877,152.268 241.637,152.268 241.637,152.507 242.142,152.507 
			242.142,153.013 241.37,153.013 241.37,153.252 242.142,153.252 242.142,153.013 242.622,153.013 242.622,153.252 
			242.889,153.252 242.889,153.759 242.622,153.759 242.622,153.997 242.382,153.997 242.382,154.264 242.889,154.264 
			242.889,153.997 243.129,153.997 243.129,152.746 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.129,147.258 243.396,147.258 243.396,148.99 243.129,148.99 
			243.129,148.75 242.889,148.75 242.889,148.51 243.129,148.51 243.129,148.244 242.889,148.244 242.889,148.005 243.129,148.005 
			243.129,147.258 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="240.891,146.486 240.624,146.513 240.624,146.006 240.385,146.006 
			240.385,147.258 240.119,147.258 240.146,147.737 240.385,147.737 240.385,147.497 240.624,147.497 240.624,146.751 
			240.891,146.751 240.891,146.486 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="245.633,157.515 245.899,157.515 245.899,157.755 245.633,157.755 
			245.633,157.515 		"/>
		<polygon fill-rule="evenodd" clip-rule="evenodd" points="243.396,157.515 243.634,157.515 243.634,157.755 243.396,157.755 
			243.396,157.515 		"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M258.793,153.333c-0.506,0.878-1.252,1.357-2.133,1.357
			c-0.371,0-0.691-0.08-1.012-0.239l-0.426,2.744h-0.826l1.199-7.62l0.852-0.132l-0.346,1.811c0.08-0.16,0.16-0.266,0.213-0.346
			c0.24-0.319,0.506-0.613,0.801-0.853c0.479-0.427,1.092-0.721,1.438-0.721c0.561,0,0.932,0.613,0.932,1.493
			C259.484,151.653,259.244,152.559,258.793,153.333L258.793,153.333z M258.26,150.136c-0.16,0-0.533,0.238-0.932,0.613
			c-0.268,0.265-0.746,0.799-1.014,1.145c-0.213,0.293-0.373,0.665-0.398,0.959l-0.16,0.906c0.293,0.212,0.559,0.293,0.932,0.293
			c1.039,0,1.893-1.413,1.893-3.171C258.58,150.4,258.473,150.136,258.26,150.136L258.26,150.136z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M263.961,150.348c-0.107-0.079-0.188-0.079-0.32-0.079
			c-0.213,0-0.424,0.079-0.666,0.32c-0.398,0.371-0.691,0.825-0.879,1.358c-0.105,0.292-0.266,0.959-0.32,1.331l-0.213,1.253h-0.824
			l0.771-4.956l0.879-0.132l-0.32,1.465c0.613-1.065,1.094-1.492,1.652-1.492c0.24,0,0.373,0.054,0.586,0.159L263.961,150.348
			L263.961,150.348z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M266.279,154.663c-1.014,0-1.68-0.799-1.68-1.996
			c0-1.812,1.227-3.277,2.691-3.277c1.039,0,1.678,0.799,1.678,2.077C268.969,153.198,267.744,154.663,266.279,154.663
			L266.279,154.663z M267.184,150.083c-0.479,0-0.957,0.346-1.305,0.931c-0.268,0.48-0.426,1.065-0.426,1.573
			c0,0.852,0.346,1.41,0.879,1.41c0.984,0,1.783-1.145,1.783-2.53C268.115,150.561,267.797,150.083,267.184,150.083L267.184,150.083
			z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M274.297,150.935c-0.105,0.532-0.295,0.799-1.145,1.732l-0.693,0.798
			c-0.453,0.453-0.666,0.667-1.279,1.198h-0.586v-5.088l0.799-0.132v4.021c0.107-0.132,0.215-0.213,0.268-0.267
			c0.08-0.105,0.373-0.426,0.852-0.931c0.266-0.32,0.48-0.614,0.666-0.828c0.215-0.319,0.346-0.611,0.346-0.958
			c0-0.16-0.025-0.24-0.131-0.426c-0.082-0.135-0.135-0.187-0.268-0.347l0.746-0.266c0.371,0.426,0.48,0.692,0.48,1.117
			C274.352,150.668,274.324,150.801,274.297,150.935L274.297,150.935z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M277.467,147.525c-0.08,0.372-0.32,0.639-0.586,0.639
			c-0.213,0-0.371-0.294-0.371-0.667c0-0.026,0-0.08,0.025-0.133c0.053-0.373,0.32-0.613,0.586-0.613
			c0.213,0,0.373,0.294,0.373,0.64C277.494,147.444,277.494,147.497,277.467,147.525L277.467,147.525z M276.242,154.531h-0.852
			l0.799-4.956l0.852-0.132L276.242,154.531L276.242,154.531z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M283.062,150.694l-0.586,3.837h-0.854l0.586-3.703l0.027-0.239
			c0.027-0.054,0.027-0.107,0.027-0.16c0-0.24-0.082-0.346-0.215-0.346c-0.266,0-0.639,0.265-1.092,0.771
			c-0.398,0.426-0.799,0.905-1.066,1.332c-0.105,0.161-0.186,0.346-0.238,0.48c-0.08,0.211-0.215,0.639-0.24,0.878l-0.16,0.986
			h-0.826l0.773-4.956l0.852-0.132l-0.373,2.023c0.107-0.159,0.186-0.267,0.268-0.347c0.318-0.452,0.531-0.691,0.799-0.959
			c0.531-0.532,1.039-0.798,1.52-0.798c0.584,0,0.85,0.292,0.85,0.905C283.113,150.4,283.088,150.561,283.062,150.694
			L283.062,150.694z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M288.07,150.4c-0.346-0.292-0.561-0.372-0.906-0.372
			c-0.986,0-1.783,1.306-1.783,2.932c0,0.664,0.131,0.932,0.451,0.932c0.453,0,1.066-0.453,1.918-1.385l0.48,0.425
			c-0.934,1.12-1.812,1.679-2.666,1.679c-0.664,0-1.092-0.586-1.092-1.545c0-1.998,1.279-3.702,2.771-3.702
			c0.506,0,0.879,0.133,1.305,0.479L288.07,150.4L288.07,150.4z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M291.453,147.525c-0.08,0.372-0.32,0.639-0.586,0.639
			c-0.213,0-0.373-0.294-0.373-0.667c0-0.026,0-0.08,0-0.133c0.08-0.373,0.32-0.613,0.613-0.613c0.186,0,0.373,0.294,0.373,0.64
			C291.48,147.444,291.48,147.497,291.453,147.525L291.453,147.525z M290.229,154.531h-0.854l0.799-4.956l0.854-0.132
			L290.229,154.531L290.229,154.531z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M295.529,151.28l-2.318,1.438c-0.027,0.107-0.027,0.134-0.027,0.268
			c0,0.611,0.215,0.932,0.588,0.932c0.559,0,1.305-0.532,1.971-1.411l0.479,0.479c-0.959,1.065-1.811,1.624-2.584,1.624
			c-0.879,0-1.303-0.559-1.303-1.65c0-1.946,1.25-3.625,2.717-3.625c0.717,0,1.17,0.374,1.17,0.934
			C296.221,150.694,296.035,150.988,295.529,151.28L295.529,151.28z M294.943,149.976c-0.693,0-1.412,0.853-1.625,1.972l2.078-1.333
			c0.053-0.079,0.053-0.159,0.053-0.186C295.449,150.188,295.211,149.976,294.943,149.976L294.943,149.976z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M312.633,154.052c-0.561,0.452-1.225,0.692-2.025,0.692
			c-0.773,0-1.465-0.24-2.025-0.692c-0.613-0.48-0.852-1.065-0.852-2.025v-4.821h0.906v4.528c0,0.934,0.078,1.173,0.426,1.572
			c0.373,0.399,0.906,0.612,1.545,0.612s1.172-0.213,1.518-0.612c0.373-0.399,0.428-0.639,0.428-1.572v-4.528h0.904v4.821
			C313.457,152.986,313.244,153.571,312.633,154.052L312.633,154.052z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M318.066,153.119c-0.24,0.24-0.426,0.426-0.559,0.532
			c-0.402,0.346-0.801,0.666-1.121,0.853c-0.186,0.106-0.266,0.134-0.559,0.159c-0.08-0.132-0.133-0.319-0.133-0.585
			c0-0.107,0.027-0.24,0.027-0.399c0.025-0.214,0.053-0.373,0.053-0.48l0.48-3.01h-0.961l0.08-0.613l0.988-0.079l0.238-1.386
			l0.852-0.133l-0.238,1.519h1.037l-0.105,0.692h-1.041l-0.529,3.436l0.291-0.238l0.4-0.399l0.346-0.319l0.24-0.24l0.426,0.505
			L318.066,153.119L318.066,153.119z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M322.621,150.348c-0.107-0.079-0.186-0.079-0.318-0.079
			c-0.24,0-0.453,0.079-0.693,0.32c-0.375,0.371-0.666,0.825-0.852,1.358c-0.133,0.292-0.268,0.959-0.346,1.331l-0.188,1.253h-0.854
			l0.799-4.956l0.854-0.132l-0.293,1.465c0.613-1.065,1.092-1.492,1.652-1.492c0.238,0,0.371,0.054,0.559,0.159L322.621,150.348
			L322.621,150.348z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M326.404,151.28l-2.344,1.438c0,0.107,0,0.134,0,0.268
			c0,0.611,0.213,0.932,0.586,0.932c0.559,0,1.279-0.532,1.971-1.411l0.48,0.479c-0.961,1.065-1.812,1.624-2.586,1.624
			c-0.877,0-1.305-0.559-1.305-1.65c0-1.946,1.254-3.625,2.719-3.625c0.719,0,1.172,0.374,1.172,0.934
			C327.098,150.694,326.91,150.988,326.404,151.28L326.404,151.28z M325.818,149.976c-0.691,0-1.412,0.853-1.625,1.972l2.078-1.333
			c0.053-0.079,0.053-0.159,0.053-0.186C326.324,150.188,326.084,149.976,325.818,149.976L325.818,149.976z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M331.918,150.4c-0.344-0.292-0.559-0.372-0.904-0.372
			c-0.986,0-1.785,1.306-1.785,2.932c0,0.664,0.133,0.932,0.48,0.932c0.424,0,1.064-0.453,1.891-1.385l0.48,0.425
			c-0.908,1.12-1.812,1.679-2.639,1.679c-0.693,0-1.119-0.586-1.119-1.545c0-1.998,1.279-3.702,2.771-3.702
			c0.506,0,0.904,0.133,1.305,0.479L331.918,150.4L331.918,150.4z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M337.887,150.694l-0.586,3.837h-0.854l0.588-3.703l0.025-0.239
			c0.025-0.054,0.025-0.107,0.025-0.16c0-0.24-0.078-0.346-0.211-0.346c-0.268,0-0.639,0.265-1.092,0.771
			c-0.428,0.426-0.801,0.905-1.066,1.332c-0.107,0.161-0.213,0.346-0.268,0.48c-0.08,0.211-0.186,0.639-0.213,0.878l-0.16,0.986
			h-0.852l1.279-8.019l0.852-0.161l-0.48,3.092c-0.158,1.064-0.213,1.277-0.371,2.023c0.105-0.159,0.186-0.267,0.266-0.347
			c0.32-0.452,0.533-0.691,0.799-0.959c0.533-0.532,1.039-0.798,1.518-0.798c0.561,0,0.826,0.292,0.826,0.905
			C337.912,150.4,337.912,150.561,337.887,150.694L337.887,150.694z"/>
		<path fill-rule="evenodd" clip-rule="evenodd" d="M342.016,153.119c-0.213,0.24-0.4,0.426-0.561,0.532
			c-0.371,0.346-0.771,0.666-1.09,0.853c-0.188,0.106-0.268,0.134-0.561,0.159c-0.08-0.132-0.133-0.319-0.133-0.585
			c0-0.107,0.027-0.24,0.027-0.399c0.025-0.214,0.051-0.373,0.051-0.48l0.48-3.01h-0.984l0.105-0.613l0.984-0.079l0.213-1.386
			l0.881-0.133l-0.266,1.519h1.064l-0.105,0.692h-1.066l-0.533,3.436l0.293-0.238l0.426-0.399l0.348-0.319l0.238-0.24l0.4,0.505
			L342.016,153.119L342.016,153.119z"/>
	</g>
	<g>
		<g>
			<path fill="#004D6D" d="M438.857,167.161c-3.809,0-6.006-1.736-6.006-5.67c0-3.33,2.295-5.894,5.941-5.894
				c1.895,0,2.93,0.397,3.76,0.731v2.501c-0.064,0-0.686,0-0.814,0c-0.412-1.163-1.322-2.007-3.01-2.007
				c-2.262,0-3.951,1.322-3.951,4.557c0,3.123,1.961,4.38,4.492,4.395c0.414,0,1.211-0.094,1.498-0.144v-3.312h1.799v4.286
				C441.547,167.004,440.035,167.161,438.857,167.161z"/>
			<path fill="#004D6D" d="M446.277,162.812c0.113,2.501,1.322,2.916,2.963,2.916c0.607,0,1.514-0.08,2.295-0.272l0.301,1.021
				c-0.699,0.43-1.941,0.717-2.992,0.717c-2.771,0-4.381-0.748-4.381-4.315c0-2.532,1.609-4.717,4.094-4.717
				c2.5,0,3.455,1.61,3.455,4.111v0.54H446.277z M448.43,159.229c-1.213,0-2.07,0.973-2.168,2.595h3.807
				C450.068,160.168,449.623,159.229,448.43,159.229z"/>
			<path fill="#004D6D" d="M457.953,167.05h-4.666c-0.062-0.287-0.08-0.494-0.062-0.764l0.875-0.304
				c0.35-0.11,0.494-0.43,0.51-0.812l0.064-2.467v-6.597h-1.531v-0.891c0.639-0.144,1.865-0.335,2.596-0.335
				c0.43,0,0.67,0.175,0.67,0.653v7.169l0.064,2.802c0.016,0.27,0.031,0.367,0.223,0.413l1.322,0.271
				C458.018,166.46,458.018,166.826,457.953,167.05z"/>
			<path fill="#004D6D" d="M465.727,167.193c-0.781,0-0.893-0.781-0.893-1.355c-0.479,0.479-1.273,1.306-2.357,1.306
				c-1.672,0-3.52-0.65-3.52-4.107c0-2.914,1.912-4.746,4.27-4.746c0.732,0,1.146,0.049,1.592,0.128v-2.296h-1.545v-0.891
				c0.701-0.159,1.848-0.351,2.564-0.351c0.525,0,0.732,0.144,0.732,0.669l-0.016,7.104l0.062,3.075h1.467l0.145,0.701
				C467.668,166.747,466.746,167.193,465.727,167.193z M464.818,159.58c-0.383-0.079-0.877-0.191-1.641-0.191
				c-1.91,0-2.357,1.576-2.357,3.663c0,1.896,0.893,2.549,2.199,2.549c0.795,0,1.32-0.335,1.734-0.526l0.064-2.421V159.58z"/>
			<path fill="#004D6D" d="M470.951,162.812c0.111,2.501,1.322,2.916,2.963,2.916c0.604,0,1.512-0.08,2.291-0.272l0.305,1.021
				c-0.701,0.43-1.943,0.717-2.994,0.717c-2.771,0-4.381-0.748-4.381-4.315c0-2.532,1.609-4.717,4.094-4.717
				c2.5,0,3.455,1.61,3.455,4.111v0.54H470.951z M473.102,159.229c-1.211,0-2.072,0.973-2.168,2.595h3.809
				C474.742,160.168,474.295,159.229,473.102,159.229z"/>
			<path fill="#004D6D" d="M484.441,160.074c-0.318-0.161-0.715-0.256-1.195-0.256c-0.955,0-1.703,0.223-2.037,0.574v2.294
				l0.062,2.738c0,0.272,0.033,0.366,0.223,0.398l1.77,0.319c0,0.238,0,0.7-0.08,0.907h-5.002c-0.062-0.367-0.08-0.557-0.062-0.781
				l0.73-0.333c0.32-0.145,0.576-0.463,0.576-1.052l0.047-2.197v-3.219h-1.529v-0.924c0.652-0.144,1.799-0.349,2.58-0.349
				c0.414,0,0.654,0.144,0.654,0.604v0.669c0.412-0.653,1.352-1.289,2.42-1.289c0.588,0,1.02,0.111,1.258,0.239L484.441,160.074z"/>
			<path fill="#004D6D" d="M490.143,167.05h-4.666c-0.064-0.287-0.08-0.494-0.064-0.764l0.877-0.304
				c0.352-0.11,0.494-0.43,0.51-0.812l0.062-2.467v-6.597h-1.527v-0.891c0.637-0.144,1.863-0.335,2.596-0.335
				c0.43,0,0.67,0.175,0.67,0.653v7.169l0.062,2.802c0.016,0.27,0.031,0.367,0.223,0.413l1.322,0.271
				C490.207,166.46,490.207,166.826,490.143,167.05z"/>
			<path fill="#004D6D" d="M497.486,167.161c-1.131,0-1.291-0.605-1.322-1.37c-0.381,0.397-1.465,1.386-2.898,1.386
				c-1.242,0-2.182-0.667-2.182-2.007c0-1.799,1.607-2.533,3.152-2.771c0.877-0.126,1.77-0.223,1.896-0.239v-1.194
				c0-1.083-0.494-1.401-2.023-1.401c-0.59,0-1.449,0.128-2.166,0.335l-0.303-1.209c0.939-0.367,1.926-0.528,2.898-0.528
				c1.227-0.016,3.314,0.065,3.314,2.39v2.152l0.111,3.041h1.561l0.111,0.653C499.27,166.747,498.074,167.161,497.486,167.161z
				 M496.133,163.115c-0.064,0.016-0.988,0.112-1.672,0.256c-1.004,0.223-1.578,0.669-1.578,1.418c0,0.477,0.287,0.892,1.1,0.892
				s2.023-0.606,2.15-0.653V163.115z"/>
			<path fill="#004D6D" d="M510.721,167.05h-4.027c-0.049-0.27-0.082-0.557-0.049-0.827l0.479-0.287
				c0.318-0.191,0.43-0.511,0.43-0.781l0.047-2.451v-1.212c0-1.323-0.143-1.943-1.623-1.943c-0.926,0-2.008,0.383-2.422,0.605v2.55
				l0.047,2.738c0,0.27,0,0.431,0.225,0.477l1.211,0.271c0,0.257-0.016,0.638-0.08,0.861h-4.381
				c-0.049-0.238-0.062-0.526-0.062-0.764l0.764-0.336c0.318-0.127,0.477-0.525,0.494-0.829l0.049-2.418v-3.235h-1.514v-0.908
				c0.699-0.159,1.877-0.333,2.611-0.333c0.445,0,0.605,0.159,0.605,0.572v0.493c0.621-0.462,1.576-1.131,3.088-1.131
				c2.551,0,2.727,1.212,2.727,2.916v1.626l0.047,2.928c0.016,0.225,0.031,0.287,0.223,0.319l1.193,0.238
				C510.801,166.46,510.787,166.86,510.721,167.05z"/>
			<path fill="#004D6D" d="M518.574,167.193c-0.779,0-0.891-0.781-0.891-1.355c-0.479,0.479-1.275,1.306-2.357,1.306
				c-1.674,0-3.521-0.65-3.521-4.107c0-2.914,1.912-4.746,4.27-4.746c0.732,0,1.148,0.049,1.592,0.128v-2.296h-1.545v-0.891
				c0.703-0.159,1.848-0.351,2.564-0.351c0.525,0,0.732,0.144,0.732,0.669l-0.014,7.104l0.062,3.075h1.465l0.143,0.701
				C520.518,166.747,519.596,167.193,518.574,167.193z M517.666,159.58c-0.383-0.079-0.875-0.191-1.639-0.191
				c-1.912,0-2.357,1.576-2.357,3.663c0,1.896,0.891,2.549,2.197,2.549c0.797,0,1.322-0.335,1.736-0.526l0.062-2.421V159.58z"/>
			<path fill="#004D6D" d="M445.006,148.642c-0.506,0-0.742-0.013-1.014-0.063l0.049,2.399c0,0.174,0.049,0.267,0.309,0.317
				l0.949,0.186c0.012,0.136,0,0.298-0.064,0.447h-3.602c-0.049-0.224-0.049-0.285-0.037-0.398l0.459-0.173
				c0.283-0.123,0.455-0.415,0.455-0.75l0.051-5.414v-2.696h-1.188v-0.483c0.471-0.096,1.373-0.267,2.023-0.267
				c0.348,0,0.496,0.137,0.496,0.452l0.012,0.298c0.396-0.396,1.053-0.75,1.803-0.75c1.812,0,2.727,0.998,2.727,3.286
				C448.434,147.822,446.732,148.642,445.006,148.642z M445.299,142.509c-0.627,0-1.135,0.273-1.383,0.436v2.273l0.039,2.628
				c0.258,0.062,0.494,0.124,1.088,0.124c1.355,0,1.938-1.269,1.938-2.701C446.98,143.892,446.523,142.509,445.299,142.509z"/>
			<path fill="#004D6D" d="M454.465,143.054c-0.262-0.124-0.67-0.233-1.039-0.233c-0.738,0-1.123,0.208-1.482,0.444v1.915
				l0.051,2.364c0,0.179,0.025,0.267,0.174,0.292l1.355,0.247c0,0.123-0.014,0.31-0.055,0.458h-3.846
				c-0.037-0.173-0.061-0.222-0.049-0.357l0.557-0.275c0.246-0.111,0.443-0.364,0.443-0.824l0.039-1.904v-2.696h-1.188v-0.502
				c0.506-0.099,1.387-0.261,2-0.261c0.307,0,0.492,0.113,0.492,0.453v0.646c0.361-0.51,1.086-1.111,1.914-1.111
				c0.457,0,0.768,0.086,0.93,0.174L454.465,143.054z"/>
			<path fill="#004D6D" d="M458.369,148.629c-1.926,0-3.074-0.976-3.074-3.323c0-1.805,1.434-3.572,3.186-3.572
				c2.086,0,3.119,1.022,3.119,3.373C461.6,146.898,460.207,148.629,458.369,148.629z M458.369,142.446
				c-1.336,0-1.617,1.377-1.617,2.673c0,1.407,0.355,2.739,1.828,2.739c1.33,0,1.555-1.282,1.555-2.578
				C460.135,143.88,459.861,142.446,458.369,142.446z"/>
			<path fill="#004D6D" d="M468.91,142.161c-0.236,0.21-0.434,0.569-0.676,1.189l-2.111,5.203l-0.977,0.298l-2.062-5.723
				c-0.098-0.285-0.295-0.67-0.574-0.855c0-0.138,0-0.302,0.049-0.429h2.662c0,0.137-0.012,0.453-0.037,0.526h-0.799l1.604,4.987
				l1.516-4.044c0.199-0.521,0.076-0.818-0.197-0.932l-0.42-0.147c0-0.146-0.014-0.264,0.023-0.391h2.012
				C468.922,141.928,468.922,142.062,468.91,142.161z"/>
			<path fill="#004D6D" d="M473.311,148.541h-3.627c-0.039-0.173-0.051-0.222-0.051-0.384l0.76-0.26
				c0.201-0.062,0.35-0.354,0.361-0.601l0.037-2.104v-2.696h-1.195v-0.515c0.557-0.112,1.443-0.261,2.012-0.261
				c0.359,0,0.547,0.113,0.547,0.478l-0.014,2.994l0.037,2.362c0,0.229,0.068,0.304,0.193,0.33l1.002,0.21
				C473.373,148.206,473.361,148.393,473.311,148.541z M471.436,140.348c-0.26,0-1.021-0.775-1.021-1.022
				c0-0.285,0.773-1.017,1.021-1.017c0.246,0,1.021,0.756,1.021,1.017C472.457,139.547,471.719,140.348,471.436,140.348z"/>
			<path fill="#004D6D" d="M482.086,148.541h-3.154c-0.039-0.173-0.062-0.273-0.051-0.408l0.508-0.225
				c0.199-0.086,0.32-0.44,0.334-0.638l0.023-2.078v-0.941c0-1.098-0.172-1.568-1.324-1.568c-0.748,0-1.33,0.199-1.861,0.446v2.063
				l0.037,2.275c0,0.281,0.023,0.391,0.223,0.43l1.002,0.211c0,0.11-0.012,0.297-0.061,0.433h-3.496
				c-0.023-0.173-0.047-0.212-0.033-0.357l0.576-0.236c0.223-0.102,0.371-0.355,0.383-0.712l0.025-2.043v-2.696h-1.145v-0.483
				c0.525-0.105,1.441-0.253,1.992-0.253c0.348,0,0.482,0.109,0.482,0.414v0.52c0.508-0.396,1.301-0.995,2.471-0.995
				c1.85,0,2.074,0.921,2.074,2.23v1.264l0.023,2.435c0.014,0.195,0.062,0.258,0.223,0.281l0.811,0.187
				C482.148,148.206,482.137,148.405,482.086,148.541z"/>
			<path fill="#004D6D" d="M487.85,143.54c-0.375-0.522-0.971-1.157-1.627-1.157c-1.207,0-1.814,0.732-1.814,2.526
				c0,1.529,0.57,2.77,2.197,2.77c0.57,0,1.146-0.098,1.641-0.258l0.164,0.401c-0.348,0.349-1.09,0.829-2.285,0.829
				c-2.199,0-3.096-0.902-3.096-3.396c0-1.767,1.318-3.583,3.293-3.583c0.754,0,2.123,0.136,2.123,0.898
				C488.445,142.979,488.234,143.314,487.85,143.54z"/>
			<path fill="#004D6D" d="M492.924,148.541h-3.633c-0.035-0.173-0.047-0.222-0.047-0.384l0.756-0.26
				c0.209-0.062,0.357-0.354,0.369-0.601l0.037-2.104v-2.696h-1.199v-0.515c0.545-0.112,1.449-0.261,2.008-0.261
				c0.352,0,0.535,0.113,0.535,0.478l-0.012,2.994l0.035,2.362c0,0.229,0.076,0.304,0.211,0.33l1,0.21
				C492.984,148.206,492.973,148.393,492.924,148.541z M491.049,140.348c-0.258,0-1.027-0.775-1.027-1.022
				c0-0.285,0.781-1.017,1.027-1.017c0.238,0,1.023,0.756,1.023,1.017C492.072,139.547,491.322,140.348,491.049,140.348z"/>
			<path fill="#004D6D" d="M495.115,145.218c0.111,1.952,1.072,2.419,2.379,2.419c0.471,0,1.182-0.082,1.777-0.216l0.172,0.438
				c-0.477,0.446-1.43,0.783-2.389,0.783c-2.145,0-3.311-0.721-3.311-3.274c0-1.99,1.287-3.683,3.199-3.683
				c1.863,0,2.613,1.32,2.613,3.21v0.323H495.115z M496.703,142.311c-0.861,0-1.574,0.681-1.588,2.289h2.947
				C498.062,143.289,497.779,142.311,496.703,142.311z"/>
			<rect x="426.178" y="136.805" fill="#004D6D" width="100.82" height="0.593"/>
			<rect x="426.178" y="151.928" fill="#004D6D" width="13.863" height="0.593"/>
			<rect x="426.178" y="148.146" fill="#004D6D" width="7.564" height="0.594"/>
			<rect x="426.178" y="144.365" fill="#004D6D" width="7.564" height="0.593"/>
			<rect x="426.178" y="140.583" fill="#004D6D" width="7.564" height="0.593"/>
			<rect x="446.971" y="151.928" fill="#004D6D" width="80.027" height="0.593"/>
			<rect x="426.178" y="172.09" fill="#004D6D" width="100.82" height="0.594"/>
		</g>
	</g>
	<g>
		<path fill="#455877" d="M35.686,223.207c-0.058,0-0.097-0.038-0.097-0.097v-6.359c0-0.059,0.039-0.097,0.097-0.097h2.457
			c1.271,0,2.159,0.818,2.159,2.033c0,1.224-0.887,2.043-2.159,2.043h-1.359c-0.038,0-0.058,0.02-0.058,0.058v2.322
			c0,0.059-0.039,0.097-0.097,0.097H35.686z M39.164,218.688c0-0.598-0.414-1.012-1.088-1.012h-1.292
			c-0.038,0-0.058,0.02-0.058,0.058v1.907c0,0.04,0.02,0.059,0.058,0.059h1.292C38.75,219.699,39.164,219.295,39.164,218.688"/>
		<path fill="#455877" d="M41.428,223.207c-0.058,0-0.096-0.038-0.096-0.097v-4.452c0-0.058,0.039-0.096,0.096-0.096h0.886
			c0.058,0,0.097,0.038,0.097,0.096v0.396h0.009c0.222-0.356,0.617-0.597,1.204-0.597c0.367,0,0.732,0.144,0.974,0.385
			c0.048,0.048,0.058,0.086,0.019,0.135l-0.51,0.646c-0.039,0.047-0.087,0.058-0.135,0.018c-0.212-0.134-0.434-0.221-0.684-0.221
			c-0.607,0-0.876,0.434-0.876,1.176v2.515c0,0.059-0.039,0.097-0.097,0.097H41.428z"/>
		<path fill="#455877" d="M45.214,222.031c-0.106-0.327-0.154-0.636-0.154-1.146s0.047-0.819,0.154-1.146
			c0.26-0.811,0.973-1.281,1.917-1.281c0.935,0,1.648,0.471,1.908,1.281c0.106,0.327,0.154,0.636,0.154,1.146
			s-0.048,0.819-0.154,1.146c-0.26,0.81-0.973,1.282-1.908,1.282C46.188,223.313,45.475,222.841,45.214,222.031 M47.999,221.742
			c0.077-0.241,0.097-0.463,0.097-0.857c0-0.396-0.02-0.607-0.097-0.858c-0.135-0.385-0.434-0.606-0.867-0.606
			s-0.742,0.222-0.877,0.606c-0.077,0.251-0.096,0.463-0.096,0.858c0,0.395,0.02,0.616,0.096,0.857
			c0.135,0.386,0.443,0.606,0.877,0.606S47.864,222.128,47.999,221.742"/>
		<path fill="#455877" d="M51.603,223.207c-0.067,0-0.106-0.038-0.125-0.097l-1.638-4.452c-0.019-0.058,0.019-0.096,0.077-0.096
			h0.945c0.058,0,0.096,0.038,0.115,0.096l1.021,3.017h0.02l1.002-3.017c0.019-0.058,0.058-0.096,0.116-0.096h0.925
			c0.058,0,0.097,0.038,0.078,0.096l-1.638,4.452c-0.02,0.059-0.058,0.097-0.125,0.097H51.603z"/>
		<path fill="#455877" d="M55.167,217.686c-0.058,0-0.097-0.039-0.097-0.097v-0.838c0-0.059,0.039-0.097,0.097-0.097h0.886
			c0.058,0,0.096,0.038,0.096,0.097v0.838c0,0.058-0.038,0.097-0.096,0.097H55.167z M55.167,223.207
			c-0.058,0-0.097-0.038-0.097-0.097v-4.452c0-0.058,0.039-0.096,0.097-0.096h0.886c0.058,0,0.096,0.038,0.096,0.096v4.452
			c0,0.059-0.038,0.097-0.096,0.097H55.167z"/>
		<path fill="#455877" d="M60.495,223.207c-0.058,0-0.096-0.038-0.096-0.097v-2.679c0-0.597-0.298-1.012-0.877-1.012
			c-0.559,0-0.886,0.415-0.886,1.012v2.679c0,0.059-0.039,0.097-0.097,0.097h-0.886c-0.058,0-0.097-0.038-0.097-0.097v-4.452
			c0-0.058,0.039-0.096,0.097-0.096h0.886c0.058,0,0.097,0.038,0.097,0.096v0.338h0.009c0.203-0.289,0.607-0.539,1.224-0.539
			c0.993,0,1.609,0.731,1.609,1.724v2.93c0,0.059-0.039,0.097-0.096,0.097H60.495z"/>
		<path fill="#455877" d="M62.73,222.031c-0.097-0.289-0.145-0.655-0.145-1.146s0.048-0.858,0.145-1.146
			c0.27-0.829,0.983-1.281,1.917-1.281c0.694,0,1.243,0.279,1.609,0.722c0.029,0.038,0.038,0.097-0.01,0.135l-0.607,0.53
			c-0.048,0.039-0.097,0.029-0.135-0.02c-0.231-0.26-0.472-0.404-0.857-0.404c-0.415,0-0.733,0.203-0.867,0.606
			c-0.078,0.232-0.097,0.502-0.097,0.858s0.019,0.636,0.097,0.867c0.134,0.395,0.453,0.597,0.867,0.597
			c0.385,0,0.626-0.145,0.857-0.403c0.039-0.049,0.087-0.049,0.135-0.011l0.607,0.53c0.048,0.038,0.039,0.087,0.01,0.135
			c-0.366,0.434-0.916,0.714-1.609,0.714C63.713,223.313,63,222.859,62.73,222.031"/>
		<path fill="#455877" d="M67.509,217.686c-0.058,0-0.097-0.039-0.097-0.097v-0.838c0-0.059,0.039-0.097,0.097-0.097h0.886
			c0.058,0,0.096,0.038,0.096,0.097v0.838c0,0.058-0.039,0.097-0.096,0.097H67.509z M67.509,223.207
			c-0.058,0-0.097-0.038-0.097-0.097v-4.452c0-0.058,0.039-0.096,0.097-0.096h0.886c0.058,0,0.096,0.038,0.096,0.096v4.452
			c0,0.059-0.039,0.097-0.096,0.097H67.509z"/>
		<path fill="#455877" d="M69.812,222.021c-0.096-0.299-0.164-0.655-0.164-1.137c0-0.482,0.058-0.848,0.154-1.146
			c0.26-0.811,0.973-1.281,1.898-1.281c0.954,0,1.647,0.491,1.908,1.281c0.106,0.327,0.154,0.646,0.154,1.396
			c0,0.058-0.038,0.097-0.106,0.097h-2.861c-0.039,0-0.058,0.019-0.058,0.058c0,0.135,0.029,0.251,0.067,0.357
			c0.154,0.452,0.52,0.702,1.041,0.702c0.52,0,0.858-0.191,1.089-0.442c0.048-0.048,0.097-0.059,0.145-0.02l0.569,0.501
			c0.048,0.039,0.048,0.087,0.009,0.135c-0.395,0.463-1.05,0.791-1.908,0.791C70.766,223.313,70.072,222.831,69.812,222.021
			 M72.616,219.969c-0.125-0.375-0.472-0.597-0.906-0.597c-0.443,0-0.79,0.222-0.915,0.597c-0.039,0.116-0.058,0.231-0.058,0.396
			c0,0.038,0.019,0.058,0.058,0.058h1.821c0.039,0,0.058-0.02,0.058-0.058C72.674,220.2,72.655,220.085,72.616,219.969"/>
		<path fill="#455877" d="M35.784,239.453c-0.117,0-0.195-0.079-0.195-0.195v-1.682c0-0.078,0.02-0.137,0.059-0.215l6.001-9.091
			v-0.04h-5.865c-0.118,0-0.196-0.077-0.196-0.195v-1.682c0-0.116,0.078-0.195,0.196-0.195h8.27c0.117,0,0.196,0.079,0.196,0.195
			v1.682c0,0.078-0.02,0.137-0.059,0.195l-6.002,9.11v0.04h5.865c0.117,0,0.196,0.078,0.196,0.195v1.682
			c0,0.116-0.079,0.195-0.196,0.195H35.784z"/>
		<path fill="#455877" d="M45.751,237.048c-0.195-0.606-0.332-1.33-0.332-2.307c0-0.978,0.117-1.721,0.312-2.327
			c0.528-1.642,1.975-2.6,3.851-2.6c1.936,0,3.343,0.997,3.872,2.6c0.214,0.666,0.312,1.311,0.312,2.835
			c0,0.118-0.078,0.196-0.214,0.196h-5.807c-0.078,0-0.117,0.039-0.117,0.117c0,0.273,0.059,0.508,0.137,0.724
			c0.313,0.918,1.056,1.427,2.111,1.427c1.056,0,1.74-0.391,2.209-0.899c0.098-0.098,0.195-0.117,0.293-0.039l1.154,1.017
			c0.098,0.078,0.098,0.176,0.02,0.273c-0.802,0.938-2.131,1.604-3.871,1.604C47.687,239.668,46.279,238.689,45.751,237.048
			 M51.44,232.885c-0.254-0.764-0.958-1.213-1.837-1.213c-0.899,0-1.603,0.449-1.857,1.213c-0.078,0.234-0.117,0.469-0.117,0.801
			c0,0.078,0.039,0.118,0.117,0.118h3.695c0.079,0,0.118-0.04,0.118-0.118C51.558,233.354,51.519,233.119,51.44,232.885"/>
		<path fill="#455877" d="M55.937,237.048c-0.195-0.606-0.332-1.33-0.332-2.307c0-0.978,0.118-1.721,0.313-2.327
			c0.527-1.642,1.974-2.6,3.852-2.6c1.935,0,3.343,0.997,3.871,2.6c0.215,0.666,0.313,1.311,0.313,2.835
			c0,0.118-0.079,0.196-0.215,0.196h-5.807c-0.078,0-0.117,0.039-0.117,0.117c0,0.273,0.059,0.508,0.137,0.724
			c0.312,0.918,1.055,1.427,2.111,1.427s1.74-0.391,2.209-0.899c0.098-0.098,0.196-0.117,0.293-0.039l1.153,1.017
			c0.098,0.078,0.098,0.176,0.02,0.273c-0.801,0.938-2.131,1.604-3.871,1.604C57.873,239.668,56.465,238.689,55.937,237.048
			 M61.626,232.885c-0.254-0.764-0.958-1.213-1.838-1.213c-0.899,0-1.603,0.449-1.857,1.213c-0.078,0.234-0.117,0.469-0.117,0.801
			c0,0.078,0.04,0.118,0.117,0.118h3.695c0.078,0,0.117-0.04,0.117-0.118C61.744,233.354,61.705,233.119,61.626,232.885"/>
		<path fill="#455877" d="M68.888,239.569c-1.837,0-2.581-0.88-2.581-2.697v-10.519c0-0.116,0.078-0.195,0.196-0.195h1.798
			c0.117,0,0.195,0.079,0.195,0.195v10.401c0,0.646,0.254,0.86,0.821,0.86h0.43c0.117,0,0.196,0.078,0.196,0.195v1.563
			c0,0.118-0.079,0.195-0.196,0.195H68.888z"/>
		<path fill="#455877" d="M77.647,239.453c-0.118,0-0.196-0.079-0.196-0.195v-0.685h-0.02c-0.45,0.646-1.33,1.095-2.659,1.095
			c-1.721,0-3.167-0.899-3.167-2.875c0-2.052,1.446-2.989,3.773-2.989h1.916c0.078,0,0.117-0.04,0.117-0.118v-0.45
			c0-1.075-0.508-1.563-2.092-1.563c-1.056,0-1.701,0.293-2.151,0.646c-0.098,0.078-0.215,0.059-0.273-0.04l-0.724-1.29
			c-0.058-0.098-0.039-0.196,0.04-0.254c0.762-0.548,1.798-0.919,3.343-0.919c2.874,0,3.93,0.977,3.93,3.284v6.159
			c0,0.116-0.079,0.195-0.196,0.195H77.647z M77.412,236.286v-0.724c0-0.078-0.039-0.117-0.117-0.117H75.73
			c-1.407,0-2.032,0.391-2.032,1.271c0,0.782,0.566,1.173,1.622,1.173C76.669,237.889,77.412,237.361,77.412,236.286"/>
		<path fill="#455877" d="M88.224,239.453c-0.117,0-0.195-0.079-0.195-0.195v-5.436c0-1.212-0.606-2.053-1.779-2.053
			c-1.134,0-1.799,0.841-1.799,2.053v5.436c0,0.116-0.078,0.195-0.195,0.195h-1.799c-0.117,0-0.195-0.079-0.195-0.195v-9.032
			c0-0.118,0.079-0.195,0.195-0.195h1.799c0.118,0,0.195,0.077,0.195,0.195v0.684h0.02c0.41-0.587,1.231-1.095,2.483-1.095
			c2.013,0,3.265,1.486,3.265,3.5v5.943c0,0.116-0.078,0.195-0.195,0.195H88.224z"/>
		<path fill="#455877" d="M98.781,239.453c-0.118,0-0.196-0.079-0.196-0.195v-0.705h-0.02c-0.45,0.646-1.232,1.115-2.502,1.115
			c-1.603,0-2.776-0.763-3.265-2.268c-0.235-0.724-0.333-1.389-0.333-2.659s0.098-1.936,0.333-2.659
			c0.489-1.505,1.662-2.268,3.265-2.268c1.271,0,2.053,0.47,2.502,1.114h0.02v-4.575c0-0.116,0.078-0.195,0.196-0.195h1.798
			c0.118,0,0.196,0.079,0.196,0.195v12.904c0,0.116-0.078,0.195-0.196,0.195H98.781z M98.39,236.501
			c0.137-0.431,0.196-0.899,0.196-1.76s-0.059-1.329-0.196-1.759c-0.254-0.782-0.86-1.213-1.759-1.213
			c-0.88,0-1.486,0.431-1.74,1.213c-0.137,0.43-0.195,0.898-0.195,1.759s0.058,1.329,0.195,1.76c0.254,0.781,0.86,1.212,1.74,1.212
			C97.53,237.713,98.136,237.282,98.39,236.501"/>
		<path fill="#CE0A52" d="M22.571,228.801c0.863-0.65,1.757-1.324,2.624-2.038c4.733-3.893,5.108-7.871,5.135-10.108h-2.338
			c-0.029,1.941-0.378,5.092-4.282,8.303c-0.829,0.683-1.702,1.34-2.546,1.977c-4.118,3.103-8.375,6.311-8.375,12.999v2.01
			l2.338,0.622v-2.632C15.125,234.41,18.576,231.811,22.571,228.801"/>
		<path fill="#CE0A52" d="M31.333,236.715v-2.625c0,0.025-1.17,0.881-1.894,1.322c-4.206,2.564-4.499,3.551-4.499,6.785v1.441
			l2.338-0.621v-1.54c0-1.696,0.45-2.33,2.505-3.683C30.652,237.225,31.333,236.715,31.333,236.715"/>
		<path fill="#CE0A52" d="M30.567,239.245c-1.292,0.961-1.577,1.072-1.577,2.465v0.853l2.343-0.622v-3.248
			C31.333,238.692,31.106,238.845,30.567,239.245"/>
		<path fill="#CE0A52" d="M19.649,216.654l-0.151,0.445h-6.67v2.837c0.006,1.252,0.938,1.475,1.637,1.475c0,0,1.246,0,2.335,0
			c0.855,0,2.302,0.561,2.302,2.158c0,0.612-0.354,1.546-1.382,1.546c-1.072,0-1.466-0.561-1.519-0.89h-3.374v2.619l5.044,0.706
			c4.255-3.522,8.597-5.356,8.597-10.896H19.649z M20.105,220.163v-1.987h2.876C22.981,218.176,22.167,219.727,20.105,220.163"/>
		<path fill="#CE0A52" d="M17.721,224.108c-0.284,0-0.459-0.207-0.532-0.515c-0.028-0.119-0.147-0.253-0.406-0.253h-3.69
			c-2.578,0-3.079-1.757-3.177-2.675c-0.03-0.282,0.174-0.536,0.457-0.566c0.28-0.031,0.514,0.176,0.566,0.455
			c0.033,0.181,0.263,1.735,2.154,1.735h3.377c0.16-0.01,0.916-0.026,1.39,0.413c0.246,0.229,0.334,0.478,0.356,0.848
			C18.233,223.834,18.004,224.108,17.721,224.108"/>
		<path fill="#CE0A52" d="M25.82,228.319c-0.492,0.357-0.965,0.738-1.447,1.102c-2.011,1.515-4.045,2.961-5.493,4.838
			c-1.232,1.646-2.042,3.592-2.042,6.077v2.683l2.338,0.622v-3.305c0-4.252,3.073-6.532,6.631-9.175
			c0.492-0.364,0.986-0.731,1.476-1.107c1.651-1.265,3.006-2.598,4.05-3.979v-5.124C31.037,222.103,29.958,225.304,25.82,228.319"/>
		<path fill="#CE0A52" d="M20.889,240.74c0-0.405,0.028-0.791,0.082-1.16C20.917,239.947,20.889,240.334,20.889,240.74"/>
		<path fill="#CE0A52" d="M27.25,232.167c-2.749,1.934-6.36,4.253-6.36,8.573v3.355l1.166,0.311l1.171-0.312v-3.354
			c0-3.107,2.346-4.744,5.315-6.815c0.273-0.19,0.549-0.384,0.826-0.579c0.732-0.518,1.383-1.023,1.966-1.514v-3
			c-0.808,0.892-1.861,1.768-3.27,2.764C27.791,231.789,27.518,231.978,27.25,232.167"/>
	</g>
	<g>
		<rect x="215.057" y="215.376" fill="#ED1C2E" width="121.972" height="15.245"/>
		<g>
			<path fill="#FFFFFF" d="M224.102,220.85h0.239c0.549,0,1.018,0.008,1.018,0.694c0,0.664-0.506,0.664-1.018,0.664h-0.239V220.85z
				 M222.686,225.154h1.416v-1.806h0.802c1.234,0,1.928-0.562,1.928-1.849c0-1.25-0.809-1.79-1.979-1.79h-2.167V225.154z"/>
			<path fill="#FFFFFF" d="M228.818,222.057h0.015c0.252-0.455,0.686-0.658,1.199-0.658h0.252v1.264
				c-0.18-0.101-0.353-0.122-0.555-0.122c-0.73,0-0.911,0.484-0.911,1.12v1.494h-1.315v-3.705h1.315V222.057z"/>
			<path fill="#FFFFFF" d="M232.676,222.468c0.535,0,0.845,0.383,0.845,0.838c0,0.47-0.31,0.83-0.845,0.83
				c-0.534,0-0.845-0.36-0.845-0.83C231.831,222.851,232.142,222.468,232.676,222.468z M232.676,221.326
				c-1.192,0-2.231,0.716-2.231,1.979s1.048,1.971,2.231,1.971c1.191,0,2.232-0.714,2.232-1.971
				C234.908,222.042,233.867,221.326,232.676,221.326z"/>
			<path fill="#FFFFFF" d="M237.393,223.349l0.881-1.899h1.474l-1.936,3.705h-0.838l-1.943-3.705h1.474L237.393,223.349z"/>
			<path fill="#FFFFFF" d="M241.458,225.154h-1.314v-3.705h1.314V225.154z M241.538,220.026c0,0.404-0.331,0.736-0.736,0.736
				s-0.737-0.332-0.737-0.736c0-0.403,0.332-0.737,0.737-0.737S241.538,219.623,241.538,220.026z"/>
			<path fill="#FFFFFF" d="M243.712,221.927h0.014c0.305-0.448,0.672-0.601,1.185-0.601c0.997,0,1.395,0.628,1.395,1.538v2.29
				h-1.315v-1.806c0-0.353,0.058-0.975-0.592-0.975c-0.535,0-0.687,0.397-0.687,0.858v1.922h-1.315v-3.705h1.315V221.927z"/>
			<path fill="#FFFFFF" d="M249.916,222.655c-0.194-0.145-0.426-0.26-0.678-0.26c-0.505,0-0.904,0.391-0.904,0.902
				c0,0.535,0.383,0.911,0.926,0.911c0.23,0,0.484-0.094,0.656-0.253v1.111c-0.289,0.145-0.605,0.209-0.924,0.209
				c-1.097,0-2.015-0.814-2.015-1.935c0-1.191,0.912-2.016,2.072-2.016c0.305,0,0.608,0.072,0.867,0.218V222.655z"/>
			<path fill="#FFFFFF" d="M252.119,225.154h-1.314v-3.705h1.314V225.154z M252.199,220.026c0,0.404-0.332,0.736-0.736,0.736
				c-0.406,0-0.738-0.332-0.738-0.736c0-0.403,0.332-0.737,0.738-0.737C251.867,219.289,252.199,219.623,252.199,220.026z"/>
			<path fill="#FFFFFF" d="M254.119,222.764c0.08-0.382,0.398-0.584,0.781-0.584c0.354,0,0.678,0.229,0.744,0.584H254.119z
				 M256.863,223.386c0-1.265-0.742-2.06-2.027-2.06c-1.207,0-2.051,0.744-2.051,1.979c0,1.279,0.916,1.971,2.145,1.971
				c0.846,0,1.674-0.396,1.885-1.271h-1.264c-0.145,0.246-0.348,0.34-0.629,0.34c-0.541,0-0.824-0.289-0.824-0.823h2.766V223.386z"
				/>
			<path fill="#FFFFFF" d="M260.115,219.71h1.416l2.594,3.328h0.014v-3.328h1.416v5.444h-1.416l-2.594-3.337h-0.014v3.337h-1.416
				V219.71z"/>
			<path fill="#FFFFFF" d="M268.588,222.468c0.533,0,0.846,0.383,0.846,0.838c0,0.47-0.312,0.83-0.846,0.83
				c-0.535,0-0.846-0.36-0.846-0.83C267.742,222.851,268.053,222.468,268.588,222.468z M268.588,221.326
				c-1.191,0-2.232,0.716-2.232,1.979s1.047,1.971,2.232,1.971c1.191,0,2.23-0.714,2.23-1.971
				C270.818,222.042,269.779,221.326,268.588,221.326z"/>
			<path fill="#FFFFFF" d="M273.551,222.468c0.533,0,0.844,0.383,0.844,0.838c0,0.47-0.311,0.83-0.844,0.83
				c-0.537,0-0.848-0.36-0.848-0.83C272.703,222.851,273.014,222.468,273.551,222.468z M273.551,221.326
				c-1.193,0-2.234,0.716-2.234,1.979s1.049,1.971,2.234,1.971c1.191,0,2.232-0.714,2.232-1.971
				C275.783,222.042,274.742,221.326,273.551,221.326z"/>
			<path fill="#FFFFFF" d="M277.869,222.057h0.014c0.254-0.455,0.686-0.658,1.199-0.658h0.254v1.264
				c-0.184-0.101-0.354-0.122-0.557-0.122c-0.73,0-0.91,0.484-0.91,1.12v1.494h-1.314v-3.705h1.314V222.057z"/>
			<path fill="#FFFFFF" d="M281.885,222.468c0.535,0,0.846,0.383,0.846,0.838c0,0.47-0.311,0.83-0.846,0.83s-0.846-0.36-0.846-0.83
				C281.039,222.851,281.35,222.468,281.885,222.468z M282.688,225.154h1.314v-5.995h-1.314v2.651
				c-0.275-0.325-0.723-0.484-1.15-0.484c-1.098,0-1.855,0.911-1.855,1.972c0,1.062,0.773,1.979,1.871,1.979
				c0.434,0,0.887-0.165,1.119-0.533h0.016V225.154z"/>
			<path fill="#FFFFFF" d="M286.947,222.294v1.083h-2.066v-1.083H286.947z"/>
			<path fill="#FFFFFF" d="M289.244,224.071h0.182c0.418,0,1.127,0.021,1.127-0.578c0-0.657-0.701-0.592-1.164-0.592h-0.145V224.071
				z M287.828,225.154v-5.444h2.023c0.969,0,1.617,0.375,1.617,1.414c0,0.491-0.158,0.889-0.6,1.113v0.014
				c0.781,0.101,1.113,0.629,1.113,1.388c0,1.14-0.975,1.516-1.973,1.516H287.828z M289.244,221.848h0.16
				c0.375,0,0.764-0.066,0.764-0.528c0-0.499-0.441-0.527-0.822-0.527h-0.102V221.848z"/>
			<path fill="#FFFFFF" d="M294.076,222.057h0.014c0.254-0.455,0.688-0.658,1.199-0.658h0.254v1.264
				c-0.182-0.101-0.355-0.122-0.557-0.122c-0.73,0-0.91,0.484-0.91,1.12v1.494h-1.314v-3.705h1.314V222.057z"/>
			<path fill="#FFFFFF" d="M298.043,222.468c0.533,0,0.844,0.383,0.844,0.838c0,0.47-0.311,0.83-0.844,0.83
				c-0.537,0-0.848-0.36-0.848-0.83C297.195,222.851,297.506,222.468,298.043,222.468z M300.158,221.449h-1.314v0.361
				c-0.275-0.325-0.723-0.484-1.15-0.484c-1.098,0-1.855,0.911-1.855,1.972c0,1.062,0.775,1.979,1.871,1.979
				c0.434,0,0.889-0.165,1.119-0.533h0.016v0.411h1.314V221.449z"/>
			<path fill="#FFFFFF" d="M303.176,222.468c0.537,0,0.846,0.383,0.846,0.838c0,0.47-0.309,0.83-0.846,0.83
				c-0.533,0-0.846-0.36-0.846-0.83C302.33,222.851,302.643,222.468,303.176,222.468z M301.061,225.154h1.314v-0.411h0.014
				c0.24,0.368,0.688,0.533,1.121,0.533c1.104,0,1.869-0.909,1.869-1.979c0-1.061-0.758-1.972-1.855-1.972
				c-0.428,0-0.867,0.159-1.148,0.484v-2.651h-1.314V225.154z"/>
			<path fill="#FFFFFF" d="M308.037,222.468c0.533,0,0.846,0.383,0.846,0.838c0,0.47-0.312,0.83-0.846,0.83
				c-0.535,0-0.846-0.36-0.846-0.83C307.191,222.851,307.502,222.468,308.037,222.468z M310.152,221.449h-1.312v0.361
				c-0.275-0.325-0.723-0.484-1.15-0.484c-1.096,0-1.855,0.911-1.855,1.972c0,1.062,0.773,1.979,1.871,1.979
				c0.436,0,0.889-0.165,1.119-0.533h0.016v0.411h1.312V221.449z"/>
			<path fill="#FFFFFF" d="M312.416,221.927h0.014c0.303-0.448,0.67-0.601,1.184-0.601c0.996,0,1.395,0.628,1.395,1.538v2.29h-1.314
				v-1.806c0-0.353,0.057-0.975-0.594-0.975c-0.533,0-0.684,0.397-0.684,0.858v1.922H311.1v-3.705h1.316V221.927z"/>
			<path fill="#FFFFFF" d="M317.383,225.154h-1.314v-2.622h-0.426v-1.083h0.426v-1.111h1.314v1.111h0.744v1.083h-0.744V225.154z"/>
		</g>
		<rect x="321.785" y="245.871" fill="#FFFFFF" width="15.246" height="15.246"/>
		<polygon fill="#888A8C" points="329.408,253.494 321.785,261.117 321.785,245.871 		"/>
		<polygon fill="#ED1C2E" points="337.031,261.117 321.785,245.871 337.031,245.871 		"/>
	</g>
	<g>
		<g>
			<path d="M420.715,222.777h0.672v1.137h0.023c0.336-0.812,1.172-1.311,2.135-1.311c1.82,0,2.691,1.474,2.691,3.167
				s-0.871,3.167-2.691,3.167c-0.893,0-1.764-0.452-2.076-1.311h-0.023v3.353h-0.73V222.777z M423.545,223.219
				c-1.613,0-2.1,1.195-2.1,2.552c0,1.241,0.545,2.553,2.1,2.553c1.393,0,1.961-1.312,1.961-2.553S424.938,223.219,423.545,223.219z
				"/>
			<path d="M428.021,222.777h0.674v1.403h0.021c0.373-0.962,1.184-1.53,2.264-1.484v0.731c-1.322-0.07-2.229,0.904-2.229,2.146
				v3.189h-0.73V222.777z"/>
		</g>
		<g>
			<path d="M437.469,225.771c0,1.717-0.998,3.167-2.832,3.167c-1.832,0-2.83-1.45-2.83-3.167s0.998-3.167,2.83-3.167
				C436.471,222.604,437.469,224.054,437.469,225.771z M432.537,225.771c0,1.275,0.697,2.553,2.1,2.553c1.404,0,2.1-1.277,2.1-2.553
				c0-1.276-0.695-2.552-2.1-2.552C433.234,223.219,432.537,224.494,432.537,225.771z"/>
			<path d="M438.523,222.777h0.812l1.879,5.255h0.023l1.855-5.255h0.754l-2.238,5.985h-0.777L438.523,222.777z"/>
			<path d="M445.217,220.481h0.73v1.171h-0.73V220.481z M445.217,222.777h0.73v5.985h-0.73V222.777z"/>
			<path d="M447.979,222.777h0.73v1.032h0.023c0.266-0.719,1.066-1.206,1.914-1.206c1.682,0,2.191,0.882,2.191,2.309v3.851h-0.73
				v-3.734c0-1.032-0.338-1.81-1.52-1.81c-1.16,0-1.855,0.882-1.879,2.053v3.491h-0.73V222.777z"/>
			<path d="M459.078,224.657c-0.197-0.894-0.742-1.438-1.693-1.438c-1.404,0-2.1,1.275-2.1,2.552c0,1.275,0.695,2.553,2.1,2.553
				c0.906,0,1.648-0.709,1.74-1.706h0.73c-0.197,1.438-1.137,2.32-2.471,2.32c-1.832,0-2.83-1.45-2.83-3.167s0.998-3.167,2.83-3.167
				c1.277,0,2.262,0.685,2.426,2.054H459.078z"/>
			<path d="M461.527,220.481h0.73v1.171h-0.73V220.481z M461.527,222.777h0.73v5.985h-0.73V222.777z"/>
			<path d="M464.729,225.968c0.012,1.067,0.568,2.355,1.973,2.355c1.066,0,1.646-0.627,1.879-1.531h0.73
				c-0.312,1.356-1.102,2.146-2.609,2.146c-1.904,0-2.703-1.461-2.703-3.167c0-1.577,0.799-3.167,2.703-3.167
				c1.926,0,2.691,1.683,2.633,3.364H464.729z M468.604,225.354c-0.035-1.103-0.721-2.135-1.902-2.135
				c-1.195,0-1.857,1.044-1.973,2.135H468.604z"/>
		</g>
		<g>
			<path d="M475.195,220.481h0.73v8.281h-0.73V220.481z"/>
			<path d="M477.979,220.481h0.73v1.171h-0.73V220.481z M477.979,222.777h0.73v5.985h-0.73V222.777z"/>
			<path d="M480.752,222.777h0.672v1.01h0.035c0.383-0.72,1.01-1.184,1.961-1.184c0.789,0,1.496,0.383,1.717,1.172
				c0.359-0.789,1.113-1.172,1.902-1.172c1.311,0,1.984,0.685,1.984,2.101v4.059h-0.732v-4.024c0-0.986-0.371-1.52-1.414-1.52
				c-1.266,0-1.625,1.044-1.625,2.157v3.387h-0.73v-4.059c0.012-0.812-0.324-1.485-1.252-1.485c-1.266,0-1.775,0.951-1.787,2.204
				v3.34h-0.73V222.777z"/>
			<path d="M491.053,220.481h0.73v3.433h0.023c0.312-0.858,1.184-1.311,2.076-1.311c1.82,0,2.691,1.474,2.691,3.167
				s-0.871,3.167-2.691,3.167c-0.963,0-1.799-0.499-2.135-1.311h-0.023v1.136h-0.672V220.481z M493.883,223.219
				c-1.555,0-2.1,1.311-2.1,2.552s0.545,2.553,2.1,2.553c1.393,0,1.961-1.312,1.961-2.553S495.275,223.219,493.883,223.219z"/>
			<path d="M503.197,228.763h-0.672v-1.078h-0.023c-0.383,0.801-1.172,1.253-2.066,1.253c-1.508,0-2.098-0.882-2.098-2.273v-3.887
				h0.73v3.897c0.033,1.079,0.439,1.648,1.6,1.648c1.254,0,1.799-1.184,1.799-2.402v-3.144h0.73V228.763z"/>
			<path d="M505.215,222.777h0.674v1.403h0.023c0.371-0.962,1.184-1.53,2.262-1.484v0.731c-1.322-0.07-2.227,0.904-2.227,2.146
				v3.189h-0.732V222.777z"/>
			<path d="M514.566,228.276c-0.014,1.786-0.697,2.876-2.658,2.876c-1.193,0-2.377-0.533-2.482-1.809h0.732
				c0.162,0.882,0.939,1.195,1.75,1.195c1.346,0,1.926-0.802,1.926-2.263v-0.812h-0.021c-0.338,0.731-1.045,1.229-1.904,1.229
				c-1.914,0-2.701-1.368-2.701-3.073c0-1.647,0.973-3.017,2.701-3.017c0.871,0,1.613,0.545,1.904,1.206h0.021v-1.032h0.732V228.276
				z M513.834,225.701c0-1.172-0.545-2.482-1.926-2.482c-1.391,0-1.971,1.241-1.971,2.482c0,1.206,0.627,2.378,1.971,2.378
				C513.174,228.079,513.834,226.919,513.834,225.701z"/>
		</g>
		<g>
			<path fill-rule="evenodd" clip-rule="evenodd" fill="#FFFFFF" d="M529.861,216.962h-1.031l0.082,0.229l-0.223-0.051v0.949
				l0.186-0.038c0,0-0.254,0.209-0.23,0.444c0.027,0.235,0.109,0.446,0.109,0.446h-0.025c0,0-0.025-0.203-0.135-0.242
				c-0.107-0.037-0.293,0.02-0.293,0.02s-0.057-0.115-0.146-0.141c-0.09-0.024-0.287,0.032-0.287,0.032s-0.131-0.133-0.24-0.115
				c-0.109,0.021-0.229,0.129-0.229,0.129s-0.166-0.146-0.318-0.059c-0.154,0.09-0.148,0.21-0.148,0.21s-0.217-0.05-0.287,0.084
				c-0.07,0.135-0.037,0.312-0.037,0.312s-0.217,0.082-0.184,0.267c0.031,0.185,0.094,0.224,0.094,0.224s-0.119,0.089-0.102,0.203
				c0.02,0.115,0.172,0.249,0.172,0.249s-0.051,0.191,0.006,0.268c0.059,0.077,0.146,0.141,0.146,0.141s-0.027,0.418,0.023,0.691
				c0.053,0.275,0.141,0.564,0.264,0.701c0.1,0.111,0.197,0.166,0.197,0.166v0.421h-4.043v13.115c0,0-0.02,1.098,0.588,1.649
				c0.58,0.527,1.336,0.548,1.336,0.548h2.012c0,0,0.676-0.042,1.268,0.438c0.738,0.602,0.941,1.292,0.941,1.292
				s0.355-0.999,1.023-1.305c0.67-0.307,1.041-0.383,1.67-0.37s1.361,0,1.361,0s0.867,0.047,1.543-0.592
				c0.674-0.637,0.578-1.382,0.578-1.623c0-0.242,0-3.266,0-3.266v-9.938h-4.006v-0.325c0,0,0.283-0.295,0.395-0.588
				c0.113-0.296,0.07-0.978,0.07-0.978s0.211-0.223,0.166-0.331s-0.045-0.108-0.045-0.108s0.166-0.141,0.16-0.274
				s-0.076-0.185-0.076-0.185s0.121-0.161,0.096-0.274s-0.158-0.216-0.158-0.216s0.031-0.229-0.033-0.299
				c-0.064-0.07-0.312-0.097-0.312-0.097s0-0.101-0.07-0.165c-0.07-0.063-0.189-0.108-0.271-0.069
				c-0.084,0.037-0.115,0.075-0.115,0.075s-0.051-0.101-0.104-0.121c-0.051-0.018-0.215-0.051-0.279,0.026
				c-0.064,0.076-0.07,0.082-0.07,0.082s-0.172-0.095-0.268-0.05c-0.096,0.044-0.186,0.146-0.186,0.146s-0.072-0.057-0.178-0.037
				c-0.107,0.019-0.234,0.14-0.234,0.229c0,0.089,0,0.062,0,0.062l-0.096,0.02c0,0,0.18-0.229,0.166-0.408
				c-0.012-0.178-0.279-0.515-0.279-0.515l-0.041-0.045l0.236,0.114v-0.988l-0.242,0.104L529.861,216.962L529.861,216.962z"/>
			<polygon fill="#EEB211" points="529.287,222.721 535.189,222.721 535.189,230.02 529.287,230.02 529.287,222.721 			"/>
			<polygon fill="#B3B5BE" points="523.379,230.02 523.379,222.721 529.287,222.721 529.287,230.021 523.379,230.02 			"/>
			<path fill="#EEB211" d="M529.287,238.722c-0.094-0.161-0.227-0.321-0.391-0.471c-0.061-0.056-0.123-0.107-0.191-0.159
				c-0.477-0.361-1.059-0.569-1.598-0.569c-1.012,0-1.072,0-1.959,0c-0.729,0-1.77-0.559-1.77-1.893v-5.61h5.908V238.722
				L529.287,238.722z"/>
			<path fill="#0060A9" d="M529.287,238.722c0.127-0.219,0.326-0.438,0.58-0.63c0.477-0.361,1.059-0.569,1.598-0.569
				c1.01,0,1.072,0,1.959,0c0.729,0,1.766-0.559,1.766-1.893v-5.61h-5.902V238.722L529.287,238.722z"/>
			<path d="M533.799,225.548c0.004-0.047,0.01-0.104,0.018-0.173c0.16-0.039,0.316-0.157,0.381-0.36
				c0.006-0.021,0.012-0.041,0.018-0.061c0.006-0.016,0.008-0.034,0.014-0.051l0.158,0.079l0.059-0.188
				c0.131-0.423,0.062-0.688-0.072-0.825l-0.119,0.117c0.096,0.097,0.143,0.304,0.031,0.658c-0.188-0.093-0.203,0.077-0.248,0.22
				c-0.064,0.208-0.25,0.271-0.369,0.26c-0.084,0.597-0.021,0.592-0.021,0.592L533.799,225.548L533.799,225.548z"/>
			<path fill="#FFFFFF" d="M534.248,225.654c0,0-0.393-0.021-0.602,0.161l0.152-0.268c0.211-0.07,0.426-0.062,0.457-0.06
				l0.068,0.007l0.08,0.007L534.248,225.654L534.248,225.654z"/>
			<path fill="#FFFFFF" d="M533.848,223.937c0.105-0.083,0.248-0.11,0.381-0.061c0.053,0.02,0.102,0.05,0.145,0.093l-0.119,0.117
				c-0.119-0.121-0.318-0.069-0.383,0.085L533.848,223.937L533.848,223.937z"/>
			<path fill="#FFFFFF" d="M530.312,223.921l-0.037,0.183c-0.012,0.058-0.1,0.517,0.002,0.87l-0.01,0.008l-0.102,0.073l0.201,0.063
				l0.113-0.082c-0.16-0.316-0.041-0.898-0.041-0.898L530.312,223.921L530.312,223.921z"/>
			<path d="M531.168,225.134c0,0-0.387-0.203-0.408-0.326c-0.041-0.252,0.168-0.517-0.32-0.67l-0.127-0.217l0.178,0.057
				c0.486,0.154,0.457,0.449,0.438,0.645c-0.004,0.052-0.008,0.1-0.004,0.142h-0.002c0.027,0.034,0.113,0.099,0.213,0.159
				L531.168,225.134L531.168,225.134z"/>
			<path fill="#FFFFFF" d="M531.689,224.771c-0.18,0-0.395,0.024-0.555,0.153v-0.001l0.033,0.211
				c0.203-0.297,0.744-0.161,0.838-0.188c0.158-0.044,0.191-0.342,0.016-0.325c-0.02,0.002-0.113,0.036-0.199,0.024L531.689,224.771
				L531.689,224.771z"/>
			<path fill="#FFFFFF" d="M525.824,224.771c-0.18,0-0.395,0.024-0.553,0.153l-0.002-0.001l0.033,0.211
				c0.203-0.297,0.744-0.161,0.838-0.188c0.158-0.044,0.191-0.342,0.016-0.325c-0.02,0.002-0.113,0.036-0.199,0.024L525.824,224.771
				L525.824,224.771z"/>
			<path d="M530.793,225.708c-0.457-0.212-0.572-0.5-0.584-0.534l-0.043-0.119l0.201,0.063c0,0,0.102,0.288,0.592,0.479
				L530.793,225.708L530.793,225.708z"/>
			<line fill="none" stroke="#000000" stroke-width="0.0245" x1="527.258" y1="222.004" x2="529.287" y2="222.004"/>
			<path fill="#B3B5BE" d="M525.975,232.154c0.012-0.078,0.018-0.171,0.018-0.279h0.234c0.006,0.1,0.006,0.193,0,0.279H525.975
				L525.975,232.154z"/>
			<path fill="#E13A3E" d="M526.227,232.154c-0.055,0.68-0.494,0.903-0.799,0.898c-0.285-0.005-0.766-0.091-0.846-0.801h0.514
				c0.047,0.223,0.207,0.345,0.42,0.328c0.236-0.017,0.404-0.095,0.459-0.426H526.227L526.227,232.154z"/>
			<path fill="#E13A3E" d="M525.992,231.875c-0.107-0.089-0.096-0.286-0.002-0.345h0.232c0.098,0.055,0.111,0.256,0.004,0.345
				H525.992L525.992,231.875z"/>
			<polygon fill="#B3B5BE" points="525.99,231.53 525.99,231.251 526.223,231.251 526.223,231.53 525.99,231.53 			"/>
			<path fill="#E13A3E" d="M525.99,231.251c-0.066-0.104-0.115-0.3-0.088-0.465h0.414c0.027,0.165-0.027,0.362-0.094,0.465H525.99
				L525.99,231.251z"/>
			<path fill="#FFFFFF" d="M527.248,220.909c0.15-0.166,0.439-0.378,0.557-0.432v-0.167c-0.117,0.054-0.406,0.266-0.557,0.433
				V220.909L527.248,220.909z"/>
			<path fill="#BCBEC0" d="M526.752,220.706c0.023,0,0.357,0.065,0.496,0.203v-0.166c-0.139-0.139-0.473-0.204-0.496-0.204V220.706
				L526.752,220.706z"/>
			<path fill="#FFFFFF" d="M528.684,220.979c0.082-0.095,0.357-0.48,0.607-0.574v-0.167c-0.25,0.093-0.525,0.479-0.607,0.573
				V220.979L528.684,220.979z"/>
			<path fill="#BCBEC0" d="M527.805,220.478c0.312,0.058,0.789,0.415,0.879,0.502v-0.168c-0.09-0.086-0.566-0.443-0.879-0.501
				V220.478L527.805,220.478z"/>
			<path fill="#FFFFFF" d="M529.889,220.979c0.09-0.087,0.566-0.444,0.879-0.502v-0.167c-0.312,0.058-0.789,0.415-0.879,0.501
				V220.979L529.889,220.979z"/>
			<path fill="#BCBEC0" d="M529.291,220.405c0.248,0.094,0.516,0.479,0.598,0.574v-0.168c-0.082-0.094-0.35-0.48-0.598-0.573
				V220.405L529.291,220.405z"/>
			<path fill="#FFFFFF" d="M531.326,220.909c0.137-0.138,0.471-0.203,0.494-0.203v-0.167c-0.023,0-0.357,0.065-0.494,0.204V220.909
				L531.326,220.909z"/>
			<path fill="#BCBEC0" d="M530.768,220.478c0.117,0.054,0.406,0.266,0.559,0.432v-0.166c-0.152-0.167-0.441-0.379-0.559-0.433
				V220.478L530.768,220.478z"/>
			<path fill="#E13A3E" d="M528.928,220.521c-0.111,0.121-0.203,0.243-0.244,0.29c-0.09-0.086-0.566-0.443-0.879-0.501
				c-0.072,0.032-0.209,0.126-0.34,0.23c-0.129-0.172-0.561-1.011-0.318-1.251c0.223-0.221,0.824-0.016,1.307,0.148
				c0.109,0.038,0.213,0.072,0.311,0.103L528.928,220.521L528.928,220.521z"/>
			<path fill="#E13A3E" d="M529.646,220.521c0.111,0.121,0.201,0.243,0.242,0.29c0.09-0.086,0.566-0.443,0.879-0.501
				c0.072,0.032,0.211,0.125,0.342,0.23c0.131-0.172,0.559-1.011,0.318-1.251c-0.225-0.221-0.826-0.016-1.309,0.148
				c-0.109,0.038-0.213,0.072-0.312,0.103L529.646,220.521L529.646,220.521z"/>
			<path fill="#E13A3E" d="M526.979,229.341c-0.002-0.175,0.039-0.258,0.111-0.297v0.297H526.979L526.979,229.341z"/>
			<polygon fill="#8C1C1E" points="527.09,229.341 526.979,229.341 526.812,229.508 526.922,229.508 527.09,229.341 			"/>
			<path fill="#8C1C1E" d="M531.635,224.271c0,0-0.447,0.126-0.557-0.245l-0.23-0.188l0.07,0.237
				c0.104,0.346,0.416,0.405,0.639,0.38L531.635,224.271L531.635,224.271z"/>
			<path d="M531.557,224.455h0.002c-0.004,0.018-0.004,0.036-0.004,0.055c0.002,0.097,0.049,0.203,0.135,0.261l0.133-0.125
				c-0.096-0.014-0.143-0.195-0.053-0.212c0.072-0.013,0.15,0.004,0.203-0.008c0.078-0.018,0.062-0.167,0.037-0.204
				c-0.061-0.09-0.24-0.032-0.334-0.068l-0.068,0.067c0.01,0.017,0.02,0.032,0.027,0.051L531.557,224.455L531.557,224.455z"/>
			<path fill="#8C1C1E" d="M525.742,224.221c0.01,0.017,0.018,0.032,0.027,0.051c0,0-0.447,0.126-0.557-0.245l-0.23-0.188
				l0.07,0.237c0.104,0.346,0.416,0.405,0.639,0.38h0.002c-0.004,0.018-0.004,0.036-0.004,0.055
				c0.002,0.097,0.049,0.203,0.135,0.261l0.133-0.125c-0.096-0.014-0.143-0.195-0.053-0.212c0.074-0.013,0.15,0.004,0.205-0.008
				c0.074-0.018,0.061-0.167,0.035-0.204c-0.061-0.09-0.24-0.032-0.334-0.068L525.742,224.221L525.742,224.221z"/>
			<path fill="#FFFFFF" d="M532.27,223.351h-0.014l-0.012,0.002c-0.164,0.024-0.281,0.176-0.365,0.288
				c-0.016,0.021-0.031,0.043-0.043,0.059c-0.012,0.015-0.072,0.017-0.102,0.021c-0.084,0.011-0.211,0.028-0.246,0.154
				c-0.002,0.007-0.004,0.014-0.006,0.022c-0.062-0.02-0.107-0.026-0.215-0.026c-0.049,0-0.105-0.004-0.174-0.011l-0.246-0.022
				l0.23,0.188c0.328,0.031,0.402-0.027,0.529,0.194l0.068-0.067c-0.057-0.021-0.045-0.16-0.025-0.233
				c0.014-0.045,0.238-0.021,0.299-0.101c0.076-0.084,0.191-0.282,0.32-0.302l0,0l0.668,0.002l0.271-0.165L532.27,223.351
				L532.27,223.351z"/>
			<path fill="#E13A3E" d="M531.635,224.271c0,0-0.447,0.126-0.557-0.245c0.328,0.031,0.402-0.027,0.529,0.194
				C531.617,224.237,531.627,224.253,531.635,224.271L531.635,224.271z"/>
			<path fill="#E13A3E" d="M525.77,224.271c0,0-0.447,0.126-0.557-0.245c0.328,0.031,0.402-0.027,0.529,0.194
				C525.752,224.237,525.76,224.253,525.77,224.271L525.77,224.271z"/>
			<path fill="#FFFFFF" d="M533.576,233.175c0.098-0.064,0.266-0.098,0.266-0.098c0.104-0.369,0.119-0.537,0.119-0.537l-0.178,0.046
				c-0.002,0.013-0.023,0.056-0.057,0.401L533.576,233.175L533.576,233.175z"/>
			<path fill="#A67E04" d="M533.576,233.175c0,0-0.062,0.006,0.021-0.591c0,0,0.172,0,0.18-0.261
				c0.064,0.131,0.082,0.137,0.184,0.217l-0.178,0.046c-0.002,0.013-0.023,0.056-0.057,0.401L533.576,233.175L533.576,233.175z"/>
			<path fill="#EEB211" d="M533.777,232.323c0.064,0.131,0.082,0.137,0.184,0.217c0,0-0.016,0.168-0.119,0.537
				c0,0-0.168,0.033-0.266,0.098c0,0-0.062,0.006,0.021-0.591C533.598,232.584,533.77,232.584,533.777,232.323L533.777,232.323z
				 M530.707,232.798h-0.123c0.078,0.056,0.178,0.111,0.305,0.16l0.004,0.375h0.312c0,0-0.086,0.471-0.377,0.471
				c-0.357,0-0.289-0.286-0.506-0.316c-0.113-0.017-0.125,0.008-0.297,0.064c0,0,0.436,0.631,0.619,0.651l0.004,0.122
				c0,0,0.5-0.032,0.83-0.423c0,0,0.416,0.317,0.773,0.521c-1.436,0.173-1.523-0.017-1.432,1.572
				c0.008,0.142,0.01,0.321-0.156,0.353c-0.512,0.098-0.826-0.141-0.82,0.354l0.168-0.167l0.168,0.167l0.166-0.167l0.168,0.167
				l0.168-0.167l0.166,0.167h0.113c0.143-0.027,0.189-0.114,0.168-0.229h0.277l-0.006-0.841c0.051-0.531,0.619-0.581,0.912-0.559
				c0,0-0.129,0.809,0.484,0.754h0.254h0.502c0.025,0,0.088,0.006,0.139,0.058c0.031,0.029,0.051,0.068,0.057,0.11
				c0.006,0.142,0.008,0.321-0.158,0.353c-0.51,0.098-0.824-0.141-0.818,0.354l0.166-0.167l0.168,0.167l0.166-0.167l0.168,0.167
				l0.168-0.167l0.166,0.167h0.115c0.141-0.027,0.189-0.114,0.168-0.229h0.275c0.006-0.217,0.025-0.347-0.045-0.551
				c-0.066-0.195-0.58-0.219-0.752-0.341c-0.156-0.112-0.115-0.477-0.119-0.749l0.004-0.06c0.477-0.221,0.4-0.729,0.4-0.729
				c0.43-0.104,0.355-1.028,0.355-1.028c-0.1-0.011-0.137,0.029-0.137,0.029c0.074-0.255,0.086-0.526,0.086-0.526
				c0.309-0.113,0.182-0.602,0.184-0.781c0.004-0.23,0.07-0.412,0.07-0.412c-0.385-0.049-0.58,0.206-0.58,0.206
				c-0.092-0.168-0.504-0.136-0.504-0.136c0.053,0.225,0.029,0.578,0.023,0.765c-0.008,0.232,0.109,0.366,0.109,0.366
				c-0.057,0.244-0.029,0.226-0.049,0.374c-0.09,0.692,0.211,0.713,0.221,1.082c0.002,0.164-0.01,0.343-0.229,0.532
				c0,0-0.086-0.238-0.518-0.454c-0.396-0.197-0.316-0.757-0.324-0.782h0.455c0,0,0.049-0.178-0.064-0.684l0.113-0.002
				c0,0-0.031-0.502-0.146-0.79h0.119c0,0-0.021-0.569-0.205-0.792l0.066-0.13l-0.127-0.084c0,0-0.139,0.203-0.225,0.139
				c-0.102-0.077,0.018-0.228,0.049-0.257l-0.176-0.124l-0.178,0.128c0,0,0.154,0.2,0.027,0.273c-0.1,0.057-0.182-0.08-0.207-0.151
				l-0.188,0.106l0.096,0.119c0,0-0.072,0.024-0.189,0.186c-0.045,0.062-0.135,0.018-0.17,0.064
				c-0.029,0.069-0.033,0.211,0.025,0.233c0.092,0.036,0.271-0.022,0.332,0.07c0.025,0.036,0.041,0.185-0.035,0.202
				c-0.055,0.013-0.133-0.005-0.205,0.008c-0.088,0.017-0.043,0.197,0.055,0.212c0.084,0.013,0.178-0.022,0.199-0.024
				c0.174-0.017,0.143,0.28-0.016,0.326c-0.061,0.017-0.295-0.031-0.514,0.005C531.287,232.645,530.957,232.798,530.707,232.798
				L530.707,232.798z"/>
			<path fill="#FFFFFF" d="M535.189,222.721h-11.811v12.909c0,0.61,0.219,1.059,0.525,1.365l-0.117,0.118
				c-0.377-0.375-0.574-0.888-0.574-1.483v-12.909v-0.168h0.166h11.811h0.168L535.189,222.721L535.189,222.721z"/>
			<path fill="#002E5E" d="M535.189,230.02v5.61c0,1.334-1.037,1.893-1.766,1.893c-0.887,0-0.949,0-1.959,0
				c-0.539,0-1.121,0.208-1.598,0.569c-0.254,0.192-0.453,0.411-0.58,0.63l-0.002,0.541c0.004-0.669,1.09-1.573,2.18-1.573h1.959
				c0.443,0,0.916-0.182,1.266-0.487c0.305-0.266,0.668-0.754,0.668-1.572v-5.61H535.189L535.189,230.02z"/>
			<polygon fill="#A67E04" points="535.357,230.02 535.357,222.721 535.357,222.553 535.189,222.721 535.189,230.02 535.357,230.02 
							"/>
			<path fill="#8C1C1E" d="M525.324,232.353c-0.059-0.062-0.086-0.174-0.076-0.309c0.07-0.067,0.117-0.158,0.131-0.258
				c0.012-0.106-0.016-0.212-0.076-0.299c0.008-0.186,0.059-0.357,0.246-0.594l0.211-0.271l-0.344,0.168
				c-0.217,0.276-0.281,0.488-0.281,0.754c0.129,0.13,0.09,0.331-0.045,0.412c-0.033,0.23,0.014,0.404,0.113,0.512L525.324,232.353
				L525.324,232.353z"/>
			<path fill="#8C1C1E" d="M526.459,230.623l0.021,0.136c0.033,0.197-0.02,0.403-0.086,0.534v0.169
				c0.043,0.055,0.068,0.128,0.074,0.207c0.006,0.1-0.02,0.194-0.072,0.268c0.02,0.54-0.156,0.845-0.311,1.007
				c-0.17,0.179-0.424,0.28-0.66,0.276c-0.311-0.005-0.559-0.102-0.732-0.284l0.119-0.118c0.184,0.198,0.439,0.232,0.615,0.235
				c0.342,0.006,0.857-0.278,0.799-1.178c0.107-0.089,0.094-0.291-0.004-0.347v-0.277c0.066-0.103,0.121-0.3,0.094-0.465
				L526.459,230.623L526.459,230.623z"/>
			<path fill="#FFFFFF" d="M525.76,230.622l-0.023,0.137c-0.031,0.197,0.02,0.403,0.086,0.534v0.169
				c-0.041,0.055-0.068,0.128-0.072,0.207c-0.006,0.1,0.02,0.194,0.072,0.268c-0.006,0.455-0.156,0.465-0.32,0.478
				c-0.076,0.005-0.135-0.016-0.178-0.062l-0.121,0.115c0.076,0.082,0.186,0.122,0.312,0.112c0.293-0.021,0.48-0.136,0.477-0.705
				l0,0c-0.107-0.087-0.096-0.286-0.002-0.345v-0.279c-0.066-0.104-0.115-0.3-0.088-0.465h0.414l0.143-0.163L525.76,230.622"/>
			<path fill="#FFFFFF" d="M524.246,230.79h1.17l0.344-0.168h-1.857l0.211,0.271c0.188,0.236,0.238,0.409,0.246,0.594
				c-0.061,0.087-0.088,0.192-0.076,0.299c0.012,0.095,0.055,0.182,0.119,0.248c0,0.396,0.098,0.699,0.291,0.901l0.119-0.118
				c-0.15-0.158-0.256-0.423-0.24-0.861c-0.137-0.081-0.174-0.282-0.043-0.412C524.529,231.278,524.463,231.066,524.246,230.79
				L524.246,230.79z"/>
			<path fill="#B3B5BE" d="M525.922,235.876c-0.01-0.088-0.014-0.186-0.01-0.296h0.52c-0.018,0.112-0.016,0.212,0.004,0.296H525.922
				L525.922,235.876z"/>
			<path fill="#B3B5BE" d="M527.314,235.778c0.012-0.078,0.018-0.171,0.018-0.279l0.234-0.001c0.008,0.102,0.006,0.194,0,0.28
				H527.314L527.314,235.778z"/>
			<path fill="#E13A3E" d="M527.566,235.778c-0.055,0.681-0.494,0.903-0.797,0.899c-0.285-0.005-0.768-0.092-0.848-0.802h0.514
				c0.049,0.223,0.207,0.345,0.42,0.328c0.236-0.018,0.404-0.095,0.459-0.426H527.566L527.566,235.778z"/>
			<path fill="#E13A3E" d="M527.332,235.498c-0.107-0.087-0.094-0.285-0.002-0.344h0.232c0.098,0.055,0.113,0.255,0.004,0.344
				H527.332L527.332,235.498z"/>
			<polygon fill="#B3B5BE" points="527.33,235.154 527.33,234.875 527.562,234.875 527.562,235.154 527.33,235.154 			"/>
			<path fill="#E13A3E" d="M527.33,234.875c-0.064-0.103-0.113-0.3-0.088-0.465h0.414c0.025,0.166-0.027,0.363-0.094,0.465H527.33
				L527.33,234.875z"/>
			<path fill="#E13A3E" d="M525.867,235.168c-0.129,0.131-0.092,0.331,0.045,0.412h0.52c0.135-0.081,0.172-0.281,0.043-0.412
				H525.867L525.867,235.168z"/>
			<path fill="#E13A3E" d="M525.832,234.873c-0.039-0.146-0.115-0.292-0.246-0.458h1.17c-0.131,0.168-0.207,0.312-0.246,0.458
				H525.832L525.832,234.873z"/>
			<path fill="#B3B5BE" d="M526.51,234.873c-0.025,0.096-0.035,0.19-0.035,0.295h-0.607c0-0.104-0.01-0.199-0.035-0.295H526.51
				L526.51,234.873z"/>
			<path fill="#8C1C1E" d="M526.664,235.978c-0.059-0.063-0.086-0.174-0.076-0.31c0.07-0.067,0.117-0.158,0.131-0.257
				c0.012-0.106-0.016-0.213-0.076-0.299c0.008-0.186,0.059-0.357,0.244-0.595l0.213-0.271l-0.344,0.168
				c-0.217,0.275-0.281,0.487-0.281,0.753c0.129,0.131,0.092,0.331-0.043,0.412c-0.035,0.231,0.012,0.405,0.111,0.512
				L526.664,235.978L526.664,235.978z"/>
			<path fill="#8C1C1E" d="M527.799,234.247l0.021,0.135c0.031,0.199-0.02,0.403-0.086,0.535v0.17
				c0.043,0.055,0.068,0.127,0.074,0.207c0.006,0.099-0.018,0.193-0.072,0.267c0.02,0.54-0.156,0.845-0.311,1.007
				c-0.17,0.179-0.424,0.28-0.66,0.277c-0.311-0.006-0.557-0.102-0.732-0.284l0.119-0.119c0.186,0.197,0.439,0.232,0.617,0.236
				c0.34,0.005,0.855-0.278,0.797-1.18c0.109-0.089,0.094-0.291-0.004-0.347v-0.276c0.066-0.102,0.119-0.299,0.094-0.465
				L527.799,234.247L527.799,234.247z"/>
			<path fill="#FFFFFF" d="M527.1,234.247l-0.021,0.135c-0.033,0.199,0.018,0.403,0.086,0.535v0.17
				c-0.043,0.055-0.07,0.127-0.074,0.207c-0.006,0.099,0.02,0.193,0.074,0.267c-0.006,0.456-0.158,0.466-0.32,0.477
				c-0.076,0.006-0.137-0.014-0.18-0.06l-0.121,0.114c0.076,0.082,0.184,0.122,0.312,0.112c0.293-0.021,0.482-0.136,0.477-0.705l0,0
				c-0.107-0.088-0.094-0.286-0.002-0.345v-0.279c-0.064-0.103-0.113-0.3-0.088-0.465h0.414l0.143-0.163H527.1"/>
			<path fill="#FFFFFF" d="M525.586,234.415h1.17l0.344-0.168h-1.857l0.213,0.271c0.186,0.236,0.236,0.409,0.244,0.595
				c-0.061,0.086-0.088,0.191-0.076,0.299c0.012,0.093,0.055,0.182,0.119,0.247c0,0.396,0.098,0.699,0.291,0.902l0.119-0.119
				c-0.15-0.159-0.256-0.423-0.24-0.861c-0.137-0.081-0.174-0.281-0.045-0.412C525.867,234.902,525.803,234.69,525.586,234.415
				L525.586,234.415z"/>
			<polygon fill="#E13A3E" points="527.424,222.171 531.148,222.171 531.148,222.386 527.424,222.386 527.424,222.171 			"/>
			<path fill="#BCBEC0" d="M526.828,220.445c-0.051-0.112-0.105-0.247-0.15-0.39l0.002-0.001c-0.064,0.036-0.105,0.104-0.105,0.184
				c0,0.115,0.094,0.211,0.213,0.211C526.801,220.449,526.814,220.447,526.828,220.445L526.828,220.445L526.828,220.445z"/>
			<path fill="#BCBEC0" d="M531.893,220.054c-0.045,0.144-0.098,0.279-0.15,0.392l0,0c0.014,0.002,0.029,0.004,0.045,0.004
				c0.117,0,0.211-0.096,0.211-0.211C531.998,220.159,531.955,220.09,531.893,220.054L531.893,220.054L531.893,220.054z"/>
			<path fill="#FFFFFF" d="M529.203,219.008l-0.242,0.241c-0.574-0.18-1.412-0.569-1.922-0.285
				c-0.662,0.373,0.029,1.617,0.094,1.698c-0.078-0.043-0.17-0.074-0.244-0.095l0,0c-0.146-0.286-0.367-0.822-0.283-1.25
				c0.043-0.222,0.164-0.395,0.352-0.498c0.486-0.272,1.178-0.031,1.734,0.163c0.078,0.026,0.15,0.052,0.221,0.076L529.203,219.008
				L529.203,219.008z"/>
			<path fill="#A67E04" d="M531.768,218.934c0.102,0.101,0.168,0.231,0.199,0.384c0.084,0.429-0.137,0.965-0.283,1.251
				c-0.076,0.021-0.166,0.051-0.246,0.094l0,0c0.061-0.076,0.668-1.162,0.213-1.61L531.768,218.934L531.768,218.934z"/>
			<path fill="#FFFFFF" d="M531.537,219.165c0.002,0.002,0.004,0.004,0.008,0.007c0.375,0.37-0.244,1.4-0.309,1.481l0,0
				c-0.039-0.037-0.084-0.074-0.127-0.109c0.131-0.172,0.559-1.014,0.318-1.254c-0.004-0.002-0.006-0.005-0.01-0.008
				L531.537,219.165L531.537,219.165z"/>
			<path fill="#A67E04" d="M531.418,219.282c-0.229-0.207-0.822-0.006-1.299,0.156c-0.109,0.038-0.213,0.072-0.312,0.103
				l-0.16,0.979h0.002c-0.047-0.051-0.096-0.102-0.146-0.146v0.001l0.158-0.964c0.605-0.174,1.498-0.603,1.877-0.246
				L531.418,219.282L531.418,219.282z"/>
			<path fill="#FFFFFF" d="M528.912,219.411l0.162,0.967l0,0c-0.051,0.044-0.1,0.094-0.146,0.143v0.001l-0.164-0.98L528.912,219.411
				L528.912,219.411z"/>
			<path fill="#A67E04" d="M528.764,219.541c-0.098-0.03-0.201-0.064-0.311-0.103c-0.482-0.164-1.084-0.369-1.307-0.148
				c-0.242,0.24,0.189,1.079,0.318,1.251l0,0c-0.045,0.038-0.088,0.075-0.129,0.112l0.002-0.003
				c-0.066-0.081-0.684-1.108-0.311-1.479c0.373-0.369,1.273,0.064,1.885,0.239L528.764,219.541L528.764,219.541z"/>
			<polygon fill="#8C1C1E" points="527.424,222.386 527.258,222.553 531.314,222.553 531.314,222.004 531.148,222.171 
				531.148,222.386 527.424,222.386 			"/>
			<polygon fill="#FFFFFF" points="531.148,222.171 531.314,222.004 527.258,222.004 527.258,222.553 527.424,222.386 
				527.424,222.171 531.148,222.171 			"/>
			<path fill="#FFFFFF" d="M525.811,224.153c-0.057-0.021-0.055-0.164-0.025-0.233c0.035-0.047,0.127-0.004,0.172-0.064
				c0.115-0.158,0.199-0.171,0.199-0.171l-0.105-0.134l0.186-0.107l-0.123-0.12l-0.145,0.083l-0.168,0.097l0.113,0.145v0.001
				c-0.027,0.03-0.051,0.059-0.064,0.076c-0.012,0.021-0.035,0.021-0.035,0.021c-0.139-0.018-0.166,0.068-0.178,0.1
				c-0.006,0.016-0.014,0.033-0.018,0.053c-0.062-0.02-0.109-0.026-0.217-0.026c-0.049,0-0.105-0.004-0.174-0.011l-0.246-0.022
				l0.23,0.188c0.328,0.031,0.402-0.027,0.531,0.194L525.811,224.153L525.811,224.153z"/>
			<path fill="#8C1C1E" d="M528.611,232.974c-0.17,0.16-0.406,0.25-0.629,0.246c-0.312-0.005-0.559-0.102-0.732-0.284l0.135-0.135
				c0.188,0.213,0.449,0.249,0.631,0.252c0.174,0.003,0.389-0.067,0.555-0.255L528.611,232.974L528.611,232.974z"/>
			<path fill="#71737A" d="M528.57,232.798h-0.705c-0.199,0-0.402-0.086-0.547-0.229l0.113-0.123
				c0.127,0.128,0.295,0.186,0.434,0.186c0.303,0,0.324,0,0.672,0c0.266,0,0.531,0.156,0.664,0.33l-0.227,0.226
				c-0.105-0.105-0.23-0.185-0.363-0.213L528.57,232.798L528.57,232.798z"/>
			<path fill="#FFFFFF" d="M530.727,233.5l-0.002-0.165l-0.002-0.267c-0.072-0.033-0.135-0.066-0.191-0.103l0.053-0.168
				c0.078,0.056,0.178,0.111,0.305,0.16l0.004,0.375L530.727,233.5L530.727,233.5z"/>
			<polygon fill="#A67E04" points="531.205,233.333 530.893,233.333 530.727,233.5 530.893,233.5 530.98,233.5 531.205,233.333 			
				"/>
			<path fill="#FFFFFF" d="M529.762,233.464l0.211-0.07c0.041-0.014,0.072-0.025,0.098-0.035c0.098-0.036,0.154-0.055,0.275-0.037
				c0.162,0.023,0.24,0.125,0.291,0.192s0.082,0.126,0.211,0.126c0.051,0,0.096-0.06,0.133-0.14l0.225-0.167
				c0,0-0.086,0.471-0.377,0.471c-0.357,0-0.289-0.286-0.506-0.316c-0.113-0.017-0.125,0.008-0.297,0.064L529.762,233.464
				L529.762,233.464z"/>
			<path fill="#A67E04" d="M530.645,234.203c-0.184-0.021-0.619-0.651-0.619-0.651l-0.264-0.088l0.127,0.184
				c0.004,0.007,0.115,0.164,0.248,0.328c0.154,0.188,0.262,0.285,0.344,0.336L530.645,234.203L530.645,234.203z"/>
			<polygon fill="#FFFFFF" points="530.488,234.503 530.482,234.33 530.48,234.312 530.645,234.203 530.648,234.325 
				530.488,234.503 			"/>
			<path fill="#A67E04" d="M532.252,234.424c-0.357-0.204-0.773-0.521-0.773-0.521c-0.33,0.391-0.83,0.423-0.83,0.423l-0.16,0.178
				l0.17-0.011c0.021-0.002,0.477-0.034,0.84-0.368c0.066,0.05,0.158,0.115,0.26,0.185L532.252,234.424L532.252,234.424z"/>
			<path fill="#FFFFFF" d="M529.68,236.87l-0.004-0.167c0-0.114,0.012-0.279,0.121-0.388c0.115-0.115,0.275-0.111,0.445-0.108
				c0.113,0.003,0.285,0,0.352-0.019c0.064-0.019,0.068-0.051,0.061-0.183c-0.045-0.765-0.047-1.124,0.115-1.358
				c0.17-0.247,0.465-0.284,0.988-0.339l0,0l0.494,0.115c-1.436,0.173-1.523-0.017-1.432,1.572c0.008,0.142,0.01,0.321-0.156,0.353
				c-0.512,0.098-0.826-0.141-0.82,0.354L529.68,236.87L529.68,236.87z"/>
			<path fill="#A67E04" d="M532.312,235.074c-0.293-0.022-0.861,0.027-0.912,0.559l0.006,0.841h-0.277
				c0.021,0.114-0.025,0.201-0.168,0.229h-1.117l-0.164,0.168h0.164h1.117h0.016l0.018-0.004c0.146-0.029,0.25-0.111,0.289-0.226
				h-0.002h0.125h0.168v-0.168l-0.006-0.84v0.015c0.029-0.323,0.334-0.399,0.564-0.409L532.312,235.074L532.312,235.074z"/>
			<path fill="#FFFFFF" d="M532.32,235.828c-0.158-0.169-0.188-0.419-0.188-0.591v0.001l0.18-0.164c0,0-0.068,0.42,0.125,0.635
				L532.32,235.828L532.32,235.828z"/>
			<path fill="#FFFFFF" d="M526.525,228.467c-0.156-0.168-0.186-0.418-0.186-0.59l0,0l0.18-0.163c0,0-0.068,0.42,0.123,0.634
				L526.525,228.467L526.525,228.467z"/>
			<path fill="#A67E04" d="M533.691,235.886c-0.051-0.052-0.113-0.058-0.139-0.058h-0.502h-0.254
				c-0.172,0.015-0.285-0.036-0.359-0.119l-0.117,0.119c0.082,0.088,0.234,0.189,0.49,0.167h-0.014h0.254h0.502
				c0,0,0.014,0,0.021,0.009L533.691,235.886L533.691,235.886z"/>
			<path fill="#8C1C1E" d="M527.088,228.468h-0.086c-0.172,0.016-0.283-0.037-0.359-0.12l-0.117,0.119
				c0.072,0.077,0.195,0.164,0.396,0.171L527.088,228.468L527.088,228.468z"/>
			<path fill="#FFFFFF" d="M532.605,236.87l-0.002-0.167c0-0.114,0.01-0.279,0.119-0.388c0.117-0.115,0.277-0.111,0.447-0.108
				c0.113,0.003,0.285-0.003,0.352-0.019c0.09-0.022,0.061-0.134,0.061-0.163c0-0.011-0.004-0.018-0.008-0.021l0.117-0.118
				c0.031,0.029,0.051,0.068,0.057,0.11c0.006,0.142,0.008,0.321-0.158,0.353c-0.51,0.098-0.824-0.141-0.818,0.354L532.605,236.87
				L532.605,236.87z"/>
			<path fill="#A67E04" d="M534.287,235.923c0.07,0.204,0.051,0.334,0.045,0.551h-0.275c0.021,0.114-0.027,0.201-0.168,0.229h-1.117
				l-0.166,0.168h0.166h1.117h0.016l0.016-0.004c0.148-0.029,0.25-0.111,0.289-0.226l0,0h0.123h0.17l0.002-0.251
				c0.006-0.17,0.01-0.317-0.059-0.521c-0.008-0.025-0.02-0.049-0.033-0.071L534.287,235.923L534.287,235.923z"/>
			<path fill="#FFFFFF" d="M533.633,235.446c0.043,0.031,0.143,0.056,0.244,0.084c0.215,0.059,0.436,0.119,0.535,0.268l-0.125,0.125
				c-0.066-0.195-0.58-0.219-0.752-0.341c-0.008-0.006-0.014-0.012-0.02-0.018L533.633,235.446L533.633,235.446z"/>
			<path fill="#A67E04" d="M534.176,233.016c0,0,0.074,0.925-0.355,1.028c0,0,0.076,0.509-0.4,0.729l-0.004,0.06
				c0.004,0.259-0.035,0.603,0.1,0.731l0.117-0.118c-0.057-0.04-0.053-0.351-0.051-0.482l0.004-0.09
				c0.311-0.19,0.4-0.503,0.406-0.724c0.41-0.241,0.357-1.049,0.35-1.148l-0.01-0.139L534.176,233.016L534.176,233.016z"/>
			<path fill="#FFFFFF" d="M534.254,232.854l0.078,0.009l-0.156,0.152c-0.1-0.011-0.137,0.029-0.137,0.029L534.254,232.854
				L534.254,232.854z"/>
			<path fill="#A67E04" d="M534.379,231.325c0,0-0.066,0.182-0.07,0.412c-0.002,0.18,0.125,0.668-0.184,0.781
				c0,0-0.012,0.271-0.086,0.526l0.215-0.19c0.016-0.09,0.025-0.171,0.031-0.23c0.258-0.174,0.221-0.552,0.199-0.766
				c-0.004-0.047-0.008-0.093-0.008-0.119c0.002-0.196,0.059-0.354,0.061-0.355l0.072-0.198L534.379,231.325L534.379,231.325z"/>
			<path fill="#FFFFFF" d="M533.795,231.309c0.119-0.089,0.322-0.186,0.605-0.149l0.209,0.026l-0.23,0.14
				c-0.385-0.049-0.58,0.206-0.58,0.206L533.795,231.309L533.795,231.309z"/>
			<path fill="#FFFFFF" d="M533.498,231.23c-0.092-0.009-0.172-0.005-0.217-0.002l-0.193,0.016c0.07,0.247,0.082,0.511,0.084,0.553
				l0.006,0.173h-0.066c0.068,0.283,0.088,0.595,0.088,0.611l0.012,0.174l-0.09,0.002l0.002-0.001
				c0.064,0.376,0.049,0.534,0.041,0.565l-0.018,0.124c0.049,0.146,0.195,0.184,0.279,0.542c0.021,0.09,0.004,0.173-0.041,0.254
				c-0.082-0.092-0.211-0.2-0.406-0.304l-0.125,0.123c0.432,0.216,0.518,0.454,0.518,0.454c0.219-0.189,0.23-0.368,0.229-0.532
				c-0.01-0.369-0.311-0.39-0.221-1.082c0.02-0.148-0.008-0.13,0.049-0.374c0,0-0.117-0.134-0.109-0.366
				c0.006-0.187,0.029-0.54-0.023-0.765c0,0,0.096-0.008,0.205,0.003L533.498,231.23L533.498,231.23z"/>
			<path fill="#FFFFFF" d="M527.703,223.869c-0.092-0.008-0.172-0.004-0.215-0.001l-0.193,0.015c0.07,0.249,0.082,0.511,0.084,0.553
				l0.006,0.174l-0.066-0.001c0.066,0.283,0.086,0.596,0.088,0.612l0.012,0.174l-0.09,0.002h0.002
				c0.064,0.375,0.049,0.533,0.041,0.564l-0.018,0.124c0.049,0.146,0.193,0.184,0.277,0.542c0.023,0.09,0.004,0.173-0.039,0.254
				c-0.082-0.092-0.213-0.201-0.408-0.305l-0.123,0.124c0.432,0.215,0.518,0.455,0.518,0.455c0.219-0.19,0.23-0.368,0.227-0.532
				c-0.008-0.37-0.309-0.391-0.219-1.082c0.018-0.149-0.008-0.131,0.047-0.375c0,0-0.117-0.134-0.109-0.365
				c0.008-0.188,0.029-0.542-0.021-0.766c0,0,0.096-0.009,0.205,0.003L527.703,223.869L527.703,223.869z"/>
			<path fill="#A67E04" d="M533.5,231.398c0.119,0.013,0.252,0.046,0.299,0.133l-0.004-0.223c-0.09-0.049-0.199-0.07-0.297-0.078
				L533.5,231.398L533.5,231.398z"/>
			<path fill="#8C1C1E" d="M527.707,224.038c0.117,0.012,0.252,0.046,0.299,0.133L528,223.948c-0.09-0.049-0.199-0.07-0.297-0.079
				L527.707,224.038L527.707,224.038z"/>
			<path fill="#A67E04" d="M532.867,230.881l-0.066,0.13c0.184,0.223,0.205,0.792,0.205,0.792h-0.119
				c0.115,0.288,0.146,0.79,0.146,0.79l-0.113,0.002c0.113,0.506,0.064,0.684,0.064,0.684h-0.455
				c0.008,0.025-0.072,0.585,0.324,0.782l0.125-0.123c-0.016-0.009-0.033-0.018-0.051-0.026c-0.143-0.07-0.221-0.228-0.232-0.467
				v0.001h0.289h0.162l0.018-0.124c0.008-0.031,0.023-0.189-0.041-0.565l-0.002,0.001l0.09-0.002l-0.012-0.174
				c0-0.017-0.02-0.328-0.088-0.611h0.066l-0.006-0.173c-0.002-0.058-0.023-0.515-0.18-0.798l0.023-0.044l0.066-0.134
				L532.867,230.881L532.867,230.881z"/>
			<polygon fill="#FFFFFF" points="530.959,225.598 530.963,225.972 530.799,226.139 530.797,225.973 530.793,225.708 
				530.959,225.598 			"/>
			<polygon points="531.277,225.972 530.963,225.972 530.799,226.139 530.963,226.139 531.053,226.139 531.277,225.972 			"/>
			<path fill="#FFFFFF" d="M529.834,226.104l0.211-0.07c0.039-0.014,0.07-0.024,0.098-0.034c0.098-0.037,0.154-0.056,0.275-0.038
				c0.162,0.023,0.238,0.125,0.289,0.191c0.053,0.068,0.082,0.126,0.213,0.126c0.051,0,0.096-0.059,0.133-0.14l0.225-0.167
				c0,0-0.086,0.473-0.379,0.473c-0.355,0-0.289-0.287-0.504-0.317c-0.115-0.017-0.127,0.008-0.297,0.065L529.834,226.104
				L529.834,226.104z"/>
			<path d="M530.715,226.843c-0.182-0.021-0.617-0.65-0.617-0.65l-0.264-0.089l0.125,0.183c0.006,0.007,0.115,0.166,0.25,0.33
				c0.154,0.187,0.262,0.284,0.342,0.336L530.715,226.843L530.715,226.843z"/>
			<polygon fill="#FFFFFF" points="530.559,227.143 530.553,226.971 530.551,226.952 530.715,226.843 530.721,226.965 
				530.559,227.143 			"/>
			<path d="M532.324,227.062c-0.359-0.202-0.773-0.52-0.773-0.52c-0.33,0.391-0.83,0.423-0.83,0.423l-0.162,0.178l0.172-0.011
				c0.021-0.002,0.477-0.035,0.838-0.368c0.068,0.05,0.158,0.114,0.262,0.185L532.324,227.062L532.324,227.062z"/>
			<path fill="#8C1C1E" d="M526.459,227.062c-0.359-0.202-0.773-0.52-0.773-0.52c-0.33,0.391-0.83,0.423-0.83,0.423l-0.162,0.178
				l0.172-0.011c0.021-0.002,0.477-0.035,0.838-0.368c0.068,0.05,0.158,0.114,0.262,0.185L526.459,227.062L526.459,227.062z"/>
			<path fill="#FFFFFF" d="M523.885,229.508l-0.002-0.165c-0.002-0.114,0.01-0.279,0.119-0.388c0.117-0.115,0.277-0.112,0.445-0.108
				c0.115,0.003,0.287,0,0.354-0.02c0.064-0.018,0.066-0.051,0.061-0.182c-0.045-0.765-0.049-1.124,0.115-1.358
				c0.17-0.246,0.463-0.284,0.986-0.339h0.002l0.494,0.113c-1.438,0.175-1.523-0.016-1.432,1.574c0.008,0.141,0.01,0.32-0.158,0.353
				c-0.51,0.098-0.824-0.142-0.818,0.353L523.885,229.508L523.885,229.508z"/>
			<path fill="#8C1C1E" d="M526.52,227.714c-0.293-0.022-0.863,0.027-0.912,0.559l0.006,0.842h-0.277
				c0.021,0.113-0.027,0.2-0.168,0.227h-1.117l-0.166,0.167h0.166h1.117h0.016l0.018-0.002c0.146-0.029,0.248-0.111,0.289-0.226
				h-0.002h0.125h0.168l-0.002-0.168l-0.004-0.841l-0.002,0.017c0.031-0.324,0.336-0.4,0.566-0.411L526.52,227.714L526.52,227.714z"
				/>
			<path fill="#FFFFFF" d="M532.557,228.467c-0.156-0.168-0.186-0.418-0.184-0.59l0,0l0.178-0.163c0,0-0.066,0.42,0.125,0.634
				L532.557,228.467L532.557,228.467z"/>
			<path d="M533.764,228.525c-0.051-0.052-0.115-0.058-0.139-0.058h-0.336h-0.254c-0.172,0.016-0.285-0.037-0.359-0.12l-0.119,0.119
				c0.084,0.089,0.236,0.19,0.492,0.167l-0.014,0.001h0.254h0.336c0,0,0.012,0,0.02,0.009L533.764,228.525L533.764,228.525z"/>
			<path fill="#FFFFFF" d="M532.678,229.508l-0.002-0.165c-0.002-0.114,0.01-0.279,0.119-0.388c0.117-0.115,0.275-0.112,0.445-0.108
				c0.115,0.003,0.285-0.003,0.352-0.02c0.092-0.021,0.061-0.134,0.061-0.163c0-0.009-0.002-0.017-0.008-0.021l0.119-0.118
				c0.029,0.029,0.049,0.068,0.055,0.11c0.008,0.141,0.01,0.32-0.156,0.353c-0.51,0.098-0.824-0.142-0.82,0.353L532.678,229.508
				L532.678,229.508z"/>
			<path d="M534.359,228.562c0.068,0.203,0.051,0.334,0.045,0.552h-0.275c0.021,0.113-0.027,0.2-0.17,0.227h-1.117l-0.164,0.167
				h0.164h1.117h0.016l0.018-0.002c0.146-0.029,0.248-0.111,0.289-0.226h-0.002h0.125h0.168l0.002-0.251
				c0.006-0.171,0.012-0.317-0.059-0.521c-0.008-0.025-0.02-0.05-0.033-0.07L534.359,228.562L534.359,228.562z"/>
			<path fill="#FFFFFF" d="M533.705,228.087c0.043,0.03,0.143,0.055,0.244,0.083c0.213,0.059,0.436,0.118,0.533,0.269l-0.123,0.124
				c-0.068-0.195-0.582-0.218-0.752-0.341c-0.008-0.005-0.014-0.012-0.021-0.018L533.705,228.087L533.705,228.087z"/>
			<path d="M534.248,225.654c0,0,0.072,0.926-0.355,1.029c0,0,0.076,0.509-0.402,0.729l-0.004,0.06
				c0.006,0.259-0.033,0.602,0.1,0.731l0.119-0.117c-0.057-0.041-0.055-0.352-0.053-0.484l0.004-0.09
				c0.311-0.188,0.402-0.502,0.408-0.722c0.408-0.243,0.357-1.05,0.35-1.149l-0.01-0.14L534.248,225.654L534.248,225.654z"/>
			<path fill="#FFFFFF" d="M533.16,223.883c0.07,0.249,0.082,0.511,0.082,0.553l0.006,0.174l-0.064-0.001
				c0.066,0.283,0.086,0.596,0.088,0.612l0.012,0.174l-0.09,0.002h0.002c0.064,0.375,0.049,0.533,0.039,0.564l-0.016,0.124
				c0.047,0.146,0.193,0.184,0.279,0.542c0.02,0.09,0.002,0.173-0.041,0.254c-0.084-0.092-0.213-0.201-0.408-0.305l-0.123,0.124
				c0.432,0.215,0.516,0.455,0.516,0.455c0.221-0.19,0.232-0.368,0.229-0.532c-0.008-0.37-0.309-0.391-0.219-1.082
				c0.018-0.149-0.01-0.131,0.049-0.375c0,0-0.119-0.134-0.111-0.365c0.008-0.188,0.029-0.542-0.021-0.766L533.16,223.883
				L533.16,223.883z"/>
			<path d="M533.367,224.035c0,0,0.41-0.032,0.504,0.136l-0.023-0.234c-0.184-0.085-0.404-0.075-0.494-0.068l-0.193,0.015
				L533.367,224.035L533.367,224.035z"/>
			<path d="M532.938,223.52l-0.064,0.13c0.182,0.223,0.203,0.793,0.203,0.793h-0.117c0.113,0.288,0.145,0.789,0.145,0.789
				l-0.111,0.002c0.111,0.506,0.064,0.685,0.064,0.685h-0.455c0.006,0.025-0.074,0.585,0.324,0.782l0.123-0.124
				c-0.016-0.009-0.031-0.017-0.049-0.025c-0.143-0.071-0.221-0.229-0.232-0.466l0,0h0.289h0.162l0.016-0.124
				c0.01-0.031,0.025-0.189-0.039-0.564h-0.002l0.09-0.002l-0.012-0.174c-0.002-0.017-0.021-0.329-0.088-0.612l0.064,0.001
				l-0.006-0.174c-0.002-0.057-0.023-0.515-0.178-0.797l0.145-0.284L532.938,223.52L532.938,223.52z"/>
			<polygon fill="#FFFFFF" points="532.74,230.797 532.867,230.881 533.082,230.821 532.957,230.741 532.859,230.676 
				532.74,230.797 			"/>
			<polygon fill="#EEB211" points="532.211,230.683 532.389,230.555 532.564,230.679 532.686,230.558 532.662,230.543 
				532.484,230.418 532.387,230.349 532.291,230.419 532.113,230.548 532.09,230.562 532.211,230.683 			"/>
			<path fill="#A67E04" d="M532.211,230.683c0,0,0.154,0.2,0.027,0.273c-0.1,0.057-0.182-0.08-0.207-0.151l-0.125-0.122l0.041-0.023
				l0.143-0.097L532.211,230.683L532.211,230.683z"/>
			<path fill="#A67E04" d="M532.564,230.679c-0.031,0.029-0.15,0.18-0.049,0.257c0.086,0.064,0.225-0.139,0.225-0.139l0.119-0.121
				l-0.027-0.019l-0.146-0.1L532.564,230.679L532.564,230.679z"/>
			<path fill="#FFFFFF" d="M527.783,225.815c0.096-0.065,0.266-0.099,0.266-0.099c0.104-0.368,0.119-0.536,0.119-0.536l-0.178,0.045
				c-0.002,0.013-0.023,0.056-0.057,0.401L527.783,225.815L527.783,225.815z"/>
			<path fill="#8C1C1E" d="M527.783,225.815c0,0-0.062,0.005,0.02-0.592c0,0,0.172,0,0.182-0.262
				c0.064,0.131,0.08,0.137,0.184,0.219l-0.178,0.045c-0.002,0.013-0.023,0.056-0.057,0.401L527.783,225.815L527.783,225.815z"/>
			<path fill="#8C1C1E" d="M528.086,227.21c0.08-0.143,0.111-0.297,0.113-0.419c0.408-0.243,0.357-1.05,0.35-1.149l-0.012-0.14
				l-0.154,0.152c0,0,0.072,0.926-0.355,1.029c0,0,0.068,0.46-0.336,0.694L528.086,227.21L528.086,227.21z"/>
			<path fill="#FFFFFF" d="M528.459,225.495l0.078,0.007l-0.154,0.152c-0.1-0.01-0.139,0.03-0.139,0.03L528.459,225.495
				L528.459,225.495z"/>
			<path fill="#8C1C1E" d="M528.586,223.965c0,0-0.066,0.183-0.07,0.412c-0.002,0.179,0.125,0.667-0.184,0.78
				c0,0-0.012,0.272-0.088,0.527l0.215-0.189c0.016-0.092,0.025-0.173,0.031-0.231c0.26-0.173,0.223-0.552,0.201-0.765
				c-0.004-0.049-0.01-0.093-0.01-0.12c0.004-0.196,0.061-0.355,0.061-0.356l0.072-0.197L528.586,223.965L528.586,223.965z"/>
			<path fill="#FFFFFF" d="M528,223.948c0.121-0.089,0.324-0.186,0.607-0.149l0.207,0.026l-0.229,0.14
				c-0.385-0.049-0.58,0.206-0.58,0.206L528,223.948L528,223.948z"/>
			<path fill="#8C1C1E" d="M527.072,223.52l-0.064,0.13c0.182,0.223,0.203,0.793,0.203,0.793h-0.117
				c0.113,0.288,0.146,0.789,0.146,0.789l-0.113,0.002c0.113,0.506,0.064,0.685,0.064,0.685h-0.455
				c0.006,0.025-0.074,0.585,0.324,0.782l0.123-0.124c-0.016-0.009-0.031-0.017-0.049-0.025c-0.143-0.071-0.221-0.229-0.232-0.466
				l0,0h0.289h0.162l0.018-0.124c0.008-0.031,0.023-0.189-0.041-0.564h-0.002l0.09-0.002l-0.012-0.174
				c-0.002-0.017-0.021-0.329-0.088-0.612l0.066,0.001l-0.006-0.174c-0.002-0.057-0.023-0.515-0.18-0.797l0.023-0.044l0.066-0.134
				L527.072,223.52L527.072,223.52z"/>
			<polygon fill="#FFFFFF" points="526.947,223.438 527.072,223.52 527.289,223.461 527.164,223.38 527.066,223.315 
				526.947,223.438 			"/>
			<polygon fill="#A67E04" points="526.416,223.323 526.596,223.194 526.771,223.319 526.891,223.198 526.867,223.183 
				526.691,223.058 526.594,222.988 526.498,223.059 526.318,223.188 526.297,223.202 526.416,223.323 			"/>
			<path fill="#EEB211" d="M526.416,223.323c0,0,0.156,0.199,0.027,0.272c-0.098,0.056-0.18-0.082-0.207-0.152l-0.123-0.12
				l0.041-0.023l0.143-0.098L526.416,223.323L526.416,223.323z"/>
			<path fill="#EEB211" d="M526.771,223.319c-0.033,0.027-0.15,0.179-0.049,0.256c0.086,0.065,0.225-0.138,0.225-0.138l0.119-0.122
				l-0.029-0.018l-0.146-0.1L526.771,223.319L526.771,223.319z"/>
			<path fill="#FFFFFF" d="M531.938,231.584c0.025,0.036,0.041,0.185-0.035,0.202c-0.055,0.013-0.133-0.005-0.205,0.008
				c-0.088,0.017-0.043,0.197,0.055,0.212l-0.131,0.124c-0.061-0.041-0.119-0.095-0.141-0.163L531.938,231.584L531.938,231.584z"/>
			<path d="M531.482,229.114h0.166v-0.842c0.049-0.531,0.613-0.581,0.906-0.559l-0.18,0.163l0,0
				c-0.23,0.011-0.535,0.087-0.564,0.411v-0.017l0.006,0.841l0.002,0.229h-0.17L531.482,229.114L531.482,229.114z"/>
			<path fill="#FFFFFF" d="M531.857,231.09c-0.029,0.028-0.064,0.068-0.107,0.126c-0.045,0.062-0.135,0.018-0.17,0.064
				c-0.029,0.069-0.033,0.211,0.025,0.233l-0.125,0.178v-0.604c0.037-0.004,0.078-0.005,0.104-0.039l0.064-0.219l0.113-0.063
				l0.145-0.084l0.125,0.122l-0.188,0.106l0.096,0.119C531.939,231.03,531.91,231.041,531.857,231.09L531.857,231.09z"/>
			<path fill="#A67E04" d="M531.605,231.514c0.092,0.036,0.271-0.022,0.332,0.07l-0.18,0.148c-0.055-0.054-0.182-0.026-0.277-0.041
				L531.605,231.514L531.605,231.514z"/>
			<path fill="#E13A3E" d="M531.48,231.691c0.096,0.015,0.223-0.013,0.277,0.041l-0.277,0.234V231.691L531.48,231.691z"/>
			<path fill="#A67E04" d="M531.615,232.134l0.137-0.128c0.084,0.013,0.178-0.022,0.199-0.024c0.09-0.008,0.125,0.067,0.115,0.148
				L531.615,232.134L531.615,232.134z"/>
			<path fill="#FFFFFF" d="M532.066,232.13c-0.01,0.075-0.055,0.156-0.131,0.178c-0.061,0.017-0.295-0.031-0.514,0.005l0.193-0.179
				L532.066,232.13L532.066,232.13z"/>
			<path fill="#FFFFFF" d="M529.287,233.171c-0.002-0.066-0.033-0.139-0.086-0.21l-0.227,0.226c0.186,0.186,0.311,0.453,0.312,0.646
				V233.171L529.287,233.171z"/>
			<path fill="#FFFFFF" d="M527.432,232.445c-0.102-0.104-0.174-0.257-0.174-0.465v-4.435h4.057l0.166-0.168h-0.5
				c0.166-0.236,0.549-0.22,1.344-0.316l-0.496-0.113c-0.463,0.049-0.746,0.084-0.924,0.264h-2.82l-0.395,0.166h-0.6v1.091
				l-0.168,0.169v0.317c-0.109,0.108-0.113,0.273-0.111,0.388l0.002,0.165l0.166-0.167c-0.002-0.175,0.039-0.258,0.111-0.297v0.296
				l-0.168,0.168v1.114h-0.463l0.211,0.271c0.186,0.236,0.236,0.409,0.246,0.594c-0.062,0.087-0.09,0.192-0.076,0.299
				c0.012,0.095,0.055,0.182,0.117,0.248c0,0.396,0.1,0.699,0.293,0.901l0.135-0.135c-0.082-0.095-0.15-0.224-0.189-0.399
				c0.033,0.062,0.072,0.116,0.123,0.167L527.432,232.445L527.432,232.445z"/>
			<path fill="#E13A3E" d="M528.57,232.798h-0.705c-0.199,0-0.402-0.086-0.547-0.229c-0.051-0.051-0.09-0.105-0.123-0.167
				c0.039,0.176,0.107,0.305,0.189,0.399c0.188,0.213,0.449,0.249,0.631,0.252C528.189,233.056,528.404,232.985,528.57,232.798
				L528.57,232.798z"/>
			<path fill="#636466" d="M530.98,227.378c0.166-0.236,0.549-0.22,1.344-0.316c-0.359-0.202-0.773-0.52-0.773-0.52
				c-0.33,0.391-0.83,0.423-0.83,0.423l-0.006-0.122c-0.182-0.021-0.617-0.65-0.617-0.65c0.17-0.058,0.182-0.082,0.297-0.065
				c0.215,0.03,0.148,0.317,0.504,0.317c0.293,0,0.379-0.473,0.379-0.473h-0.314l-0.004-0.374c-0.49-0.191-0.592-0.479-0.592-0.479
				l0.113-0.082c-0.16-0.316-0.041-0.898-0.041-0.898c0.488,0.153,0.279,0.418,0.32,0.67c0.021,0.123,0.408,0.326,0.408,0.326
				c0.203-0.297,0.744-0.161,0.838-0.188c0.158-0.044,0.191-0.342,0.016-0.325c-0.02,0.002-0.113,0.036-0.199,0.024
				c-0.096-0.014-0.143-0.195-0.053-0.212c0.072-0.013,0.15,0.004,0.203-0.008c0.078-0.018,0.062-0.167,0.037-0.204
				c-0.061-0.09-0.24-0.032-0.334-0.068c-0.057-0.021-0.045-0.16-0.025-0.233c0.014-0.045,0.238-0.021,0.299-0.101
				c0.076-0.084,0.191-0.282,0.32-0.302l0,0l0.668,0.002l-0.064,0.13c0.182,0.223,0.203,0.793,0.203,0.793h-0.117
				c0.113,0.288,0.145,0.789,0.145,0.789l-0.111,0.002c0.111,0.506,0.064,0.685,0.064,0.685h-0.455
				c0.006,0.025-0.074,0.585,0.324,0.782c0.432,0.215,0.516,0.455,0.516,0.455c0.221-0.19,0.232-0.368,0.229-0.532
				c-0.008-0.37-0.309-0.391-0.219-1.082c0.018-0.149-0.01-0.131,0.049-0.375c0,0-0.119-0.134-0.111-0.365
				c0.008-0.188,0.029-0.542-0.021-0.766c0,0,0.41-0.032,0.504,0.136c0.117-0.276,0.662-0.224,0.414,0.573
				c-0.188-0.093-0.203,0.077-0.248,0.22c-0.064,0.208-0.25,0.271-0.369,0.26c-0.084,0.597-0.021,0.592-0.021,0.592
				c0.209-0.182,0.602-0.161,0.602-0.161s0.072,0.926-0.355,1.029c0,0,0.076,0.509-0.402,0.729l-0.004,0.06
				c0.006,0.272-0.037,0.636,0.121,0.749c0.17,0.123,0.684,0.146,0.752,0.341c0.068,0.203,0.051,0.334,0.045,0.552h-0.275
				c0.021,0.113-0.027,0.2-0.17,0.227h-0.113l-0.166-0.167l-0.168,0.167l-0.168-0.167l-0.166,0.167l-0.168-0.167l-0.168,0.167
				c-0.004-0.494,0.311-0.255,0.82-0.353c0.166-0.032,0.164-0.212,0.156-0.353c-0.006-0.042-0.025-0.081-0.055-0.11
				c-0.051-0.052-0.115-0.058-0.139-0.058h-0.504h-0.084c-0.613,0.055-0.482-0.754-0.482-0.754
				c-0.293-0.022-0.857,0.027-0.906,0.559v0.842h-0.166l-0.002-1.736H530.98L530.98,227.378z"/>
			<path fill="#E13A3E" d="M527.09,227.378v1.091l-0.168,0.001c-0.117-0.005-0.203-0.047-0.264-0.107
				c-0.211-0.209-0.139-0.648-0.139-0.648c-0.293-0.022-0.863,0.027-0.912,0.559l0.006,0.842h-0.277
				c0.021,0.113-0.027,0.2-0.168,0.227h-0.115l-0.168-0.167l-0.166,0.167l-0.168-0.167l-0.166,0.167l-0.168-0.167l-0.166,0.167
				c-0.006-0.494,0.309-0.255,0.818-0.353c0.168-0.032,0.166-0.212,0.158-0.353c-0.092-1.59-0.006-1.399,1.432-1.574
				c-0.359-0.202-0.773-0.52-0.773-0.52c-0.33,0.391-0.83,0.423-0.83,0.423l-0.004-0.122c-0.184-0.021-0.619-0.65-0.619-0.65
				c0.17-0.058,0.184-0.082,0.297-0.065c0.215,0.03,0.148,0.317,0.506,0.317c0.291,0,0.377-0.473,0.377-0.473H525.1l-0.004-0.374
				c-0.492-0.191-0.596-0.479-0.596-0.479l0.115-0.082c-0.16-0.316-0.041-0.898-0.041-0.898c0.488,0.153,0.279,0.418,0.32,0.67
				c0.021,0.123,0.408,0.326,0.408,0.326c0.203-0.297,0.744-0.161,0.838-0.188c0.158-0.044,0.191-0.342,0.016-0.325
				c-0.02,0.002-0.113,0.036-0.199,0.024c-0.096-0.014-0.143-0.195-0.053-0.212c0.074-0.013,0.15,0.004,0.205-0.008
				c0.074-0.018,0.061-0.167,0.035-0.204c-0.061-0.09-0.24-0.032-0.334-0.068c-0.057-0.021-0.055-0.164-0.025-0.233
				c0.035-0.047,0.127-0.004,0.172-0.064c0.115-0.158,0.199-0.171,0.199-0.171l-0.105-0.134l0.186-0.107
				c0.027,0.07,0.109,0.208,0.207,0.152c0.129-0.073-0.027-0.272-0.027-0.272l0.18-0.129l0.176,0.125
				c-0.033,0.027-0.15,0.179-0.049,0.256c0.086,0.065,0.225-0.138,0.225-0.138l0.125,0.082l-0.064,0.13
				c0.182,0.223,0.203,0.793,0.203,0.793h-0.117c0.113,0.288,0.146,0.789,0.146,0.789l-0.113,0.002
				c0.113,0.506,0.064,0.685,0.064,0.685h-0.455c0.006,0.025-0.074,0.585,0.324,0.782c0.432,0.215,0.518,0.455,0.518,0.455
				c0.219-0.19,0.23-0.368,0.227-0.532c-0.008-0.37-0.309-0.391-0.219-1.082c0.018-0.149-0.008-0.131,0.047-0.375
				c0,0-0.117-0.134-0.109-0.365c0.008-0.188,0.029-0.542-0.021-0.766c0,0,0.412-0.032,0.504,0.136c0,0,0.195-0.255,0.58-0.206
				c0,0-0.066,0.183-0.07,0.412c-0.002,0.179,0.125,0.667-0.184,0.78c0,0-0.012,0.272-0.088,0.527c0,0,0.039-0.04,0.139-0.03
				c0,0,0.072,0.926-0.355,1.029c0,0,0.068,0.46-0.338,0.694H527.09L527.09,227.378z M528.168,225.181
				c-0.104-0.082-0.119-0.088-0.184-0.219c-0.01,0.262-0.182,0.262-0.182,0.262c-0.082,0.597-0.02,0.592-0.02,0.592
				c0.096-0.065,0.266-0.099,0.266-0.099C528.152,225.349,528.168,225.181,528.168,225.181L528.168,225.181z"/>
			<path fill="#B3B5BE" d="M527.258,231.98v-4.435h4.057v4.435l0,0c0,0.459-0.357,0.65-0.607,0.65c-0.305,0-0.324,0-0.672,0
				c-0.375,0-0.748,0.311-0.748,0.54c-0.002-0.229-0.375-0.54-0.75-0.54c-0.348,0-0.369,0-0.672,0
				C527.613,232.631,527.258,232.439,527.258,231.98L527.258,231.98z"/>
			<path fill="#8C1C1E" d="M528.816,228.646c0.006,0.011,0.012,0.021,0.018,0.034c0,0-0.305,0.086-0.381-0.166l-0.156-0.129
				l0.047,0.161c0.072,0.236,0.285,0.276,0.438,0.26h0.002c-0.002,0.012-0.004,0.023-0.004,0.037
				c0.002,0.066,0.033,0.139,0.092,0.178l0.092-0.085c-0.066-0.01-0.098-0.134-0.037-0.145c0.049-0.01,0.104,0.003,0.139-0.006
				c0.053-0.012,0.043-0.114,0.025-0.139c-0.041-0.062-0.164-0.022-0.229-0.048L528.816,228.646L528.816,228.646z"/>
			<path fill="#E13A3E" d="M528.834,228.68c0,0-0.305,0.086-0.381-0.166c0.225,0.021,0.275-0.021,0.363,0.132
				C528.822,228.656,528.828,228.667,528.834,228.68L528.834,228.68z"/>
			<path fill="#FFFFFF" d="M530.209,229.732c0.064-0.044,0.182-0.065,0.182-0.065c0.07-0.252,0.08-0.367,0.08-0.367l-0.121,0.031
				c0,0.009-0.016,0.038-0.039,0.274L530.209,229.732L530.209,229.732z"/>
			<path fill="#8C1C1E" d="M530.209,229.732c0,0-0.043,0.004,0.014-0.403c0,0,0.117,0,0.123-0.177
				c0.045,0.088,0.055,0.092,0.125,0.147l-0.121,0.031c0,0.009-0.016,0.038-0.039,0.274L530.209,229.732L530.209,229.732z"/>
			<polygon fill="#FFFFFF" points="528.1,230.641 528.096,230.522 528.096,230.51 528.207,230.436 528.209,230.519 528.1,230.641 
							"/>
			<path fill="#FFFFFF" d="M527.932,228.44l-0.025,0.125c-0.008,0.039-0.068,0.353,0.002,0.595l-0.008,0.004l-0.068,0.05
				l0.135,0.044l0.078-0.057c-0.107-0.216-0.027-0.613-0.027-0.613L527.932,228.44L527.932,228.44z"/>
			<path fill="#8C1C1E" d="M528.516,229.269c0,0-0.264-0.139-0.277-0.223c-0.029-0.172,0.113-0.354-0.221-0.458l-0.086-0.147
				l0.121,0.039c0.332,0.105,0.312,0.307,0.299,0.44c-0.002,0.034-0.006,0.067-0.002,0.096h-0.002
				c0.02,0.023,0.078,0.068,0.145,0.108L528.516,229.269L528.516,229.269z"/>
			<path fill="#FFFFFF" d="M528.871,229.021c-0.121,0-0.268,0.017-0.377,0.105l-0.002-0.002l0.023,0.145
				c0.139-0.203,0.508-0.109,0.572-0.128c0.107-0.03,0.129-0.233,0.01-0.223c-0.014,0.002-0.076,0.025-0.135,0.018L528.871,229.021
				L528.871,229.021z"/>
			<path fill="#8C1C1E" d="M528.26,229.661c-0.312-0.145-0.391-0.341-0.4-0.365l-0.027-0.082l0.135,0.044
				c0,0,0.072,0.197,0.406,0.327L528.26,229.661L528.26,229.661z"/>
			<path fill="#FFFFFF" d="M528.861,228.599c-0.039-0.015-0.037-0.111-0.018-0.158c0.025-0.033,0.088-0.002,0.117-0.044
				c0.08-0.108,0.137-0.117,0.137-0.117l-0.072-0.091l0.127-0.073l-0.084-0.083l-0.1,0.057l-0.113,0.066l0.078,0.1l0,0
				c-0.021,0.021-0.035,0.04-0.045,0.052c-0.01,0.015-0.025,0.015-0.025,0.015c-0.094-0.013-0.111,0.046-0.121,0.068
				c-0.004,0.011-0.008,0.021-0.012,0.033c-0.043-0.011-0.074-0.016-0.146-0.016c-0.035-0.001-0.072-0.004-0.119-0.008l-0.168-0.015
				l0.156,0.129c0.225,0.021,0.275-0.021,0.363,0.132L528.861,228.599L528.861,228.599z"/>
			<polygon fill="#FFFFFF" points="528.373,229.585 528.377,229.841 528.264,229.955 528.264,229.843 528.26,229.661 
				528.373,229.585 			"/>
			<polygon fill="#8C1C1E" points="528.59,229.841 528.377,229.841 528.264,229.955 528.377,229.955 528.436,229.955 
				528.59,229.841 			"/>
			<path fill="#FFFFFF" d="M527.604,229.932l0.145-0.049c0.027-0.01,0.049-0.018,0.066-0.024c0.066-0.024,0.105-0.037,0.189-0.024
				c0.109,0.016,0.162,0.084,0.197,0.13c0.035,0.047,0.057,0.086,0.145,0.086c0.035,0,0.066-0.04,0.09-0.095l0.154-0.114
				c0,0-0.059,0.322-0.258,0.322c-0.244,0-0.199-0.195-0.346-0.217c-0.076-0.011-0.086,0.006-0.201,0.045L527.604,229.932
				L527.604,229.932z"/>
			<path fill="#8C1C1E" d="M528.207,230.436c-0.125-0.014-0.422-0.444-0.422-0.444l-0.182-0.06l0.088,0.124
				c0.002,0.005,0.078,0.113,0.17,0.224c0.104,0.128,0.178,0.194,0.234,0.23L528.207,230.436L528.207,230.436z"/>
			<path fill="#8C1C1E" d="M529.305,230.586c-0.244-0.14-0.527-0.356-0.527-0.356c-0.227,0.267-0.568,0.289-0.568,0.289
				l-0.109,0.122l0.117-0.009c0.014,0,0.324-0.023,0.572-0.25c0.047,0.033,0.107,0.078,0.178,0.125L529.305,230.586L529.305,230.586
				z"/>
			<path fill="#FFFFFF" d="M527.547,232.255v-0.112c-0.002-0.079,0.006-0.191,0.08-0.266c0.08-0.078,0.189-0.076,0.305-0.073
				c0.078,0.002,0.195,0,0.24-0.014c0.045-0.013,0.047-0.035,0.041-0.124c-0.029-0.521-0.031-0.768,0.08-0.927
				c0.115-0.169,0.316-0.195,0.674-0.232l0,0l0.338,0.079c-0.98,0.118-1.041-0.012-0.977,1.073c0.006,0.096,0.006,0.219-0.109,0.241
				c-0.348,0.066-0.562-0.097-0.559,0.241L527.547,232.255L527.547,232.255z"/>
			<path fill="#8C1C1E" d="M529.346,231.029c-0.201-0.015-0.59,0.019-0.623,0.382l0.004,0.575h-0.189
				c0.016,0.076-0.018,0.137-0.113,0.155h-0.764l-0.113,0.113h0.113h0.764h0.012l0.01-0.001c0.1-0.021,0.17-0.077,0.197-0.155l0,0
				h0.084h0.115v-0.114l-0.004-0.574v0.011c0.02-0.221,0.229-0.271,0.385-0.279L529.346,231.029L529.346,231.029z"/>
			<path fill="#FFFFFF" d="M529.35,231.544c-0.105-0.115-0.127-0.285-0.127-0.403v0.001l0.123-0.112c0,0-0.047,0.288,0.084,0.435
				L529.35,231.544L529.35,231.544z"/>
			<path fill="#8C1C1E" d="M530.287,231.584c-0.035-0.035-0.078-0.039-0.094-0.039h-0.344h-0.174
				c-0.117,0.01-0.195-0.024-0.246-0.081l-0.08,0.08c0.057,0.062,0.16,0.129,0.336,0.114l-0.01,0.001h0.174h0.344
				c0,0,0.008,0,0.014,0.006L530.287,231.584L530.287,231.584z"/>
			<path fill="#FFFFFF" d="M529.545,232.255v-0.112c-0.002-0.079,0.006-0.191,0.082-0.266c0.078-0.078,0.188-0.076,0.303-0.073
				c0.078,0.002,0.195-0.002,0.24-0.014c0.062-0.015,0.043-0.091,0.043-0.112c0-0.007-0.004-0.011-0.006-0.013l0.08-0.081
				c0.02,0.021,0.033,0.047,0.037,0.075c0.006,0.096,0.008,0.219-0.105,0.241c-0.35,0.066-0.564-0.097-0.561,0.241L529.545,232.255
				L529.545,232.255z"/>
			<path fill="#8C1C1E" d="M530.693,231.61c0.047,0.138,0.035,0.227,0.031,0.376h-0.188c0.014,0.076-0.02,0.137-0.115,0.155h-0.764
				l-0.113,0.113h0.113h0.764h0.01l0.01-0.001c0.102-0.021,0.172-0.077,0.199-0.155l0,0h0.084h0.115l0.002-0.171
				c0.004-0.115,0.008-0.217-0.041-0.355c-0.006-0.018-0.012-0.033-0.023-0.049L530.693,231.61L530.693,231.61z"/>
			<path fill="#FFFFFF" d="M530.248,231.284c0.027,0.021,0.096,0.038,0.166,0.057c0.146,0.041,0.297,0.082,0.363,0.183l-0.084,0.087
				c-0.045-0.134-0.396-0.15-0.512-0.233c-0.006-0.003-0.012-0.009-0.016-0.013L530.248,231.284L530.248,231.284z"/>
			<path fill="#8C1C1E" d="M530.619,229.624c0,0,0.049,0.632-0.244,0.702c0,0,0.053,0.348-0.273,0.498l-0.004,0.041
				c0.004,0.178-0.021,0.411,0.068,0.499l0.082-0.08c-0.039-0.028-0.037-0.239-0.035-0.331l0.002-0.06
				c0.211-0.13,0.273-0.344,0.277-0.494c0.279-0.165,0.244-0.717,0.24-0.783l-0.008-0.096L530.619,229.624L530.619,229.624z"/>
			<path fill="#FFFFFF" d="M530.67,229.515l0.055,0.006l-0.105,0.104c-0.07-0.006-0.096,0.021-0.096,0.021L530.67,229.515
				L530.67,229.515z"/>
			<path fill="#8C1C1E" d="M530.756,228.471c0,0-0.045,0.124-0.047,0.281c-0.002,0.122,0.084,0.455-0.127,0.533
				c0,0-0.008,0.185-0.059,0.359l0.146-0.13c0.012-0.062,0.018-0.117,0.021-0.157c0.178-0.119,0.152-0.376,0.137-0.522
				c-0.002-0.032-0.006-0.063-0.006-0.082c0.002-0.133,0.041-0.241,0.041-0.243l0.049-0.134L530.756,228.471L530.756,228.471z"/>
			<path fill="#FFFFFF" d="M530.357,228.458c0.082-0.06,0.221-0.125,0.414-0.102c0,0,0.143,0.019,0.141,0.02l-0.156,0.095
				c-0.262-0.033-0.396,0.141-0.396,0.141L530.357,228.458L530.357,228.458z"/>
			<path fill="#FFFFFF" d="M530.154,228.405c-0.062-0.005-0.117-0.003-0.146,0l-0.133,0.01c0.047,0.169,0.055,0.348,0.057,0.377
				l0.004,0.119l-0.045-0.001c0.045,0.193,0.061,0.406,0.061,0.419l0.008,0.118l-0.061,0.001l0,0
				c0.045,0.255,0.033,0.363,0.027,0.386l-0.01,0.084c0.033,0.101,0.133,0.125,0.189,0.37c0.014,0.061,0.002,0.118-0.027,0.174
				c-0.057-0.062-0.146-0.138-0.277-0.209l-0.086,0.086c0.295,0.146,0.354,0.31,0.354,0.31c0.15-0.13,0.158-0.251,0.154-0.363
				c-0.004-0.252-0.209-0.266-0.15-0.739c0.014-0.102-0.004-0.089,0.033-0.255c0,0-0.078-0.093-0.074-0.251
				c0.006-0.127,0.02-0.369-0.016-0.521c0,0,0.066-0.005,0.141,0.003L530.154,228.405L530.154,228.405z"/>
			<path fill="#8C1C1E" d="M530.156,228.521c0.08,0.007,0.172,0.03,0.203,0.09l-0.002-0.153c-0.062-0.032-0.137-0.047-0.203-0.053
				L530.156,228.521L530.156,228.521z"/>
			<path fill="#8C1C1E" d="M529.723,228.166l-0.043,0.09c0.125,0.151,0.139,0.54,0.139,0.54h-0.08c0.076,0.197,0.1,0.539,0.1,0.539
				l-0.078,0.002c0.078,0.346,0.045,0.467,0.045,0.467h-0.311c0.004,0.018-0.051,0.399,0.221,0.535l0.086-0.086
				c-0.012-0.006-0.021-0.012-0.035-0.017c-0.098-0.048-0.15-0.156-0.158-0.318l0,0h0.197h0.111l0.01-0.084
				c0.006-0.022,0.018-0.131-0.027-0.386l0,0l0.061-0.001l-0.008-0.118c0-0.013-0.016-0.226-0.061-0.419l0.045,0.001l-0.004-0.119
				c-0.002-0.039-0.016-0.352-0.121-0.544l0.016-0.03l0.045-0.091L529.723,228.166L529.723,228.166z"/>
			<polygon fill="#FFFFFF" points="529.637,228.11 529.723,228.166 529.871,228.127 529.785,228.071 529.719,228.027 
				529.637,228.11 			"/>
			<polygon fill="#A67E04" points="529.277,228.032 529.396,227.944 529.518,228.03 529.6,227.947 529.582,227.937 529.463,227.851 
				529.396,227.805 529.33,227.852 529.209,227.94 529.193,227.95 529.277,228.032 			"/>
			<path fill="#EEB211" d="M529.518,228.03c-0.021,0.019-0.104,0.121-0.033,0.174c0.059,0.045,0.152-0.094,0.152-0.094l0.082-0.083
				l-0.02-0.013l-0.1-0.067L529.518,228.03L529.518,228.03z"/>
			<path fill="#EEB211" d="M529.277,228.032c0,0,0.104,0.137,0.016,0.187c-0.066,0.038-0.121-0.056-0.141-0.104l-0.084-0.083
				l0.027-0.016l0.098-0.066L529.277,228.032L529.277,228.032z"/>
			<path fill="#E13A3E" d="M529.805,229.804c0,0,0.033-0.121-0.045-0.467l0.078-0.002c0,0-0.023-0.342-0.1-0.539h0.08
				c0,0-0.014-0.389-0.139-0.54l0.043-0.09l-0.086-0.056c0,0-0.094,0.139-0.152,0.094c-0.07-0.053,0.012-0.155,0.033-0.174
				l-0.121-0.086l-0.119,0.088c0,0,0.104,0.137,0.016,0.187c-0.066,0.038-0.121-0.056-0.141-0.104l-0.127,0.073l0.072,0.091
				c0,0-0.057,0.009-0.137,0.117c-0.029,0.042-0.092,0.011-0.117,0.044c-0.02,0.047-0.021,0.144,0.018,0.158
				c0.064,0.025,0.188-0.015,0.229,0.048c0.018,0.024,0.027,0.127-0.025,0.139c-0.035,0.009-0.09-0.004-0.139,0.006
				c-0.061,0.011-0.029,0.135,0.037,0.145c0.059,0.008,0.121-0.016,0.135-0.018c0.119-0.011,0.098,0.192-0.01,0.223
				c-0.064,0.019-0.434-0.075-0.572,0.128c0,0-0.264-0.139-0.277-0.223c-0.029-0.172,0.113-0.354-0.221-0.458
				c0,0-0.08,0.397,0.027,0.613l-0.078,0.057c0,0,0.072,0.197,0.406,0.327l0.004,0.256h0.213c0,0-0.059,0.322-0.258,0.322
				c-0.244,0-0.199-0.195-0.346-0.217c-0.076-0.011-0.086,0.006-0.201,0.045c0,0,0.297,0.431,0.422,0.444l0.002,0.083
				c0,0,0.342-0.022,0.568-0.289c0,0,0.283,0.217,0.527,0.356c-0.98,0.118-1.041-0.012-0.977,1.073
				c0.006,0.096,0.006,0.219-0.109,0.241c-0.348,0.066-0.562-0.097-0.559,0.241l0.113-0.115l0.115,0.115l0.113-0.115l0.115,0.115
				l0.115-0.115l0.115,0.115h0.076c0.096-0.019,0.129-0.079,0.113-0.155h0.189l-0.004-0.575c0.033-0.363,0.422-0.396,0.623-0.382
				c0,0-0.09,0.553,0.33,0.516h0.174h0.344c0.016,0,0.059,0.004,0.094,0.039c0.02,0.021,0.033,0.047,0.037,0.075
				c0.006,0.096,0.008,0.219-0.105,0.241c-0.35,0.066-0.564-0.097-0.561,0.241l0.115-0.116l0.111,0.116l0.117-0.116l0.115,0.116
				l0.115-0.116l0.113,0.116h0.076c0.096-0.019,0.129-0.079,0.115-0.155h0.188c0.004-0.149,0.016-0.238-0.031-0.376
				c-0.045-0.134-0.396-0.15-0.512-0.233c-0.109-0.077-0.08-0.326-0.084-0.512l0.004-0.041c0.326-0.15,0.273-0.498,0.273-0.498
				c0.293-0.07,0.244-0.702,0.244-0.702c-0.07-0.006-0.096,0.021-0.096,0.021c0.051-0.175,0.059-0.359,0.059-0.359
				c0.211-0.078,0.125-0.411,0.127-0.533c0.002-0.157,0.047-0.281,0.047-0.281c-0.262-0.033-0.396,0.141-0.396,0.141
				c-0.062-0.115-0.344-0.093-0.344-0.093c0.035,0.152,0.021,0.395,0.016,0.521c-0.004,0.158,0.074,0.251,0.074,0.251
				c-0.037,0.166-0.02,0.153-0.033,0.255c-0.059,0.474,0.146,0.487,0.15,0.739c0.004,0.112-0.004,0.233-0.154,0.363
				c0,0-0.059-0.164-0.354-0.31c-0.271-0.136-0.217-0.518-0.221-0.535H529.805L529.805,229.804z M530.209,229.732
				c0,0-0.043,0.004,0.014-0.403c0,0,0.117,0,0.123-0.177c0.045,0.088,0.055,0.092,0.125,0.147c0,0-0.01,0.115-0.08,0.367
				C530.391,229.667,530.273,229.688,530.209,229.732L530.209,229.732z"/>
			<path fill="#E13A3E" d="M527.09,231.574c-0.076,0.101-0.068,0.231,0,0.319V231.574L527.09,231.574z"/>
			<path fill="#E13A3E" d="M526.922,230.911c0.078,0.119,0.139,0.228,0.168,0.338v-0.459h-0.256
				C526.867,230.832,526.896,230.872,526.922,230.911L526.922,230.911z"/>
			<path fill="#EEB211" d="M529.369,219.011c-0.025,0.004-0.053,0.008-0.08,0.008c-0.029,0-0.057-0.003-0.084-0.008l-0.002-0.003
				l-0.242,0.241c-0.574-0.18-1.412-0.569-1.922-0.285c-0.662,0.373,0.029,1.617,0.094,1.698c0.045,0.022,0.084,0.05,0.115,0.081
				c0.025-0.03,0.055-0.061,0.09-0.093c-0.066-0.081-0.684-1.108-0.311-1.479c0.373-0.369,1.273,0.064,1.885,0.239l0.162,0.967
				c0.07-0.062,0.145-0.113,0.217-0.14c0.07,0.026,0.143,0.076,0.211,0.137l0.158-0.964c0.609-0.175,1.512-0.608,1.885-0.239
				c0.375,0.37-0.244,1.4-0.309,1.481c0.031,0.03,0.062,0.06,0.09,0.09c0.029-0.031,0.068-0.058,0.111-0.081
				c0.066-0.081,0.758-1.325,0.094-1.698c-0.508-0.284-1.346,0.105-1.92,0.285l-0.244-0.241L529.369,219.011L529.369,219.011z"/>
			<path fill="#E6E7E8" d="M531.314,222.004c0.266-0.207,0.43-0.261,0.506-1.298c-0.023,0-0.357,0.065-0.494,0.203
				c-0.152-0.166-0.441-0.378-0.559-0.432c-0.312,0.058-0.789,0.415-0.879,0.502c-0.082-0.095-0.35-0.48-0.598-0.574
				c-0.25,0.094-0.525,0.479-0.607,0.574c-0.09-0.087-0.566-0.444-0.879-0.502c-0.117,0.054-0.406,0.266-0.557,0.432
				c-0.139-0.138-0.473-0.203-0.496-0.203c0.076,1.037,0.24,1.091,0.506,1.298H531.314L531.314,222.004z"/>
			<polygon fill="#E13A3E" points="532.842,229.341 533.01,229.174 533.178,229.341 532.842,229.341 			"/>
			<polygon fill="#E13A3E" points="533.178,229.341 533.344,229.174 533.512,229.341 533.178,229.341 			"/>
			<polygon fill="#E13A3E" points="533.512,229.341 533.68,229.174 533.846,229.341 533.512,229.341 			"/>
			<polygon fill="#EEB211" points="527.66,232.142 527.775,232.026 527.889,232.142 527.66,232.142 			"/>
			<polygon fill="#EEB211" points="527.889,232.142 528.004,232.025 528.119,232.142 527.889,232.142 			"/>
			<polygon fill="#EEB211" points="528.119,232.142 528.234,232.025 528.348,232.142 528.119,232.142 			"/>
			<polygon fill="#EEB211" points="529.658,232.142 529.773,232.025 529.887,232.142 529.658,232.142 			"/>
			<polygon fill="#EEB211" points="529.887,232.142 530.002,232.025 530.117,232.142 529.887,232.142 			"/>
			<polygon fill="#EEB211" points="530.117,232.142 530.232,232.025 530.346,232.142 530.117,232.142 			"/>
			<path fill="#E13A3E" d="M530.408,224.774l0.166,0.167l-0.094,0.095c-0.16-0.316-0.041-0.898-0.041-0.898l0.135,0.135
				l-0.166,0.167l0.166,0.167L530.408,224.774L530.408,224.774z"/>
			<path fill="#E13A3E" d="M530.098,226.192l0.234,0.034l-0.035,0.233l0.236,0.013l-0.014,0.237l0.236,0.005l-0.041,0.128
				C530.533,226.822,530.098,226.192,530.098,226.192L530.098,226.192z"/>
			<path fill="#A67E04" d="M530.025,233.552l0.234,0.035l-0.035,0.234l0.236,0.014l-0.014,0.235l0.236,0.005l-0.039,0.128
				C530.461,234.183,530.025,233.552,530.025,233.552L530.025,233.552z"/>
			<path fill="#EEB211" d="M527.785,229.991l0.16,0.023l-0.023,0.159l0.16,0.01l-0.01,0.16l0.162,0.004l-0.027,0.088
				C528.082,230.422,527.785,229.991,527.785,229.991L527.785,229.991z"/>
			<path fill="#EEB211" d="M527.996,229.022l0.115,0.113l-0.066,0.063c-0.107-0.215-0.027-0.611-0.027-0.611l0.094,0.092
				l-0.115,0.114l0.115,0.114L527.996,229.022L527.996,229.022z"/>
			<path fill="#71737A" d="M531.48,231.967c0.021,0.068,0.08,0.122,0.141,0.163l-0.199,0.183c-0.135,0.332-0.465,0.485-0.715,0.485
				h-0.123l-0.053,0.168h-0.496c-0.375,0-0.748,0.636-0.748,0.866v-0.661c0-0.229,0.373-0.54,0.748-0.54c0.348,0,0.367,0,0.672,0
				c0.25,0,0.607-0.191,0.607-0.65l0,0v-4.435l0.166-0.168l0.002,1.736l0.166,0.227v1.489l-0.064,0.219
				c-0.025,0.034-0.066,0.035-0.104,0.039V231.967L531.48,231.967z"/>
			<path fill="#FFFFFF" d="M524.447,223.921l-0.037,0.183c-0.012,0.058-0.1,0.517,0.002,0.87l-0.008,0.008l-0.104,0.073l0.199,0.063
				l0.115-0.082c-0.16-0.316-0.041-0.898-0.041-0.898L524.447,223.921L524.447,223.921z"/>
			<path fill="#8C1C1E" d="M524.447,223.921l0.178,0.057c0.486,0.154,0.457,0.449,0.439,0.645c-0.006,0.052-0.01,0.1-0.006,0.142
				h-0.002c0.027,0.034,0.113,0.099,0.213,0.159l0.033,0.211c0,0-0.387-0.203-0.408-0.326c-0.041-0.252,0.168-0.517-0.32-0.67"/>
			<path fill="#8C1C1E" d="M524.928,225.708c-0.457-0.212-0.572-0.5-0.584-0.534l-0.043-0.119l0.199,0.063
				c0,0,0.104,0.288,0.596,0.479L524.928,225.708L524.928,225.708z"/>
			<path fill="#B3B5BE" d="M524.582,232.252c-0.01-0.089-0.014-0.188-0.01-0.296h0.518c-0.016,0.111-0.014,0.211,0.006,0.296
				H524.582L524.582,232.252z"/>
			<path fill="#E13A3E" d="M524.529,231.544c-0.131,0.13-0.094,0.331,0.043,0.412h0.518c0.135-0.081,0.174-0.282,0.045-0.412
				H524.529L524.529,231.544z"/>
			<path fill="#E13A3E" d="M524.492,231.249c-0.039-0.146-0.115-0.292-0.246-0.459h1.17c-0.131,0.167-0.207,0.312-0.246,0.459
				H524.492L524.492,231.249z"/>
			<path fill="#B3B5BE" d="M525.17,231.249c-0.027,0.096-0.035,0.19-0.035,0.295h-0.605c0-0.104-0.012-0.199-0.037-0.295H525.17
				L525.17,231.249z"/>
			<path fill="#A67E04" d="M528.895,238.251c-0.059-0.056-0.121-0.107-0.189-0.159c-0.477-0.361-1.061-0.569-1.598-0.569
				c-1.012,0-1.072,0-1.959,0c-0.395,0-0.883-0.164-1.244-0.527l-0.117,0.118c0.359,0.361,0.869,0.576,1.361,0.576h1.959
				c0.627,0,1.252,0.3,1.672,0.681L528.895,238.251L528.895,238.251z"/>
			<path fill="#FFFFFF" d="M529.285,239.263c0-0.284-0.197-0.61-0.506-0.893l0.115-0.119c0.166,0.149,0.297,0.31,0.393,0.471
				L529.285,239.263L529.285,239.263z"/>
			<path fill="#BCBEC0" d="M526.676,220.042c-0.041-0.133-0.072-0.272-0.084-0.41l0,0c-0.082,0.03-0.141,0.108-0.141,0.2
				c0,0.116,0.096,0.212,0.213,0.212c0.004,0,0.008,0,0.012,0V220.042L526.676,220.042z"/>
			<path fill="#BCBEC0" d="M526.59,219.616c-0.006-0.102-0.004-0.202,0.016-0.299c0.008-0.041,0.02-0.081,0.033-0.118l-0.004-0.002
				c-0.117,0-0.211,0.094-0.211,0.211c0,0.102,0.07,0.187,0.164,0.207L526.59,219.616L526.59,219.616z"/>
			<path fill="#BCBEC0" d="M526.648,219.171c0.055-0.137,0.146-0.248,0.268-0.327v-0.001c-0.035-0.027-0.08-0.043-0.127-0.043
				c-0.117,0-0.213,0.096-0.213,0.213C526.576,219.076,526.604,219.132,526.648,219.171L526.648,219.171L526.648,219.171z"/>
			<path fill="#BCBEC0" d="M526.941,218.829c0.006-0.003,0.012-0.007,0.016-0.01c0.119-0.067,0.248-0.103,0.385-0.116v-0.001
				c-0.031-0.075-0.107-0.129-0.193-0.129c-0.117,0-0.213,0.095-0.213,0.212c0,0.015,0.002,0.028,0.004,0.043L526.941,218.829
				L526.941,218.829z"/>
			<path fill="#BCBEC0" d="M527.359,218.701c0.133-0.011,0.273-0.002,0.418,0.021l0,0c-0.008-0.11-0.1-0.196-0.211-0.196
				C527.463,218.526,527.377,218.602,527.359,218.701L527.359,218.701L527.359,218.701z"/>
			<path fill="#BCBEC0" d="M527.789,218.724c0.135,0.022,0.271,0.057,0.406,0.096l0,0c0-0.004,0-0.009,0-0.013
				c0-0.116-0.096-0.212-0.213-0.212C527.895,218.595,527.82,218.649,527.789,218.724L527.789,218.724L527.789,218.724z"/>
			<path fill="#BCBEC0" d="M528.205,218.822c0.135,0.039,0.268,0.084,0.396,0.128l0,0c0-0.009,0-0.017,0-0.025
				c0-0.117-0.094-0.212-0.211-0.212C528.311,218.713,528.242,218.757,528.205,218.822L528.205,218.822L528.205,218.822z"/>
			<path fill="#BCBEC0" d="M529.971,218.949c0.127-0.044,0.262-0.088,0.396-0.128l0,0c-0.037-0.064-0.107-0.108-0.184-0.108
				c-0.119,0-0.213,0.095-0.213,0.212C529.971,218.934,529.971,218.941,529.971,218.949L529.971,218.949L529.971,218.949z"/>
			<path fill="#BCBEC0" d="M530.377,218.819c0.135-0.039,0.271-0.073,0.406-0.096l0,0c-0.033-0.074-0.107-0.129-0.193-0.129
				c-0.117,0-0.213,0.096-0.213,0.212C530.377,218.811,530.377,218.815,530.377,218.819L530.377,218.819z"/>
			<path fill="#BCBEC0" d="M530.793,218.723c0.145-0.023,0.287-0.033,0.422-0.021l0,0c-0.018-0.1-0.105-0.175-0.209-0.175
				C530.895,218.526,530.803,218.612,530.793,218.723L530.793,218.723L530.793,218.723z"/>
			<path fill="#BCBEC0" d="M531.229,218.703c0.137,0.014,0.268,0.049,0.387,0.116c0.006,0.003,0.01,0.007,0.018,0.01v0.002
				c0.002-0.016,0.004-0.031,0.004-0.046c0-0.117-0.096-0.212-0.211-0.212C531.336,218.573,531.262,218.627,531.229,218.703
				L531.229,218.703L531.229,218.703z"/>
			<path fill="#BCBEC0" d="M531.654,218.844c0.123,0.079,0.213,0.19,0.27,0.327h-0.002c0.043-0.039,0.074-0.095,0.074-0.158
				c0-0.117-0.094-0.213-0.213-0.213C531.734,218.8,531.689,218.815,531.654,218.844L531.654,218.844L531.654,218.844z"/>
			<path fill="#BCBEC0" d="M531.934,219.197c0.014,0.038,0.025,0.078,0.033,0.12c0.018,0.097,0.02,0.196,0.014,0.299l0,0
				c0.096-0.021,0.168-0.106,0.168-0.208c0-0.117-0.1-0.211-0.217-0.211H531.934L531.934,219.197z"/>
			<path fill="#BCBEC0" d="M531.979,219.632c-0.012,0.139-0.043,0.279-0.082,0.412l0,0c0.002,0,0.008,0,0.012,0
				c0.117,0,0.213-0.096,0.213-0.212C532.121,219.739,532.061,219.661,531.979,219.632L531.979,219.632z"/>
			<polygon fill="#FFFFFF" points="529.664,217.029 528.906,217.029 528.98,217.292 528.717,217.218 528.717,217.981 
				528.885,217.762 528.885,217.438 529.221,217.532 529.127,217.196 529.449,217.196 529.664,217.029 			"/>
			<polygon fill="#A67E04" points="528.717,217.981 528.885,217.762 529.221,217.668 528.98,217.907 528.717,217.981 			"/>
			<polygon fill="#A67E04" points="529.449,217.196 529.664,217.029 529.592,217.292 529.357,217.532 529.449,217.196 			"/>
			<polygon fill="#FFFFFF" points="529.855,217.218 529.592,217.292 529.357,217.532 529.693,217.438 529.855,217.218 			"/>
			<polygon fill="#A67E04" points="529.693,217.438 529.693,217.762 529.357,217.668 529.449,218.003 529.355,218.001 
				529.355,218.1 529.625,218.03 529.592,217.907 529.855,217.981 529.855,217.218 529.693,217.438 			"/>
			<path fill="#FFFFFF" d="M528.84,218.996c-0.111-0.114-0.18-0.27-0.18-0.438c0-0.218,0.113-0.414,0.287-0.527l0.033-0.123
				l0.24-0.239l-0.094,0.335l0.094-0.002v0.099c-0.223,0.033-0.393,0.226-0.393,0.458c0,0.125,0.049,0.238,0.131,0.32
				L528.84,218.996L528.84,218.996z"/>
			<path fill="#002E5E" d="M529.203,219.008c-0.094-0.018-0.18-0.064-0.244-0.13l-0.119,0.118c0.023,0.022,0.047,0.042,0.072,0.062
				L529.203,219.008L529.203,219.008z"/>
			<path fill="#FFFFFF" d="M529.609,218.226c-0.068-0.066-0.156-0.11-0.254-0.126l0.27-0.069c0.037,0.023,0.07,0.05,0.1,0.08
				L529.609,218.226L529.609,218.226z"/>
			<path fill="#002E5E" d="M529.367,219.008c0.217-0.038,0.383-0.223,0.383-0.45c0-0.131-0.055-0.248-0.141-0.332l0.115-0.115
				c0.115,0.115,0.188,0.274,0.188,0.447c0,0.202-0.098,0.385-0.252,0.501L529.367,219.008L529.367,219.008z"/>
			<path fill="#FFFFFF" d="M531.65,219.052c-0.033-0.033-0.072-0.062-0.119-0.088c-0.508-0.284-1.346,0.105-1.92,0.285l-0.244-0.241
				l0.293,0.051c0.068-0.024,0.143-0.05,0.221-0.076c0.555-0.194,1.248-0.436,1.734-0.163c0.057,0.031,0.107,0.07,0.152,0.114
				L531.65,219.052L531.65,219.052z"/>
			<polygon fill="#FFFFFF" points="525.096,225.598 525.1,225.972 524.934,226.139 524.932,225.973 524.928,225.708 
				525.096,225.598 			"/>
			<polygon fill="#8C1C1E" points="525.412,225.972 525.1,225.972 524.934,226.139 525.1,226.139 525.188,226.139 525.412,225.972 
							"/>
			<path fill="#FFFFFF" d="M523.969,226.104l0.211-0.07c0.041-0.014,0.07-0.024,0.098-0.034c0.098-0.037,0.154-0.056,0.275-0.038
				c0.162,0.023,0.238,0.125,0.289,0.191c0.053,0.068,0.082,0.126,0.213,0.126c0.051,0,0.096-0.059,0.133-0.14l0.225-0.167
				c0,0-0.086,0.473-0.377,0.473c-0.357,0-0.291-0.287-0.506-0.317c-0.113-0.017-0.127,0.008-0.297,0.065L523.969,226.104
				L523.969,226.104z"/>
			<path fill="#8C1C1E" d="M524.852,226.843c-0.184-0.021-0.619-0.65-0.619-0.65l-0.264-0.089l0.125,0.183
				c0.006,0.007,0.115,0.166,0.25,0.33c0.154,0.187,0.262,0.284,0.342,0.336L524.852,226.843L524.852,226.843z"/>
			<polygon fill="#FFFFFF" points="524.693,227.143 524.688,226.971 524.686,226.952 524.852,226.843 524.855,226.965 
				524.693,227.143 			"/>
			<path fill="#0060A9" d="M529.369,219.011c0.217-0.038,0.381-0.223,0.381-0.451c0-0.13-0.053-0.247-0.139-0.332
				c-0.068-0.065-0.156-0.109-0.254-0.125c-0.023-0.003-0.045-0.006-0.068-0.006c-0.021,0-0.045,0.003-0.066,0.006
				c-0.223,0.032-0.393,0.226-0.393,0.457c0,0.125,0.049,0.238,0.131,0.321c0.064,0.065,0.148,0.112,0.244,0.13
				c0.027,0.005,0.055,0.008,0.084,0.008C529.316,219.019,529.344,219.015,529.369,219.011L529.369,219.011z"/>
			<path fill="#EEB211" d="M529.221,218.1c0.023-0.003,0.045-0.006,0.068-0.006c0.021,0,0.045,0.002,0.066,0.006v-0.097h0.094
				l-0.092-0.335l0.336,0.094v-0.323l-0.336,0.094l0.092-0.336h-0.322l0.094,0.336l-0.336-0.094v0.323l0.336-0.094l-0.094,0.335
				l0.094-0.002V218.1L529.221,218.1z"/>
			<polygon fill="#A67E04" points="529.844,236.702 530.012,236.535 530.18,236.702 529.844,236.702 			"/>
			<polygon fill="#A67E04" points="530.18,236.702 530.346,236.535 530.514,236.702 530.18,236.702 			"/>
			<polygon fill="#A67E04" points="530.514,236.702 530.682,236.535 530.848,236.702 530.514,236.702 			"/>
			<polygon fill="#A67E04" points="532.771,236.702 532.938,236.535 533.105,236.702 532.771,236.702 			"/>
			<polygon fill="#A67E04" points="533.105,236.702 533.271,236.535 533.439,236.702 533.105,236.702 			"/>
			<polygon fill="#A67E04" points="533.439,236.702 533.607,236.535 533.773,236.702 533.439,236.702 			"/>
			<polygon fill="#EEB211" points="524.049,229.341 524.217,229.174 524.385,229.341 524.049,229.341 			"/>
			<polygon fill="#EEB211" points="524.385,229.341 524.551,229.174 524.717,229.341 524.385,229.341 			"/>
			<polygon fill="#EEB211" points="524.719,229.341 524.885,229.174 525.053,229.341 524.719,229.341 			"/>
			<path fill="#EEB211" d="M524.543,224.774l0.166,0.167l-0.094,0.095c-0.16-0.316-0.041-0.898-0.041-0.898l0.135,0.135
				l-0.166,0.167l0.166,0.167L524.543,224.774L524.543,224.774z"/>
			<path fill="#EEB211" d="M524.232,226.192l0.232,0.034l-0.033,0.233l0.236,0.013l-0.014,0.237l0.236,0.005l-0.039,0.128
				C524.668,226.822,524.232,226.192,524.232,226.192L524.232,226.192z"/>
		</g>
	</g>
</g>
</svg>
');
