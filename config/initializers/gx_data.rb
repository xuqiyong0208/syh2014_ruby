$gxjp_projects = %q(田径,篮球,排球,足球,游泳,乒乓球,羽毛球,网球,射击,击剑,毽球,棒球,跆拳道,板球,高尔夫,健美操,武术,棋类,桥牌).split(",")

gxjp_str = <<EOF
1,上海体育学院,48,35,33,116,10,18,15,3,1,7,1,3,8,4,3,2,7,3,1,,,1,,,,,,,,,,,,,,,2,2,2,,,,13,6,4,,,,,,
2,上海交通大学,48,28,28,104,2,2,1,10,5,,23,18,12,,1,6,1,2,1,2,,2,,,,,,,,,,3,1,1,3,,,,,,,,,,,1,3,3,,1,
3,同济大学,34,32,27,93,4,1,3,,,7,12,17,15,,,,1,6,4,,,,,,,,,,,,,,,,,4,1,,,,3,1,5,4,3,,1,,,,1
4,华东师范大学,44,16,20,80,20,9,12,2,5,3,2,1,4,,,,,,,,,,,,,,,,,,,,,,,,,,,12,6,4,,,,,,,,,
5,复旦大学,40,14,18,72,2,4,2,5,18,,8,4,1,,2,,,,1,,,,1,1,4,,1,,,,,,2,,4,,,,,,,,1,1,3,2,1,3,1,,
6,上海大学,20,22,20,62,4,7,8,5,2,,4,1,2,3,1,1,,,,1,6,2,,,,,3,1,,,,,,,,,,1,1,,,,1,3,5,,,,,,
7,东华大学,30,16,12,58,1,2,,2,2,7,3,4,5,,,,,,,,,,4,4,2,,,,,,,2,4,3,5,,1,,,4,3,,,,,,,,,,
8,上海海事大学,15,19,14,48,,,,,,2,4,6,8,,,,,,,1,1,2,,,,,,,,2,,,,,,,,,,4,3,,4,7,4,,,,,,
9,上海财经大学,25,9,9,43,2,,,,,,2,1,2,,,,4,2,,4,1,2,,,,,,,,,,,,,,,,,1,1,,2,,,,12,5,2,,,
10,上海立信会计学院,15,11,16,42,,,,,,,4,4,,,,,,,,,,,,,,,,,,2,1,,11,5,12,,,,,,,,,,3,,,,,,
11,华东政法大学,14,5,14,33,,,,,,,,,,1,,1,,,2,1,,1,,,,,,,,,2,5,,2,1,,,,,,2,3,7,1,1,,,3,,,
12,华东理工大学,13,10,9,32,1,2,2,1,,,,1,1,3,4,,,,,,,1,1,1,,,,,,1,2,5,1,,2,,,,,,,,1,1,1,,,,,,
13,上海第二工业大学,12,7,5,24,,,1,,,,,,,3,,1,,,,,1,,,,,,,,5,,,,3,3,3,,,,,,,,1,3,,,,,,,
14,上海工程技术大学,12,5,6,23,2,1,1,6,,1,,,,,,,,,,2,,,,,,,,,,,,,1,4,4,,,,,,,1,,,,,,,,,
15,上海对外经贸大学,5,10,8,23,1,3,2,,,,2,3,3,,,,,,1,1,1,,,,,,,,,,,,1,2,1,,,,,,,,,,,,1,1,,,
16,上海师范大学,8,8,4,20,,1,1,,,,,,,,,,,,1,,,,,,,,,,,,,,2,1,1,,,1,,,1,1,6,4,,,,,,,
17,上海中医药大学,7,5,7,19,,,,,1,,,,,,,,,,1,,,,,,,,,,,,,,,,,,,,,,,,6,4,5,,1,1,,,
18,上海外国语大学,6,6,3,15,,,,,,,,,,,,,,,,,,,,,,,,,,,,3,,3,3,,,,,,,,,,,3,3,,,,
19,上海电力学院,5,4,6,15,,,,,,,,,,,1,1,,,,,,,,,,5,3,5,,,,,,,,,,,,,,,,,,,,,,,
20,上海应用技术学院,1,8,6,15,,1,,,,,,,,,,,,,,,,,,,,,,,,,,,,1,3,,,,,,,,1,6,3,,,,,,
21,上海理工大学,3,3,8,14,1,,3,,,,,,,,1,1,1,1,,,1,,,,,,,,,,,,1,,2,,,,,,,1,,,,,,1,,,
22,上海政法学院,8,2,3,13,1,,1,,,,,2,2,,,,,,,,,,,,,,,,,,,,,,,7,,,,,,,,,,,,,,,
23,上海海洋大学,7,2,4,13,1,,,,,,5,1,3,,,,,,,,1,,,,,,,,,,,,,,,,,,,1,,1,,,,,,,,,
24,上海金融学院,6,4,2,12,,,,,,,,,,,,,,,,,,,,,,6,4,2,,,,,,,,,,,,,,,,,,,,,,,
25,上海视觉艺术学院,2,4,4,10,1,,2,,,,1,4,2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
26,上海建桥学院,1,4,5,10,,2,1,,,,,,,,1,,,,,,,,,,,1,1,4,,,,,,,,,,,,,,,,,,,,,,,
27,上海医疗器械高等专科学校,6,,3,9,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,6,,,,,,,,,3,,,,,,
28,上海农林职业技术学院,1,2,5,8,1,,,,,,,,,,,1,,2,3,,,,,,,,,,,,,,,,1,,,,,,,,,,,,,,,,
29,上海思博职业技术学院,4,,,4,,,,,,4,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
30,上海师范大学天华学院,1,2,1,4,,,,,,,,,,,,,,,,,,,,,,,,,,,,,1,2,1,,,,,,,,,,,,,,,,
31,上海工会管理职业学院,1,1,1,3,1,1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,1,,,,,,
32,上海建峰职业技术学院,,2,,2,,,,,,,,,,,,,,2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
33,上海交通职业技术学院,1,,,1,,,,,,,,,,,,,1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
34,上海东海职业技术学院,,1,,1,,1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海戏剧学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海电机学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海商学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海杉达学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海海关学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上外贤达经济人文学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海民远职业技术学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
35,上海新侨职业技术学院,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
EOF

$gxjp_score = []
gxjp_str.split("\n").each do |line|
  arr = line.split(",", -1)[1..-1]
  $gxjp_score << arr
end


$gxzf_projects = %q(田径,篮球,排球,足球,游泳,乒乓球,羽毛球,网球,射击,击剑,毽球,棒球,跆拳道,板球,高尔夫,健美操,武术,棋类,桥牌).split(",")

gxzf_str = <<EOF
1,上海体育学院,1761.5,624.5,68,60,91,240,121,119,50,,,36,,,,116,,236,,
2,上海交通大学,1417,76,163,85,25,615,118,45,66,,,8,45,57,,,,,105,9
3,同济大学,1374,156,18,65,89,563,,130,13,,,,25,,76,37,24,151,19,8
4,上海大学,1236.5,415.5,55,39,30,123,59,9,103,,67,12,3,,,54,31,192,39,5
5,复旦大学,1169,144,85,198,25,231,23,32,13,86*,13,,35,101,25,13,,51,83,11
6,华东师范大学,1132,604,64,101,45,112,25,,24,,,,12,,,,121,,24,
7,东华大学,955.5,52,49,49,123,176,3,,,158,,,40,187.5,,42,62,,14,
8,上海海事大学,843,,35,30,40,341,12,,54,,,47,6,,,,66,190,15,7
9,上海财经大学,732,26,25,6,15,182,9,80,88,,,,30,,,28,34,,203,6
10,上海立信会计学院,673,,20,,,115,,24,19,,,57,,334,,,12,92,,
11,华东理工大学,663,115.5,32,37,12,25,113,,17,42*,,64,55,58.5,15,12,,65,,
12,华东政法大学,600,31,,37,50,,41,35,28,,,42,55,41,63,5,42,98,32,
13,上海对外经贸大学,542.5,161,39,15,6,148,9,21,33,,,,20,70.5,,3,,,17,
14,上海工程技术大学,430.5,51,118,20,32,,6,12,27,,,,,156.5,,,8,,,
15,上海海洋大学,398.5,103.5,12,35,9,177,,10,19,,,,9,,,,24,,,
16,上海第二工业大学,394.5,27,25,,20,,47,,13,,,87,,116.5,,,,45,14,
17,上海理工大学,327.5,143,,6,24,,20,23,20,,,,,56.5,,,8,,23,4
18,上海师范大学,304,28.5,6,3,30,,7,12,9,,,,,58.5,,32,9,109,,
19,上海应用技术学院,282,77,,,20,,11,4,,,,,,,,,,170,,
20,上海外国语大学,267,,3,9,,,,,,,,,45,94,20,,,30,66,
21,上海中医药大学,265,,,47,,,,18,,,,,,,,,,183,17,
22,上海金融学院,265,,15,,,,,,,,202,,,48,,,,,,
23,上海电力学院,251.5,4,,,,35,37,,4,,161,,,,10.5,,,,,
24,上海视觉艺术学院,235.5,73.5,12,,,68,,,,,,,,,,82,,,,
25,上海政法学院,199,35,,,,70,5,,,,,,,,89,,,,,
26,上海建桥学院,190.5,83.5,,,,,24,5,,,78,,,,,,,,,
27,上海医疗器械高等专科学校,160,,,,24,,,15,,,,,,,87,,,34,,
28,上海震旦职业技术学院,125.5,,,,,,,41,,,,,,84.5,,,,,,
29,上海农林职业技术学院,123,23,,,,,14,71,3,,,,,12,,,,,,
30,上外贤达经济人文学院,104,13,,,,,,,,,7,15,15,4.5,10.5,,,39,,
31,上海工会管理职业学院,80,51,,,16,,,,,,,,,,,,,13,,
32,上海师范大学天华学院,67.5,,,,,,,,,,,,,67.5,,,,,,
33,上海交通职业技术学院,60,,,,,,,6,,,,,,,54,,,,,
34,上海电机学院,60,25,,,,,6,,9,,,,,,,5,,,12,3
35,上海商学院,39,4,,,,,25,7,,,,,,,,,,3,,
36,上海东海职业技术学院,28,28,,,,,,,,,,,,,,,,,,
37,上海建峰职业技术学院,24,6,,,,,,18, ,,,,,,,,,,,
38,上海新侨职业技术学院,20,,,,20,,,,,,,,,,,,,,,
39,上海民远职业技术学院,19,12,,,,,,7,,,,,,,,,,,,
40,上海海关学院,10,,,,,7,,,,,,3,,,,,,,,
41,上海戏剧学院,0,,,,,,,,,,,,,,,,,,,
41,上海杉达学院,0,,,,,,,,,,,,,,,,,,,
EOF

$gxzf_score = []
gxzf_str.split("\n").each do |line|
  arr = line.split(",", -1)[1..-1]
  $gxzf_score << arr
end