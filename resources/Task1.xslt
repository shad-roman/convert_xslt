<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="/list">                                  <!-- шаблон для эл-та list в исходном документе. "/list" - путь к эл-ту от корня док-та -->
        <touristInformation>                                      <!-- создание корневого элемента в исходном файле -->
            <xsl:for-each select="tourists">                      <!-- цикл для прохождения по каждому эл-ту списка листа (для каждой группы туристов) -->
                <touristGroup>                                    <!-- создание элемента для каждой группы туристов-->
                    <xsl:call-template name="GroupParsingTempl">  <!-- вызов шаблона для парсинга каждой группы туристов -->
                        <xsl:with-param name="group" select=".">  <!--  передача аргумента в метод (group - имя параметра, "." - значение, которое указывает, что будет передаваться-->
                        </xsl:with-param>                         <!--  вся текущая строка tourists -->
                    </xsl:call-template>
                </touristGroup>
            </xsl:for-each>
        </touristInformation>
    </xsl:template>

    <xsl:template name="GroupParsingTempl">                                 <!--  именованный шаблон, который нужно вызывать -->
        <xsl:param name="group"/>                                           <!--  объявление параметра -->
        <xsl:variable name="groupVar" select="normalize-space($group)"/>    <!-- создаём переменную, куда записываем строку с туристами удалив ненужные пробелы (встроенный метод) -->
        <xsl:call-template name="splitGroup">                               <!--  вызов метода для разделения каждой строки с туристами -->
            <xsl:with-param name="groupV" select="$groupVar"/>               <!-- передавая в параметрах строку -->
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="splitGroup">
        <xsl:param name="groupV"/>
        <xsl:choose>                                                                    <!-- аналог свитч/кейс -->
            <xsl:when test="contains($groupV, '|')">                                    <!-- contains возвраает тру, если строка содержит |, после этого выполняется код внутри -->
                <xsl:variable name="first" select="substring-before($groupV, '|')" />   <!-- первая часть строки до слеша будет храниться   в var first-->
                <xsl:call-template name="touristParsing">                               <!-- ызов метода для обработки каждого туриста по отдельности -->
                    <xsl:with-param name="tourist" select="$first" />
                </xsl:call-template>
                <xsl:call-template name="splitGroup">                                   <!-- рекурсивно вызываем этот же шаблон с оставшейся частью строки -->
                    <xsl:with-param name="groupV" select="substring-after($groupV, '|')" />
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="touristParsing">
        <xsl:param name="tourist" />
        <xsl:variable name="type" select="substring-before($tourist, '/')" />        <!-- разделяем входную строку на отдельные части, каждая из которых хранится -->
        <xsl:variable name="rest1" select="substring-after($tourist, '/')" />        <!-- в переменной с соотв. именем -->
        <xsl:variable name="birth" select="substring-before($rest1, '/')" />
        <xsl:variable name="rest2" select="substring-after($rest1, '/')" />
        <xsl:variable name="surname" select="substring-before($rest2, '/')" />
        <xsl:variable name="rest3" select="substring-after($rest2, '/')" />
        <xsl:variable name="name" select="substring-before($rest3, '/')" />
        <xsl:variable name="prefix" select="substring-after($rest3, '/')" />

        <xsl:element name="tourist">                                                 <!-- объявляем элемент, который будет содержать атрибуты -->
            <xsl:attribute name="type">                                              <!-- имя атрибута (тип туриста) -->
                <xsl:choose>                                                         <!-- в зависимости от числового значения присваиваем атрибуту нужный тип -->
                    <xsl:when test="$type = '10'">Adult</xsl:when>
                    <xsl:when test="$type = '8'">Child</xsl:when>
                    <xsl:when test="$type = '7'">Newborn</xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:if test="$type != '10'">                                            <!-- конструкция if для проверки на то,что турист не взрослый -->
                <xsl:attribute name="birthDate">                                     <!-- добавление таким туристам даты  рождения -->
                    <xsl:value-of select="$birth" />
                </xsl:attribute>
            </xsl:if>
            <!-- добавление оставшихся элементов для туриста -->
            <prefix><xsl:value-of select="$prefix" /></prefix>
            <name><xsl:value-of select="$name" /></name>
            <surname><xsl:value-of select="$surname" /></surname>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>