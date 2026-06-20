<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">

   <html>
   <head><title>Rocrail Tours report</title>
  </head>
  <body>
  <h2>Rocrail Touren Report</h2>

  <table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%">
      <THEAD>
	  <TR>
	     <TH width="30%" height="30" bgcolor="lightgrey">Kennung</TH>
	     <TH width="35%" height="30" bgcolor="lightgrey">Gruppe</TH>
		 <TH width="35%" height="30" bgcolor="lightgrey">Wiederholen</TH>
	  </TR>
      </THEAD> 
      <TBODY>
        <xsl:apply-templates/>
      </TBODY>
   </table>
   </body>
   </html>
   
</xsl:template>

<xsl:template match="tourlist">  
  
  <xsl:apply-templates/>

</xsl:template>


<xsl:template match="tour">  

	<TR>
       <th rowspan="2" align="center">
	    <xsl:value-of select="@id" />
	   </th>	
 
       <xsl:variable name="group" select="@group" />

	   <TD align="center">
	   <xsl:choose>
         <xsl:when test="$group = ''">
         <xsl:text>-</xsl:text>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="@group" />
       </xsl:otherwise>
       </xsl:choose>
	   </TD>
	   
	   <xsl:variable name="recycle" select="@recycle" />
	   
	   <td align="center">
	   <xsl:choose>
         <xsl:when test="@recycle = 'true'">
       <xsl:text>Ja</xsl:text>	 
       </xsl:when>
       <xsl:otherwise>
         <xsl:text>Nein</xsl:text>
       </xsl:otherwise>
       </xsl:choose>
	   </td>	
   </TR>

    <TR>
	<td colspan="3">
    <table border="0" rules="all" cellpadding="4" cellspacing="0" width="100%">
      <THEAD>
	  <TR>
		 <TH width="50$" height="30" bgcolor="white">Fahrplan</TH>
	     <TH width="25%" height="30" bgcolor="white">Stunde</TH>
	     <TH width="25%" height="30" bgcolor="white">Minute</TH>
 	  </TR>
      </THEAD> 
      <TBODY>
        <xsl:apply-templates/>
      </TBODY>
      </table>

	</td>
	</TR>
 
</xsl:template>

<xsl:template match="tourentry">  

      <TR>
	  
	   <th rowspan="1" align="center">
	    <xsl:value-of select="@id" />
	   </th>	

	   <xsl:variable name="hour" select="@hour" />
	   <TD align="center">
	   <xsl:choose>
         <xsl:when test="$hour = ''">
         <xsl:text>-</xsl:text>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="@hour" />
       </xsl:otherwise>
       </xsl:choose>
	   </TD>
	   
	   <xsl:variable name="minute" select="@minute" />
	   <TD align="center">
	   <xsl:choose>
         <xsl:when test="$minute = ''">
         <xsl:text>-</xsl:text>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="@minute" />
       </xsl:otherwise>
       </xsl:choose>
	   </TD>

	</TR>
</xsl:template>


</xsl:stylesheet>

