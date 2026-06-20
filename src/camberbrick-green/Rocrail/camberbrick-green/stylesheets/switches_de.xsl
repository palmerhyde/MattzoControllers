<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--

	xsl Template for Switch Report

	Version 1.1
	
	History:	
  14.11.2017  andy inital Version

-->

<xsl:output method="html" encoding="UTF-8"/>
<!-- Variable für Hintergrundfarbe in Titelzellen -->
<xsl:variable name="bgcolor" select="'lightgrey'" />

<xsl:template match="/">

   <html>
   <head><title>Rocrail Weichen report</title>
  </head>
  <body style="font-family:Arial, Helvetica, sans-serif">
  <h2>Weichen report</h2>

  <table border="1" rules="all" cellpadding="4" cellspacing="0" width="80%" style="font-family:Arial, Helvetica, sans-serif; font-size:12px">
      <THEAD>
        <TR>
            <TH height="30" bgcolor="{$bgcolor}">Kennung</TH>
            <TH bgcolor="{$bgcolor}">Beschreibung</TH>
            <TH bgcolor="{$bgcolor}">Sichere Weichenlage</TH>
            <TH bgcolor="{$bgcolor}">Einzel Ausgang</TH>
            <TH bgcolor="{$bgcolor}">Geschaltet</TH>
            <TH bgcolor="{$bgcolor}">Dekoder</TH>
            <TH bgcolor="{$bgcolor}">IID</TH>
            <TH bgcolor="{$bgcolor}">Bus</TH>            
            <TH bgcolor="{$bgcolor}">Adresse<br/>(1 / 2)</TH>
            <TH bgcolor="{$bgcolor}">Port<br/>(1 / 2)</TH>
            <TH bgcolor="{$bgcolor}">Rückmelder<br/>abbiegend 1</TH>
            <TH bgcolor="{$bgcolor}">Rückmelder<br/>gerade 1</TH>
            <TH bgcolor="{$bgcolor}">Rückmelder<br/>Belegung 1</TH>
            <TH bgcolor="{$bgcolor}">Rückmelder<br/>abbiegend 2</TH>
            <TH bgcolor="{$bgcolor}">Rückmelder<br/>gerade 2</TH>
            <TH bgcolor="{$bgcolor}">Rückmelder<br/>Belegung 2</TH>
        </TR>
      </THEAD> 
      <TBODY>
        <xsl:apply-templates/>
      </TBODY>
   </table>
   </body>
   </html>
   
</xsl:template>

<xsl:template match="swlist">  

  <xsl:apply-templates>
   <xsl:sort select="@addr1" order="ascending" data-type="number" />
  
  </xsl:apply-templates>

</xsl:template>

<xsl:template match="swlist">  

  <xsl:apply-templates>
   <xsl:sort select="@id" order="ascending" />
  </xsl:apply-templates>

</xsl:template>

<xsl:template match="sw">  

	<TR>	
      <TD align="left"><xsl:value-of select="@id" /></TD>

      <TD align="left">
        <xsl:variable name="desc" select="@desc" />
        <xsl:choose>
          <xsl:when test="$desc = ''">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@desc" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>
      <TD align="center"><xsl:value-of select="@savepos" /></TD>
      <TD align="center"><xsl:value-of select="@singlegate" /></TD>
      <TD align="center"><xsl:value-of select="@switched" /></TD>
      <TD align="center">
        <xsl:variable name="decid" select="@decid" />
        <xsl:choose>
          <xsl:when test="not(string($decid))">
            <xsl:text>-</xsl:text>
          </xsl:when>        
          <xsl:otherwise>
            <xsl:value-of select="@decid" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>
      <TD align="center">
        <xsl:variable name="iid" select="@iid" />
        <xsl:choose>
          <xsl:when test="not(string($iid))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@iid" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

      <TD align="center">
        <xsl:variable name="bus" select="@bus" />
        <xsl:choose>
          <xsl:when test="not(string($bus))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@bus" />
          </xsl:otherwise>
        </xsl:choose>
      </TD> 

      <TD align="center"><xsl:value-of select="@addr1" />/<xsl:value-of select="@addr2" /></TD>
      <TD align="center"><xsl:value-of select="@port1" />/<xsl:value-of select="@port2" /></TD>

      <TD align="center">
        <xsl:variable name="fbR" select="@fbR" />
        <xsl:choose>
          <xsl:when test="not(string($fbR))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@fbR" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

      <TD align="center">
        <xsl:variable name="fbG" select="@fbG" />
        <xsl:choose>
          <xsl:when test="not(string($fbG))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@fbG" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

      <TD align="center">
        <xsl:variable name="fbOcc1" select="@fbOcc1" />
        <xsl:choose>
          <xsl:when test="not(string($fbOcc1))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@fbOcc1" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

      <TD align="center">
        <xsl:variable name="fb2R" select="@fb2R" />
        <xsl:choose>
          <xsl:when test="not(string($fb2R))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@fb2R" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

      <TD align="center">
        <xsl:variable name="fb2G" select="@fb2G" />
        <xsl:choose>
          <xsl:when test="not(string($fb2G))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@fb2G" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

      <TD align="center">
        <xsl:variable name="fbOcc2" select="@fbOcc2" />
        <xsl:choose>
          <xsl:when test="not(string($fbOcc2))">
            <xsl:text>-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@fbOcc2" />
          </xsl:otherwise>
        </xsl:choose>
      </TD>

	</TR>

    <xsl:apply-templates/>
 
</xsl:template>


</xsl:stylesheet>

