<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="UTF-8"/>


<!-- Mit diesem Stylesheet kann nur jeweils eine DS/SB ausgewertet werden -->
<!-- Durch ändern der Zahl in den eckigen Klammern auf z. B. 2 wird die zweite Drehscheibe aufgerufen usw. -->
<xsl:variable name="Pfad" select="plan/ttlist/tt[1]"/>

<!-- Vorlage für die Parameter der Drehscheibe -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Rocrail Drehscheiben Report</title>
			</head>
      <tbody>
        <h2>Parameter einer Drehscheibe / Schiebebühne in Rocrail</h2>
				<TR>
				<h3>Allgemein und Schnittstellen</h3>
				</TR>
        <table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
          <THEAD>
            <TR>
				      <TH width="20%" bgcolor="lightgrey">Kennung</TH>
 	    			  <TH width="20%" bgcolor="lightgrey">Beschreibung</TH>
							<TH width="20%" bgcolor="lightgrey">Schnittstellenkennung</TH>
							<TH width="10%" bgcolor="lightgrey">Adresse</TH>
							<TH width="10%" bgcolor="lightgrey">Adr. AccDec</TH>
            	<TH width="5%" bgcolor="lightgrey">Bus</TH>
							<TH width="15%" bgcolor="lightgrey">UID Name</TH>
						</TR>
         </THEAD>

   	<xsl:for-each select="$Pfad">
	
		<TR>	
			<td align="center">
				<xsl:value-of select="@id"/>
			</td>
	
	<xsl:variable name="desc" select="@desc"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$desc = ''">
	      <xsl:text>-</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
				<xsl:value-of select="@desc"/>
	    </xsl:otherwise>	
	    </xsl:choose>
		</td>

	<xsl:variable name="iid" select="@iid"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$iid = ''">
	      <xsl:text>-</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
				<xsl:value-of select="@iid"/>
	    </xsl:otherwise>	
	    </xsl:choose>
	</td>
	
	<td align="center">
	<xsl:value-of select="@addr"/>
	</td>

	
	<td align="center">
		<xsl:value-of select="@diraddr"/>
	</td>

	<td align="center">
		<xsl:value-of select="@bus"/>
	</td>
	
	<xsl:variable name="uidname" select="@uidname"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$uidname = ''">
	      <xsl:text>-</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
				<xsl:value-of select="@uidname"/>
	    </xsl:otherwise>	
	    </xsl:choose>
	</td>
</TR>
</xsl:for-each>	
     </table>
     
    


<TR>
  
    <table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
      <THEAD>
       
        <TH width="11%" bgcolor="lightgrey">Zufallsrate</TH>
        <TH width="11%" bgcolor="lightgrey">Symbolgröße</TH>
        <TH width="8%" bgcolor="lightgrey">Gleisblöcke verwalten</TH>
        <TH width="8%" bgcolor="lightgrey">Integrierter Block</TH>
      	<TH width="8%" bgcolor="lightgrey">Schiebebühne</TH>
	      <TH width="14%" bgcolor="lightgrey">Brücke drehen...</TH>             
        <TH width="10%" bgcolor="lightgrey">f-Lokdec.</TH>
        <TH width="10%" bgcolor="lightgrey">f-Relais</TH>
        <TH width="10%" bgcolor="lightgrey">f-Licht</TH>
        <TH width="10%" bgcolor="lightgrey">V_Drehen</TH>
	      
      </THEAD>
	   
				
	<xsl:for-each select="$Pfad">
		<TR>
	<td align="center">
		<xsl:value-of select="@randomrate"/>
	</td>

	<td align="center">
		<xsl:value-of select="@symbolsize"/>
	</td>

	<xsl:variable name="manager" select="@manager"/>
	<td align="center">
	  <xsl:choose>
	  <xsl:when test="$manager = 'true'">
	    <xsl:text>Ja</xsl:text>
	  </xsl:when>
	  <xsl:when test="$manager = 'false'">
	    <xsl:text>Nein</xsl:text>
	  </xsl:when>
	  </xsl:choose>
	</td>

	<xsl:variable name="embeddedblock" select="@embeddedblock"/>
	<td align="center">
	  <xsl:choose>
	  <xsl:when test="$embeddedblock = 'true'">
	    <xsl:text>Ja</xsl:text>
	  </xsl:when>
	  <xsl:when test="$embeddedblock = 'false'">
	    <xsl:text>Nein</xsl:text>
	  </xsl:when>
	  </xsl:choose>
	</td>

	<xsl:variable name="traverser" select="@traverser"/>
	<td align="center">
		<xsl:choose>
	  <xsl:when test="$traverser = 'true'">
	    <xsl:text>Ja</xsl:text>
	  </xsl:when>
	  <xsl:when test="$traverser = 'false'">
	      <xsl:text>Nein</xsl:text>
	  </xsl:when>
	  </xsl:choose>
	</td>

	<xsl:variable name="move4opp" select="@move4opp"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$move4opp = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$move4opp = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>

	<td align="center">
		<xsl:value-of select="@actfn"/>
	</td>

	<td align="center">
		<xsl:value-of select="@polfn"/>
	</td>

	<td align="center">
		<xsl:value-of select="@lightsfn"/>
	</td>
	
	<td align="center">
		<xsl:value-of select="@V"/>%
	</td>
</TR>
</xsl:for-each>
</table>
</TR>




<TR>
   
      <table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
         <THEAD>
           <TR>
            <TH width="15%" bgcolor="lightgrey">Verzögerung Lokstart</TH>
	      		<TH width="15%" bgcolor="lightgrey">Wartezeit Richtungswechsel</TH>
						<TH width="15%" bgcolor="lightgrey">Ausschaltverzögerung Motor</TH>
	      		<TH width="10%" bgcolor="lightgrey">Protokoll</TH>
						<TH width="25%" bgcolor="lightgrey">Type</TH>
	      		<TH width="10%" bgcolor="lightgrey">Umkehren</TH>
	      		<TH width="10%" bgcolor="lightgrey">Wechsel der Drehrichtung</TH>	
            </TR>
          </THEAD>

					<xsl:for-each select="$Pfad">

		<TR>

		<td align="center">
			<xsl:value-of select="@delay"/>s
		</td>

		<td align="center">
			<xsl:value-of select="@pause"/>s
		</td>

		<td align="center">
			<xsl:value-of select="@motoroffdelay"/>ms
		</td>		

		<td align="center">
	     <xsl:variable name="prot" select="@prot"/>
          <xsl:choose>
            <xsl:when test="$prot = 'MP'">
            	<xsl:text>Multiport</xsl:text>
            </xsl:when>
            <xsl:when test="$prot = 'M'">
              <xsl:text>Motorola</xsl:text>
            </xsl:when>
            <xsl:when test="$prot = 'N'">
              <xsl:text>DCC</xsl:text>
            </xsl:when>
            <xsl:when test="$prot = 'D'">
            	<xsl:text>DEFAULT</xsl:text>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:value-of select="@prot"/>
            </xsl:otherwise>
            </xsl:choose>
    </td>

			
	<td align="center">
		<xsl:value-of select="@type"/>
	</td>
			

			

	<xsl:variable name="inv" select="@inv"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$inv = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$inv = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>

		<xsl:variable name="swaprotation" select="@swaprotation"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$swaprotation = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$swaprotation = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>
</TR>
</xsl:for-each>
</table>
</TR>





<TR>
  
  	<table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
  	  <THEAD>
  	    <TR>
        <TH width="10%" bgcolor="lightgrey">Positions- Rückmelder</TH>
	      <TH width="10%" bgcolor="lightgrey">Brücke Rm 1</TH>
	      <TH width="10%" bgcolor="lightgrey">Brücke Rm 2</TH>
	      <TH width="10%" bgcolor="lightgrey">Brücke Rm 3</TH>
	      <TH width="10%" bgcolor="lightgrey">Brücke Rm 4</TH>
	      <TH width="10%" bgcolor="lightgrey">Polarisierung Adresse 1</TH>
				<TH width="10%" bgcolor="lightgrey">Polarisierung Adresse 2</TH>
	      <TH width="10%" bgcolor="lightgrey">Polarisierung Ausgang 1</TH>
				<TH width="10%" bgcolor="lightgrey">Polarisierung Ausgang 2</TH>
				</TR>
       </THEAD>
				
					<xsl:for-each select="$Pfad"> 	

					<TR>

	<td align="center">
  	<xsl:variable name="psen" select="@psen"/>
		<xsl:choose>
  		<xsl:when test="$psen = ''">
  	<xsl:text>-</xsl:text>
		</xsl:when>
  		<xsl:otherwise>
  	<xsl:value-of select="@psen"/>
  	</xsl:otherwise>
  	</xsl:choose>
  </td>

	<td align="center">
		<xsl:variable name="s1" select="@s1"/>
    <xsl:choose>
    	<xsl:when test="$s1 = ''">
    <xsl:text>-</xsl:text>
		</xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="@s1"/>
    </xsl:otherwise>
    </xsl:choose>
  </td>
		
	<td align="center">
		<xsl:variable name="s2" select="@s2"/>
    <xsl:choose>
    <xsl:when test="$s2 = ''">
    	<xsl:text>-</xsl:text>
		</xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="@s2"/>
   	</xsl:otherwise>
    </xsl:choose>
  </td>

	<td align="center">
	  <xsl:variable name="sMid" select="@sMid"/>
    <xsl:choose>
    <xsl:when test="$sMid = ''">
    	<xsl:text>-</xsl:text>
		</xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="@sMid"/>
    </xsl:otherwise>
    </xsl:choose>
  </td>

	<td align="center">
		<xsl:variable name="sMid2" select="@sMid2"/>
    <xsl:choose>
    <xsl:when test="$sMid2 = ''">
      <xsl:text>-</xsl:text>
		</xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="@sMid2"/>
    </xsl:otherwise>
    </xsl:choose>
  </td>

	<td align="center">
		<xsl:value-of select="@poladdr"/>
	</td>

	<td align="center">
		<xsl:value-of select="@poladdr2"/>
	</td>

	<td align="center">
		<xsl:variable name="poloutput1" select="@poloutput1"/>
    <xsl:choose>
    <xsl:when test="$poloutput1 = ''">
    	<xsl:text>-</xsl:text>
		</xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="@poloutput1"/>
    </xsl:otherwise>
    </xsl:choose>
  </td>

	<td align="center">
		<xsl:variable name="poloutput2" select="@poloutput2"/>
    <xsl:choose>
    <xsl:when test="$poloutput2 = ''">
    	<xsl:text>-</xsl:text>
		</xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="@poloutput2"/>
    </xsl:otherwise>
    </xsl:choose>
  </td>

</TR>
</xsl:for-each>
</table>
</TR>




<TR>
  
  	<table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
  	  <THEAD>
  	    <TR>
        <TH width="10%" bgcolor="lightgrey">Multiport Adresse </TH>
	      <TH width="5%" bgcolor="lightgrey">Port 0</TH>
	      <TH width="10%" bgcolor="lightgrey">Multiport Adresse 1</TH>
	      <TH width="5%" bgcolor="lightgrey">Port 1</TH>
	      <TH width="10%" bgcolor="lightgrey">Multiport Adresse 2</TH>
	      <TH width="5%" bgcolor="lightgrey">Port 2</TH>
				<TH width="10%" bgcolor="lightgrey">Multiport Adresse 3</TH>
	      <TH width="5%" bgcolor="lightgrey">Port 3</TH>
				<TH width="10%" bgcolor="lightgrey">Multiport Adresse 4</TH>
				<TH width="5%" bgcolor="lightgrey">Port 4</TH>
				<TH width="10%" bgcolor="lightgrey">Multiport Adresse 5</TH>
				<TH width="5%" bgcolor="lightgrey">Port 5</TH>
				<TH width="5%" bgcolor="lightgrey">Umkehren</TH>
				<TH width="5%" bgcolor="lightgrey">Ein Ausgang</TH>
				</TR>
       </THEAD>

				<xsl:for-each select="$Pfad"> 

			<TR>
	<td align="center">
		<xsl:value-of select="@addr0"/>
	</td>
	
	<td align="center">
		<xsl:value-of select="@port0"/>
	</td>

	<td align="center">
		<xsl:value-of select="@addr1"/>
	</td>
		
	<td align="center">
		<xsl:value-of select="@port1"/>
	</td>
	
	<td align="center">
		<xsl:value-of select="@addr2"/>
	</td>

		<td align="center">
		<xsl:value-of select="@port2"/>
	</td>

	<td align="center">
		<xsl:value-of select="@addr3"/>
	</td>

		<td align="center">
		<xsl:value-of select="@port3"/>
	</td>
	
	<td align="center">
		<xsl:value-of select="@addr4"/>
	</td>

	<td align="center">
		<xsl:value-of select="@port4"/>
	</td>
	<td align="center">
		<xsl:value-of select="@addr5"/>
	</td>

		<td align="center">
		<xsl:value-of select="@port5"/>
	</td>

	<xsl:variable name="invpos" select="@invpos"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$invpos = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$invpos = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>

	<xsl:variable name="singlegatepos" select="@singlegatepos"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$singlegatepos = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$singlegatepos = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>


</TR>
</xsl:for-each>
</table>
</TR>




<TR>
  
  	<table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
  	  <THEAD>
  	    <TR>
        <TH width="20%" bgcolor="lightgrey">Neupositionierung Adresse</TH>
	      <TH width="20%" bgcolor="lightgrey">Neupositionierung Port</TH>
	      <TH width="10%" bgcolor="lightgrey">Umkehren</TH>
	      <TH width="15%" bgcolor="lightgrey">Ein Ausgang</TH>
	      <TH width="20%" bgcolor="lightgrey">Zurücksetzen Adresse</TH>
				<TH width="15%" bgcolor="lightgrey">Zurücksetzen Port</TH>
				</TR>
        </THEAD>
					<xsl:for-each select="$Pfad"> 
					<TR>
	<td align="center">
		<xsl:value-of select="@addr5"/>
	</td>
	
	<td align="center">
		<xsl:value-of select="@port5"/>
	</td>

	<xsl:variable name="invnew" select="@invnew"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$invnew = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$invnew = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>

	<xsl:variable name="singlegatenew" select="@singlegatenew"/>
	  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$singlegatenew = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$singlegatenew = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
		</td>
	
	<td align="center">
		<xsl:value-of select="@resetaddr"/>
	</td>

		<td align="center">
		<xsl:value-of select="@resetport"/>
	</td>

	
</TR>
</xsl:for-each>
</table>
</TR>


	

<!-- Parameter der Drehscheibengleise lesen -->

<TR>
				<table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
    		<THEAD><h3>Gleise</h3>
        	<TR>
          <TH width="12%" bgcolor="lightgrey">Gleisnummer</TH>
	      	<TH width="12%" bgcolor="lightgrey">Dekoder Gleisnummer</TH>
	      	<TH width="15%" bgcolor="lightgrey">Entgegengesetzte Gleisnummer</TH>
					<TH width="21%" bgcolor="lightgrey">Beschreibung</TH>
	      	<TH width="15%" bgcolor="lightgrey">Blockkennung</TH>
	      	<TH width="15%" bgcolor="lightgrey">Positions- Rückmelder</TH>
					<TH width="15%" bgcolor="lightgrey">Polarisierung der Brücke</TH>
	      	<TH width="15%" bgcolor="lightgrey">Sichtbar</TH>
					</TR>
        </THEAD>
					<xsl:for-each select="$Pfad/track"> 
						<xsl:sort select="@id" order="ascending" data-type="number"/>

		<TR>
		<td align="center">
			<xsl:value-of select="@nr"/>
		</td>

		<td align="center">
			<xsl:value-of select="@decnr"/>
		</td>

		<td align="center">
			<xsl:value-of select="@oppositetrack"/>
		</td>

		<td align="center">
	  	<xsl:variable name="desc" select="@desc"/>
      <xsl:choose>
      <xsl:when test="$desc = ''">
      	<xsl:text>-</xsl:text>
			</xsl:when>
      <xsl:otherwise>
      	<xsl:value-of select="@desc"/>
      </xsl:otherwise>
      </xsl:choose>
    </td>

		<td align="center">
	  	<xsl:variable name="bkid" select="@bkid"/>
      <xsl:choose>
      <xsl:when test="$bkid = ''">
      	<xsl:text>-</xsl:text>
			</xsl:when>
      <xsl:otherwise>
      	<xsl:value-of select="@bkid"/>
      </xsl:otherwise>
      </xsl:choose>
     </td>

		<td align="center">
	    <xsl:variable name="posfb" select="@posfb"/>
      <xsl:choose>
      <xsl:when test="$posfb = ''">
       	<xsl:text>-</xsl:text>
			</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@posfb"/>
      </xsl:otherwise>
      </xsl:choose>
     </td>

		<xsl:variable name="polarization" select="@polarization"/>
		  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$polarization = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$polarization = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
	</td>

		<xsl:variable name="show" select="@show"/>
		  <td align="center">
	    <xsl:choose>
	    <xsl:when test="$show = 'true'">
	      <xsl:text>Ja</xsl:text>
	    </xsl:when>
	    <xsl:when test="$show = 'false'">
	      <xsl:text>Nein</xsl:text>
	    </xsl:when>
	    </xsl:choose>
			</td>
	</TR>
	</xsl:for-each>
	</table>
	</TR>

<!-- Aktionsparameter lesen -->
	
	<TR>
			<table border="1" rules="all" cellpadding="2" cellspacing="0" width="100%">
	 		<THEAD><h3>Aktionen</h3>
        <TR>
        <TH width="50%" bgcolor="lightgrey">Aktion </TH>
				<TH width="25%" bgcolor="lightgrey">1. Bedingung</TH>
				<TH width="25%" bgcolor="lightgrey">Status</TH>
	      </TR>
      </THEAD>
			
				<xsl:for-each select="$Pfad/actionctrl">
				<xsl:sort select="@id" order="ascending" data-type="text"/>
				<tr>
					<td><xsl:value-of select="@id"/></td>
					<td><xsl:value-of select="actioncond/@id"/></td>
					<td><xsl:value-of select="actioncond/@state"/></td>
				</tr>
				</xsl:for-each>
				</table>
	</TR>

</tbody>
</html>
</xsl:template>

</xsl:stylesheet>
