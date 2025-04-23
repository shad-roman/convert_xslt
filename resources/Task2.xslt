<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/Task2">
        <resultStings>                                                          <!-- создание корневого элемента в исходном файле -->
            <str1>                                                              <!-- создание элемента для первой результирующей строки -->
                <xsl:call-template name="reverseString">                        <!-- вызов шаблона для  возврата строки в обр. порядке -->
                    <xsl:with-param name="str" select="/Task2/str1"/>
                </xsl:call-template>
            </str1>
            <str2>                                                              <!-- создание элемента для второй результирующей строки -->
                <xsl:call-template name="onlyDigits">                           <!-- вызов шаблона для  возврата только цифр -->
                    <xsl:with-param name="str" select="/Task2/str2"/>
                </xsl:call-template>
            </str2>
            <str3>                                                              <!-- создание элемента для третьей результирующей строки -->
                <xsl:call-template name="notDigits">                            <!-- вызов шаблона для  возврата всего кроме цифр -->
                    <xsl:with-param name="str" select="/Task2/str3"/>
                </xsl:call-template>
            </str3>
            <str4>                                                              <!-- создание элемента для четвертой результирующей строки -->
                <xsl:call-template name="whitespaceCount">                      <!-- вызов шаблона для  возврата количества пробелов в строке -->
                    <xsl:with-param name="str" select="/Task2/str4"/>
                </xsl:call-template>
            </str4>
        </resultStings>
    </xsl:template>


    <xsl:template name="reverseString">
        <xsl:param name="str"/>
        <!-- при условии, что длина текущего аргумента больше 0, рекурсивно вызываем этот же шаблон,
        передавая в аргументах подстроку, начиная со второго символа-->
        <xsl:choose>
            <xsl:when test="string-length($str) > 0">
                <xsl:call-template name="reverseString">
                    <xsl:with-param name="str" select="substring($str, 2)"/>
                </xsl:call-template>
                <!-- выводим первый символ каждой подстроки в обратном порядке -->
                <xsl:value-of select="substring($str, 1,1)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="onlyDigits">
        <xsl:param name="str"/>
        <!-- при условии, что длина текущего аргумента больше 0, берём первый символ из строки
        проверяем является ли он цифрой, если да - выводим-->
        <xsl:choose>
            <xsl:when test="string-length($str) >0">
                <xsl:variable name="char" select="substring($str, 1, 1)"/>
                <xsl:if test="$char &gt; '0' and $char &lt; '10'">                          <!-- проверяем не выходит ли символ за границы 0-9 -->
                    <xsl:value-of select="$char"/>
                </xsl:if>
                <xsl:call-template name="onlyDigits">
                    <xsl:with-param name="str" select="substring($str, 2)"/>                <!-- вызываем этот же шаблон, аргументом передаём строку без первого символа-->
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="notDigits">
        <xsl:param name="str"/>
        <!-- при условии, что длина текущего аргумента больше 0, берём первый символ из строки
            проверяем является ли он цифрой, если нет - выводим-->
        <xsl:choose>
            <xsl:when test="string-length($str) >0">
                <xsl:variable name="char" select="substring($str, 1, 1)"/>
                <xsl:if test="not($char &gt; '0' and $char &lt; '10')">                <!-- проверяем чтобы символ был меньше 0 или больше 9-->
                    <xsl:value-of select="$char"/>
                </xsl:if>
                <xsl:call-template name="notDigits">
                    <xsl:with-param name="str" select="substring($str, 2)"/>           <!-- вызываем этот же шаблон, аргументом передаём строку без первого символа-->
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="whitespaceCount">
        <xsl:param name="str"/>
        <xsl:param name="count" select="0"/>                                          <!--  объявляем параметр с изначальным значением 0 -->
        <xsl:choose>
            <xsl:when test="string-length($str) >0">
                <xsl:variable name="char" select="substring($str, 1, 1)"/>            <!--  получаем первый символ из строки -->
                <xsl:variable name="newCount">                                        <!--  объявляем новую переменную-счётчик -->
                    <xsl:choose>
                        <xsl:when test="$char = ' ' or $char = '&#10;'">              <!--  если первый символ пробел или перенос строки -->
                            <xsl:value-of select="$count + 1"/>                       <!--  увеличиваем счётчик на  1 -->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$count"/>                           <!-- иначе присваеваем счётчику прежнее  значение -->
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:call-template name="whitespaceCount">
                    <xsl:with-param name="str" select="substring($str, 2)"/>           <!-- вызываем этот же шаблон, аргументом передаём строку без первого символа-->
                    <xsl:with-param name="count" select="$newCount"/>                  <!-- и новый счётчик -->
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>                                                            <!--  когда строка заканчивается выводим количество -->
                <xsl:value-of select="$count"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>