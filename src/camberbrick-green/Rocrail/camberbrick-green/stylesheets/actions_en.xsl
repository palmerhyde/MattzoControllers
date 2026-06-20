<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- 
	xsl Template für Report Aktionen von Objekten

	Version 1.0
	
	History:	
	08.10.2017 andy		Inital Version

-->

<xsl:output method="html" encoding="UTF-8"/>


<xsl:template match="/">

    <html>
    <head><title>Rocrail Objekts Actions</title>
    </head>
    <body>
		<h2>Rocrail Report: Actions from Objects</h2>
  
		<xsl:for-each select="//actionctrl">
			<xsl:sort select="@callerid"/>
			<xsl:sort select="@id"/>

			<table border="1" rules="all" cellpadding="2" cellspacing="0" width="90%">
				<td width="20%" rowspan="2" valign="top" align="left" style="font-family:Arial, Helvetica, sans-serif">
					<!--xsl:value-of select="../@id" /-->
					
					<xsl:variable name="temp" select="../@id" />
					<xsl:choose>
					  <xsl:when test="$temp = ''">
						<xsl:text>System</xsl:text>
					  </xsl:when>
					  <xsl:otherwise>
						<xsl:value-of select="../@id" />
					  </xsl:otherwise>
					</xsl:choose>					
					
					
					
					
					<br/><br/>
					<font size="2">
						Description:<br/>
						<xsl:value-of select="@desc" />
					</font>
				</td>
				<td valign="top" align="left" style="font-family:Arial, Helvetica, sans-serif">
					Action: <xsl:value-of select="@id" />

					<table  border="0" rules="all" cellpadding="2" cellspacing="0" width="100%" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
						<td  valign="top" width="25%">
							<h5>Settings:</h5>
							<table  rules="all" cellpadding="2" cellspacing="0" width="100%" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<TR>
									<TH width="20%" bgcolor="lightgrey">State</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="state" select="@state" />
										<xsl:choose>
										  <xsl:when test="$state = ''">
											<xsl:text>-</xsl:text>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="@state" />
										  </xsl:otherwise>
										</xsl:choose>
									</TD>
								</TR>							

								<TR>
									<TH width="20%" bgcolor="lightgrey">Sub-state</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="substate" select="@substate" />
										<xsl:choose>
										  <xsl:when test="$substate = ''">
											<xsl:text>-</xsl:text>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="@substate" />
										  </xsl:otherwise>
										</xsl:choose>
									</TD>
								</TR>									

								<TR>
									<TH width="20%" bgcolor="lightgrey">Duration</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="duration" select="@duration" />
										<xsl:choose>
										  <xsl:when test="$duration = ''">
											<xsl:text>-</xsl:text>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="@duration" />
										  </xsl:otherwise>
										</xsl:choose>
									</TD>
								</TR>								

								<TR>
									<TH width="20%" bgcolor="lightgrey">Time</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="timer" select="@timer" />
										<xsl:choose>
										  <xsl:when test="$timer = ''">
											<xsl:text>-</xsl:text>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="@timer" />
										  </xsl:otherwise>
										</xsl:choose>
									</TD>
								</TR>
								
								<TR>
									<TH width="20%" bgcolor="lightgrey">Reset</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="reset" select="@reset" />
										 <xsl:choose>
										 <xsl:when test="$reset = 'false'">
										  <xsl:text>No</xsl:text>
										   </xsl:when>
										   <xsl:when test="$reset = 'true'">
										   <xsl:text>Yes</xsl:text>
										 </xsl:when>
										 </xsl:choose>
									</TD>	
								</TR>
								<TR>
									<TH width="20%" bgcolor="lightgrey">All conditions must be true</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="allconditions" select="@allconditions" />
										 <xsl:choose>
										 <xsl:when test="$allconditions = 'false'">
										  <xsl:text>No</xsl:text>
										   </xsl:when>
										   <xsl:when test="$allconditions = 'true'">
										   <xsl:text>Yes</xsl:text>
										 </xsl:when>
										 </xsl:choose>
									</TD>	
								</TR>								
								<TR>
									<TH width="20%" bgcolor="lightgrey">At command</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="atcmd" select="@atcmd" />
										 <xsl:choose>
										 <xsl:when test="$atcmd = 'false'">
										  <xsl:text>No</xsl:text>
										   </xsl:when>
										   <xsl:when test="$atcmd = 'true'">
										   <xsl:text>Yes</xsl:text>
										 </xsl:when>
										 </xsl:choose>
									</TD>	
								</TR>								
								<TR>
									<TH width="20%" bgcolor="lightgrey">At event</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="atevt" select="@atevt" />
										 <xsl:choose>
										 <xsl:when test="$atevt = 'false'">
										  <xsl:text>No</xsl:text>
										   </xsl:when>
										   <xsl:when test="$atevt = 'true'">
										   <xsl:text>Yes</xsl:text>
										 </xsl:when>
										 </xsl:choose>
									</TD>	
								</TR>								
							</table>
						</td>
						<td valign="top" width="25%">
							<h5>Mode:</h5>
							<table  rules="all" cellpadding="2" cellspacing="0" width="100%" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<TR>
									<TH width="20%" bgcolor="lightgrey">Automatic</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="auto" select="@auto" />
										 <xsl:choose>
										 <xsl:when test="$auto = 'false'">
										  <xsl:text>No</xsl:text>
										   </xsl:when>
										   <xsl:when test="$auto = 'true'">
										   <xsl:text>Yes</xsl:text>
										 </xsl:when>
										 </xsl:choose>
									</TD>	
								</TR>
								<TR>
									<TH width="20%" bgcolor="lightgrey">Manually</TH>				
									<TD align="left" width="20%">
										<xsl:variable name="manual" select="@manual" />
										 <xsl:choose>
										 <xsl:when test="$manual = 'false'">
										  <xsl:text>No</xsl:text>
										   </xsl:when>
										   <xsl:when test="$manual = 'true'">
										   <xsl:text>Yes</xsl:text>
										 </xsl:when>
										 </xsl:choose>
									</TD>	
								</TR>								
							
							</table>
						</td>						
						<td  valign="top" width="50%">
							<h5>Conditions:</h5>
							<!--table  rules="all" cellpadding="2" cellspacing="0" width="100%" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<tbody>
									<xsl:apply-templates/>
								</tbody>
							</table-->

							<table  rules="all" cellpadding="2" cellspacing="0" width="100%" style="font-family:Arial, Helvetica, sans-serif; font-size:11px">
								<thead>
									<th width="20%" height="20" bgcolor="lightgrey">Must be true</th>
									<th width="20%" height="20" bgcolor="lightgrey">Condition</th>
									<th width="20%" height="20" bgcolor="lightgrey">State</th>
									<th width="20%" height="20" bgcolor="lightgrey">Sub-State</th>									
									<th width="20%" height="20" bgcolor="lightgrey">Type</th>
								</thead>
								<tbody>
									<xsl:apply-templates/>
								</tbody>
							</table>							
							
							
						</td>
					</table>
					
						
					
					
				</td>
			
			</table>
			<br/>
		
		</xsl:for-each>

    </body>	
    </html>
   
</xsl:template>

<xsl:template match="actioncond">
	<tr>

		<TD align="center" width="20%">
			<xsl:variable name="mustbetrue" select="@mustbetrue" />
			 <xsl:choose>
			 <xsl:when test="$mustbetrue = 'false'">
			  <xsl:text>No</xsl:text>
			   </xsl:when>
			   <xsl:when test="$mustbetrue = 'true'">
			   <xsl:text>Yes</xsl:text>
			 </xsl:when>
			 </xsl:choose>
		</TD>
		<TD align="center" width="20%">
			<xsl:value-of select="@id" />
		</TD>			
		<TD align="center" >
			<xsl:value-of select="@state" />
		</TD>	
		  <xsl:variable name="subid" select="@subid" />
			<TD align="center">
			<xsl:choose>
			  <xsl:when test="$subid = ''">
				<xsl:text>.</xsl:text>
			  </xsl:when>
			  <xsl:otherwise>
				<xsl:value-of select="@subid" />
			  </xsl:otherwise>
			</xsl:choose>			
		</TD>	
		<TD align="center" >
			<xsl:variable name="type" select="@type" />
			<xsl:choose>
				<xsl:when test="$type = 'bk'">
					<xsl:text>Block</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'sg'">
					<xsl:text>Signal</xsl:text>
				</xsl:when>					
				<xsl:when test="$type = 'sw'">
					<xsl:text>Switch</xsl:text>
				</xsl:when>					
				<xsl:when test="$type = 'fb'">
					<xsl:text>Sensor</xsl:text>
				</xsl:when>	
				<xsl:when test="$type = 'co'">
					<xsl:text>Output</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'tx'">
					<xsl:text>Text</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'sb'">
					<xsl:text>Route</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'vr'">
					<xsl:text>Variable</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'lc'">
					<xsl:text>Loco</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'car'">
					<xsl:text>Car</xsl:text>
				</xsl:when>
				<xsl:when test="$type = 'operator'">
					<xsl:text>Train</xsl:text>
				</xsl:when>					
				<xsl:otherwise>
					<xsl:value-of select="@type" />
				</xsl:otherwise>
			</xsl:choose>			
		

		</TD>				
	</tr>

 </xsl:template>

</xsl:stylesheet>



