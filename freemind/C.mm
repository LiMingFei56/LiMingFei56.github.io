<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1592905772013" ID="ID_950427768" MODIFIED="1592905792581" TEXT="C&#x8bed;&#x8a00;">
<node CREATED="1592905819163" ID="ID_1022815629" MODIFIED="1592906896186" POSITION="right" TEXT="Preprocessor">
<node CREATED="1592905836005" ID="ID_1317064092" MODIFIED="1592905836921" TEXT="#define"/>
<node CREATED="1592905837414" ID="ID_1210759596" MODIFIED="1592905842312" TEXT="#include"/>
<node CREATED="1592905842580" ID="ID_678298081" MODIFIED="1592905846728" TEXT="#undef"/>
<node CREATED="1592905847051" ID="ID_264473021" MODIFIED="1592905851624" TEXT="#ifdef"/>
<node CREATED="1592905851881" ID="ID_723239014" MODIFIED="1592905857528" TEXT="#ifndef"/>
<node CREATED="1592905857817" ID="ID_202365645" MODIFIED="1592905863801" TEXT="#if"/>
<node CREATED="1592905864057" ID="ID_1677614006" MODIFIED="1592905869889" TEXT="#else"/>
<node CREATED="1592905870155" ID="ID_52763531" MODIFIED="1592905879425" TEXT="#elif"/>
<node CREATED="1592905880338" ID="ID_1772224478" MODIFIED="1592905884593" TEXT="#endif"/>
<node CREATED="1592905885017" ID="ID_1928960784" MODIFIED="1592905889561" TEXT="#error"/>
<node CREATED="1592905889817" ID="ID_1384223366" MODIFIED="1592905894138" TEXT="#pragma"/>
<node CREATED="1592905894435" ID="ID_1102457066" MODIFIED="1592905897290" TEXT="#line"/>
</node>
<node CREATED="1592905939179" ID="ID_856814715" MODIFIED="1592907417027" POSITION="right" TEXT="Macros">
<node CREATED="1592907421014" ID="ID_242002660" MODIFIED="1592907439455" TEXT="type-generic math(C99)"/>
<node CREATED="1592907515630" ID="ID_1395439154" MODIFIED="1592907521477" TEXT="variadic macros(C99)"/>
<node CREATED="1592905943697" ID="ID_58525492" MODIFIED="1592905944427" TEXT="__DATE__"/>
<node CREATED="1592905944689" ID="ID_620260288" MODIFIED="1592905949683" TEXT="__TIME__"/>
<node CREATED="1592905949932" ID="ID_278104225" MODIFIED="1592905955612" TEXT="__FILE__"/>
<node CREATED="1592905955853" ID="ID_1126286418" MODIFIED="1592905961390" TEXT="__LINE__"/>
<node CREATED="1592905961638" ID="ID_545824669" MODIFIED="1592905966443" TEXT="__STDC__"/>
</node>
<node CREATED="1592906014016" ID="ID_344912642" MODIFIED="1592906899917" POSITION="right" TEXT="Data Types">
<node CREATED="1592906015596" ID="ID_757706935" MODIFIED="1592906019694" TEXT="Basic Types">
<node CREATED="1592906040347" ID="ID_1571757794" MODIFIED="1592906040958" TEXT="Integer">
<node CREATED="1592906135271" ID="ID_1150344667" MODIFIED="1592906144586" TEXT="&#x5341;&#x8fdb;&#x5236;"/>
<node CREATED="1592906145025" ID="ID_192939930" MODIFIED="1592906150834" TEXT="0, &#x516b;&#x8fdb;&#x5236;"/>
<node CREATED="1592906151285" ID="ID_994685479" MODIFIED="1592906160906" TEXT="0x, &#x5341;&#x516d;&#x8fdb;&#x5236;"/>
</node>
<node CREATED="1592906041263" ID="ID_39641920" MODIFIED="1592906049518" TEXT="Floating-Point">
<node CREATED="1592907430703" ID="ID_799976883" MODIFIED="1592907431446" TEXT="IEEE floating point"/>
</node>
<node CREATED="1592906314277" ID="ID_320230579" MODIFIED="1592906384569" TEXT="_Bool(C99)"/>
<node CREATED="1592906315160" ID="ID_1873318472" MODIFIED="1592906378479" TEXT="_Complex, _Imaginary(C99)">
<node CREATED="1592967542823" ID="ID_1877101863" MODIFIED="1592967549865" TEXT="Macros for the construction (C11)"/>
</node>
<node CREATED="1592906327896" ID="ID_1558640715" MODIFIED="1592967077382" TEXT="Alignment specification(C11)"/>
<node CREATED="1592967105544" ID="ID_42952524" MODIFIED="1592967110329" TEXT="_Noreturn(C11)"/>
<node CREATED="1592906342280" ID="ID_1945004030" MODIFIED="1592906372461" TEXT="_Atomic(C11)"/>
<node CREATED="1592906187509" ID="ID_1392809192" MODIFIED="1592906188499" TEXT="Character">
<node CREATED="1592906188906" ID="ID_336544943" MODIFIED="1592906208155" TEXT="universal character"/>
<node CREATED="1592967214374" ID="ID_446049142" MODIFIED="1592967218602" TEXT="Improved Unicode support(C11)">
<node CREATED="1592967219852" ID="ID_914263678" MODIFIED="1592967230396" TEXT="char16_t/UTF-16"/>
<node CREATED="1592967235422" ID="ID_1285973023" MODIFIED="1592967241332" TEXT="char32_t/UTF-32"/>
<node CREATED="1592967263343" ID="ID_937894249" MODIFIED="1592967278589" TEXT="u&quot;Hello world&quot;;/ utf-8"/>
</node>
</node>
<node CREATED="1592967136087" ID="ID_390850652" MODIFIED="1592967136937" TEXT="Type-generic expressions">
<node CREATED="1592967137704" ID="ID_468048516" MODIFIED="1592967153875">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <pre style="letter-spacing: normal; padding-left: 0; padding-top: 0; text-align: start; font-family: monospace, monospace; text-indent: 0px; background-color: rgb(248, 249, 250); padding-right: 0; color: rgb(0, 0, 0); white-space: pre-wrap; text-transform: none; word-spacing: 0px; font-style: normal; font-size: 14px; font-weight: 400; padding-bottom: 0; line-height: 1.3" charset="utf-8"><span class="cp" style="color: rgb(188, 122, 0)"><font color="rgb(188, 122, 0)">#define cbrt(x) _Generic((x), long double: cbrtl, \</font></span>
<span class="cp" style="color: rgb(188, 122, 0)"><font color="rgb(188, 122, 0)">                              default: cbrt, \</font></span>
<span class="cp" style="color: rgb(188, 122, 0)"><font color="rgb(188, 122, 0)">                              float: cbrtf)(</font></span></pre>
  </body>
</html>
</richcontent>
</node>
</node>
</node>
<node CREATED="1592906019959" ID="ID_1825582392" MODIFIED="1592906023965" TEXT="Enumerated types"/>
<node CREATED="1592906024216" ID="ID_1035413202" MODIFIED="1592906028989" TEXT="The type void">
<node CREATED="1592906056283" ID="ID_80057897" MODIFIED="1592906061911" TEXT="&#x65e0;&#x8fd4;&#x56de;&#x503c;"/>
<node CREATED="1592906062723" ID="ID_1235258841" MODIFIED="1592906065040" TEXT="&#x65e0;&#x53c2;&#x6570;"/>
<node CREATED="1592906065401" ID="ID_559809640" MODIFIED="1592906080440" TEXT="&#x6307;&#x9488;, &#x53ef;&#x4ee5;&#x8f6c;&#x6362;&#x6210;&#x4efb;&#x4f55;&#x7c7b;&#x578b;&#x6307;&#x9488;"/>
</node>
<node CREATED="1592906029227" ID="ID_265966821" MODIFIED="1592906033222" TEXT="Derived types">
<node CREATED="1592906903244" ID="ID_1118578394" MODIFIED="1592906904209" TEXT="Arrays">
<node CREATED="1592906908975" ID="ID_1763552708" MODIFIED="1592906909761" TEXT="type arrayName [ arraySize ];"/>
<node CREATED="1592906915022" ID="ID_1562186077" MODIFIED="1592906915402" TEXT="double balance[5] = {1000.0, 2.0, 3.4, 7.0, 50.0};"/>
<node CREATED="1592907298353" ID="ID_1123790041" MODIFIED="1592907308110" TEXT="variable-length arrays(C99)"/>
<node CREATED="1592907383932" ID="ID_1855233141" MODIFIED="1592907387188" TEXT="flexible array member(C99)"/>
</node>
<node CREATED="1592906925102" ID="ID_724462618" MODIFIED="1592906925482" TEXT="Pointers"/>
<node CREATED="1592906932843" ID="ID_894591854" MODIFIED="1592906933410" TEXT="Strings"/>
<node CREATED="1592906941188" ID="ID_1468318144" MODIFIED="1592906943340" TEXT="Structures">
<node CREATED="1592906943341" ID="ID_397020403" MODIFIED="1592907013555">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      struct [structure tag] {
    </p>
    <p>
      &#160;&#160;&#160;&#160;member defintion;
    </p>
    <p>
      &#160;&#160;&#160;&#160;...
    </p>
    <p>
      } [one or more structure variables]
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1592907030420" ID="ID_1928109351" MODIFIED="1592907031461" TEXT="Bit Fields"/>
</node>
<node CREATED="1592907036549" ID="ID_1823088906" MODIFIED="1592907037559" TEXT="Union">
<node CREATED="1592907042038" ID="ID_1907132173" MODIFIED="1592907081069">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      union [union tag] {
    </p>
    <p>
      &#160;&#160;&#160;&#160;member definition;
    </p>
    <p>
      &#160;&#160;&#160;&#160;...
    </p>
    <p>
      } [one or more union variables];
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1592907104070" ID="ID_1220685377" MODIFIED="1592907104847" TEXT="typedef"/>
<node CREATED="1592907124570" ID="ID_567747531" MODIFIED="1592907125328" TEXT="Type Casting"/>
<node CREATED="1592967382014" ID="ID_1790144672" MODIFIED="1592967385621" TEXT="Anonymous structures and unions(C11)">
<node CREATED="1592967397027" ID="ID_1129695353" MODIFIED="1592967404762" TEXT="struct T { int tag; union { float x; int n; }; };"/>
</node>
</node>
</node>
<node CREATED="1592906097407" ID="ID_38291713" MODIFIED="1592907453165" POSITION="right" TEXT="Variable">
<node CREATED="1592906102541" ID="ID_1704691754" MODIFIED="1592906103480" TEXT="type variable_list;"/>
<node CREATED="1592906111792" ID="ID_978942230" MODIFIED="1592906112208" TEXT="type variable_name = value;"/>
<node CREATED="1592906117511" ID="ID_1040319982" MODIFIED="1592906125464" TEXT="extern type variable_list;"/>
<node CREATED="1592906226884" ID="ID_808063013" MODIFIED="1592906227948" TEXT="Constants">
<node CREATED="1592906228275" ID="ID_812354083" MODIFIED="1592906232676" TEXT="#define"/>
<node CREATED="1592906232940" ID="ID_222395413" MODIFIED="1592906236189" TEXT="const"/>
</node>
</node>
<node CREATED="1592906244716" ID="ID_633084135" MODIFIED="1592907459386" POSITION="right" TEXT="Storage">
<node CREATED="1592906248565" ID="ID_1562059094" MODIFIED="1592906249141" TEXT="auto"/>
<node CREATED="1592906249430" ID="ID_1681434578" MODIFIED="1592906253229" TEXT="register"/>
<node CREATED="1592906253486" ID="ID_1239825111" MODIFIED="1592906257541" TEXT="static"/>
<node CREATED="1592906257792" ID="ID_995516907" MODIFIED="1592906261861" TEXT="extern"/>
<node CREATED="1592906272721" ID="ID_284765449" MODIFIED="1592906273430" TEXT="restrict"/>
<node CREATED="1592906273968" ID="ID_1040243420" MODIFIED="1592906299679" TEXT="volatile"/>
</node>
<node CREATED="1592906407272" ID="ID_1504961016" MODIFIED="1592907460587" POSITION="right" TEXT="Operators">
<node CREATED="1592906411499" ID="ID_1124470652" MODIFIED="1592906412216" TEXT="Arithmetic Operators"/>
<node CREATED="1592906412450" ID="ID_1479436381" MODIFIED="1592906417193" TEXT="Relational Operators"/>
<node CREATED="1592906417468" ID="ID_93363947" MODIFIED="1592906422642" TEXT="Logical Operators"/>
<node CREATED="1592906426921" ID="ID_1442527641" MODIFIED="1592906427299" TEXT="Bitwise Operators"/>
<node CREATED="1592906431689" ID="ID_1102916704" MODIFIED="1592906432067" TEXT="Assignment Operators"/>
<node CREATED="1592906435589" ID="ID_729505240" MODIFIED="1592906436195" TEXT="Misc Operators">
<node CREATED="1592906436754" ID="ID_1680061373" MODIFIED="1592906443116" TEXT="sizeof()"/>
<node CREATED="1592906443366" ID="ID_66463260" MODIFIED="1592906450988" TEXT="&#x6307;&#x9488;&amp;"/>
<node CREATED="1592906451277" ID="ID_768483378" MODIFIED="1592906455917" TEXT="&#x6307;&#x9488;*"/>
<node CREATED="1592906458189" ID="ID_518905834" MODIFIED="1592906459645" TEXT="?:"/>
</node>
</node>
<node CREATED="1592906478531" ID="ID_1610774038" MODIFIED="1592906484813" POSITION="left" TEXT="Decision Making">
<node CREATED="1592906485318" ID="ID_1063270315" MODIFIED="1592906493254" TEXT="if...else..."/>
<node CREATED="1592906494039" ID="ID_1165370431" MODIFIED="1592906496974" TEXT="switch"/>
</node>
<node CREATED="1592906503271" ID="ID_1689549246" MODIFIED="1592906503518" POSITION="left" TEXT="Loops">
<node CREATED="1592906504510" ID="ID_782114776" MODIFIED="1592906508454" TEXT="while"/>
<node CREATED="1592906508952" ID="ID_1365042504" MODIFIED="1592906512016" TEXT="do...while"/>
<node CREATED="1592906512504" ID="ID_832995881" MODIFIED="1592906513294" TEXT="for"/>
</node>
<node CREATED="1592906534591" ID="ID_1892404218" MODIFIED="1592906535239" POSITION="left" TEXT="Loop Control">
<node CREATED="1592906537694" ID="ID_1134695804" MODIFIED="1592906539367" TEXT="break"/>
<node CREATED="1592906539792" ID="ID_1652117278" MODIFIED="1592906546845" TEXT="continue"/>
<node CREATED="1592906547871" ID="ID_1693580506" MODIFIED="1592906548735" TEXT="goto"/>
</node>
<node CREATED="1592906559181" ID="ID_1410233442" MODIFIED="1592906629241" POSITION="left" TEXT="Function">
<node CREATED="1592906566145" ID="ID_1714229779" MODIFIED="1592906605306">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      return_type function_name(parameter list)
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1592906610847" ID="ID_939430898" MODIFIED="1592906613689" TEXT="inline"/>
<node CREATED="1592907167626" ID="ID_1663590997" MODIFIED="1592907168097" TEXT="Variable Arguments">
<node CREATED="1592907174890" ID="ID_1837904938" MODIFIED="1592907176009" TEXT="nt func(int, ... )"/>
</node>
<node CREATED="1592967507722" ID="ID_682782741" MODIFIED="1592967511080" TEXT="Time">
<node CREATED="1592967511509" ID="ID_17983998" MODIFIED="1592967516224" TEXT="timespec_get(C11)"/>
</node>
</node>
<node CREATED="1592906629800" ID="ID_1366793734" MODIFIED="1592906630650" POSITION="left" TEXT="Scope Rules">
<node CREATED="1592906633232" ID="ID_1292930458" MODIFIED="1592906641122" TEXT="Local Variables">
<node CREATED="1592906649044" ID="ID_28756920" MODIFIED="1592906656466" TEXT="&#x521d;&#x59cb;&#x5316;&#x672a;&#x5b9a;&#x4e49;"/>
</node>
<node CREATED="1592906641738" ID="ID_367450327" MODIFIED="1592906647274" TEXT="Global Variables">
<node CREATED="1592906777589" ID="ID_1127702070" MODIFIED="1592906778894" TEXT="&#x5168;&#x5c40;&#x6570;&#x636e;&#x533a;"/>
<node CREATED="1592906779341" ID="ID_1687700696" MODIFIED="1592906788422" TEXT="&#x81ea;&#x52a8;&#x521d;&#x59cb;&#x5316;"/>
<node CREATED="1592906877722" ID="ID_416824018" MODIFIED="1592906886553" TEXT="&#x5f53;&#x524d;&#x7a0b;&#x5e8f;"/>
</node>
<node CREATED="1592906738300" ID="ID_1792091757" MODIFIED="1592906748804" TEXT="static Local Variables">
<node CREATED="1592906819798" ID="ID_1738816442" MODIFIED="1592906821063" TEXT="&#x5168;&#x5c40;&#x6570;&#x636e;&#x533a;"/>
<node CREATED="1592906822254" ID="ID_56124692" MODIFIED="1592906827928" TEXT="&#x81ea;&#x52a8;&#x521d;&#x59cb;&#x5316;"/>
<node CREATED="1592906840675" ID="ID_1239015449" MODIFIED="1592906871346" TEXT="&#x5c40;&#x90e8;&#x4f5c;&#x7528;&#x57df;"/>
</node>
<node CREATED="1592906749364" ID="ID_202758466" MODIFIED="1592906758253" TEXT="static Global Variables">
<node CREATED="1592906819798" ID="ID_1835523635" MODIFIED="1592906821063" TEXT="&#x5168;&#x5c40;&#x6570;&#x636e;&#x533a;"/>
<node CREATED="1592906822254" ID="ID_566129490" MODIFIED="1592906827928" TEXT="&#x81ea;&#x52a8;&#x521d;&#x59cb;&#x5316;"/>
<node CREATED="1592906840675" ID="ID_1765207813" MODIFIED="1592906846360" TEXT="&#x53ea;&#x5bf9;&#x5f53;&#x524d;&#x6587;&#x4ef6;&#x53ef;&#x89c1;"/>
</node>
</node>
<node CREATED="1592907194212" ID="ID_1564528951" MODIFIED="1592907194810" POSITION="left" TEXT="Memory Management">
<node CREATED="1592907195949" ID="ID_1843406169" MODIFIED="1592907205642" TEXT="void *calloc(int num, int size);"/>
<node CREATED="1592907206427" ID="ID_1539170354" MODIFIED="1592907210984" TEXT="void free(void *address);"/>
<node CREATED="1592907216834" ID="ID_630981216" MODIFIED="1592907217242" TEXT="void *malloc(int num);"/>
<node CREATED="1592907221788" ID="ID_592016402" MODIFIED="1592907222419" TEXT="void *realloc(void *address, int newsize);"/>
</node>
<node CREATED="1592907466874" ID="ID_974017138" MODIFIED="1592907472553" POSITION="left" TEXT="Initializers">
<node CREATED="1592907473304" ID="ID_32753216" MODIFIED="1592907479344" TEXT="designated initializers(C99)"/>
<node CREATED="1592907493223" ID="ID_558618914" MODIFIED="1592907497576" TEXT="compound literals(C99)"/>
</node>
<node CREATED="1592967181493" ID="ID_325532639" MODIFIED="1592967316800" POSITION="left" TEXT="Multi-threading(C11)">
<node CREATED="1592967186987" ID="ID_1456018834" MODIFIED="1592967188051" TEXT="_Thread_local"/>
</node>
<node CREATED="1592967306338" ID="ID_510051987" MODIFIED="1592967322618" POSITION="left" TEXT="Bounds-checking interfaces(C11)"/>
<node CREATED="1592967333820" ID="ID_1606618859" MODIFIED="1592967336642" POSITION="left" TEXT="Analyzability features(C11)"/>
<node CREATED="1592967436712" ID="ID_934897382" MODIFIED="1592967440438" POSITION="left" TEXT="Static assertions(C11)"/>
<node CREATED="1592967478001" ID="ID_1988605922" MODIFIED="1592967480455" POSITION="left" TEXT="Exit">
<node CREATED="1592967481116" ID="ID_1340290599" MODIFIED="1592967490599" TEXT="quick_exit(C11)"/>
</node>
<node CREATED="1592907545002" ID="ID_1682267485" MODIFIED="1592907547650" POSITION="left" TEXT="Reference">
<node CREATED="1592907549466" ID="ID_733452287" MODIFIED="1592907550306" TEXT="https://cloud.tencent.com/developer/doc/1023"/>
</node>
</node>
</map>
