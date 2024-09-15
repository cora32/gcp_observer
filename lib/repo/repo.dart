import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' show parse;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repo.g.dart';

final test = '''
<chart>
<p i="0" a="0.3925284" t="0.3325489" q1="0.3683299" q3="0.4110305" b="0.4366879" />
<p i="1" a="0.3806583" t="0.2734049" q1="0.3197013" q3="0.4489733" b="0.4912533" />
<p i="2" a="0.4153562" t="0.3084388" q1="0.3961639" q3="0.43541" b="0.4880301" />
<p i="3" a="0.2452079" t="0.1740754" q1="0.2085115" q3="0.2580034" b="0.4078084" />
<p i="4" a="0.2265684" t="0.1717758" q1="0.1983711" q3="0.2429586" b="0.3370605" />
<p i="5" a="0.3641819" t="0.2051215" q1="0.2663816" q3="0.4742042" b="0.5869447" />
<p i="6" a="0.5500478" t="0.5050287" q1="0.534744" q3="0.5621864" b="0.6125956" />
<p i="7" a="0.5425736" t="0.4982927" q1="0.5254206" q3="0.5546688" b="0.5808151" />
<p i="8" a="0.6926389" t="0.5645805" q1="0.6533777" q3="0.7352554" b="0.7573849" />
<p i="9" a="0.7552752" t="0.6591642" q1="0.7165834" q3="0.7889336" b="0.8313179" />
<p i="10" a="0.7335512" t="0.6892761" q1="0.7132373" q3="0.744013" b="0.7914779" />
<p i="11" a="0.6515073" t="0.5520389" q1="0.6318643" q3="0.6704487" b="0.7235931" />
<p i="12" a="0.534699" t="0.4296322" q1="0.4865269" q3="0.5806984" b="0.652116" />
<p i="13" a="0.6018716" t="0.4946091" q1="0.5917838" q3="0.6218066" b="0.6376756" />
<p i="14" a="0.5507365" t="0.4832568" q1="0.5138351" q3="0.5884271" b="0.629041" />
<p i="15" a="0.5456757" t="0.4049145" q1="0.5303027" q3="0.5779636" b="0.606213" />
<p i="16" a="0.419347" t="0.3710823" q1="0.3997886" q3="0.4348532" b="0.4810061" />
<p i="17" a="0.3565155" t="0.2790119" q1="0.3307487" q3="0.3744136" b="0.4149186" />
<p i="18" a="0.3043926" t="0.2501507" q1="0.2893999" q3="0.3167992" b="0.3463139" />
<p i="19" a="0.3371073" t="0.2858191" q1="0.3164746" q3="0.3551789" b="0.3982742" />
<p i="20" a="0.324187" t="0.1853294" q1="0.2779299" q3="0.3877765" b="0.4754854" />
<p i="21" a="0.171415" t="0.1285023" q1="0.1546712" q3="0.1910554" b="0.216565" />
<p i="22" a="0.1020993" t="0.0361239" q1="0.0671736" q3="0.1278135" b="0.1650361" />
<p i="23" a="0.0438764" t="0.0190759" q1="0.0282496" q3="0.065692" b="0.0905136" />
<p i="24" a="0.0630332" t="0.0350539" q1="0.0543737" q3="0.0721358" b="0.0949096" />
<p i="25" a="0.0450134" t="0.0273827" q1="0.0414891" q3="0.0488453" b="0.0581436" />
<p i="26" a="0.0775906" t="0.0412797" q1="0.0543382" q3="0.0908907" b="0.1462089" />
<p i="27" a="0.1272898" t="0.0947147" q1="0.115182" q3="0.1385998" b="0.1667306" />
<p i="28" a="0.1658227" t="0.1069564" q1="0.1332127" q3="0.1740575" b="0.2905158" />
<p i="29" a="0.2661455" t="0.2149765" q1="0.2336399" q3="0.2959037" b="0.345379" />
<p i="30" a="0.2892797" t="0.1604108" q1="0.217468" q3="0.3450682" b="0.3959558" />
<p i="31" a="0.3561576" t="0.3036231" q1="0.3370861" q3="0.3678861" b="0.4339431" />
<p i="32" a="0.4288668" t="0.3405139" q1="0.3990617" q3="0.4584927" b="0.510493" />
<p i="33" a="0.4486645" t="0.3399216" q1="0.3768052" q3="0.4927478" b="0.6131166" />
<p i="34" a="0.5491127" t="0.4603948" q1="0.5046994" q3="0.5829318" b="0.6156749" />
<p i="35" a="0.445548" t="0.3924371" q1="0.4232025" q3="0.4663015" b="0.5036352" />
<p i="36" a="0.4410918" t="0.2896549" q1="0.3717791" q3="0.4967265" b="0.5243942" />
<p i="37" a="0.2045427" t="0.1225566" q1="0.166112" q3="0.224334" b="0.3150007" />
<p i="38" a="0.1602285" t="0.1241103" q1="0.1412647" q3="0.1832055" b="0.2080172" />
<p i="39" a="0.1164869" t="0.0900425" q1="0.104729" q3="0.126807" b="0.1515958" />
<p i="40" a="0.1020375" t="0.070514" q1="0.0902267" q3="0.1155001" b="0.1499804" />
<p i="41" a="0.1479687" t="0.1001502" q1="0.1299828" q3="0.165246" b="0.1991625" />
<p i="42" a="0.2706855" t="0.1668984" q1="0.2142402" q3="0.3244666" b="0.3540547" />
<p i="43" a="0.2934688" t="0.2167249" q1="0.2474869" q3="0.329283" b="0.3643437" />
<p i="44" a="0.2566847" t="0.1799146" q1="0.2066188" q3="0.2893716" b="0.3974214" />
<p i="45" a="0.4303656" t="0.3483182" q1="0.3922838" q3="0.4633503" b="0.4986081" />
<p i="46" a="0.5507027" t="0.4273419" q1="0.5250649" q3="0.5843853" b="0.656902" />
<p i="47" a="0.65989" t="0.6187698" q1="0.6408518" q3="0.6711503" b="0.7051849" />
<p i="48" a="0.6632802" t="0.5683934" q1="0.6394056" q3="0.6849766" b="0.7284272" />
<p i="49" a="0.7075305" t="0.6145118" q1="0.6762832" q3="0.7170584" b="0.8346354" />
<p i="50" a="0.7034747" t="0.5740441" q1="0.6330607" q3="0.7630359" b="0.833968" />
<p i="51" a="0.7962198" t="0.6355923" q1="0.7573773" q3="0.8525092" b="0.8759947" />
<p i="52" a="0.8322106" t="0.7688553" q1="0.8170811" q3="0.852551" b="0.8844461" />
<p i="53" a="0.8617469" t="0.8193306" q1="0.8474206" q3="0.8691666" b="0.9056094" />
<p i="54" a="0.8867643" t="0.8509751" q1="0.8743553" q3="0.8965004" b="0.9206217" />
<p i="55" a="0.8931555" t="0.8652616" q1="0.8781378" q3="0.9038765" b="0.9205441" />
<p i="56" a="0.8311759" t="0.7743251" q1="0.8058314" q3="0.8601481" b="0.8897824" />
<p i="57" a="0.7210512" t="0.631641" q1="0.6684789" q3="0.777827" b="0.8061577" />
<p i="58" a="0.593014" t="0.5241551" q1="0.5725055" q3="0.6150998" b="0.6488905" />
<p i="59" a="0.5929104" t="0.4520841" q1="0.5599052" q3="0.633489" b="0.6693129" />
<p i="60" a="0.458043" t="0.3952686" q1="0.4344383" q3="0.4786311" b="0.5324733" />
<p i="61" a="0.2742826" t="0.2000865" q1="0.2354428" q3="0.2810014" b="0.419568" />
<p i="62" a="0.1977044" t="0.1222464" q1="0.1569235" q3="0.2412545" b="0.2851439" />
<p i="63" a="0.164579" t="0.095269" q1="0.1215675" q3="0.1817611" b="0.2953628" />
<p i="64" a="0.2179123" t="0.1708544" q1="0.1929989" q3="0.2350558" b="0.3144171" />
<p i="65" a="0.3237726" t="0.2329979" q1="0.2929868" q3="0.3499236" b="0.3855945" />
<p i="66" a="0.4010124" t="0.3353604" q1="0.3598247" q3="0.4413979" b="0.4878046" />
<p i="67" a="0.4270307" t="0.2613242" q1="0.3956122" q3="0.4783027" b="0.5192189" />
<p i="68" a="0.2832886" t="0.2387974" q1="0.2635758" q3="0.2940729" b="0.3779906" />
<p i="69" a="0.2054696" t="0.1632785" q1="0.1862253" q3="0.215787" b="0.2947901" />
<p i="70" a="0.2451738" t="0.1545663" q1="0.1856153" q3="0.2909323" b="0.4289676" />
<p i="71" a="0.4016833" t="0.2991427" q1="0.3846257" q3="0.4262931" b="0.4494574" />
<p i="72" a="0.4518348" t="0.3573902" q1="0.3961548" q3="0.5107563" b="0.5379515" />
<p i="73" a="0.5615175" t="0.4165677" q1="0.4570363" q3="0.6412498" b="0.6837521" />
<p i="74" a="0.6305212" t="0.5029782" q1="0.6200504" q3="0.6534793" b="0.688924" />
<p i="75" a="0.4810682" t="0.3403958" q1="0.3750698" q3="0.5757532" b="0.6144605" />
<p i="76" a="0.3435393" t="0.2890727" q1="0.323681" q3="0.3604915" b="0.4092448" />
<p i="77" a="0.3867674" t="0.3333937" q1="0.3528283" q3="0.4188396" b="0.4468819" />
<p i="78" a="0.4493092" t="0.3279172" q1="0.4117079" q3="0.4878548" b="0.5234459" />
<p i="79" a="0.4451673" t="0.3742765" q1="0.4063533" q3="0.4939424" b="0.542586" />
<p i="80" a="0.4154453" t="0.3713473" q1="0.4019039" q3="0.4278263" b="0.4511889" />
<p i="81" a="0.3431576" t="0.2709649" q1="0.3255479" q3="0.3596964" b="0.4252758" />
<p i="82" a="0.22759" t="0.1853156" q1="0.2016677" q3="0.2445466" b="0.3104194" />
<p i="83" a="0.2095572" t="0.1551295" q1="0.1966647" q3="0.2259816" b="0.2523288" />
<p i="84" a="0.1522068" t="0.0925635" q1="0.1269344" q3="0.1806089" b="0.2187736" />
<p i="85" a="0.1148637" t="0.0727368" q1="0.0951994" q3="0.1389804" b="0.1718777" />
<p i="86" a="0.1776565" t="0.1426265" q1="0.1662971" q3="0.1877007" b="0.227984" />
<p i="87" a="0.2269424" t="0.1513565" q1="0.1962024" q3="0.2589408" b="0.3123956" />
<p i="88" a="0.1797446" t="0.1068381" q1="0.1355556" q3="0.2244378" b="0.2585256" />
<p i="89" a="0.2581688" t="0.1588446" q1="0.1910821" q3="0.3113448" b="0.393546" />
<p i="90" a="0.5462327" t="0.3632168" q1="0.5275255" q3="0.5889421" b="0.6450237" />
<p i="91" a="0.5039586" t="0.4111858" q1="0.458997" q3="0.5423747" b="0.6157657" />
<p i="92" a="0.4084841" t="0.3252089" q1="0.3508787" q3="0.4614915" b="0.5310841" />
<p i="93" a="0.4090701" t="0.3205382" q1="0.3834516" q3="0.4362433" b="0.5008716" />
<p i="94" a="0.5028877" t="0.3538544" q1="0.418191" q3="0.5697672" b="0.6313665" />
<p i="95" a="0.6314342" t="0.5780762" q1="0.609446" q3="0.6560658" b="0.6839286" />
<p i="96" a="0.5866321" t="0.5149268" q1="0.5636512" q3="0.6080014" b="0.6458334" />
<p i="97" a="0.6591204" t="0.6055519" q1="0.6421536" q3="0.6738248" b="0.702375" />
<p i="98" a="0.7182886" t="0.6427657" q1="0.6872714" q3="0.749985" b="0.7751585" />
<p i="99" a="0.690192" t="0.6329679" q1="0.6560227" q3="0.7210688" b="0.7601627" />
<p i="100" a="0.6679664" t="0.6262514" q1="0.6455656" q3="0.6878113" b="0.7352634" />
<p i="101" a="0.7310813" t="0.659668" q1="0.714317" q3="0.7551546" b="0.7719816" />
<p i="102" a="0.4822624" t="0.4012146" q1="0.4332166" q3="0.5197373" b="0.6621136" />
<p i="103" a="0.4310824" t="0.3706054" q1="0.3952886" q3="0.455877" b="0.5347801" />
<p i="104" a="0.6469288" t="0.4507327" q1="0.5958428" q3="0.7142986" b="0.7410111" />
<p i="105" a="0.6431782" t="0.5326778" q1="0.5907856" q3="0.673673" b="0.7341167" />
<p i="106" a="0.5138542" t="0.4713418" q1="0.4975144" q3="0.5300372" b="0.5544673" />
<p i="107" a="0.4776092" t="0.4281904" q1="0.4565569" q3="0.490704" b="0.5431405" />
<p i="108" a="0.4788317" t="0.3841793" q1="0.4483746" q3="0.5041672" b="0.5400685" />
<p i="109" a="0.52656" t="0.4500254" q1="0.4943835" q3="0.5392076" b="0.6424539" />
<p i="110" a="0.6194037" t="0.5302768" q1="0.5979013" q3="0.6334265" b="0.6938426" />
<p i="111" a="0.5176518" t="0.3923426" q1="0.4381981" q3="0.6156161" b="0.6642058" />
<p i="112" a="0.4244887" t="0.3680471" q1="0.4114965" q3="0.4364656" b="0.4673468" />
<p i="113" a="0.4020363" t="0.2854375" q1="0.3735406" q3="0.4411381" b="0.4815874" />
<p i="114" a="0.3644337" t="0.2992482" q1="0.3299844" q3="0.3982823" b="0.446173" />
<p i="115" a="0.2335516" t="0.1285412" q1="0.1596765" q3="0.3105084" b="0.3724308" />
<p i="116" a="0.2420054" t="0.143715" q1="0.1752597" q3="0.3127334" b="0.3789273" />
<p i="117" a="0.4745568" t="0.3355055" q1="0.4167602" q3="0.5208639" b="0.6593643" />
<p i="118" a="0.5230108" t="0.3453704" q1="0.4102814" q3="0.6163941" b="0.665356" />
<p i="119" a="0.4167766" t="0.331393" q1="0.3729722" q3="0.4588849" b="0.4853997" />
<p i="120" a="0.5970017" t="0.3988532" q1="0.5577893" q3="0.6468691" b="0.7120425" />
<p i="121" a="0.7625228" t="0.6872938" q1="0.7464864" q3="0.7835977" b="0.8067926" />
<p i="122" a="0.7801027" t="0.7248457" q1="0.7728024" q3="0.7872342" b="0.8018412" />
<p i="123" a="0.7465951" t="0.6579602" q1="0.7306818" q3="0.7701532" b="0.7956052" />
<p i="124" a="0.726986" t="0.6525274" q1="0.6921205" q3="0.7505439" b="0.7925335" />
<p i="125" a="0.7553443" t="0.6750498" q1="0.7328885" q3="0.7812999" b="0.8027814" />
<p i="126" a="0.7652274" t="0.7227449" q1="0.740179" q3="0.7863982" b="0.807645" />
<p i="127" a="0.7596645" t="0.6892555" q1="0.7352402" q3="0.7934324" b="0.8227688" />
<p i="128" a="0.7176376" t="0.6699622" q1="0.6963467" q3="0.7305488" b="0.7861386" />
<p i="129" a="0.7392964" t="0.6796345" q1="0.713491" q3="0.7547463" b="0.7790282" />
<p i="130" a="0.7039328" t="0.6614332" q1="0.6824349" q3="0.715659" b="0.7638107" />
<p i="131" a="0.7810442" t="0.7103803" q1="0.7645349" q3="0.793715" b="0.8223216" />
<p i="132" a="0.7930985" t="0.7214839" q1="0.7712734" q3="0.8115046" b="0.8388347" />
<p i="133" a="0.7037351" t="0.6344293" q1="0.670246" q3="0.7280462" b="0.788657" />
<p i="134" a="0.7058809" t="0.630104" q1="0.6771643" q3="0.7343909" b="0.7705792" />
<p i="135" a="0.6834948" t="0.5702686" q1="0.6414368" q3="0.7300433" b="0.7687682" />
<p i="136" a="0.5036767" t="0.3523702" q1="0.4386286" q3="0.5792143" b="0.6268564" />
<p i="137" a="0.3961245" t="0.2684898" q1="0.306379" q3="0.4546778" b="0.5571623" />
<p i="138" a="0.3218969" t="0.2753845" q1="0.2947784" q3="0.3459865" b="0.4029276" />
<p i="139" a="0.2370813" t="0.1616281" q1="0.203969" q3="0.2682632" b="0.324768" />
<p i="140" a="0.3303451" t="0.2703551" q1="0.3151039" q3="0.3436997" b="0.3886683" />
<p i="141" a="0.2398557" t="0.1429257" q1="0.1827712" q3="0.2927831" b="0.361375" />
<p i="142" a="0.156017" t="0.0765781" q1="0.1155045" q3="0.1882167" b="0.2353377" />
<p i="143" a="0.193029" t="0.1087088" q1="0.1672243" q3="0.2151678" b="0.2736864" />
<p i="144" a="0.162801" t="0.1135846" q1="0.1431095" q3="0.1817005" b="0.2051384" />
<p i="145" a="0.3155068" t="0.1986204" q1="0.2524926" q3="0.3691308" b="0.4434117" />
<p i="146" a="0.5247421" t="0.3989731" q1="0.4969189" q3="0.5655366" b="0.6089923" />
<p i="147" a="0.5151146" t="0.4344804" q1="0.4931677" q3="0.5388025" b="0.5668612" />
<p i="148" a="0.6553473" t="0.4515674" q1="0.5909291" q3="0.7157774" b="0.7773974" />
<p i="149" a="0.7262117" t="0.6285476" q1="0.712498" q3="0.7437055" b="0.7923845" />
<p i="150" a="0.7266481" t="0.607162" q1="0.6804811" q3="0.7649299" b="0.8135546" />
<p i="151" a="0.6469674" t="0.586827" q1="0.6237284" q3="0.6648387" b="0.6886878" />
<p i="152" a="0.5667542" t="0.4901428" q1="0.5184835" q3="0.6064867" b="0.6723435" />
<p i="153" a="0.5686977" t="0.5207827" q1="0.5495287" q3="0.5819933" b="0.6300352" />
<p i="154" a="0.6299676" t="0.5585058" q1="0.6046594" q3="0.6539755" b="0.6940803" />
<p i="155" a="0.6498728" t="0.5988096" q1="0.6312697" q3="0.6670327" b="0.7001823" />
<p i="156" a="0.7207086" t="0.6505244" q1="0.6861456" q3="0.7490389" b="0.767324" />
<p i="157" a="0.7875564" t="0.7149532" q1="0.7663946" q3="0.8072398" b="0.8384279" />
<p i="158" a="0.7684937" t="0.7229704" q1="0.7479088" q3="0.7790881" b="0.8109916" />
<p i="159" a="0.8087602" t="0.7802456" q1="0.7952233" q3="0.817318" b="0.8357308" />
<p i="160" a="0.8735045" t="0.8075069" q1="0.8506378" q3="0.8972003" b="0.9131213" />
<p i="161" a="0.9037751" t="0.8553372" q1="0.8949031" q3="0.9093337" b="0.9195545" />
<p i="162" a="0.8374965" t="0.7535663" q1="0.8016818" q3="0.8754237" b="0.8904833" />
<p i="163" a="0.7068686" t="0.6162453" q1="0.6550248" q3="0.7529313" b="0.8146995" />
<p i="164" a="0.6896862" t="0.5100008" q1="0.6207197" q3="0.7622182" b="0.7982519" />
<p i="165" a="0.6379571" t="0.5201558" q1="0.6003205" q3="0.6664519" b="0.7475419" />
<p i="166" a="0.7556234" t="0.6297016" q1="0.6799906" q3="0.8225796" b="0.9078581" />
<p i="167" a="0.7518073" t="0.7023283" q1="0.7315853" q3="0.7686188" b="0.807279" />
<p i="168" a="0.6547651" t="0.5325963" q1="0.5878728" q3="0.7428698" b="0.7716193" />
<p i="169" a="0.5853461" t="0.4784424" q1="0.5345147" q3="0.6301092" b="0.6875215" />
<p i="170" a="0.4934432" t="0.4173939" q1="0.4651061" q3="0.5165625" b="0.5647583" />
<p i="171" a="0.4039803" t="0.2707879" q1="0.3338606" q3="0.455224" b="0.9246368" />
<p i="172" a="0.3844845" t="0.2694066" q1="0.3340026" q3="0.433134" b="0.4927081" />
<p i="173" a="0.2764443" t="0.2101363" q1="0.2443318" q3="0.2818089" b="0.4168335" />
<p i="174" a="0.2908887" t="0.231938" q1="0.2673629" q3="0.3154697" b="0.3425476" />
<p i="175" a="0.2490935" t="0.181918" q1="0.2279293" q3="0.2663654" b="0.3180617" />
<p i="176" a="0.2914643" t="0.2182207" q1="0.2484497" q3="0.3138084" b="0.4530171" />
<p i="177" a="0.5141028" t="0.3814218" q1="0.4787447" q3="0.5613344" b="0.6174607" />
<p i="178" a="0.4717435" t="0.3776221" q1="0.4553277" q3="0.4938675" b="0.5227143" />
<p i="179" a="0.6708187" t="0.4789116" q1="0.6044189" q3="0.7453133" b="0.7905036" />
<p i="180" a="0.7052112" t="0.5809859" q1="0.6788763" q3="0.7306341" b="0.8033962" />
<p i="181" a="0.500477" t="0.3992239" q1="0.4596529" q3="0.5280274" b="0.6003713" />
<p i="182" a="0.498347" t="0.438504" q1="0.465969" q3="0.5248337" b="0.5924911" />
<p i="183" a="0.6049814" t="0.5144103" q1="0.5700767" q3="0.6323238" b="0.6657227" />
<p i="184" a="0.6538701" t="0.5901732" q1="0.6361966" q3="0.6717707" b="0.6878106" />
<p i="185" a="0.6887088" t="0.6167619" q1="0.6728461" q3="0.7084139" b="0.7283666" />
<p i="186" a="0.7167272" t="0.6118092" q1="0.6960725" q3="0.7454897" b="0.7887078" />
<p i="187" a="0.6075215" t="0.4931078" q1="0.5930632" q3="0.630259" b="0.6459918" />
<p i="188" a="0.4608407" t="0.3811115" q1="0.4313002" q3="0.4950578" b="0.5315361" />
<p i="189" a="0.3398377" t="0.2423202" q1="0.2850001" q3="0.3840129" b="0.4614407" />
<p i="190" a="0.2873769" t="0.2345628" q1="0.2741878" q3="0.3028785" b="0.3351025" />
<p i="191" a="0.3837225" t="0.2871784" q1="0.3212333" q3="0.4458072" b="0.5076809" />
<p i="192" a="0.4511031" t="0.3980055" q1="0.4274028" q3="0.4698606" b="0.5124198" />
<p i="193" a="0.4790579" t="0.3907286" q1="0.4212605" q3="0.5551384" b="0.6066259" />
<p i="194" a="0.4651081" t="0.3792079" q1="0.4307003" q3="0.4943166" b="0.5880876" />
<p i="195" a="0.5077488" t="0.4558109" q1="0.483125" q3="0.5254182" b="0.5644792" />
<p i="196" a="0.5036666" t="0.4137088" q1="0.4689124" q3="0.536112" b="0.5578916" />
<p i="197" a="0.459471" t="0.4047446" q1="0.4396476" q3="0.4774408" b="0.5134909" />
<p i="198" a="0.359034" t="0.3081708" q1="0.3430546" q3="0.3710444" b="0.4128142" />
<p i="199" a="0.2877349" t="0.1569471" q1="0.2176492" q3="0.3364013" b="0.4381539" />
<p i="200" a="0.2143417" t="0.132332" q1="0.1809578" q3="0.2424813" b="0.2754989" />
<p i="201" a="0.20877" t="0.1392623" q1="0.1868088" q3="0.2269216" b="0.2602526" />
<p i="202" a="0.1848814" t="0.140448" q1="0.1627849" q3="0.2077435" b="0.2512242" />
<p i="203" a="0.2273566" t="0.1135524" q1="0.1445325" q3="0.317209" b="0.4241223" />
<p i="204" a="0.4090226" t="0.3575516" q1="0.3940958" q3="0.4225218" b="0.4557156" />
<p i="205" a="0.4630707" t="0.3690079" q1="0.4439829" q3="0.4880128" b="0.5177968" />
<p i="206" a="0.4663841" t="0.3738545" q1="0.4201365" q3="0.5196501" b="0.5777537" />
<p i="207" a="0.5441595" t="0.4684181" q1="0.4990322" q3="0.5807005" b="0.6134171" />
<p i="208" a="0.4648161" t="0.4199639" q1="0.4507474" q3="0.4778691" b="0.5021131" />
<p i="209" a="0.4395122" t="0.3401505" q1="0.4018151" q3="0.4732404" b="0.5210086" />
<p i="210" a="0.4668594" t="0.3480829" q1="0.4259746" q3="0.5165709" b="0.554682" />
<p i="211" a="0.5925342" t="0.5168133" q1="0.5757627" q3="0.6098787" b="0.6431382" />
<p i="212" a="0.5226171" t="0.4599938" q1="0.4943561" q3="0.5363035" b="0.6029193" />
<p i="213" a="0.4531814" t="0.390346" q1="0.4385474" q3="0.4703611" b="0.5030589" />
<p i="214" a="0.3603087" t="0.300254" q1="0.3486401" q3="0.3732175" b="0.437032" />
<p i="215" a="0.3164811" t="0.2574601" q1="0.289755" q3="0.3447064" b="0.3955994" />
<p i="216" a="0.4765312" t="0.3758125" q1="0.4166221" q3="0.5158102" b="0.6693662" />
<p i="217" a="0.705533" t="0.6341328" q1="0.6645844" q3="0.7403586" b="0.7641137" />
<p i="218" a="0.7798313" t="0.6913602" q1="0.7533318" q3="0.8021918" b="0.8286449" />
<p i="219" a="0.8389995" t="0.7881723" q1="0.8152887" q3="0.8702189" b="0.9027475" />
<p i="220" a="0.8654444" t="0.8301356" q1="0.8498227" q3="0.8766905" b="0.8975748" />
<p i="221" a="0.8809017" t="0.8305329" q1="0.8645489" q3="0.892165" b="0.9156268" />
<p i="222" a="0.8423646" t="0.752778" q1="0.786496" q3="0.8826061" b="0.9025374" />
<p i="223" a="0.7504831" t="0.7130266" q1="0.7387296" q3="0.7581348" b="0.7777119" />
<p i="224" a="0.7926443" t="0.7378615" q1="0.7623857" q3="0.8122759" b="0.8313966" />
<p i="225" a="0.8074645" t="0.7502305" q1="0.7825882" q3="0.8260093" b="0.8425765" />
<p i="226" a="0.8103274" t="0.7546505" q1="0.7956449" q3="0.8239172" b="0.8440642" />
<p i="227" a="0.7321065" t="0.4575985" q1="0.6521949" q3="0.8332045" b="0.864985" />
<p i="228" a="0.4764254" t="0.393243" q1="0.4533382" q3="0.5010868" b="0.540578" />
<p i="229" a="0.4561654" t="0.3924409" q1="0.431347" q3="0.4733991" b="0.5528143" />
<p i="230" a="0.5139171" t="0.4044615" q1="0.5047757" q3="0.5334722" b="0.5737043" />
<p i="231" a="0.2877753" t="0.1955059" q1="0.2265084" q3="0.369706" b="0.4197904" />
<p i="232" a="0.3088691" t="0.1774717" q1="0.2553879" q3="0.3316865" b="0.5117145" />
<p i="233" a="0.3475984" t="0.169552" q1="0.2778263" q3="0.4252683" b="0.5015257" />
<p i="234" a="0.1202728" t="0.0655684" q1="0.0971785" q3="0.1492895" b="0.2009686" />
<p i="235" a="0.0892676" t="0.0615849" q1="0.0759809" q3="0.1005921" b="0.1341375" />
<p i="236" a="0.0711017" t="0.0442165" q1="0.0593369" q3="0.0776012" b="0.1163808" />
<p i="237" a="0.135949" t="0.0628576" q1="0.0909327" q3="0.187865" b="0.2307446" />
<p i="238" a="0.1738782" t="0.1251293" q1="0.1398257" q3="0.2026933" b="0.2588275" />
<p i="239" a="0.1246117" t="0.0777162" q1="0.1143564" q3="0.1377024" b="0.1576823" />
<p i="240" a="0.1445929" t="0.0932164" q1="0.1256298" q3="0.1620403" b="0.1851632" />
<p i="241" a="0.1680874" t="0.114611" q1="0.1427107" q3="0.1832333" b="0.2798543" />
<p i="242" a="0.5020675" t="0.2758066" q1="0.3913637" q3="0.58921" b="0.6320385" />
<p i="243" a="0.681435" t="0.6005248" q1="0.6378965" q3="0.7069126" b="0.7411687" />
<p i="244" a="0.7207625" t="0.6530563" q1="0.6786522" q3="0.7537308" b="0.7813054" />
<p i="245" a="0.7058097" t="0.6126205" q1="0.677362" q3="0.7559235" b="0.78136" />
<p i="246" a="0.5445093" t="0.4638795" q1="0.5095393" q3="0.5811966" b="0.6218271" />
<p i="247" a="0.5002" t="0.4104928" q1="0.4621136" q3="0.5229565" b="0.6024301" />
<p i="248" a="0.5126066" t="0.4337322" q1="0.4933878" q3="0.5254693" b="0.5633333" />
<p i="249" a="0.4275489" t="0.3654746" q1="0.4107212" q3="0.4422831" b="0.4745908" />
<p i="250" a="0.5056099" t="0.4398975" q1="0.478978" q3="0.5255232" b="0.5699595" />
<p i="251" a="0.4777069" t="0.3963358" q1="0.4513786" q3="0.5020311" b="0.5462177" />
<p i="252" a="0.5233719" t="0.4556525" q1="0.4891468" q3="0.5543998" b="0.6118975" />
<p i="253" a="0.4534511" t="0.3982657" q1="0.4267365" q3="0.4664501" b="0.5298573" />
<p i="254" a="0.4370729" t="0.3428516" q1="0.3943438" q3="0.4740802" b="0.5180574" />
<p i="255" a="0.332651" t="0.2711506" q1="0.3124728" q3="0.3433261" b="0.4190092" />
<p i="256" a="0.3052843" t="0.2161336" q1="0.2570194" q3="0.340848" b="0.4256815" />
<p i="257" a="0.277472" t="0.1333124" q1="0.2187029" q3="0.3307732" b="0.3909361" />
<p i="258" a="0.1069099" t="0.0651258" q1="0.0912538" q3="0.1275184" b="0.1429757" />
<p i="259" a="0.139654" t="0.1061703" q1="0.1241759" q3="0.1509368" b="0.1788373" />
<p i="260" a="0.1655789" t="0.120603" q1="0.1470449" q3="0.1837065" b="0.2156779" />
<p i="261" a="0.1769343" t="0.1264341" q1="0.1538501" q3="0.1987602" b="0.2216696" />
<p i="262" a="0.1735682" t="0.1217218" q1="0.1431066" q3="0.1968453" b="0.2521888" />
<p i="263" a="0.2224647" t="0.1627354" q1="0.1842444" q3="0.2724889" b="0.3026837" />
<p i="264" a="0.1799655" t="0.0907888" q1="0.1258345" q3="0.2241992" b="0.2860332" />
<p i="265" a="0.1282247" t="0.0659868" q1="0.0934552" q3="0.1390614" b="0.2617494" />
<p i="266" a="0.2477919" t="0.1608411" q1="0.2044211" q3="0.2915335" b="0.3355055" />
<p i="267" a="0.381251" t="0.2839867" q1="0.3281722" q3="0.419568" b="0.4814842" />
<p i="268" a="0.3559526" t="0.274447" q1="0.3277832" q3="0.3797933" b="0.4439608" />
<p i="269" a="0.5483661" t="0.420413" q1="0.5028936" q3="0.5852121" b="0.6674967" />
<p i="270" a="0.7587429" t="0.6464636" q1="0.7418256" q3="0.7792949" b="0.8140356" />
<p i="271" a="0.6752149" t="0.5914348" q1="0.6552754" q3="0.7096404" b="0.7484444" />
<p i="272" a="0.5426948" t="0.4536335" q1="0.5073125" q3="0.5948326" b="0.6396376" />
<p i="273" a="0.4844687" t="0.4224863" q1="0.4684467" q3="0.4978634" b="0.5465939" />
<p i="274" a="0.5039515" t="0.4471371" q1="0.4855016" q3="0.5226207" b="0.5603069" />
<p i="275" a="0.4902456" t="0.4289217" q1="0.4633371" q3="0.5110029" b="0.5644848" />
<p i="276" a="0.6810007" t="0.5640969" q1="0.6549486" q3="0.7107136" b="0.7317891" />
<p i="277" a="0.6158856" t="0.5747126" q1="0.6028198" q3="0.6266491" b="0.6676662" />
<p i="278" a="0.7137599" t="0.619923" q1="0.7005357" q3="0.7387181" b="0.75989" />
<p i="279" a="0.6958994" t="0.6469085" q1="0.6781352" q3="0.7085654" b="0.75989" />
<p i="280" a="0.7604926" t="0.7100883" q1="0.7303658" q3="0.7833313" b="0.8282333" />
<p i="281" a="0.7790305" t="0.704392" q1="0.7495888" q3="0.7989525" b="0.8377369" />
<p i="282" a="0.7606242" t="0.6696953" q1="0.7278203" q3="0.7922398" b="0.8403262" />
<p i="283" a="0.7580269" t="0.6764818" q1="0.7211859" q3="0.7930769" b="0.8211891" />
<p i="284" a="0.7426446" t="0.6019338" q1="0.6618317" q3="0.7931586" b="0.8129608" />
<p i="285" a="0.7668892" t="0.6295663" q1="0.7287004" q3="0.7838616" b="0.9179306" />
<p i="286" a="0.9348083" t="0.7993459" q1="0.917406" q3="0.9541976" b="0.9617215" />
<p i="287" a="0.9571159" t="0.9356509" q1="0.9478738" q3="0.9625828" b="0.9691567" />
<p i="288" a="0.9437484" t="0.9251648" q1="0.9375318" q3="0.9448087" b="0.9511477" />
<p i="289" a="0.9391244" t="0.9169591" q1="0.9279701" q3="0.9440877" b="0.9554317" />
<p i="290" a="0.9442234" t="0.9265175" q1="0.9368977" q3="0.9460096" b="0.9535787" />
<p i="291" a="0.9419906" t="0.9124068" q1="0.9263189" q3="0.9509239" b="0.960173" />
<p i="292" a="0.638099" t="0.4754606" q1="0.5977365" q3="0.673827" b="0.9142743" />
<p i="293" a="0.5735857" t="0.393868" q1="0.4547038" q3="0.5663013" b="0.9175683" />
<p i="294" a="0.3003233" t="0.2041572" q1="0.2299656" q3="0.3968063" b="0.4660459" />
<p i="295" a="0.2864624" t="0.1932411" q1="0.2467547" q3="0.3197682" b="0.3910262" />
<p i="296" a="0.3457859" t="0.2889007" q1="0.3204461" q3="0.3647556" b="0.4189895" />
<p i="297" a="0.4250023" t="0.3319452" q1="0.4111675" q3="0.4430134" b="0.499066" />
<p i="298" a="0.4075606" t="0.3218374" q1="0.3804007" q3="0.434938" b="0.4834933" />
<p i="299" a="0.4742621" t="0.3962724" q1="0.4402288" q3="0.500834" b="0.5631659" />
<p i="300" a="0.2712836" t="0.1497074" q1="0.1868428" q3="0.3562014" b="0.4574004" />
<p i="301" a="0.197404" t="0.126636" q1="0.1533281" q3="0.2430316" b="0.2787687" />
<p i="302" a="0.1691023" t="0.1258441" q1="0.1508988" q3="0.1818286" b="0.244157" />
<p i="303" a="0.155343" t="0.1013868" q1="0.1290621" q3="0.1772147" b="0.2366851" />
<p i="304" a="0.2413641" t="0.178146" q1="0.2186273" q3="0.2593321" b="0.318623" />
<p i="305" a="0.1752785" t="0.0784255" q1="0.155069" q3="0.1993447" b="0.2247504" />
<p i="306" a="0.0699652" t="0.0496246" q1="0.0624624" q3="0.0765884" b="0.1001268" />
<p i="307" a="0.0883711" t="0.0567063" q1="0.0714608" q3="0.0996689" b="0.1316195" />
<p i="308" a="0.1147742" t="0.0809203" q1="0.0965901" q3="0.1362519" b="0.1746549" />
<p i="309" a="0.1122873" t="0.0710593" q1="0.0934072" q3="0.1318093" b="0.1471368" />
<p i="310" a="0.056778" t="0.037921" q1="0.0493637" q3="0.0634359" b="0.0830157" />
<p i="311" a="0.0230635" t="0.0073648" q1="0.0122488" q3="0.0371463" b="0.0505572" />
<p i="312" a="0.0152984" t="0.0077597" q1="0.0119964" q3="0.0186959" b="0.0229456" />
<p i="313" a="0.030499" t="0.0119008" q1="0.027741" q3="0.0363389" b="0.0435861" />
<p i="314" a="0.0269086" t="0.0143632" q1="0.0218882" q3="0.0294004" b="0.0497095" />
<p i="315" a="0.017646" t="0.0067159" q1="0.0098118" q3="0.0276892" b="0.0465586" />
<p i="316" a="0.0049861" t="0.0023357" q1="0.0035796" q3="0.0065807" b="0.0082659" />
<p i="317" a="0.0039682" t="0.0022371" q1="0.0031233" q3="0.0047004" b="0.0068012" />
<p i="318" a="0.0012005" t="0.0003172" q1="0.0005918" q3="0.0013835" b="0.0040322" />
<p i="319" a="0.0010232" t="0.0003369" q1="0.0004577" q3="0.0013836" b="0.0025945" />
<p i="320" a="0.0042725" t="0.0018477" q1="0.0035197" q3="0.0051069" b="0.0065147" />
<p i="321" a="0.0079969" t="0.0041742" q1="0.0057444" q3="0.0095961" b="0.0146928" />
<p i="322" a="0.0095969" t="0.005152" q1="0.0070395" q3="0.0119823" b="0.0151872" />
<p i="323" a="0.031558" t="0.0112083" q1="0.019363" q3="0.0430968" b="0.0500389" />
<p i="324" a="0.0426571" t="0.0295222" q1="0.0355925" q3="0.0481281" b="0.057694" />
<p i="325" a="0.0350221" t="0.0258868" q1="0.0319642" q3="0.0388609" b="0.0439084" />
<p i="326" a="0.0312865" t="0.0241235" q1="0.028302" q3="0.0332063" b="0.0421943" />
<p i="327" a="0.0533981" t="0.039177" q1="0.0454749" q3="0.0594402" b="0.082459" />
<p i="328" a="0.0325555" t="0.0182065" q1="0.0238299" q3="0.0407235" b="0.0596089" />
<p i="329" a="0.0653255" t="0.0293734" q1="0.0425784" q3="0.0875389" b="0.1122464" />
<p i="330" a="0.0312213" t="0.018018" q1="0.0229071" q3="0.0423181" b="0.0524488" />
<p i="331" a="0.0292884" t="0.010583" q1="0.0220181" q3="0.0356053" b="0.0449426" />
<p i="332" a="0.0155355" t="0.0113759" q1="0.0141983" q3="0.0169488" b="0.0189215" />
<p i="333" a="0.0156621" t="0.0093975" q1="0.0135684" q3="0.0180238" b="0.0237778" />
<p i="334" a="0.0143846" t="0.0079688" q1="0.0116858" q3="0.0166727" b="0.0206701" />
<p i="335" a="0.0261821" t="0.0158774" q1="0.0225788" q3="0.0300744" b="0.0343674" />
<p i="336" a="0.0314927" t="0.0200928" q1="0.0259035" q3="0.0361399" b="0.044626" />
<p i="337" a="0.0334053" t="0.0243669" q1="0.0307882" q3="0.0355336" b="0.0458184" />
<p i="338" a="0.0629056" t="0.0423594" q1="0.0492467" q3="0.0800911" b="0.087913" />
<p i="339" a="0.1196752" t="0.0812648" q1="0.1083892" q3="0.1327488" b="0.1571673" />
<p i="340" a="0.2185398" t="0.1368195" q1="0.1617898" q3="0.2582529" b="0.3452158" />
<p i="341" a="0.360352" t="0.3014668" q1="0.3402032" q3="0.3769314" b="0.4207658" />
<p i="342" a="0.4034521" t="0.3164661" q1="0.3924917" q3="0.4208048" b="0.4465156" />
<p i="343" a="0.4233433" t="0.3681211" q1="0.4106752" q3="0.4333839" b="0.4749718" />
<p i="344" a="0.5083658" t="0.4021108" q1="0.4597442" q3="0.5532568" b="0.5797509" />
<p i="345" a="0.6169222" t="0.5274059" q1="0.5928657" q3="0.6402296" b="0.6759976" />
<p i="346" a="0.6788211" t="0.6303776" q1="0.6621047" q3="0.6902525" b="0.7280128" />
<p i="347" a=".95" t="0.7144215" q1="0.7573417" q3="0.7972354" b="0.0020434" />
</chart>

''';

class GCPData {
  final List<double> dataA;
  final List<double> dataB;
  final List<double> dataQ1;
  final List<double> dataQ3;
  final List<double> dataT;

  double get value {
    if (dataA.isEmpty) {
      return -1;
    }

    return dataA.last;
  }

  GCPData(
      {required this.dataA,
      required this.dataB,
      required this.dataQ1,
      required this.dataQ3,
      required this.dataT});
}

final rng = Random();

@riverpod
Future<GCPData> getParsedGcpData(GetParsedGcpDataRef ref) async {
  print('--> getParsedGcpData!');
  const pixels = 348;
  const seconds = -86400;
  final nonce = rng.nextInt(9999999);
  // final result = await getGcpData(pixels, seconds, nonce);

  return compute(_parseHtml, test);
}

GCPData _parseHtml(String raw) {
  final document = parse(raw);

  final dots = document.getElementsByTagName('p');

  final dataA = <double>[];
  final dataB = <double>[];
  final dataQ1 = <double>[];
  final dataQ3 = <double>[];
  final dataT = <double>[];

  for (var dot in dots) {
    // final i = dot.attributes['i'] as String;
    final a = dot.attributes['a'] as String;
    final b = dot.attributes['b'] as String;
    final q1 = dot.attributes['q1'] as String;
    final q3 = dot.attributes['q3'] as String;
    final t = dot.attributes['t'] as String;

    dataA.add(double.parse(a));
    dataB.add(double.parse(b));
    dataQ1.add(double.parse(q1));
    dataQ3.add(double.parse(q3));
    dataT.add(double.parse(t));
  }

  return GCPData(
      dataA: dataA, dataB: dataB, dataQ1: dataQ1, dataQ3: dataQ3, dataT: dataT);
}