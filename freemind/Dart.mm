<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1594878845130" ID="ID_1746956203" MODIFIED="1594878870099" TEXT="Dart">
<node CREATED="1594878978742" ID="ID_1085541971" MODIFIED="1594878979888" POSITION="right" TEXT="https://dart.dev/guides/language/language-tour"/>
<node CREATED="1594878899005" ID="ID_292003435" MODIFIED="1594878906661" POSITION="right" TEXT="concepts">
<node CREATED="1594878907347" ID="ID_1535113733" MODIFIED="1594878920525" TEXT="&#x6240;&#x6709;&#x90fd;&#x662f;&#x5bf9;&#x8c61;, &#x7ee7;&#x627f;&#x81ea;Object"/>
<node CREATED="1594878955764" ID="ID_1000564342" MODIFIED="1594878990335" TEXT="infer types"/>
<node CREATED="1594888047999" ID="ID_563737492" MODIFIED="1594888053739" TEXT="type safety"/>
<node CREATED="1594888061833" ID="ID_1160708008" MODIFIED="1594888066898" TEXT="null safety"/>
<node CREATED="1594879203715" ID="ID_1434943509" MODIFIED="1594879212976" TEXT="generic type"/>
<node CREATED="1594879217026" ID="ID_1818267784" MODIFIED="1594879275201" TEXT="top-level functions and variables"/>
<node CREATED="1594879284140" ID="ID_513653389" MODIFIED="1594879330454" TEXT="not support public, protected, private">
<node CREATED="1594879344181" ID="ID_1797862884" MODIFIED="1594879356549" TEXT="&#x4f7f;&#x7528;`_`&#x5f00;&#x5934;, &#x4ee3;&#x8868;&#x79c1;&#x6709;"/>
</node>
<node CREATED="1594879518688" ID="ID_1559949167" MODIFIED="1594879531850" TEXT="expressions and statement"/>
<node CREATED="1594879572874" ID="ID_1185021455" MODIFIED="1594879582829" TEXT="warnings and errors"/>
<node CREATED="1594880682541" ID="ID_580072127" MODIFIED="1594880688491" TEXT="&#x652f;&#x6301;&#x4f4d;&#x8fd0;&#x7b97;"/>
</node>
<node CREATED="1594879589641" ID="ID_1394258505" MODIFIED="1594879594708" POSITION="right" TEXT="Variables">
<node CREATED="1594879741257" ID="ID_682070002" MODIFIED="1594879744481" TEXT="var"/>
<node CREATED="1594879744979" ID="ID_1714197612" MODIFIED="1594879747665" TEXT="dynamic"/>
<node CREATED="1594879748322" ID="ID_643925883" MODIFIED="1594879750353" TEXT="String"/>
<node CREATED="1594879802742" ID="ID_1886359043" MODIFIED="1594879806291" TEXT="final"/>
<node CREATED="1594879808803" ID="ID_623748628" MODIFIED="1594879816620" TEXT="const &#x7f16;&#x8bd1;&#x65f6;&#x5e38;&#x91cf;">
<node CREATED="1594879928435" ID="ID_1692864966" MODIFIED="1594879954502" TEXT="&#x5982;&#x679c;&#x662f;class-level, &#x90a3;&#x4e48;&#x88ab;&#x89c6;&#x4e3a;static const"/>
<node CREATED="1594880016561" ID="ID_800103627" MODIFIED="1594880017864" TEXT="create constant values">
<node CREATED="1594880018311" ID="ID_1207973954" MODIFIED="1594880029769" TEXT=" const [];"/>
<node CREATED="1594880051180" ID="ID_1801594843" MODIFIED="1594880051874" TEXT=" [1, 2, 3]; // Was const []"/>
<node CREATED="1594880198587" ID="ID_1683832940" MODIFIED="1594880280556">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      // Valid compile-time constants as of Dart 2.5.
    </p>
    <p>
      const Object i = 3; // Where i is a const Object with an int value...
    </p>
    <p>
      const list = [i as int]; // Use a typecast.
    </p>
    <p>
      const map = {if (i is int) i: &quot;int&quot;}; // Use is and collection if.
    </p>
    <p>
      const set = {if (list is List&lt;int&gt;) ...list}; // ...and a spread.
    </p>
  </body>
</html></richcontent>
</node>
</node>
</node>
<node CREATED="1594879823729" ID="ID_754457876" MODIFIED="1594879836259" TEXT="&#x9ed8;&#x8ba4;&#x4e0d;&#x521d;&#x59cb;&#x5316; &#x4e3a;null"/>
</node>
<node CREATED="1594880339643" ID="ID_988410773" MODIFIED="1594880340641" POSITION="right" TEXT="Built-in types">
<node CREATED="1594880341035" ID="ID_1359263795" MODIFIED="1594880348161" TEXT="numbers">
<node CREATED="1594880480310" ID="ID_973531911" MODIFIED="1594880482821" TEXT="int">
<node CREATED="1594880483189" ID="ID_387937184" MODIFIED="1594880507206" TEXT="dart -2^63~-2^63-1"/>
<node CREATED="1594880508200" ID="ID_76357030" MODIFIED="1594880523438" TEXT="js -2^53~-2^53-1"/>
</node>
<node CREATED="1594880527155" ID="ID_1310593410" MODIFIED="1594880528679" TEXT="double">
<node CREATED="1594880539049" ID="ID_1829169216" MODIFIED="1594880540431" TEXT="IEEE 754 standard."/>
<node CREATED="1594880540991" ID="ID_696960950" MODIFIED="1594880544943" TEXT="64&#x4f4d;"/>
</node>
</node>
<node CREATED="1594880348472" ID="ID_1919995076" MODIFIED="1594880351329" TEXT="strings">
<node CREATED="1594880716629" ID="ID_1275510686" MODIFIED="1594880718524" TEXT="${expression}"/>
<node CREATED="1594880756654" ID="ID_22617106" MODIFIED="1594880865816" TEXT="raw string"/>
</node>
<node CREATED="1594880351941" ID="ID_21767114" MODIFIED="1594880354105" TEXT="booleans"/>
<node CREATED="1594881224068" ID="ID_166372986" MODIFIED="1594881232419" TEXT="collection">
<node CREATED="1594880866158" ID="ID_1661178135" MODIFIED="1594880869856" TEXT="spread operator">
<node CREATED="1594881344031" ID="ID_1695078399" MODIFIED="1594881346143" TEXT="...list"/>
</node>
<node CREATED="1594880870217" ID="ID_1900460065" MODIFIED="1594880885424" TEXT="null-aware spread operator">
<node CREATED="1594881348304" ID="ID_994055872" MODIFIED="1594881352439" TEXT="...?list"/>
</node>
<node CREATED="1594880933787" ID="ID_1869137557" MODIFIED="1594880939970" TEXT="collection if"/>
<node CREATED="1594880940476" ID="ID_1576259448" MODIFIED="1594880946276" TEXT="collection for"/>
</node>
<node CREATED="1594880354521" ID="ID_819394164" MODIFIED="1594880358241" TEXT="lists">
<node CREATED="1594881240416" ID="ID_650204044" MODIFIED="1594881241939" TEXT="[]"/>
</node>
<node CREATED="1594880362195" ID="ID_1346945169" MODIFIED="1594880364674" TEXT="sets">
<node CREATED="1594881245032" ID="ID_1399804312" MODIFIED="1594881246859" TEXT="{}"/>
</node>
<node CREATED="1594880364987" ID="ID_1438578285" MODIFIED="1594880366450" TEXT="maps">
<node CREATED="1594881248466" ID="ID_83443793" MODIFIED="1594881250061" TEXT="{}"/>
</node>
<node CREATED="1594880366984" ID="ID_38273322" MODIFIED="1594880378307" TEXT="runes">
<node CREATED="1594881324574" ID="ID_1813017844" MODIFIED="1594881325278" TEXT="Unicode code points of a string"/>
</node>
<node CREATED="1594880378740" ID="ID_189096791" MODIFIED="1594880381314" TEXT="symbols">
<node CREATED="1594881340581" ID="ID_1836965290" MODIFIED="1594881341798" TEXT="#radix"/>
</node>
</node>
<node CREATED="1594881500564" ID="ID_855925350" MODIFIED="1594881503643" POSITION="right" TEXT="Function">
<node CREATED="1594881505176" ID="ID_1545834462" MODIFIED="1594881522811">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      bool isNoble(int atomicNumber) {
    </p>
    <p>
      &#160;&#160;return _nobleGases[atomicNumber] != null;
    </p>
    <p>
      }
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1594881525796" ID="ID_501798601" MODIFIED="1594881557021" TEXT="bool isNoble(int atomicNumber) =&gt; {return expr;}"/>
<node CREATED="1594881663788" ID="ID_57842980" MODIFIED="1594881664536" TEXT="Optional parameters">
<node CREATED="1594881695314" ID="ID_1506276706" MODIFIED="1594881696081" TEXT="Named parameters"/>
<node CREATED="1594881666615" ID="ID_1034536515" MODIFIED="1594881724158" TEXT=" {param1, param2, &#x2026;}">
<node CREATED="1594881729227" ID="ID_1193752100" MODIFIED="1594881737914" TEXT=" @required"/>
</node>
<node CREATED="1594881863974" ID="ID_1375866525" MODIFIED="1594881864958" TEXT="Positional parameters">
<node CREATED="1594881866599" ID="ID_1929127894" MODIFIED="1594881877158" TEXT="String say(String from, String msg, [String device])"/>
</node>
<node CREATED="1594881889097" ID="ID_1982659079" MODIFIED="1594881889394" TEXT="Default parameter values"/>
</node>
<node CREATED="1594882059448" ID="ID_1617301212" MODIFIED="1594882060432" TEXT="Functions as first-class objects"/>
<node CREATED="1594882069947" ID="ID_717802802" MODIFIED="1594882071104" TEXT="Anonymous functions">
<node CREATED="1594882071560" ID="ID_1699312184" MODIFIED="1594882087615">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      ([[Type] param1[, &#8230;]]) {
    </p>
    <p>
      &#160;&#160;codeBlock;
    </p>
    <p>
      };
    </p>
  </body>
</html></richcontent>
</node>
</node>
</node>
<node CREATED="1594882227199" ID="ID_1847229385" MODIFIED="1594882249941" POSITION="right" TEXT="Scope">
<node CREATED="1594882251301" ID="ID_675486895" MODIFIED="1594882256581" TEXT="Lexical scope"/>
<node CREATED="1594882256967" ID="ID_1428368622" MODIFIED="1594882262309" TEXT="Lexical closures"/>
</node>
<node CREATED="1594882448164" ID="ID_515181780" MODIFIED="1594882448699" POSITION="right" TEXT="Operators">
<node CREATED="1594882456465" ID="ID_1813540100" MODIFIED="1594882457147" TEXT="Arithmetic operators"/>
<node CREATED="1594882469099" ID="ID_1874540787" MODIFIED="1594882469396" TEXT="Equality and relational operators"/>
<node CREATED="1594882478804" ID="ID_292597670" MODIFIED="1594882479116" TEXT="Type test operators">
<node CREATED="1594882479827" ID="ID_1357725070" MODIFIED="1594882481628" TEXT="as"/>
<node CREATED="1594882481991" ID="ID_446045584" MODIFIED="1594882482756" TEXT="is"/>
<node CREATED="1594882483383" ID="ID_793094046" MODIFIED="1594882492052" TEXT="is!"/>
</node>
<node CREATED="1594882510214" ID="ID_721172375" MODIFIED="1594882510581" TEXT="Assignment operators"/>
<node CREATED="1594882520461" ID="ID_226750956" MODIFIED="1594882520749" TEXT="Logical operators"/>
<node CREATED="1594882526350" ID="ID_1538203278" MODIFIED="1594882526565" TEXT="Bitwise and shift operators"/>
<node CREATED="1594882533020" ID="ID_1659161170" MODIFIED="1594882533598" TEXT="Conditional expressions">
<node CREATED="1594882534754" ID="ID_1571304079" MODIFIED="1594882541422" TEXT="condition ? expr1 : expr2"/>
<node CREATED="1594882542272" ID="ID_1997649778" MODIFIED="1594882546478" TEXT="expr1 ?? expr2"/>
</node>
<node CREATED="1594882562002" ID="ID_586904715" MODIFIED="1594882562303" TEXT="Cascade notation (..)"/>
<node CREATED="1594882582809" ID="ID_164805291" MODIFIED="1594882583135" TEXT="Other operators">
<node CREATED="1594882583693" ID="ID_843595357" MODIFIED="1594882585911" TEXT="()"/>
<node CREATED="1594882586190" ID="ID_239720024" MODIFIED="1594882588368" TEXT="[]"/>
<node CREATED="1594882589968" ID="ID_1554368428" MODIFIED="1594882591632" TEXT="."/>
<node CREATED="1594882592026" ID="ID_792247538" MODIFIED="1594882595000" TEXT="?."/>
</node>
</node>
<node CREATED="1594882610291" ID="ID_1488269877" MODIFIED="1594882611272" POSITION="right" TEXT="Control flow statements">
<node CREATED="1594882612894" ID="ID_889106131" MODIFIED="1594882616104" TEXT="if and else"/>
<node CREATED="1594882616377" ID="ID_301472849" MODIFIED="1594882619376" TEXT="for loops">
<node CREATED="1594882783373" ID="ID_1608256607" MODIFIED="1594882787941" TEXT="for ( ; ;)"/>
<node CREATED="1594882788456" ID="ID_437741187" MODIFIED="1594882806486" TEXT="for (var in) each"/>
</node>
<node CREATED="1594882619651" ID="ID_1809362901" MODIFIED="1594882626126" TEXT="while and do-while loops"/>
<node CREATED="1594882626422" ID="ID_837433255" MODIFIED="1594882635625" TEXT="break and continue"/>
<node CREATED="1594882636130" ID="ID_1423290824" MODIFIED="1594882640489" TEXT="switch and case">
<node CREATED="1594882729052" ID="ID_168496411" MODIFIED="1594882751572" TEXT="Empty case falls through"/>
<node CREATED="1594882761443" ID="ID_1031436044" MODIFIED="1594882765501" TEXT="continue statement"/>
</node>
<node CREATED="1594882640754" ID="ID_1584453161" MODIFIED="1594882649089" TEXT="assert"/>
<node CREATED="1594882655218" ID="ID_614108124" MODIFIED="1594882659681" TEXT="try-catch">
<node CREATED="1594882860504" ID="ID_1945482551" MODIFIED="1594882910204" TEXT="try {} on Ecception catch {} catch {} finally {}"/>
</node>
<node CREATED="1594882660348" ID="ID_1246940630" MODIFIED="1594882661625" TEXT="throw">
<node CREATED="1594882852349" ID="ID_29620608" MODIFIED="1594882853287" TEXT="throw &apos;Out of llamas!&apos;;"/>
<node CREATED="1594882853877" ID="ID_1960866700" MODIFIED="1594882857976" TEXT="throw FormatException(&apos;Expected at least 1 section&apos;);"/>
</node>
</node>
<node CREATED="1594882919388" ID="ID_1838809241" MODIFIED="1594882922236" POSITION="left" TEXT="classes">
<node CREATED="1594882952254" ID="ID_633935361" MODIFIED="1594882952957" TEXT=" constant constructors.">
<node CREATED="1594882960445" ID="ID_1806467373" MODIFIED="1594882961069" TEXT="const ImmutablePoint(2, 2)"/>
</node>
<node CREATED="1594882988801" ID="ID_1483319605" MODIFIED="1594882989374" TEXT="runtimeType"/>
<node CREATED="1594883029034" ID="ID_137892256" MODIFIED="1594883038360" TEXT="Instance variables ">
<node CREATED="1594883061449" ID="ID_959512353" MODIFIED="1594883072008" TEXT="initialized null"/>
<node CREATED="1594883072823" ID="ID_1512568903" MODIFIED="1594883091399" TEXT="implicit getter and setter"/>
</node>
<node CREATED="1594883095769" ID="ID_1496236651" MODIFIED="1594883101609" TEXT="Constructors">
<node CREATED="1594883175389" ID="ID_1918194361" MODIFIED="1594883176748" TEXT=" Named constructors">
<node CREATED="1594883201166" ID="ID_956582006" MODIFIED="1594883254855" TEXT="  Point.origin() {     x = 0;     y = 0;   }"/>
</node>
<node CREATED="1594883211296" ID="ID_1895291596" MODIFIED="1594883211557" TEXT="Default constructors"/>
<node CREATED="1594883212559" ID="ID_1776163317" MODIFIED="1594883219029" TEXT="Constructors aren&#x2019;t inherited"/>
<node CREATED="1594883238895" ID="ID_1898802914" MODIFIED="1594883239574" TEXT="Point(this.x, this.y);"/>
<node CREATED="1594883405365" ID="ID_244109798" MODIFIED="1594883406099" TEXT="Invoking a non-default superclass constructor">
<node CREATED="1594883414276" ID="ID_1333411798" MODIFIED="1594883415053" TEXT="initializer list">
<node CREATED="1594883460997" ID="ID_1179903755" MODIFIED="1594883737469" TEXT="Employee.fromJson(Map data) : i = data[&apos;i&apos;], super.fromJson(data[&apos;name&apos;])"/>
</node>
<node CREATED="1594883415483" ID="ID_726407907" MODIFIED="1594883421099" TEXT="superclass&#x2019;s no-arg constructor"/>
<node CREATED="1594883421622" ID="ID_262971631" MODIFIED="1594883426612" TEXT="main class&#x2019;s no-arg constructor"/>
</node>
<node CREATED="1594883761804" ID="ID_560149536" MODIFIED="1594883762179" TEXT="Redirecting constructors">
<node CREATED="1594883780447" ID="ID_78983993" MODIFIED="1594883781232" TEXT="this"/>
</node>
<node CREATED="1594883775790" ID="ID_1934982101" MODIFIED="1594883776181" TEXT="Constant constructors"/>
<node CREATED="1594883800177" ID="ID_1630108994" MODIFIED="1594883800514" TEXT="Factory constructors">
<node CREATED="1594883801786" ID="ID_57314945" MODIFIED="1594883803898" TEXT="factory"/>
</node>
</node>
<node CREATED="1594883834860" ID="ID_71324402" MODIFIED="1594883835588" TEXT="Methods">
<node CREATED="1594883841058" ID="ID_1048078771" MODIFIED="1594883841700" TEXT="Instance methods"/>
<node CREATED="1594883842342" ID="ID_1873302023" MODIFIED="1594883847436" TEXT="Getters and setters">
<node CREATED="1594883852006" ID="ID_741160689" MODIFIED="1594883852860" TEXT="double get right =&gt; left + width"/>
<node CREATED="1594883853372" ID="ID_32490123" MODIFIED="1594883861205" TEXT="set right(double value) =&gt; left = value - width"/>
</node>
<node CREATED="1594883889181" ID="ID_500024044" MODIFIED="1594883889654" TEXT="Abstract methods"/>
</node>
<node CREATED="1594883898800" ID="ID_714528684" MODIFIED="1594883899102" TEXT="Abstract classes"/>
<node CREATED="1594883910515" ID="ID_1677205333" MODIFIED="1594883911046" TEXT="Implicit interfaces"/>
<node CREATED="1594883923800" ID="ID_606164856" MODIFIED="1594883924215" TEXT="Extending a class"/>
<node CREATED="1594883930845" ID="ID_141201134" MODIFIED="1594883931423" TEXT="Overriding members"/>
<node CREATED="1594883932002" ID="ID_1873516983" MODIFIED="1594883936287" TEXT="Overridable operators">
<node CREATED="1594883949604" ID="ID_368170421" MODIFIED="1594883950535" TEXT=" Vector operator +(Vector v) =&gt; Vector(x + v.x, y + v.y)"/>
</node>
<node CREATED="1594883964597" ID="ID_1451018662" MODIFIED="1594883964912" TEXT="noSuchMethod"/>
<node CREATED="1594883971057" ID="ID_1684740786" MODIFIED="1594883971312" TEXT="Extension methods">
<node CREATED="1594884055473" ID="ID_961931833" MODIFIED="1594884071916">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      extension NumberParsing on String {
    </p>
    <p>
      &#160;&#160;int parseInt() {
    </p>
    <p>
      &#160;&#160;&#160;&#160;return int.parse(this);
    </p>
    <p>
      &#160;&#160;}
    </p>
    <p>
      &#160;&#160;// &#183;&#183;&#183;
    </p>
    <p>
      }
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1594884292579" ID="ID_1679052671" MODIFIED="1594884293242" TEXT="Class variables and methods">
<node CREATED="1594884294271" ID="ID_560142020" MODIFIED="1594884296226" TEXT="static"/>
</node>
</node>
<node CREATED="1594884085937" ID="ID_113951292" MODIFIED="1594884086355" POSITION="left" TEXT="Enumerated types">
<node CREATED="1594884092485" ID="ID_141165060" MODIFIED="1594884093132" TEXT="enum Color { red, green, blue }"/>
</node>
<node CREATED="1594884120397" ID="ID_1819163937" MODIFIED="1594884120693" POSITION="left" TEXT="Adding features to a class: mixins">
<node CREATED="1594884230898" ID="ID_1551872390" MODIFIED="1594884261897" TEXT="with MixinsClassName"/>
<node CREATED="1594884240539" ID="ID_668343424" MODIFIED="1594884249233" TEXT="mixin ClassName"/>
<node CREATED="1594884275411" ID="ID_259336234" MODIFIED="1594884276985" TEXT="mixin MusicalPerformer on Musician"/>
</node>
<node CREATED="1594884308408" ID="ID_1696013113" MODIFIED="1594884551289" POSITION="left" TEXT="Generics">
<node CREATED="1594884524947" ID="ID_1253829782" MODIFIED="1594884525713" TEXT="Restricting the parameterized type"/>
</node>
<node CREATED="1594884549466" ID="ID_1825680645" MODIFIED="1594884550010" POSITION="left" TEXT="Libraries and visibility">
<node CREATED="1594884558415" ID="ID_84359822" MODIFIED="1594884559082" TEXT="import"/>
<node CREATED="1594884563660" ID="ID_1911803684" MODIFIED="1594884565330" TEXT="import as"/>
<node CREATED="1594884568691" ID="ID_1399054585" MODIFIED="1594884570362" TEXT="import show"/>
<node CREATED="1594884570789" ID="ID_1445062114" MODIFIED="1594884574074" TEXT="import hide"/>
<node CREATED="1594884579955" ID="ID_559981016" MODIFIED="1594884589027" TEXT="import deferred as"/>
</node>
<node CREATED="1594884596579" ID="ID_1268901685" MODIFIED="1594884597203" POSITION="left" TEXT="Asynchrony support">
<node CREATED="1594884598208" ID="ID_1694337093" MODIFIED="1594884600995" TEXT="Future"/>
<node CREATED="1594884601525" ID="ID_1494564812" MODIFIED="1594884605635" TEXT="Stream"/>
</node>
<node CREATED="1594884618483" ID="ID_732328554" MODIFIED="1594884618923" POSITION="left" TEXT="Generators">
<node CREATED="1594884636211" ID="ID_308621994" MODIFIED="1594884651101" TEXT="Synchronous - Iterable"/>
<node CREATED="1594884637623" ID="ID_1887476656" MODIFIED="1594884658173" TEXT="Asynchronous - Stream"/>
</node>
<node CREATED="1594884682783" ID="ID_1701698985" MODIFIED="1594884683614" POSITION="left" TEXT="Callable classes">
<node CREATED="1594884684437" ID="ID_577787135" MODIFIED="1594884699408" TEXT="&#x5b9e;&#x73b0;call&#x51fd;&#x6570;"/>
<node CREATED="1594884711757" ID="ID_1713611319" MODIFIED="1594884724031" TEXT="Class() &#x8fd4;&#x56de;call&#x51fd;&#x6570;"/>
</node>
<node CREATED="1594884730097" ID="ID_891689620" MODIFIED="1594884730391" POSITION="left" TEXT="Isolates"/>
<node CREATED="1594884731058" ID="ID_562169281" MODIFIED="1594884734544" POSITION="left" TEXT="Typedefs"/>
<node CREATED="1594884744497" ID="ID_918564618" MODIFIED="1594884744832" POSITION="left" TEXT="Metadata"/>
<node CREATED="1594884753225" ID="ID_1549459156" MODIFIED="1594884753568" POSITION="left" TEXT="Comments">
<node CREATED="1594884774483" ID="ID_1908099907" MODIFIED="1594884775723" TEXT="//"/>
<node CREATED="1594884767825" ID="ID_1665131837" MODIFIED="1594884772186" TEXT="/* */"/>
<node CREATED="1594884754128" ID="ID_298620346" MODIFIED="1594884755681" TEXT="///"/>
</node>
</node>
</map>
