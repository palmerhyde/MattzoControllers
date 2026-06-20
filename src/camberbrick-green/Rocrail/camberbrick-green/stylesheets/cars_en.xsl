<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- 
	xsl Template für Wagen Report

	Version 1.1
	
	History:	
	15.10.2017 andy		Initial Version
	10.08.2018 andy		Fehler unter Chrom in der Ausgabe des Protokolls und der Fahrstufen behoben	
-->

	<xsl:output method="html" encoding="UTF-8" />
  
	<!-- Variable für Hintergrundfarbe in Titelzellen -->
	<xsl:variable name="bgcolor" select="'lightgrey'" />
	
  
  <xsl:template match="/">

    <html>
	<head>
        <title>Rocrail Cars report</title>
	</head>
	<body style="font-family:Arial, Helvetica, sans-serif">
		<h2>All Cars report</h2>
		<xsl:for-each select="/*/carlist/car">

		<!-- Alternative sorting by address // uncomment here or the other sorting part  -->
		<xsl:sort select="@type" order="ascending" data-type="text" />
		<xsl:sort select="@subtype" order="ascending" data-type="text" />
		<xsl:sort select="@era" order="ascending" data-type="text" />
		<xsl:sort select="@id" order="ascending" />

		
		<!--xsl:sort select="@addr" order="ascending" data-type="number" /--> 		
		
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

			<!-- Description -->
			  <TD valign="top" align="left" height="200px" style="font-family:Arial, Helvetica, sans-serif; font-size:13px">
				<br/>
				<h5>Description:</h5>
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
					<!-- ident -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Code</TH>	
						<xsl:variable name="ident" select="@ident" />
						
						<TD align="left">
						
						<xsl:choose>
						  <xsl:when test="$ident = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:otherwise>
							<xsl:value-of select="@ident" />
						  </xsl:otherwise>
						</xsl:choose>
						

						 </TD>
					</TR>						
					
					<!-- Address -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Address</TH>
						<xsl:variable name="addr" select="@addr" />
						<TD align="left">
						 <xsl:choose>
						  <xsl:when test="$addr = ''">
							<xsl:text>-</xsl:text>
						  </xsl:when>
						  <xsl:when test="$addr = '0'">
							<xsl:text>-</xsl:text>
						  </xsl:when>						  
						  <xsl:otherwise>
							<xsl:value-of select="@addr" />
						  </xsl:otherwise>
						 </xsl:choose>
						</TD>
					</TR>

					<!-- Decoder -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Decoder type</TH>
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

							<!-- Protocol -->
							<TR>
								<TH width="40%" bgcolor="{$bgcolor}">Protocol</TH>					
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

							<!-- Decoder steps -->
							<TR>
								<TH width="40%" bgcolor="{$bgcolor}">Decoder steps</TH>					
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
												
					<!-- Manufacturer -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Manufacturer</TH>					
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

					<!-- Catalog number -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Catalog number</TH>					
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

					<!-- Date of purchase -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Date of purchase</TH>
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
					
				</table>
				
			</TD>
			
			<!-- 1. Zeile, Spalte 3 -->
			<TD width="20%" valign="top">
			
				<table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%"  style="font-family:Arial, Helvetica, sans-serif; font-size:11px">

					<!-- Roadname -->
					<TR>						  
						<TH width="40%" bgcolor="{$bgcolor}">Roadname</TH>
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
						
					<!-- Era -->
					<TR>						  
						<TH width="40%" bgcolor="{$bgcolor}">Era</TH>					
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

					<!-- Length -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Length</TH>
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
			
					<!-- Color -->
					<TR>

						<TH width="40%" bgcolor="{$bgcolor}">Color</TH>
						  <TD align="left">					
							<xsl:variable name="color" select="@color" />
						   <xsl:choose>
							 <xsl:when test="$color = ''">
							 <xsl:text>-</xsl:text>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:value-of select="@color" />
						   </xsl:otherwise>
						   </xsl:choose>
						   </TD>
				
					</TR>						   
						   
					<!-- Commuter train -->
					<TR>						  
						<TH width="40%" bgcolor="{$bgcolor}">Commuter train</TH>						  
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
					
					<!-- Type -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Type</TH>						
					
						<TD align="left">
							<xsl:variable name="type" select="@type" />
						   <xsl:choose>
							 <xsl:when test="$type = ''">
								<xsl:text>-</xsl:text>
							 </xsl:when>
							 <xsl:when test="$type = 'goods'">
								<xsl:text>Freight</xsl:text>
							 </xsl:when>
							 <xsl:when test="$type = 'passenger'">
								<xsl:text>Passenger</xsl:text>
							 </xsl:when>
						   </xsl:choose>

					   </TD>					
					</TR>
					
					<!-- Sub-Typ -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Subtype</TH>						
					
						<TD align="left">
						   <xsl:variable name="subtype" select="@subtype" />
						   <xsl:choose>
								<xsl:when test="$subtype = ''">
									<xsl:text>-</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'coach'">
									<xsl:text>Coach</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'lounge'">
									<xsl:text>Lounge</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'dome'">
									<xsl:text>Dome</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'express'">
									<xsl:text>Express</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'dinner'">
									<xsl:text>Dinner</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'baggage'">
									<xsl:text>Baggage</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'postoffice'">
									<xsl:text>Postoffice</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'sleeper'">
									<xsl:text>Sleeper</xsl:text>
								</xsl:when>								
								<xsl:when test="$subtype = 'boxcar'">
									<xsl:text>Boxcar</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'gondola'">
									<xsl:text>Gondola</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'flatcar'">
									<xsl:text>Flatcar</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'reefer'">
									<xsl:text>Reefer</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'stockcar'">
									<xsl:text>Stockcar</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'tankcar'">
									<xsl:text>Tankcar</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'wellcar'">
									<xsl:text>Wellcar</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'hopper'">
									<xsl:text>Hopper</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'caboose'">
									<xsl:text>Caboose</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'autorack'">
									<xsl:text>Autorack</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'autocarrier'">
									<xsl:text>Autocarrier</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'logdumpcar'">
									<xsl:text>Logdumpcar</xsl:text>
								</xsl:when>
								<xsl:when test="$subtype = 'coilcar'">
									<xsl:text>Coilcar</xsl:text>
								</xsl:when>
							   <xsl:otherwise>
								 <xsl:value-of select="@subtype" />
							   </xsl:otherwise>								
						   </xsl:choose>

					   </TD>
					   
					</TR>
					
					<!-- Status  -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Status</TH>						
					
						<TD align="left">
						   <xsl:variable name="status" select="@status" />

						   <xsl:choose>
							 <xsl:when test="$status = ''">
							 <xsl:text>-</xsl:text>
						   </xsl:when>
						   <xsl:when test="$status = 'empty'">
								<xsl:text>Empty</xsl:text>
							</xsl:when>
							<xsl:when test="$status = 'loaded'">
								<xsl:text>Loaded</xsl:text>
							</xsl:when>
							<xsl:when test="$status = 'maintenance'">
								<xsl:text>Maintenance</xsl:text>
							</xsl:when>	
						   </xsl:choose>

					   </TD>					
					</TR>
					
				</table>	

			</TD>

			<!-- 1. Zeile, Spalte 4 -->
			<TD width="20%" valign="top">
				<table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%"  style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
					
					<!-- weight_empty -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Weight empty</TH>	

						  <xsl:variable name="weight_empty" select="@weight_empty" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$weight_empty = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@weight_empty" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>	
					</TR>
					
					<!-- weight_loaded -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Weight loaded</TH>					
						  <xsl:variable name="weight_loaded" select="@weight_loaded" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$weight_loaded = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@weight_loaded" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>					
					</TR>

					<!-- maxloadweight -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">Max. load weight</TH>	
						  <xsl:variable name="maxloadweight" select="@maxloadweight" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$maxloadweight = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@maxloadweight" />
							  </xsl:otherwise>
							</xsl:choose>
						  </TD>	
					</TR>
					
					<!-- v_max -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Max empty</TH>			
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
					
					<!-- V_max_loaded -->
					<TR>
						<TH width="40%" bgcolor="{$bgcolor}">V_Max loaded</TH>			
						  <xsl:variable name="V_max_loaded" select="@V_max_loaded" />
						  <TD align="left">
							<xsl:choose>
							  <xsl:when test="$V_max_loaded = ''">
								<xsl:text>-</xsl:text>
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:value-of select="@V_max_loaded" />
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
				<h5>Remark:</h5>
				<xsl:value-of select="@remark" />
			</TD>			

			<!-- Funktionen auflisten -->
			<TD width="20%" valign="top" colspan="2">
				<h5>Functions:</h5>
				
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

</xsl:stylesheet>
