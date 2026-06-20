<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >


<!-- 
	xsl Template für Lok Report

	Version 1.0
	
	History:	
	15.10.2017 andy		Inital Version

-->

	<xsl:output method="html" encoding="UTF-8" />
  
	<xsl:variable name="engineSortOrder">steam|diesel|electric|automobile|</xsl:variable>

	<!-- Variable für Hintergrundfarbe in Titelzellen -->
	<xsl:variable name="bgcolor" select="'lightgrey'" />

  <xsl:template match="/">

    <html>
	<head>
        <title>Rocrail Lok report</title>
	</head>
	<body style="font-family:Arial, Helvetica, sans-serif">

		<!--
		<h2>Liste der aktiven Loks</h2>
		<xsl:for-each select="/*/lclist/lc[@show='true']">	
		-->
		
		<h2>Liste aller definierten Loks</h2>
		<xsl:for-each select="/*/lclist/lc">

		<!-- Alternative Sortierung nach Adresse // Entweder hier oder die andere Sortierung auskommentieren -->
		<xsl:sort select="@era" order="ascending" data-type="text" />
		<xsl:sort select="@id" order="ascending" /> 	
		<xsl:sort select="@addr" order="ascending" data-type="number" /> 		

		<!-- xsl:sort select="string-length(substring-before($engineSortOrder, @engine))" order="ascending" data-type="number"/-->
		
		<!-- Main Table -->
		<table border="1" rules="all" cellpadding="2" cellspacing="0" width="90%" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
		
		<TR> <!-- 1. Zeile Main Table -->
			
			<!-- 1. Zeile, Spalte 1 -->
			<TD width="20%" valign="top">
				<h2><xsl:value-of select="@id" /></h2>
				<table border="0" cellpadding="4" cellspacing="0" width="100%">	
					<TR>				
						<th align="center" >
							<xsl:choose>
								  <xsl:when test="contains(@image, '.xpm')">
									<xsl:text>-</xsl:text>
								  </xsl:when>
								  <xsl:when test="contains(@image, '.XPM')">
									<xsl:text>-</xsl:text>
								  </xsl:when>
								  <xsl:otherwise>
									<img>
									  <xsl:attribute name="src">
										<xsl:value-of select="concat(../../@guiimagepath, '/', @image)" />
									  </xsl:attribute>
									</img>
								  </xsl:otherwise>
							</xsl:choose>
						</th>
					</TR>

			<!-- Beschreibung -->
			  <TD valign="top" align="left" height="200px" style="font-family:Arial, Helvetica, sans-serif; font-size:13px">
				<br/>
				<h5>Beschreibung:</h5>
				<xsl:variable name="desc1" select="@desc" />
				<xsl:choose>
				  <xsl:when test="$desc1 = ''">
					<xsl:text>-</xsl:text>
				  </xsl:when>
				  <xsl:otherwise>
					<xsl:value-of select="@desc" />
				  </xsl:otherwise>
				</xsl:choose>
			  </TD>						
					
					
				</table>
			</TD>				
			
			<!-- 1. Zeile, Spalte 2 -->
			<TD width="20%" valign="top">
				<table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%"  style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
					<!-- Short ID -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Kurz ID </TH>	
						<xsl:variable name="sid" select="@shortid" />
						
						<TD align="left">
						
						<xsl:choose>
						  <xsl:when test="$sid = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@shortid" />
						  </xsl:otherwise>
						</xsl:choose>
						

						 </TD>
					</TR>						
					
					<!-- Adresse -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}" >Adresse</TH>				
						<TD align="left">
							<xsl:value-of select="@addr" />
						</TD>
					</TR>

					<!-- Decoder -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Decoder</TH>
						<TD align="left">
						  <xsl:variable name="dectype1" select="@dectype" />
						 <xsl:choose>
						  <xsl:when test="$dectype1 = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@dectype" />
						  </xsl:otherwise>
						 </xsl:choose>
					   </TD>
					</TR>

					<!-- Protokoll -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Protokoll</TH>					
						<TD align="left">
						  <xsl:variable name="prot1" select="@prot" />
						 <xsl:choose>
						  <xsl:when test="$prot1 = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:when test="$prot1 = 'P'">
							<xsl:text>Server</xsl:text>
						  </xsl:when>
						  <xsl:when test="$prot1 = 'M'">
							<xsl:text>Motorola</xsl:text>
						  </xsl:when>
						  <xsl:when test="$prot1 = 'N'">
							<xsl:text>DCC</xsl:text>
						  </xsl:when>
						  <xsl:when test="$prot1 = 'L'">
							<xsl:text>DCC long</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@prot" />
						  </xsl:otherwise>
						 </xsl:choose>
					   </TD>					
					</TR>

					<!-- Fahrstufen -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Fahrstufen</TH>					
						<TD align="left">
						  <xsl:variable name="spcnt1" select="@spcnt" />
						 <xsl:choose>
						  <xsl:when test="$spcnt1 = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@spcnt" />
						  </xsl:otherwise>
						 </xsl:choose>
					   </TD>
					</TR>
					
					<!-- Hersteller -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Hersteller</TH>					
						<TD align="left">
						  <xsl:variable name="manuid" select="@manuid" />
						 <xsl:choose>
						  <xsl:when test="$manuid = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@manuid" />
						  </xsl:otherwise>
						 </xsl:choose>
					   </TD>
					</TR>					

					<!-- Katalognummer -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Katalognummer</TH>					
						<TD align="left">
						  <xsl:variable name="catnr" select="@catnr" />
						 <xsl:choose>
						  <xsl:when test="$catnr = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@catnr" />
						  </xsl:otherwise>
						 </xsl:choose>
					   </TD>
					</TR>					

					<!-- Kaufdatum -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Kaufdatum</TH>
						  <xsl:variable name="purchased" select="@purchased" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$purchased = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@purchased" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
					</TR>
					
					<!-- Betriebszeit -->
					<TR>
					
						<TH width="40%" bgcolor="{$bgcolor}">Betriebszeit</TH>
						  <xsl:variable name="runtime" select="@runtime" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="string(number($runtime))='NaN'">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="format-number(floor(@runtime div 3600),'00')" /> h
								<xsl:value-of select="format-number(@runtime mod 3600 div 60,'00')" /> min
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
					</TR>
					
					<!-- Date of the last run  -->
					<TR>
					
						<TH width="40%" bgcolor="{$bgcolor}">Letztes Betriebsdatum</TH>
						  <xsl:variable name="rdate" select="@rdate" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="string(number($rdate))='NaN'">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
									<xsl:call-template name="millisecs-to-ISO">
										<xsl:with-param name="millisecs" select="number(@rdate * 1000)" />
									</xsl:call-template>								
								
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
					</TR>

					<!-- Date of the last revision  -->
					<TR>
					
						<TH width="40%" bgcolor="{$bgcolor}">Letzte Wartung</TH>
						  <xsl:variable name="mdate" select="@mdate" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="string(number($mdate))='NaN'">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
							  		<xsl:call-template name="millisecs-to-ISO">
										<xsl:with-param name="millisecs" select="number(@mdate * 1000)"/>
										<xsl:with-param name="showtime" select="0"/>
									</xsl:call-template>								
								
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
					</TR>					
					
				</table>
				
			</TD>
			
			<!-- 1. Zeile, Spalte 3 -->
			<TD width="20%" valign="top">
			
				<table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%"  style="font-family:Arial, Helvetica, sans-serif; font-size:11px">

					<!-- Gesellschaft -->
					<TR>						  
						<TH width="40%" bgcolor="{$bgcolor}">Gesellschaft</TH>
						  <xsl:variable name="roadname" select="@roadname" />
							<TD align="left">
							<xsl:choose>
							  <xsl:when test="$roadname = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@roadname" />
							  </xsl:otherwise>
							</xsl:choose>
							</TD>
					</TR>
						
					<!-- Epoche -->
					<TR>						  
						<TH width="40%" bgcolor="{$bgcolor}">Epoche</TH>					
						  <xsl:variable name="era" select="@era" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$era = 'Null'">
								<xsl:text> - </xsl:text>
							  </xsl:when>
							  <xsl:when test="$era = '0'">
								<xsl:text>I</xsl:text>
							  </xsl:when>
							  <xsl:when test="$era = '1'">
								<xsl:text>I I</xsl:text>
							  </xsl:when>
							  <xsl:when test="$era = '2'">
								<xsl:text>I I I</xsl:text>
							  </xsl:when>
							  <xsl:when test="$era = '3'">
								<xsl:text>I V</xsl:text>
							  </xsl:when>
							  <xsl:when test="$era = '4'">
								<xsl:text>V</xsl:text>
							  </xsl:when>
							  <xsl:when test="$era = '5'">
								<xsl:text>V I</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:text> - </xsl:text>
							  </xsl:otherwise>
							</xsl:choose>
							</TD>					
					</TR>

					<!-- Antrieb -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Antrieb</TH>
					  <TD align="left">
						<xsl:variable name="engine" select="@engine" />
						<xsl:choose>
						  <xsl:when test="$engine = 'none'">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:when test="$engine = 'steam'">
							<xsl:text>Dampf</xsl:text>
						  </xsl:when>
						  <xsl:when test="$engine = 'diesel'">
							<xsl:text>Diesel</xsl:text>
						  </xsl:when>
						  <xsl:when test="$engine = 'electric'">
							<xsl:text>Elektrisch</xsl:text>
						  </xsl:when>
						  <xsl:when test="$engine = 'automobile'">
							<xsl:text>Auto</xsl:text>
						  </xsl:when>

						  <xsl:otherwise>
							<xsl:value-of select="@engine" />
						  </xsl:otherwise>
						</xsl:choose>
					  </TD>					
					</TR>					
					
					<!-- Länge -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Länge</TH>
					  <xsl:variable name="len1" select="@len" />
					  <TD align="left">
						<xsl:choose>
						  <xsl:when test="$len1 = ''">
							<xsl:text>0</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@len" />
						  </xsl:otherwise>
						</xsl:choose>
					  </TD>						
					</TR>

					<!-- Zugart -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Zugart</TH>
						  <xsl:variable name="cargo" select="@cargo" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$cargo = 'none'">
								<xsl:text>Andere</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'goods'">
								<xsl:text>G&#252;terverkehr</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'person'">
								<xsl:text>Nahverkehr</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'mixed'">
								<xsl:text>Mischverkehr</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'cleaning'">
								<xsl:text>Gleisreinigung</xsl:text>
							  </xsl:when>    
							  <xsl:when test="$cargo = 'ice'">
								<xsl:text>Fernverkehr</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'post'">
								<xsl:text>Post</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'light'">
								<xsl:text>Nebenbahn</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'lightgoods'">
								<xsl:text>G&#252;ter-Nebenbahn</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'regional'">
								<xsl:text>Regionalzug</xsl:text>
							  </xsl:when>
							  <xsl:when test="$cargo = 'shunting'">
								<xsl:text>Rangieren</xsl:text>
							  </xsl:when>							  
							  <xsl:when test="$cargo = 'all'">
								<xsl:text>Alle</xsl:text>
							  </xsl:when>

							  <xsl:when test="$cargo = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>

							  <xsl:otherwise>
								<xsl:value-of select="@cargo" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
				
					</TR>
					
					<!-- Pendelzug -->
					<TR>						  
						<TH width="40%" bgcolor="{$bgcolor}">Pendelzug</TH>						  
						  <xsl:variable name="commuter" select="@commuter" />
							<TD align="left">
							 <xsl:choose>
							 <xsl:when test="$commuter = 'false'">
							  <xsl:text>Nein</xsl:text>
							   </xsl:when>
							   <xsl:when test="$commuter = 'true'">
							   <xsl:text>Ja</xsl:text>
							 </xsl:when>
							 </xsl:choose>
						  </TD>					
					</TR>
					
					<!-- Zuglänge -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Zug (Länge)</TH>						
					
						<TD align="left">
						  <xsl:variable name="train1" select="@train" />
						 <xsl:choose>
						  <xsl:when test="$train1 = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@train" /> (<xsl:value-of select="@trainlen" />)
						  </xsl:otherwise>
						 </xsl:choose>
					   </TD>					
					</TR>
					

				
				</table>	

			</TD>

			<!-- 1. Zeile, Spalte 4 -->
			<TD width="20%" valign="top">
				<table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%"  style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
					
					<!-- V_Min -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Min</TH>	

						  <xsl:variable name="v_min" select="@V_min" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$v_min = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@V_min" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>	
					</TR>
					
					<!-- v_mid -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Mid</TH>					
						  <xsl:variable name="v_mid" select="@V_mid" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$v_mid = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@V_mid" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>					
					</TR>

					<!-- v_cru -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Reise</TH>	
						  <xsl:variable name="v_cru" select="@V_cru" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$v_cru = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@V_cru" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>	
					</TR>
					
					<!-- v_max -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Max</TH>			
						  <xsl:variable name="v_max" select="@V_max" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$v_max = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@V_max" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
					</TR>
					
					<!-- v_mod -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Modus</TH>							  
						  
						  <xsl:variable name="v_mode" select="@V_mode" />
						  <TD align="left">
						   <xsl:choose>
							  <xsl:when test="$v_mode = 'percent'">
								<xsl:text>%</xsl:text>
							  </xsl:when>
							  <xsl:when test="$v_mode = 'kmh'">
								<xsl:text>Km/h</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>   
								<xsl:value-of select="@V_mode" />                  
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>						  
					</TR>

					<!-- Blockwartezeit -->	
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Blockwartezeit</TH>		
						
						
						  <xsl:variable name="blockwaittime" select="@blockwaittime" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$blockwaittime = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@blockwaittime" /> Sek.
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>						
					</TR>

					<!-- Eigene Blockwartezeit -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Eigene BWZ</TH>	
						  <xsl:variable name="useownwaittime" select="@useownwaittime" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$useownwaittime='false'">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:when test="$useownwaittime='true'">
								<xsl:text>Ja</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@useownwaittime" /> Sek.
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>
					</TR>

					<!-- Verwende ShortIn -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">ShortIn</TH>
						  <xsl:variable name="shortin1" select="@shortin" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$shortin1='false'">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:when test="$shortin1='true'">
								<xsl:text>Ja</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
							  <xsl:value-of select="@shortin" />
							   </xsl:otherwise>
							</xsl:choose>
							</TD>
							
					</TR>

					<!-- Stop bei Pre2In -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Pre2In</TH>							
						  <xsl:variable name="inatpre2in1" select="@inatpre2in" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$inatpre2in1='false'">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:when test="$inatpre2in1='true'">
								<xsl:text>Ja</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
							  <xsl:value-of select="@inatpre2in" />
							   </xsl:otherwise>
							</xsl:choose>
							</TD>
					</TR>


					<!-- leer -->
					<!-- TR>
						<TH width="40%" bgcolor="{$bgcolor}">- </TH>	
						
						<TD align="left">
						<xsl:text>-</xsl:text>	
						 </TD>
					</TR -->
					
				</table>
			
			</TD>
		
		</TR> <!-- 1. Zeile Main Table -->
		
		<TR> <!-- 2. Zeile Main Table -->
		
			<!-- Bemerkungen -->
			<TD valign="top" align="left" height="200px" style="font-family:Arial, Helvetica, sans-serif; font-size:13px" >
				<h5>Bemerkungen:</h5>
				<xsl:value-of select="@remark" />
			</TD>			

			<!-- Funktionen auflisten -->
			<TD width="20%" valign="top" colspan="2">
				<h5>Funktionen:</h5>
				
				<table border="0" rules="all" cellpadding="0" cellspacing="1" width="100%">
					<tr>
						<!-- 1. Spalte ausgeben -->
						<td valign="top">
							<table width="100%" border="1" rules="all" cellpadding="4" cellspacing="0" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<xsl:apply-templates select="fundef">
									<!-- sortieren der fundef Nodes -->
									<xsl:sort select="@fn" order="ascending" data-type="number"/>
									<!-- Parameter übergeben -->
									<xsl:with-param name="cellpos" select="1" />									
								</xsl:apply-templates>	
							</table>
						</td>
						<!-- 2. Spalte ausgeben -->						
						<td valign="top">
							<table width="100%" border="1" rules="all" cellpadding="4" cellspacing="0" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<xsl:apply-templates select="fundef">
									<!-- sortieren der fundef Nodes -->
									<xsl:sort select="@fn" order="ascending" data-type="number"/>
									<!-- Parameter übergeben -->
									<xsl:with-param name="cellpos" select="2" />
								</xsl:apply-templates>	
							</table>
						</td>
						<!-- 3. Spalte ausgeben -->						
						<td valign="top">
							<table width="100%" border="1" rules="all" cellpadding="4" cellspacing="0" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<xsl:apply-templates select="fundef">
									<!-- sortieren der fundef Nodes -->
									<xsl:sort select="@fn" order="ascending" data-type="number"/>
									<!-- Parameter übergeben -->
									<xsl:with-param name="cellpos" select="3" />									
								</xsl:apply-templates>	
							</table>
						</td>
						<!-- 4. Spalte ausgeben -->						
						<td valign="top">
							<table width="100%" border="1" rules="all" cellpadding="4" cellspacing="0" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<xsl:apply-templates select="fundef">
									<!-- sortieren der fundef Nodes -->
									<xsl:sort select="@fn" order="ascending" data-type="number"/>
									<!-- Parameter übergeben -->
									<xsl:with-param name="cellpos" select="0" />									
								</xsl:apply-templates>	
							</table>
						</td>						
					</tr>				
				</table>
					
			</TD>	
			
			<TD>.</TD>

			
		</TR> <!-- 2. Zeile Main Table -->
		
		</table>

		<br/>
		
		</xsl:for-each>

	</body>
    </html>
  </xsl:template>
  
	<xsl:template match="fundef">
	<!--
		Parameter für Spalte. Bei 4 Spalten bedeuten 
		1 = Spalte 1
		2 = Spalte 2
		3 = Spalte 3
		0 = Spalte 4
	-->
	<xsl:param name="cellpos" />
		<!-- 
			prüfen ob Datensatz ausgegeben werden soll.
			Ausgangslage 4 Spalten. Berechnung mit mod 4 
		-->
			
		<xsl:if test="position() mod 4 = $cellpos">
				<tr valign="top">
					<TH width="5%" bgcolor="{$bgcolor}">F<xsl:value-of select="@fn" /></TH>				
					<TD width="95%" align="left" >
						<xsl:value-of select="@text" />
					</TD>
				</tr>
		</xsl:if>		
	</xsl:template>	
	
 	<xsl:template match="lc">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template name="millisecs-to-ISO">
		<xsl:param name="millisecs"/>
		<xsl:param name="showtime" select="1"/>

		<xsl:param name="JDN" select="floor($millisecs div 86400000) + 2440588"/>
		<xsl:param name="mSec" select="$millisecs mod 86400000"/>

		<xsl:param name="f" select="$JDN + 1401 + floor((floor((4 * $JDN + 274277) div 146097) * 3) div 4) - 38"/>
		<xsl:param name="e" select="4*$f + 3"/>
		<xsl:param name="g" select="floor(($e mod 1461) div 4)"/>
		<xsl:param name="h" select="5*$g + 2"/>

		<xsl:param name="d" select="floor(($h mod 153) div 5 ) + 1"/>
		<xsl:param name="m" select="(floor($h div 153) + 2) mod 12 + 1"/>
		<xsl:param name="y" select="floor($e div 1461) - 4716 + floor((14 - $m) div 12)"/>

		<xsl:param name="H" select="floor($mSec div 3600000)"/>
		<xsl:param name="M" select="floor($mSec mod 3600000 div 60000)"/>
		<xsl:param name="S" select="$mSec mod 60000 div 1000"/>
<!--
		<xsl:value-of select="concat(format-number($d, '00'), format-number($m, '.00'), format-number($y, '.0000') )" />
		<xsl:value-of select="concat(format-number($H, ' 00'), format-number($M, ':00'), format-number($S, ':00'))" />
-->

		<xsl:value-of select="concat(format-number($d, '00:'), format-number($m, '00:'), $y )" />

		<xsl:if test="$showtime = 1">
			<xsl:value-of select="concat(format-number($H, ' 00'), format-number($M, ':00'), format-number($S, ':00'))" />
		</xsl:if>
		
	</xsl:template> 	

</xsl:stylesheet>
