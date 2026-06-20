<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8"/>

<!--
	29.09.2017	andy	Column Usage added

-->

<xsl:template match="/">

   <html>
   <head><title>Rocrail Decoders report</title>
  </head>
  <body>
  <h2>Rocrail Decoder Report</h2>

  <table border="1" rules="all" cellpadding="4" cellspacing="0" width="100%">
      <THEAD>
	  <TR>
	     <TH width="20%" height="30" bgcolor="lightgrey">Image</TH>
	     <TH width="10%" height="30" bgcolor="lightgrey">ID</TH>
 	     <TH width="10%" bgcolor="lightgrey">Address</TH>
 	     <TH width="10%" bgcolor="lightgrey">Manufacturer</TH>
 	     <TH width="30%" bgcolor="lightgrey">CatNr</TH>
		<TH width="20%" bgcolor="lightgrey">Usage</TH>		 
	  </TR>
      </THEAD> 
      <TBODY>
        <xsl:apply-templates/>
      </TBODY>
   </table>
   </body>
   </html>
   
</xsl:template>

<xsl:template match="declist">  

  <xsl:apply-templates>
   <!--xsl:sort select="@addr" order="ascending" data-type="number" /-->
   <xsl:sort select="@id" order="ascending" data-type="text" />
  </xsl:apply-templates>

</xsl:template>

<xsl:template match="dec">  

	<TR>
      <th rowspan="1" align="center">
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
		
		<TD valign="top" >
			<xsl:value-of select="@id" />
		</TD>


	   <xsl:variable name="addr" select="@addr" />

	   <TD valign="top" align="center">
	   <xsl:choose>
         <xsl:when test="$addr = ''">
         <xsl:text>-</xsl:text>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="@addr" />
       </xsl:otherwise>
       </xsl:choose>

	   </TD>
	   <TD valign="top" align="center"><xsl:value-of select="@manu" /></TD>

	   <TD valign="top">
	   <xsl:variable name="remark" select="@desc" />
	   <xsl:choose>
         <xsl:when test="@remark = ''">
         <xsl:text>-</xsl:text>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="@desc" />
       </xsl:otherwise>
       </xsl:choose>

	   </TD>
	   
	   <TD valign="top">
			<xsl:variable name="id" select="@id" />	
			
			<xsl:for-each select="/*/*/*[@decid=$id]">
				<xsl:value-of select="@id" />
				<br/>
			</xsl:for-each>	
			
			<br/>
	   
	   </TD>
	   
	</TR>
 
</xsl:template>

</xsl:stylesheet>


