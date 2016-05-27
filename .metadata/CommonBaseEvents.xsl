<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output version="1.0" method="html" indent="yes"/>
	<xsl:param name="SV_OutputFormat" select="'HTML'"/>
	<xsl:variable name="XML" select="/"/>
	<xsl:template match="/">

		<html>
			<head>
				<title>Common Base Event XML Viewer</title>

				<script language="JavaScript1.3">
					&lt;!--
					var BROWSER_NAME = navigator.appName;
					var BROWSER_VERSION = parseInt(navigator.appVersion);
					var sortColumnIndex = 0;
					var sortIncreasing = true;
					var filters = new Array();
					var filterTableRowCount = 0;

					function initialize(){

						var eventTableRows = window.document.getElementById("eventTable").rows;

						for (var counter = 0;counter &lt; eventTableRows.length;counter++)
						{
							var cellText = parseFloat(eventTableRows[counter].cells[1].innerHTML);

							if((cellText &gt;= 0) &amp;&amp; (cellText &lt;= 70))
							{
								
								var greenAndBlue = parseInt(Math.abs(225 - (parseFloat(cellText/70.0) * 225)));
								
								eventTableRows[counter].cells[1].style.background = "rgb(255, " + greenAndBlue + ", " + greenAndBlue + ")";
							}
						}

						configureEventTable();
					}

					function openPreferencesWindow()
					{

						if(((BROWSER_NAME != "Microsoft Internet Explorer") &amp;&amp; (BROWSER_NAME != "Netscape")) || (BROWSER_VERSION &lt; 4)){
							alert("The Common Base Event XML Viewer requires Netscape Navigator 4.x+ or Microsoft Internet Explorer 4.x+.");
						}
						else{
							var newWindow = window.open("","newWindow","width=600,height=500,left=" + ((screen.availWidth - 600) / 2) + ",top=" + ((screen.availHeight - 500) / 2) + ",resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
							newWindow.document.writeln("&lt;html&gt;");
							newWindow.document.writeln("  &lt;head&gt;");
							newWindow.document.writeln("    &lt;title&gt;Common Base Event XML Viewer Preferences&lt;/title&gt;");
							newWindow.document.writeln("  &lt;/head&gt;");
							newWindow.document.writeln("  &lt;body style='background:#DDDDDD;' &gt;");
							newWindow.document.writeln("    &lt;center&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;a style='font-weight:bold; font-size:140%;'&gt;Common Base Event XML Viewer Preferences&lt;/a&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;a style='font-weight:bold; font-size:120%;'&gt;Sorting Order&lt;/a&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;form&gt;");
							newWindow.document.writeln("        &lt;table cellspacing='1' cellpadding='5'&gt;");
							newWindow.document.writeln("          &lt;tr&gt;");
							newWindow.document.writeln("            &lt;td&gt;&lt;select id='sortColumn'&gt;&lt;option&gt;Time&lt;/option&gt;&lt;option&gt;Severity&lt;/option&gt;&lt;option&gt;Message&lt;/option&gt;&lt;/select&gt;&lt;/td&gt;");
							newWindow.document.writeln("            &lt;td&gt;&lt;input id='sortDirectionIncreasing' name='sortDirectionGroup' type='radio' &gt;Increasing&lt;/input&gt;&lt;br/&gt;&lt;input id='sortDirectionDecreasing' name='sortDirectionGroup' type='radio' value='down'&gt;Decreasing&lt;/input&gt;&lt;/td&gt;");
							newWindow.document.writeln("          &lt;/tr&gt;");
							newWindow.document.writeln("        &lt;/table&gt;");
							newWindow.document.writeln("      &lt;/form&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;a style='font-weight:bold; font-size:120%;'&gt;Filtering Rules&lt;/a&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;a style='font-size:75%;'&gt;(* = any string)&lt;/a&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;a style='font-size:75%; color:#0000FF; text-decoration:none;' href='#' onClick='window.opener.addFilter(window);return false;'&gt;(Add)&lt;/a&gt;");
							newWindow.document.writeln("      &lt;form&gt;");
							newWindow.document.writeln("        &lt;table id='filterTable' cellspacing='1' cellpadding='5'&gt;");
							newWindow.document.writeln("        &lt;/table&gt;");
							newWindow.document.writeln("      &lt;/form&gt;");
							newWindow.document.writeln("      &lt;br/&gt;");
							newWindow.document.writeln("      &lt;form&gt;");
							newWindow.document.writeln("        &lt;input type='button' style='width:5em;' value='Save' onClick='window.opener.savePreferences(window);window.close();return false;'/&gt;&amp;#xA0;&amp;#xA0;&lt;input type='button' style='width:5em;' value='Cancel' onClick='window.close();return false;'/&gt;");
							newWindow.document.writeln("      &lt;/form&gt;");
							newWindow.document.writeln("    &lt;/center&gt;");
							newWindow.document.writeln("  &lt;/body&gt;");
							newWindow.document.writeln("&lt;/html&gt;");
							newWindow.document.close();
							newWindow.document.getElementById("sortColumn").options[sortColumnIndex].selected = "true";
							newWindow.document.getElementById("sortDirection" + (sortIncreasing?"In":"De") + "creasing").checked = true;
			
							filterTableRowCount = 0;
			
							for(var counter = 0;counter &lt; filters.length;counter++){
								
								addFilter(newWindow);
								
								newWindow.document.getElementById("filterColumn_" + counter).selectedIndex = filters[counter][0];
								newWindow.document.getElementById("filterRule_" + counter).value = filters[counter][1];
								newWindow.document.getElementById("filterRule" + (filters[counter][2]?"In":"Ex") + "clude_" + counter).checked = true;
							}
						}
					}

					function addFilter(preferenceWindow)
					{
					
						var filterTable = preferenceWindow.document.getElementById("filterTable");
						var rowIndex = filterTable.rows.length;
						var newRow = filterTable.insertRow(rowIndex);
	
						filterTableRowCount += 1;
					
						newRow.insertCell(0).innerHTML = filterTableRowCount + ".&#xA0;";
						newRow.insertCell(1).innerHTML = "&lt;select id='filterColumn_" + rowIndex + "'&gt;&lt;option&gt;Time&lt;/option&gt;&lt;option&gt;Severity&lt;/option&gt;&lt;option&gt;Message&lt;/option&gt;&gt;&lt;/select&gt;";
						newRow.insertCell(2).innerHTML = "&lt;input id='filterRule_" + rowIndex + "' type='text' value='*'/&gt;";
						newRow.insertCell(3).innerHTML = "&lt;input id='filterRuleInclude_" + rowIndex + "' name='filterRuleGroup_" + rowIndex + "' type='radio' checked='true' &gt;Include&lt;/input&gt;&lt;br/&gt;&lt;input id='filterRuleExclude_" + rowIndex + "' name='filterRuleGroup_" + rowIndex + "' type='radio' value='down'&gt;Exclude&lt;/input&gt;";
						newRow.insertCell(4).innerHTML = "&lt;a style='font-size:75%; color:#0000FF; text-decoration:none;' href='#' onClick='window.opener.removeFilter(window," + rowIndex + ");return false;'&gt;(Remove)&lt;/a&gt;";
					}

					function removeFilter(preferenceWindow,selectedRowIndex)
					{
					
						var filterTable = preferenceWindow.document.getElementById("filterTable");
						filterTable.rows[selectedRowIndex].style.display = "none";
						
						filterTableRowCount -= 1;
						var numberCount = 1;
						
						for(var counter = 0;counter &lt; filterTable.rows.length;counter++)
						{
							if(filterTable.rows[counter].style.display == "")
							{
								filterTable.rows[counter].cells[0].innerHTML = (numberCount + ".&#xA0;");
								numberCount += 1;
							}
						}
					}

					function savePreferences(preferenceWindow)
					{
					
						sortColumnIndex = preferenceWindow.document.getElementById("sortColumn").selectedIndex;

						sortIncreasing = preferenceWindow.document.getElementById("sortDirectionIncreasing").checked;
	
						filters = new Array();
						var filterTable = preferenceWindow.document.getElementById("filterTable");

						for(var counter = 0;counter &lt; filterTable.rows.length;counter++)
						{
	
							if(filterTable.rows[counter].style.display != "none"){
							
								filters[filters.length] = new Array(preferenceWindow.document.getElementById("filterColumn_" + counter).selectedIndex,preferenceWindow.document.getElementById("filterRule_" + counter).value,preferenceWindow.document.getElementById("filterRuleInclude_" + counter).checked);
								
								var filter = "^" + filters[filters.length - 1][1].replace(/\\/g,"\\\\");
								filter = filter.replace(/\?/g,"\\?");
								filter = filter.replace(/\//g,"\\/");
								filter = filter.replace(/\./g,"\\.");
								filter = filter.replace(/\[/g,"\\[");
								filter = filter.replace(/\]/g,"\\]");
								filter = filter.replace(/\{/g,"\\{");
								filter = filter.replace(/\}/g,"\\}");
								filter = filter.replace(/\(/g,"\\(");
								filter = filter.replace(/\)/g,"\\)");
								filter = filter.replace(/\+/g,"\\+");
								filter = filter.replace(/\|/g,"\\|");
								filter = filter.replace(/\*/g,"(.|\s)+");
	
								filters[filters.length - 1][3] = filter + "$";
							}
						}
	
						configureEventTable();
					}

					function configureEventTable()
					{
					
						var eventTable = window.document.getElementById("eventTable");
						var sortableRows = new Array(eventTable.rows.length - 1);
						
						for(var counter = 1;counter &lt; eventTable.rows.length;counter++)
						{
							sortableRows[counter - 1] = eventTable.rows[counter];
							sortableRows[counter - 1].style.display = "";
						}

						for (var counter = 1; counter &lt; sortableRows.length; counter++)
						{

							var index = counter;
							var currentRow = sortableRows[counter];
							var currentCellText = parseInt(currentRow.cells[0].innerHTML.toLowerCase());

							while ((index &gt; 0) &amp;&amp; (parseInt(sortableRows[index - 1].cells[0].innerHTML.toLowerCase()) &gt; currentCellText))
							{
								sortableRows[index] = sortableRows[index - 1];
								index -= 1;
							}

							sortableRows[index] = currentRow;
						}

						if(sortColumnIndex != -1)
						{
			
							if(sortColumnIndex == 0)
							{
								
								for (var counter = 1; counter &lt; sortableRows.length; counter++)
								{

									var index = counter;
									var currentRow = sortableRows[counter];
									var currentCellText = currentRow.cells[sortColumnIndex].innerHTML.toLowerCase();

									currentCellText = parseAsDate(currentCellText);

									while (index &gt; 0)
									{
										var sortedPreviousCellText = sortableRows[index - 1].cells[sortColumnIndex].innerHTML.toLowerCase();
										sortedPreviousCellText = parseAsDate(sortedPreviousCellText);
					
										if(sortedPreviousCellText &lt;= currentCellText)
										{
										break;
										}
					
										sortableRows[index] = sortableRows[index - 1];
										index -= 1;
									}

									sortableRows[index] = currentRow;
								}
							}
							else
							{
							
								for (var counter = 1; counter &lt; sortableRows.length; counter++)
								{
									
									var index = counter;
									var currentRow = sortableRows[counter];
									var currentCellText = currentRow.cells[sortColumnIndex].innerHTML.toLowerCase();
				
									if (!isNaN(parseInt(currentCellText)))
									{
									currentCellText = parseInt(currentCellText);
									}
				
									while (index &gt; 0)
									{
									
										var sortedPreviousCellText = sortableRows[index - 1].cells[sortColumnIndex].innerHTML.toLowerCase();
					
										if (!isNaN(parseInt(sortedPreviousCellText)))
										{
										sortedPreviousCellText = parseInt(sortedPreviousCellText);
										}
									
										if(sortedPreviousCellText &lt;= currentCellText)
										{
										break;
										}
					
										sortableRows[index] = sortableRows[index - 1];
										index -= 1;
									}
		
									sortableRows[index] = currentRow;
								}
							}
						}

						if(!sortIncreasing)
						{
							sortableRows.reverse();
						}
	
						var rowCount = 0;
					
						for (var counter = 0;counter &lt; sortableRows.length;counter++)
						{
							
							eventTable.tBodies[0].appendChild(sortableRows[counter]);

							if(filterRow(sortableRows[counter]))
							{
								sortableRows[counter].style.display = "none";
							}
							else
							{
								
								if(rowCount % 2 == 0)
								{
									sortableRows[counter].style.background = "#FFFFC1";
								}
								else
								{
									sortableRows[counter].style.background = "#FFFFE1";
								}

							rowCount += 1;
							}
						}
					}

					function parseAsDate(dateString)
					{
					
						var RE, OK, DateObj;
						RE = /^(\d{4})?-?(\d\d)?-?(\d\d)?t?(\d\d)?:?(\d\d)?:?(\d\d)?.?(\d\d\d)?z?$/;
						OK = RE.test(dateString);

						with (RegExp)
						{
						
						DateObj = new Date($1 || 77, $2 - 1, $3, $4, $5, $6);
						
						var millisecs = parseInt($7);
						
						return new Date(DateObj.getTime() + millisecs);
						}
					}

					function filterRow(row)
					{
					
						for(var counter = 0;counter &lt; row.cells.length;counter++)
						{
					
							for(var filterCounter = 0;filterCounter &lt; filters.length;filterCounter++)
							{
					
								if(filters[filterCounter][0] == counter)
								{
					
									if(row.cells[counter].innerHTML.match(new RegExp(filters[filterCounter][3])))
									{
					
										if(!filters[filterCounter][2])
										{
											return true;
										}
									}
									else if(filters[filterCounter][2])
									{
										return true;
									}
								}
							}
						}

						return false;
					}
					// --&gt;
				</script>
			</head>

			<body onLoad="setTimeout('initialize()',1);return false;">

				<table width="90%">
					<tr align="left">
						<td>
							<a style="font-size:75%;">|</a>&#xA0;
							<a id="Preferences" style="font-size:75%; color:#0000FF; text-decoration:none;"
							href="#" onClick="openPreferencesWindow();return false;">Preferences</a>&#xA0;
							<a style="font-size:75%;">|</a>&#xA0;
							<a id="Help" style="font-size:75%; color:#0000FF; text-decoration:none;"
							href="#" onClick="alert('The Common Base Event XML Viewer displays several Common Base Event properties from Common Base Event XML documents in a tabular view.  The viewer also provides column-level sorting and hierarchal filtering (see Preferences).');return false;">Help</a>&#xA0;
							<a style="font-size:75%;">|</a>
						</td>
					</tr>
				</table>

				<table id="eventTable" border="1" cellspacing="1" cellpadding="5" width="90%">
					<thead>
						<tr style="background:#ACD6FF;">
							<th>
								<xsl:text>Creation Time</xsl:text>
							</th>
							<th>
								<xsl:text>Severity</xsl:text>
							</th>
							<th>
								<xsl:text>Message</xsl:text>
							</th>
							<th>
								<xsl:text>Source Component ID</xsl:text>
								<table border="1" width="90%">
									<thead>
										<tr>
											<th width="10%">
												<xsl:text>Application</xsl:text>

											</th>
											<th width="10%">
												<xsl:text>Component</xsl:text>

											</th>
											<th width="10%">
												<xsl:text>Component ID Type</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Component Type</xsl:text>

											</th>
											<th width="5%">
												<xsl:text>Execution Environment</xsl:text>

											</th>
											<th width="10%">
												<xsl:text>Instance ID</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Location</xsl:text>
											</th>
											<th width="5%">
												<xsl:text>Location Type</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Process ID</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Sub- Component</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Thread ID</xsl:text>
											</th>
										</tr>
									</thead>
								</table>
							</th>
							<th>
								<xsl:text>Situation</xsl:text>
								<table border="1" width="90%">
									<thead>
										<tr>
											<th width="30%">
												<xsl:text>Category Name</xsl:text>
											</th>
											<th width="70%">
												<xsl:text>Situation Type</xsl:text>
												<table border="1">
													<thead>
														<tr>
															<th width="100%">
																<xsl:text>Reasoning Scope</xsl:text>
															</th>
														</tr>
													</thead>
												</table>
											</th>
										</tr>
									</thead>
								</table>
							</th>
							<th>
								<xsl:text>Global Instance ID</xsl:text>
							</th>
							<th>
								<xsl:text>Extended Data Elements</xsl:text>
								<table border="1" width="100%">
									<thead width="100%">
										<tr>
											<th width="25%">
												<xsl:text>Name</xsl:text>
											</th>
											<th width="25%">
												<xsl:text>Type</xsl:text>
											</th>
											<th width="50%">
												<xsl:text>Values</xsl:text>
											</th>
										</tr>
									</thead>
								</table>
							</th>
							<th>
								<xsl:text>Message Data Element</xsl:text>
								<table border="1" width="90%">
									<thead>
										<tr>
											<th width="16%">
												<xsl:text>Message Locale</xsl:text>
											</th>
											<th width="16%">
												<xsl:text>Message Catalog</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Message Catalog ID</xsl:text>
											</th>
											<th width="16%">
												<xsl:text>Message Catalog Tokens</xsl:text>
												<table border="1">
													<thead>
														<tr>
															<th width="100%">
																<xsl:text>Value</xsl:text>
															</th>
														</tr>
													</thead>
												</table>
											</th>
											<th width="16%">
												<xsl:text>Message Catalog Type</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Message ID</xsl:text>
											</th>
											<th width="16%">
												<xsl:text>Message ID Type</xsl:text>
											</th>
										</tr>
									</thead>
								</table>
							</th>
							<th>
								<xsl:text>Reporter Component ID</xsl:text>
								<table border="1" width="90%">
									<thead>
										<tr>
											<th width="10%">
												<xsl:text>Application</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Component</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Component ID Type</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Component Type</xsl:text>
											</th>
											<th width="5%">
												<xsl:text>Execution Environment</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Instance ID</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Location</xsl:text>
											</th>
											<th width="5%">
												<xsl:text>Location Type</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Process ID</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Sub- Component</xsl:text>
											</th>
											<th width="10%">
												<xsl:text>Thread ID</xsl:text>
											</th>
										</tr>
									</thead>
								</table>
							</th>
							<th>
								<xsl:text>Elapsed Time</xsl:text>
							</th>
							<th>
								<xsl:text>Extension Name</xsl:text>
							</th>
							<th>
								<xsl:text>Local Instance ID</xsl:text>
							</th>
							<th>
								<xsl:text>Priority</xsl:text>
							</th>
							<th>
								<xsl:text>Repeat Count</xsl:text>
							</th>
							<th>
								<xsl:text>Sequence Number</xsl:text>
							</th>
							<th>
								<xsl:text>Associated Events</xsl:text>
								<table border="1" width="90%">
									<thead>
										<tr>
											<th width="30%">
												<xsl:text>Resolved Events</xsl:text>
											</th>
											<th width="30%">
												<xsl:text>Association Engine</xsl:text>
											</th>
											<th width="40%">
												<xsl:text>Association Engine Information</xsl:text>
												<table border="1" width="100%">
													<thead>
														<tr>
															<th width="30%">
																<xsl:text>ID</xsl:text>
															</th>
															<th width="30%">
																<xsl:text>Name</xsl:text>
															</th>
															<th width="40%">
																<xsl:text>Type</xsl:text>
															</th>
														</tr>
													</thead>
												</table>
											</th>
										</tr>
									</thead>
								</table>
							</th>
							<th>
								<xsl:text>Context Data Elements</xsl:text>
								<table border="1" width="90%">
									<thead>
										<tr>
											<th width="20%">
												<xsl:text>Name</xsl:text>
											</th>
											<th width="20%">
												<xsl:text>Type</xsl:text>
											</th>
											<th width="30%">
												<xsl:text>Context ID</xsl:text>
											</th>
											<th width="30%">
												<xsl:text>Context Value</xsl:text>
											</th>
										</tr>
									</thead>
								</table>
							</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$XML">
							<xsl:for-each select="CommonBaseEvents">
								<xsl:for-each select="CommonBaseEvent">
									<tr>
										<td>
											<xsl:for-each select="@creationTime">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@severity">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@msg">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="sourceComponentId">
												<table border="1">
													<tbody>
														<tr>
															<td width="10%">
																<xsl:for-each select="@application">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@component">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@componentIdType">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@componentType">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="5%">
																<xsl:for-each select="@executionEnvironment">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@instanceId">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@location">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="5%">
																<xsl:for-each select="@locationType">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@processId">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@subComponent">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@threadId">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
														</tr>
													</tbody>
												</table>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="situation">
												<xsl:apply-templates/>
											</xsl:for-each>
											<xsl:for-each select="situation">
												<table border="1">
													<tbody>
														<tr>
															<td width="30%">
																<xsl:for-each select="@categoryName">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="70%">
																<xsl:for-each select="situationType">
																	<table border="0">
																		<tbody>
																			<tr>
																				<td width="100%">
																					<xsl:for-each select="@reasoningScope">
																						<xsl:value-of select="string(.)" />
																					</xsl:for-each>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</xsl:for-each>
															</td>
														</tr>
													</tbody>
												</table>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@globalInstanceId">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td width="3%">
											<table border="1">
												<xsl:for-each select="extendedDataElements">
													<tbody>
														<tr>
															<td width="25%">
																<xsl:for-each select="@name">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="25%">
																<xsl:for-each select="@type">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="50%">
																<xsl:for-each select="values">
																	<xsl:value-of select="string(.)"/><br/>
																</xsl:for-each>

															</td>
														</tr>
													</tbody>
												</xsl:for-each>
											</table>
										</td>
										<td>
											<xsl:for-each select="msgDataElement">
												<table border="1">
													<tbody>
														<tr>
															<td width="16%">
																<xsl:for-each select="@msgLocale">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="16%">
																<xsl:for-each select="msgCatalog">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
															<td width="5%">
																<xsl:for-each select="msgCatalogId">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
															<td width="16%">
																<xsl:for-each select="msgCatalogTokens">
																	<xsl:for-each select="@value">
																		<table border="0">
																			<tbody>
																				<tr>
																					<td width="100%">
																						<xsl:value-of select="string(.)" />
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</xsl:for-each>
																</xsl:for-each>
															</td>
															<td width="16%">
																<xsl:for-each select="msgCatalogType">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
															<td width="5%">
																<xsl:for-each select="msgId">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
															<td width="16%">
																<xsl:for-each select="msgIdType">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
														</tr>
													</tbody>
												</table>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="reporterComponentId">
												<xsl:apply-templates/>
											</xsl:for-each>
											<xsl:for-each select="reporterComponentId">
												<table border="1">
													<tbody>
														<tr>
															<td width="10%">
																<xsl:for-each select="@application">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@component">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@componentIdType">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@componentType">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="5%">
																<xsl:for-each select="@executionEnvironment">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@instanceId">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@location">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="5%">
																<xsl:for-each select="@locationType">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@processId">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@subComponent">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="10%">
																<xsl:for-each select="@threadId">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
														</tr>
													</tbody>
												</table>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@elapsedTime">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@extensionName">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@localInstanceId">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@priority">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@repeatCount">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="@sequenceNumber">
												<xsl:value-of select="string(.)"/>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="associatedEvents">
												<table border="1">
													<tbody>
														<tr>
															<td width="30%">
																<xsl:for-each select="@resolvedEvents">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="30%">
																<xsl:for-each select="associationEngine">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
															<td width="40%">

																<xsl:for-each select="associationEngineInfo">
																	<table border="1">
																		<tbody>
																			<tr>
																				<td width="30%">
																					<xsl:for-each select="@id">
																						<xsl:value-of select="string(.)" />
																					</xsl:for-each>
																				</td>
																				<td width="30%">
																					<xsl:for-each select="@name">
																						<xsl:value-of select="string(.)" />
																					</xsl:for-each>
																				</td>
																				<td width="40%">
																					<xsl:for-each select="@type">																	
																						<xsl:value-of select="string(.)" />
																					</xsl:for-each>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</xsl:for-each>
															</td>
														</tr>
													</tbody>
												</table>
											</xsl:for-each>
										</td>
										<td>
											<xsl:for-each select="contextDataElements">
												<table border="1">
													<tbody>
														<tr>
															<td width="20%">
																<xsl:for-each select="@name">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="20%">
																<xsl:for-each select="@type">
																	<xsl:value-of select="string(.)"/>
																</xsl:for-each>
															</td>
															<td width="30%">
																<xsl:for-each select="contextId">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
															<td width="30%">
																<xsl:for-each select="contextValue">
																	<xsl:apply-templates/>
																</xsl:for-each>
															</td>
														</tr>
													</tbody>
												</table>
											</xsl:for-each>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>