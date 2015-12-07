# Dial Post Test- Data Preparation
<!-- for more options study http://rmarkdown.rstudio.com/html_document_format.html  -->
<!-- The report is produced from
REPOSITORY: the-name-of-the-repository
BRANCH: the-name-of-the-branch
PATH: ../Reports/
-->

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external script file. -->



```r
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(dplyr)
base::require(reshape2)
base::require(stringr)
base::require(stats)
base::require(ggplot2)
base::require(extrafont)
```


Load tagged data from Superlab

```r
# Link to the data source 
myExtract <- "./data/raw/Dial_PostTest_raw.csv"
pathSourceData <- paste0(myExtract) 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData
ds0
```

```
     Sub   Sent TotalRT SentPosition SentType Corectness Sent2 Char. RTbyChar Accuracy
1    s01 sent01    7481           24      Jar  Incorrect     1   120       62        0
2    s01 sent02    8528           11      Jar  Incorrect     2   138       62        0
3    s01 sent03    9806           30      Jar    Correct     3   114       86        1
4    s01 sent04    6323            3      Jar    Correct     4   113       56        1
5    s01 sent05    8141           28      Jar  Incorrect     5   127       64        0
6    s01 sent06    4397            1      Jar    Correct     6   130       34        1
7    s01 sent07    6333            6      Jar    Correct     7    96       66        1
8    s01 sent08    4622           32      Jar  Incorrect     8   107       43        0
9    s01 sent09    4299            4      Jar  Incorrect     9   113       38        0
10   s01 sent10    4977           31      Jar    Correct    10   109       46        1
11   s01 sent11    3825            9      Jar  Incorrect    11    98       39        0
12   s01 sent12    8409           12      Jar  Incorrect    12   133       63        0
13   s01 sent13    4785           19      Jar  Incorrect    13   130       37        0
14   s01 sent14   10529           20      Jar    Correct    14    94      112        1
15   s01 sent15    5141           10      Jar  Incorrect    15    92       56        0
16   s01 sent16    8412           16      Jar    Correct    16   135       62        1
17   s01 sent17    9348           18      Key    Correct    17   126       74        1
18   s01 sent18    4155           27      Key    Correct    18   128       32        1
19   s01 sent19   10231           22      Key    Correct    19    96      107        1
20   s01 sent20    7463           17      Key    Correct    20    93       80        1
21   s01 sent21    5089           25      Key    Correct    21    95       54        1
22   s01 sent22    7129           21      Key    Correct    22   140       51        1
23   s01 sent23    6268           14      Key  Incorrect    23    90       70        0
24   s01 sent24    7361           23      Key    Correct    24    71      104        1
25   s01 sent25    7171            8      Key    Correct    25   129       56        1
26   s01 sent26    3838           15      Key    Correct    26    65       59        1
27   s01 sent27    8057           29      Key    Correct    27   118       68        1
28   s01 sent28    4450           13      Key    Correct    28    87       51        1
29   s01 sent29      65            2      Key    Correct    29    87        1        1
30   s01 sent30    6306            5      Key    Correct    30   125       50        1
31   s01 sent31    6729            7      Key  Incorrect    31   118       57        0
32   s01 sent32    2514           26      Key    Correct    32    87       29        1
33   s10 sent01    7410            8      Jar  Incorrect     1   120       62        0
34   s10 sent02   12802            1      Jar  Incorrect     2   138       93        0
35   s10 sent03    7017            6      Jar  Incorrect     3   114       62        0
36   s10 sent04    3895           17      Jar  Incorrect     4   113       34        0
37   s10 sent05    4549           32      Jar  Incorrect     5   127       36        0
38   s10 sent06    4367           21      Jar  Incorrect     6   130       34        0
39   s10 sent07    3522           28      Jar  Incorrect     7    96       37        0
40   s10 sent08    5819            3      Jar    Correct     8   107       54        1
41   s10 sent09    2608           16      Jar    Correct     9   113       23        1
42   s10 sent10    3365           23      Jar    Correct    10   109       31        1
43   s10 sent11    6318            7      Jar    Correct    11    98       64        1
44   s10 sent12    4745           15      Jar    Correct    12   133       36        1
45   s10 sent13    4850           25      Jar    Correct    13   130       37        1
46   s10 sent14    3630           26      Jar    Correct    14    94       39        1
47   s10 sent15    2299           29      Jar    Correct    15    92       25        1
48   s10 sent16    5241            4      Jar  Incorrect    16   135       39        0
49   s10 sent17    5798           10      Key    Correct    17   126       46        1
50   s10 sent18    3361           30      Key    Correct    18   128       26        1
51   s10 sent19    3163           13      Key    Correct    19    96       33        1
52   s10 sent20    7076            5      Key    Correct    20    93       76        1
53   s10 sent21    5701           14      Key    Correct    21    95       60        1
54   s10 sent22    4223           22      Key    Correct    22   140       30        1
55   s10 sent23    3595           11      Key    Correct    23    90       40        1
56   s10 sent24    8441            9      Key    Correct    24    71      119        1
57   s10 sent25    3317           27      Key    Correct    25   129       26        1
58   s10 sent26    3482           19      Key    Correct    26    65       54        1
59   s10 sent27    6779            2      Key    Correct    27   118       57        1
60   s10 sent28    3554           24      Key    Correct    28    87       41        1
61   s10 sent29    4457           12      Key  Incorrect    29    87       51        0
62   s10 sent30    3300           31      Key    Correct    30   125       26        1
63   s10 sent31    5949           18      Key  Incorrect    31   118       50        0
64   s10 sent32    3101           20      Key    Correct    32    87       36        1
65   s11 sent01    1245           27      Jar    Correct     1   120       10        1
66   s11 sent03    6521           18      Jar  Incorrect     3   114       57        0
67   s11 sent04    1806           13      Jar    Correct     4   113       16        1
68   s11 sent05   12832            2      Jar  Incorrect     5   127      101        0
69   s11 sent06    4590            8      Jar    Correct     6   130       35        1
70   s11 sent07    2567           21      Jar  Incorrect     7    96       27        0
71   s11 sent08    1568           31      Jar    Correct     8   107       15        1
72   s11 sent09    2897           17      Jar    Correct     9   113       26        1
73   s11 sent10    1684           12      Jar    Correct    10   109       15        1
74   s11 sent11    2266           24      Jar  Incorrect    11    98       23        0
75   s11 sent12    4781           29      Jar  Incorrect    12   133       36        0
76   s11 sent13    2845           19      Jar    Correct    13   130       22        1
77   s11 sent14    4569           10      Jar    Correct    14    94       49        1
78   s11 sent15    2289           14      Jar  Incorrect    15    92       25        0
79   s11 sent16    6037            9      Jar  Incorrect    16   135       45        0
80   s11 sent17    4481            5      Key    Correct    17   126       36        1
81   s11 sent18    2529           16      Key    Correct    18   128       20        1
82   s11 sent19    2435           30      Key  Incorrect    19    96       25        0
83   s11 sent20    2710           28      Key  Incorrect    20    93       29        0
84   s11 sent21    5538            3      Key    Correct    21    95       58        1
85   s11 sent22    4194           11      Key  Incorrect    22   140       30        0
86   s11 sent23    1818           22      Key    Correct    23    90       20        1
87   s11 sent24    2082            7      Key    Correct    24    71       29        1
88   s11 sent25    4650           25      Key    Correct    25   129       36        1
89   s11 sent26   14788            1      Key    Correct    26    65      228        1
90   s11 sent27    3546           15      Key    Correct    27   118       30        1
91   s11 sent28    3179           26      Key  Incorrect    28    87       37        0
92   s11 sent29    2929            4      Key  Incorrect    29    87       34        0
93   s11 sent30    2027           23      Key  Incorrect    30   125       16        0
94   s11 sent31    4768            6      Key  Incorrect    31   118       40        0
95   s11 sent32    2020           20      Key  Incorrect    32    87       23        0
96   s12 sent01    3771           31      Jar    Correct     1   120       31        1
97   s12 sent02    5951            6      Jar    Correct     2   138       43        1
98   s12 sent03    3764            8      Jar  Incorrect     3   114       33        0
99   s12 sent04    6769            1      Jar  Incorrect     4   113       60        0
100  s12 sent05    3707           18      Jar  Incorrect     5   127       29        0
101  s12 sent06    4094           27      Jar  Incorrect     6   130       31        0
102  s12 sent07    7014           25      Jar  Incorrect     7    96       73        0
103  s12 sent08    2297           19      Jar  Incorrect     8   107       21        0
104  s12 sent09    4354           22      Jar    Correct     9   113       39        1
105  s12 sent10    2568            7      Jar    Correct    10   109       24        1
106  s12 sent11    2825           14      Jar    Correct    11    98       29        1
107  s12 sent12    3993           29      Jar    Correct    12   133       30        1
108  s12 sent13    2697           16      Jar    Correct    13   130       21        1
109  s12 sent14    3990           28      Jar    Correct    14    94       42        1
110  s12 sent15    3771            3      Jar    Correct    15    92       41        1
111  s12 sent17    4764           11      Key    Correct    17   126       38        1
112  s12 sent18    3326           17      Key    Correct    18   128       26        1
113  s12 sent19    2290           24      Key    Correct    19    96       24        1
114  s12 sent20    3275           15      Key    Correct    20    93       35        1
115  s12 sent21    3215           13      Key    Correct    21    95       34        1
116  s12 sent22    4068           10      Key    Correct    22   140       29        1
117  s12 sent23    2308           23      Key    Correct    23    90       26        1
118  s12 sent24    2279           21      Key    Correct    24    71       32        1
119  s12 sent25    4452           12      Key    Correct    25   129       35        1
120  s12 sent26    3354           20      Key    Correct    26    65       52        1
121  s12 sent27    5786           26      Key    Correct    27   118       49        1
122  s12 sent28    4582            5      Key  Incorrect    28    87       53        0
123  s12 sent29    2434            9      Key    Correct    29    87       28        1
124  s12 sent30    4321           30      Key    Correct    30   125       35        1
125  s12 sent31    4768            4      Key  Incorrect    31   118       40        0
126  s12 sent32    4757            2      Key    Correct    32    87       55        1
127  s13 sent01    1682           25      Jar    Correct     1   120       14        1
128  s13 sent02    3097           21      Jar    Correct     2   138       22        1
129  s13 sent03    4714           17      Jar  Incorrect     3   114       41        0
130  s13 sent04    4126            3      Jar    Correct     4   113       37        1
131  s13 sent05    5422            5      Jar  Incorrect     5   127       43        0
132  s13 sent06   10024            2      Jar  Incorrect     6   130       77        0
133  s13 sent07    5494           11      Jar    Correct     7    96       57        1
134  s13 sent08    3873           30      Jar  Incorrect     8   107       36        0
135  s13 sent09    3581            7      Jar    Correct     9   113       32        1
136  s13 sent10    2692           27      Jar  Incorrect    10   109       25        0
137  s13 sent11    2501           26      Jar  Incorrect    11    98       26        0
138  s13 sent12    4011           24      Jar    Correct    12   133       30        1
139  s13 sent13    3381           15      Jar    Correct    13   130       26        1
140  s13 sent15    2279           12      Jar  Incorrect    15    92       25        0
141  s13 sent16    2868           22      Jar    Correct    16   135       21        1
142  s13 sent17    2747           16      Key    Correct    17   126       22        1
143  s13 sent18    3196           31      Key    Correct    18   128       25        1
144  s13 sent19    5359           28      Key    Correct    19    96       56        1
145  s13 sent20    2806           14      Key    Correct    20    93       30        1
146  s13 sent21    3689            9      Key    Correct    21    95       39        1
147  s13 sent22    8027            4      Key    Correct    22   140       57        1
148  s13 sent23    3233           13      Key    Correct    23    90       36        1
149  s13 sent24    5176           10      Key    Correct    24    71       73        1
150  s13 sent25    8655           29      Key    Correct    25   129       67        1
151  s13 sent26    2292           20      Key    Correct    26    65       35        1
152  s13 sent27    3053           19      Key    Correct    27   118       26        1
153  s13 sent28    5151            1      Key    Correct    28    87       59        1
154  s13 sent29    2227           23      Key  Incorrect    29    87       26        0
155  s13 sent30    3216           18      Key    Correct    30   125       26        1
156  s13 sent31    5807            8      Key  Incorrect    31   118       49        0
157  s13 sent32    2219            6      Key    Correct    32    87       26        1
158  s14 sent01    5261           25      Jar    Correct     1   120       44        1
159  s14 sent02    5498           20      Jar    Correct     2   138       40        1
160  s14 sent03    9145            6      Jar  Incorrect     3   114       80        0
161  s14 sent04   10375            2      Jar  Incorrect     4   113       92        0
162  s14 sent05    4662           23      Jar  Incorrect     5   127       37        0
163  s14 sent06    5913            7      Jar  Incorrect     6   130       45        0
164  s14 sent07    5335           13      Jar  Incorrect     7    96       56        0
165  s14 sent08    7337           29      Jar  Incorrect     8   107       69        0
166  s14 sent09    5642           24      Jar    Correct     9   113       50        1
167  s14 sent10    7454            3      Jar    Correct    10   109       68        1
168  s14 sent11   11758            1      Jar    Correct    11    98      120        1
169  s14 sent12    6069           16      Jar    Correct    12   133       46        1
170  s14 sent13    7027            5      Jar    Correct    13   130       54        1
171  s14 sent14    6292           14      Jar    Correct    14    94       67        1
172  s14 sent15    4124           18      Jar    Correct    15    92       45        1
173  s14 sent16    6857            9      Jar    Correct    16   135       51        1
174  s14 sent18    9324           22      Key    Correct    18   128       73        1
175  s14 sent19    8015           21      Key    Correct    19    96       83        1
176  s14 sent20    5212           27      Key    Correct    20    93       56        1
177  s14 sent21    7418           12      Key    Correct    21    95       78        1
178  s14 sent22    8030            8      Key  Incorrect    22   140       57        0
179  s14 sent23    5438           19      Key    Correct    23    90       60        1
180  s14 sent24    7116           10      Key    Correct    24    71      100        1
181  s14 sent25    6770           11      Key  Incorrect    25   129       52        0
182  s14 sent26    4413            4      Key  Incorrect    26    65       68        0
183  s14 sent27    5175           17      Key    Correct    27   118       44        1
184  s14 sent28    5019           30      Key  Incorrect    28    87       58        0
185  s14 sent29    4975           31      Key  Incorrect    29    87       57        0
186  s14 sent30    5679           26      Key    Correct    30   125       45        1
187  s14 sent31    6005           28      Key  Incorrect    31   118       51        0
188  s14 sent32    3584           15      Key    Correct    32    87       41        1
189  s15 sent01    3294           30      Jar    Correct     1   120       27        1
190  s15 sent02    6221           24      Jar    Correct     2   138       45        1
191  s15 sent03    4677           19      Jar  Incorrect     3   114       41        0
192  s15 sent04    4002            8      Jar  Incorrect     4   113       35        0
193  s15 sent05    6954           12      Jar  Incorrect     5   127       55        0
194  s15 sent06    5562           29      Jar  Incorrect     6   130       43        0
195  s15 sent07    4504            1      Jar    Correct     7    96       47        1
196  s15 sent08    4654            6      Jar  Incorrect     8   107       43        0
197  s15 sent09    9174            5      Jar    Correct     9   113       81        1
198  s15 sent10    4125            9      Jar    Correct    10   109       38        1
199  s15 sent11    5910            4      Jar  Incorrect    11    98       60        0
200  s15 sent12    4198           23      Jar    Correct    12   133       32        1
201  s15 sent13    3980           17      Jar    Correct    13   130       31        1
202  s15 sent14    4314           10      Jar    Correct    14    94       46        1
203  s15 sent15    2916           31      Jar    Correct    15    92       32        1
204  s15 sent16    6521           18      Jar    Correct    16   135       48        1
205  s15 sent17    9525           20      Key    Correct    17   126       76        1
206  s15 sent18   12466           14      Key    Correct    18   128       97        1
207  s15 sent19    5307           26      Key    Correct    19    96       55        1
208  s15 sent20    3504           15      Key    Correct    20    93       38        1
209  s15 sent21    2536           25      Key    Correct    21    95       27        1
210  s15 sent22    4792           27      Key    Correct    22   140       34        1
211  s15 sent23    5251           13      Key    Correct    23    90       58        1
212  s15 sent24    7609            2      Key  Incorrect    24    71      107        0
213  s15 sent25    6069           21      Key    Correct    25   129       47        1
214  s15 sent26    3820           16      Key    Correct    26    65       59        1
215  s15 sent27    8593           28      Key    Correct    27   118       73        1
216  s15 sent28    4613           32      Key    Correct    28    87       53        1
217  s15 sent29    2863            3      Key    Correct    29    87       33        1
218  s15 sent30    6092           22      Key    Correct    30   125       49        1
219  s15 sent31    6054           11      Key  Incorrect    31   118       51        0
220  s15 sent32    5105            7      Key    Correct    32    87       59        1
221  s16 sent01    5546           29      Jar    Correct     1   120       46        1
222  s16 sent02    5842            7      Jar    Correct     2   138       42        1
223  s16 sent03    5910           16      Jar  Incorrect     3   114       52        0
224  s16 sent04    5683            3      Jar  Incorrect     4   113       50        0
225  s16 sent05    6849            8      Jar  Incorrect     5   127       54        0
226  s16 sent06    7080           31      Jar  Incorrect     6   130       54        0
227  s16 sent07    7334            1      Jar  Incorrect     7    96       76        0
228  s16 sent08    3703           30      Jar  Incorrect     8   107       35        0
229  s16 sent09    4611           24      Jar    Correct     9   113       41        1
230  s16 sent10    3767           18      Jar  Incorrect    10   109       35        0
231  s16 sent11    6328           28      Jar    Correct    11    98       65        1
232  s16 sent12    7517           14      Jar    Correct    12   133       57        1
233  s16 sent13    6350            9      Jar    Correct    13   130       49        1
234  s16 sent14    4687           11      Jar    Correct    14    94       50        1
235  s16 sent15    4592           19      Jar    Correct    15    92       50        1
236  s16 sent17    7614           26      Key    Correct    17   126       60        1
237  s16 sent18    6014            4      Key    Correct    18   128       47        1
238  s16 sent19    4980           15      Key    Correct    19    96       52        1
239  s16 sent20    7049           27      Key  Incorrect    20    93       76        0
240  s16 sent21    3099           13      Key    Correct    21    95       33        1
241  s16 sent22    5567           23      Key    Correct    22   140       40        1
242  s16 sent23    6895            2      Key    Correct    23    90       77        1
243  s16 sent24    4792           10      Key    Correct    24    71       67        1
244  s16 sent25    5782            5      Key    Correct    25   129       45        1
245  s16 sent26    3723           20      Key    Correct    26    65       57        1
246  s16 sent27    5239            6      Key    Correct    27   118       44        1
247  s16 sent28    6353           22      Key    Correct    28    87       73        1
248  s16 sent29    5836           21      Key    Correct    29    87       67        1
249  s16 sent30    5830           17      Key    Correct    30   125       47        1
250  s16 sent31    8951           25      Key  Incorrect    31   118       76        0
251  s16 sent32    3861           12      Key    Correct    32    87       44        1
252  s17 sent01    5245           10      Jar  Incorrect     1   120       44        0
253  s17 sent02    7047            9      Jar    Correct     2   138       51        1
254  s17 sent03    6020            3      Jar  Incorrect     3   114       53        0
255  s17 sent04    3343           31      Jar  Incorrect     4   113       30        0
256  s17 sent05   10812            6      Jar  Incorrect     5   127       85        0
257  s17 sent06    5744           21      Jar    Correct     6   130       44        1
258  s17 sent07    4447           22      Jar    Correct     7    96       46        1
259  s17 sent08    3335           27      Jar  Incorrect     8   107       31        0
260  s17 sent09    8544           17      Jar  Incorrect     9   113       76        0
261  s17 sent10    2816           29      Jar    Correct    10   109       26        1
262  s17 sent11    3438           14      Jar    Correct    11    98       35        1
263  s17 sent12    4179           15      Jar    Correct    12   133       31        1
264  s17 sent13    5242           25      Jar    Correct    13   130       40        1
265  s17 sent14    3034           24      Jar  Incorrect    14    94       32        0
266  s17 sent15    6063           26      Jar    Correct    15    92       66        1
267  s17 sent16    5285           19      Jar    Correct    16   135       39        1
268  s17 sent17    7566            5      Key  Incorrect    17   126       60        0
269  s17 sent18    3158           13      Key    Correct    18   128       25        1
270  s17 sent19    6303            1      Key    Correct    19    96       66        1
271  s17 sent20    2449           30      Key    Correct    20    93       26        1
272  s17 sent21    5337            2      Key    Correct    21    95       56        1
273  s17 sent22    3818           11      Key    Correct    22   140       27        1
274  s17 sent23    4276            4      Key    Correct    23    90       48        1
275  s17 sent24    3487           12      Key    Correct    24    71       49        1
276  s17 sent25    5562            8      Key    Correct    25   129       43        1
277  s17 sent26    2471            7      Key    Correct    26    65       38        1
278  s17 sent28    2865           23      Key  Incorrect    28    87       33        0
279  s17 sent29    4922           16      Key    Correct    29    87       57        1
280  s17 sent30    3863           28      Key    Correct    30   125       31        1
281  s17 sent31    6424           18      Key    Correct    31   118       54        1
282  s17 sent32    2635           20      Key    Correct    32    87       30        1
283  s18 sent01    5359           11      Jar  Incorrect     1   120       45        0
284  s18 sent02    7696           20      Jar    Correct     2   138       56        1
285  s18 sent03   18717           17      Jar    Correct     3   114      164        1
286  s18 sent04    4607           29      Jar    Correct     4   113       41        1
287  s18 sent05   10263            8      Jar    Correct     5   127       81        1
288  s18 sent06    7283           31      Jar    Correct     6   130       56        1
289  s18 sent07    8206            1      Jar    Correct     7    96       85        1
290  s18 sent08    8203           13      Jar    Correct     8   107       77        1
291  s18 sent09    8305           25      Jar  Incorrect     9   113       73        0
292  s18 sent10    4378            2      Jar  Incorrect    10   109       40        0
293  s18 sent11    5342            5      Jar  Incorrect    11    98       55        0
294  s18 sent12   10561           22      Jar  Incorrect    12   133       79        0
295  s18 sent13   11626           28      Jar  Incorrect    13   130       89        0
296  s18 sent14    9703           24      Jar    Correct    14    94      103        1
297  s18 sent15    5252           32      Jar  Incorrect    15    92       57        0
298  s18 sent16    6795           15      Jar  Incorrect    16   135       50        0
299  s18 sent17    5918            4      Key    Correct    17   126       47        1
300  s18 sent18    6782           21      Key  Incorrect    18   128       53        0
301  s18 sent19    8089           16      Key  Incorrect    19    96       84        0
302  s18 sent20    7233           27      Key    Correct    20    93       78        1
303  s18 sent21    6822            6      Key  Incorrect    21    95       72        0
304  s18 sent22    7364            7      Key    Correct    22   140       53        1
305  s18 sent23    4320           10      Key    Correct    23    90       48        1
306  s18 sent24    7730            9      Key    Correct    24    71      109        1
307  s18 sent25    9189           26      Key    Correct    25   129       71        1
308  s18 sent26    5129            3      Key    Correct    26    65       79        1
309  s18 sent27    5052           12      Key    Correct    27   118       43        1
310  s18 sent28   11150           30      Key    Correct    28    87      128        1
311  s18 sent29   10463           23      Key  Incorrect    29    87      120        0
312  s18 sent30   12328           19      Key    Correct    30   125       99        1
313  s18 sent31    7180           18      Key    Correct    31   118       61        1
314  s18 sent32    4425           14      Key    Correct    32    87       51        1
315  s19 sent01    3838            2      Jar    Correct     1   120       32        1
316  s19 sent02    5987           11      Jar    Correct     2   138       43        1
317  s19 sent03    2886           12      Jar  Incorrect     3   114       25        0
318  s19 sent04    2287           29      Jar  Incorrect     4   113       20        0
319  s19 sent05    2937           13      Jar  Incorrect     5   127       23        0
320  s19 sent06    4027            3      Jar  Incorrect     6   130       31        0
321  s19 sent07    5074           24      Jar  Incorrect     7    96       53        0
322  s19 sent08    3625           31      Jar  Incorrect     8   107       34        0
323  s19 sent09    2856           16      Jar    Correct     9   113       25        1
324  s19 sent10    5249           28      Jar    Correct    10   109       48        1
325  s19 sent11    3585            5      Jar    Correct    11    98       37        1
326  s19 sent12    5860           18      Jar    Correct    12   133       44        1
327  s19 sent13    5460           20      Jar    Correct    13   130       42        1
328  s19 sent14    3433           22      Jar    Correct    14    94       37        1
329  s19 sent15    5216           21      Jar    Correct    15    92       57        1
330  s19 sent16    3666            8      Jar    Correct    16   135       27        1
331  s19 sent17    4367            7      Key    Correct    17   126       35        1
332  s19 sent18    3821           32      Key    Correct    18   128       30        1
333  s19 sent19    7630           30      Key    Correct    19    96       79        1
334  s19 sent20    5627            4      Key  Incorrect    20    93       61        0
335  s19 sent21    3271           26      Key    Correct    21    95       34        1
336  s19 sent22    4586           14      Key    Correct    22   140       33        1
337  s19 sent23    3689           10      Key    Correct    23    90       41        1
338  s19 sent24    3301            6      Key    Correct    24    71       46        1
339  s19 sent25    8044           17      Key  Incorrect    25   129       62        0
340  s19 sent26    4956            1      Key    Correct    26    65       76        1
341  s19 sent27    5408           23      Key    Correct    27   118       46        1
342  s19 sent28    4313           19      Key    Correct    28    87       50        1
343  s19 sent29    5742           25      Key    Correct    29    87       66        1
344  s19 sent30    7489           27      Key    Correct    30   125       60        1
345  s19 sent31    3756            9      Key  Incorrect    31   118       32        0
346  s19 sent32    3151           15      Key    Correct    32    87       36        1
347  s02 sent01    2455           27      Jar    Correct     1   120       20        1
348  s02 sent02    3769           22      Jar    Correct     2   138       27        1
349  s02 sent03    6045            6      Jar  Incorrect     3   114       53        0
350  s02 sent04    2289            7      Jar  Incorrect     4   113       20        0
351  s02 sent05    3946           28      Jar  Incorrect     5   127       31        0
352  s02 sent06    4334            4      Jar    Correct     6   130       33        1
353  s02 sent07    4711           10      Jar  Incorrect     7    96       49        0
354  s02 sent08    2910           30      Jar  Incorrect     8   107       27        0
355  s02 sent09    3271           25      Jar    Correct     9   113       29        1
356  s02 sent10    3312           19      Jar    Correct    10   109       30        1
357  s02 sent11    3287           11      Jar    Correct    11    98       34        1
358  s02 sent12    4214           17      Jar    Correct    12   133       32        1
359  s02 sent13    3275           14      Jar    Correct    13   130       25        1
360  s02 sent14    7200            1      Jar    Correct    14    94       77        1
361  s02 sent15    2476           23      Jar    Correct    15    92       27        1
362  s02 sent16    4213           32      Jar    Correct    16   135       31        1
363  s02 sent17    7148           21      Key    Correct    17   126       57        1
364  s02 sent18    6485            5      Key    Correct    18   128       51        1
365  s02 sent19    4116           24      Key    Correct    19    96       43        1
366  s02 sent20    2933           13      Key    Correct    20    93       32        1
367  s02 sent21    2502            3      Key    Correct    21    95       26        1
368  s02 sent22    4318           15      Key    Correct    22   140       31        1
369  s02 sent23    1978           26      Key    Correct    23    90       22        1
370  s02 sent24    3021            8      Key    Correct    24    71       43        1
371  s02 sent25    4461           18      Key    Correct    25   129       35        1
372  s02 sent26    3366           20      Key    Correct    26    65       52        1
373  s02 sent27    4121           29      Key    Correct    27   118       35        1
374  s02 sent28    1677           31      Key  Incorrect    28    87       19        0
375  s02 sent29    4511            2      Key    Correct    29    87       52        1
376  s02 sent30    4153           12      Key    Correct    30   125       33        1
377  s02 sent31    5734           16      Key  Incorrect    31   118       49        0
378  s02 sent32    2010            9      Key    Correct    32    87       23        1
379  s20 sent01    5205           30      Jar    Correct     1   120       43        1
380  s20 sent02    4034           26      Jar    Correct     2   138       29        1
381  s20 sent03    5882           31      Jar  Incorrect     3   114       52        0
382  s20 sent04    3818           16      Jar  Incorrect     4   113       34        0
383  s20 sent05   23119            1      Jar    Correct     5   127      182        1
384  s20 sent06    4044           23      Jar  Incorrect     6   130       31        0
385  s20 sent07    3128           19      Jar  Incorrect     7    96       33        0
386  s20 sent08    4552           17      Jar  Incorrect     8   107       43        0
387  s20 sent09    6601           15      Jar    Correct     9   113       58        1
388  s20 sent10    2364           22      Jar    Correct    10   109       22        1
389  s20 sent11    4519           20      Jar  Incorrect    11    98       46        0
390  s20 sent12    5416           27      Jar    Correct    12   133       41        1
391  s20 sent13    5683            3      Jar  Incorrect    13   130       44        0
392  s20 sent14    2545           24      Jar    Correct    14    94       27        1
393  s20 sent15    4478           12      Jar    Correct    15    92       49        1
394  s20 sent16    7418            4      Jar  Incorrect    16   135       55        0
395  s20 sent17    5673           11      Key  Incorrect    17   126       45        0
396  s20 sent18    5423           10      Key    Correct    18   128       42        1
397  s20 sent19    5623           28      Key    Correct    19    96       59        1
398  s20 sent20    3860            6      Key  Incorrect    20    93       42        0
399  s20 sent21    5128            7      Key    Correct    21    95       54        1
400  s20 sent22    5319           29      Key    Correct    22   140       38        1
401  s20 sent23    4393           32      Key    Correct    23    90       49        1
402  s20 sent24    2335           21      Key    Correct    24    71       33        1
403  s20 sent25    5393           18      Key    Correct    25   129       42        1
404  s20 sent26    4434           13      Key    Correct    26    65       68        1
405  s20 sent27    4335            8      Key    Correct    27   118       37        1
406  s20 sent28    3804           25      Key    Correct    28    87       44        1
407  s20 sent29    3917            2      Key    Correct    29    87       45        1
408  s20 sent30    6568            5      Key    Correct    30   125       53        1
409  s20 sent31    4631           14      Key  Incorrect    31   118       39        0
410  s20 sent32    5808            9      Key    Correct    32    87       67        1
411  s21 sent01   17312           16      Jar  Incorrect     1   120      144        0
412  s21 sent02    5193           18      Jar  Incorrect     2   138       38        0
413  s21 sent03    5145           15      Jar  Incorrect     3   114       45        0
414  s21 sent04    5467           12      Jar    Correct     4   113       48        1
415  s21 sent05    5577            7      Jar  Incorrect     5   127       44        0
416  s21 sent06    4683            5      Jar    Correct     6   130       36        1
417  s21 sent07    4025           25      Jar    Correct     7    96       42        1
418  s21 sent08    3842           10      Jar    Correct     8   107       36        1
419  s21 sent09    3720            9      Jar  Incorrect     9   113       33        0
420  s21 sent10    4182            8      Jar  Incorrect    10   109       38        0
421  s21 sent11    4008           14      Jar  Incorrect    11    98       41        0
422  s21 sent12    5803           23      Jar  Incorrect    12   133       44        0
423  s21 sent13    3578           19      Jar  Incorrect    13   130       28        0
424  s21 sent14    3789           17      Jar  Incorrect    14    94       40        0
425  s21 sent15    9473            3      Jar  Incorrect    15    92      103        0
426  s21 sent16    4390            4      Jar  Incorrect    16   135       33        0
427  s21 sent17    9783           24      Key    Correct    17   126       78        1
428  s21 sent18    6006           28      Key    Correct    18   128       47        1
429  s21 sent19    5281           29      Key    Correct    19    96       55        1
430  s21 sent20    3291           13      Key    Correct    20    93       35        1
431  s21 sent21    6153            1      Key    Correct    21    95       65        1
432  s21 sent22    5633            2      Key    Correct    22   140       40        1
433  s21 sent23    4306           31      Key    Correct    23    90       48        1
434  s21 sent24    3231           32      Key    Correct    24    71       46        1
435  s21 sent25    3938           20      Key    Correct    25   129       31        1
436  s21 sent26    8603           11      Key    Correct    26    65      132        1
437  s21 sent27    6527           22      Key    Correct    27   118       55        1
438  s21 sent28    4645            6      Key  Incorrect    28    87       53        0
439  s21 sent29    5436           26      Key  Incorrect    29    87       62        0
440  s21 sent30    4831           30      Key    Correct    30   125       39        1
441  s21 sent31    9044           21      Key  Incorrect    31   118       77        0
442  s21 sent32    4258           27      Key    Correct    32    87       49        1
443  s22 sent01    3661           12      Jar  Incorrect     1   120       31        0
444  s22 sent02    5414           25      Jar  Incorrect     2   138       39        0
445  s22 sent03    4889           18      Jar    Correct     3   114       43        1
446  s22 sent04    4240            4      Jar    Correct     4   113       38        1
447  s22 sent05    4316           23      Jar    Correct     5   127       34        1
448  s22 sent06   21925            1      Jar    Correct     6   130      169        1
449  s22 sent07    4783           13      Jar    Correct     7    96       50        1
450  s22 sent08    3202            7      Jar    Correct     8   107       30        1
451  s22 sent09    3893           28      Jar  Incorrect     9   113       34        0
452  s22 sent11    1966           17      Jar  Incorrect    11    98       20        0
453  s22 sent12    6378            9      Jar  Incorrect    12   133       48        0
454  s22 sent13    3011           20      Jar  Incorrect    13   130       23        0
455  s22 sent14    4015           11      Jar  Incorrect    14    94       43        0
456  s22 sent15    2558           26      Jar  Incorrect    15    92       28        0
457  s22 sent17    4961           30      Key    Correct    17   126       39        1
458  s22 sent18    3846           10      Key  Incorrect    18   128       30        0
459  s22 sent19    2873           29      Key    Correct    19    96       30        1
460  s22 sent20    3465           21      Key    Correct    20    93       37        1
461  s22 sent21    4374            3      Key    Correct    21    95       46        1
462  s22 sent22    7376           15      Key  Incorrect    22   140       53        0
463  s22 sent23    5328           16      Key  Incorrect    23    90       59        0
464  s22 sent24    4729           22      Key  Incorrect    24    71       67        0
465  s22 sent25    6056           14      Key  Incorrect    25   129       47        0
466  s22 sent26    4120            6      Key    Correct    26    65       63        1
467  s22 sent27    5173            2      Key    Correct    27   118       44        1
468  s22 sent28    3607            8      Key  Incorrect    28    87       41        0
469  s22 sent29    3908           19      Key    Correct    29    87       45        1
470  s22 sent30    5320            5      Key  Incorrect    30   125       43        0
471  s22 sent31    7129           27      Key  Incorrect    31   118       60        0
472  s22 sent32    2107           24      Key    Correct    32    87       24        1
473  s23 sent01    4461           15      Jar    Correct     1   120       37        1
474  s23 sent02    4406           28      Jar    Correct     2   138       32        1
475  s23 sent03    8872            7      Jar    Correct     3   114       78        1
476  s23 sent04    4948           29      Jar  Incorrect     4   113       44        0
477  s23 sent05    8346           10      Jar  Incorrect     5   127       66        0
478  s23 sent06    7645            2      Jar    Correct     6   130       59        1
479  s23 sent07    4012           26      Jar  Incorrect     7    96       42        0
480  s23 sent08    3533           18      Jar  Incorrect     8   107       33        0
481  s23 sent09   13313            9      Jar  Incorrect     9   113      118        0
482  s23 sent10    4768           11      Jar    Correct    10   109       44        1
483  s23 sent11    8957           13      Jar    Correct    11    98       91        1
484  s23 sent12    7115           17      Jar    Correct    12   133       53        1
485  s23 sent13    4038           31      Jar    Correct    13   130       31        1
486  s23 sent14    6691           19      Jar    Correct    14    94       71        1
487  s23 sent15    5696           22      Jar    Correct    15    92       62        1
488  s23 sent16   13670            4      Jar  Incorrect    16   135      101        0
489  s23 sent18    8284           20      Key    Correct    18   128       65        1
490  s23 sent19    6403            3      Key    Correct    19    96       67        1
491  s23 sent20    6520           16      Key  Incorrect    20    93       70        0
492  s23 sent21    3280           27      Key  Incorrect    21    95       35        0
493  s23 sent22   12419            1      Key    Correct    22   140       89        1
494  s23 sent23    4490           30      Key    Correct    23    90       50        1
495  s23 sent24    5449            6      Key  Incorrect    24    71       77        0
496  s23 sent25    7672           25      Key    Correct    25   129       59        1
497  s23 sent26    6242            5      Key    Correct    26    65       96        1
498  s23 sent27    7179           23      Key  Incorrect    27   118       61        0
499  s23 sent28    8338           24      Key    Correct    28    87       96        1
500  s23 sent29    9785           21      Key  Incorrect    29    87      112        0
501  s23 sent30    8101            8      Key  Incorrect    30   125       65        0
502  s23 sent31    7768           12      Key  Incorrect    31   118       66        0
503  s23 sent32    5757           14      Key  Incorrect    32    87       66        0
504  s24 sent01    2305           23      Jar  Incorrect     1   120       19        0
505  s24 sent02    3252            7      Jar    Correct     2   138       24        1
506  s24 sent03    5951           17      Jar    Correct     3   114       52        1
507  s24 sent04    5631           32      Jar  Incorrect     4   113       50        0
508  s24 sent05    4641           22      Jar    Correct     5   127       37        1
509  s24 sent06    3985           19      Jar    Correct     6   130       31        1
510  s24 sent07    4270           10      Jar    Correct     7    96       44        1
511  s24 sent08    2972           11      Jar    Correct     8   107       28        1
512  s24 sent09    3333           16      Jar    Correct     9   113       29        1
513  s24 sent10    3506           27      Jar    Correct    10   109       32        1
514  s24 sent11    3360           28      Jar    Correct    11    98       34        1
515  s24 sent12    4996           21      Jar  Incorrect    12   133       38        0
516  s24 sent13    4630            4      Jar    Correct    13   130       36        1
517  s24 sent14    3370            9      Jar    Correct    14    94       36        1
518  s24 sent15    3988            2      Jar    Correct    15    92       43        1
519  s24 sent16    6223           26      Jar    Correct    16   135       46        1
520  s24 sent17    6417           29      Key    Correct    17   126       51        1
521  s24 sent18    4437           14      Key  Incorrect    18   128       35        0
522  s24 sent19    3769            5      Key    Correct    19    96       39        1
523  s24 sent20    3769            1      Key  Incorrect    20    93       41        0
524  s24 sent21    3727           12      Key  Incorrect    21    95       39        0
525  s24 sent22    9759           18      Key    Correct    22   140       70        1
526  s24 sent23    5018           15      Key  Incorrect    23    90       56        0
527  s24 sent24    5920           31      Key    Correct    24    71       83        1
528  s24 sent25    3665           20      Key    Correct    25   129       28        1
529  s24 sent26    6400           13      Key    Correct    26    65       98        1
530  s24 sent27    6478           25      Key    Correct    27   118       55        1
531  s24 sent28   12447           24      Key    Correct    28    87      143        1
532  s24 sent29    5051            3      Key    Correct    29    87       58        1
533  s24 sent30    5888            6      Key    Correct    30   125       47        1
534  s24 sent31    8623            8      Key    Correct    31   118       73        1
535  s24 sent32    5408           30      Key    Correct    32    87       62        1
536  s25 sent01    6515            3      Jar  Incorrect     1   120       54        0
537  s25 sent02    5082           13      Jar  Incorrect     2   138       37        0
538  s25 sent03    6688           19      Jar    Correct     3   114       59        1
539  s25 sent04    4625            4      Jar    Correct     4   113       41        1
540  s25 sent05   11181           11      Jar    Correct     5   127       88        1
541  s25 sent06    7058           17      Jar    Correct     6   130       54        1
542  s25 sent07    5788            5      Jar    Correct     7    96       60        1
543  s25 sent08    5363           31      Jar    Correct     8   107       50        1
544  s25 sent09    4056           20      Jar  Incorrect     9   113       36        0
545  s25 sent10    5250           29      Jar  Incorrect    10   109       48        0
546  s25 sent11    4153           24      Jar  Incorrect    11    98       42        0
547  s25 sent12    4397           28      Jar  Incorrect    12   133       33        0
548  s25 sent13    8290           10      Jar  Incorrect    13   130       64        0
549  s25 sent14    8415            6      Jar  Incorrect    14    94       90        0
550  s25 sent15    3279           16      Jar  Incorrect    15    92       36        0
551  s25 sent16    3458           14      Jar  Incorrect    16   135       26        0
552  s25 sent17    8972            8      Key    Correct    17   126       71        1
553  s25 sent18   10913            1      Key  Incorrect    18   128       85        0
554  s25 sent19    6288           21      Key    Correct    19    96       66        1
555  s25 sent20    8573           26      Key    Correct    20    93       92        1
556  s25 sent21    4489           18      Key    Correct    21    95       47        1
557  s25 sent22    5827           30      Key    Correct    22   140       42        1
558  s25 sent23    6705           27      Key  Incorrect    23    90       75        0
559  s25 sent24    5672           22      Key    Correct    24    71       80        1
560  s25 sent25    5095           12      Key    Correct    25   129       39        1
561  s25 sent26    5734           23      Key  Incorrect    26    65       88        0
562  s25 sent27   11755            7      Key    Correct    27   118      100        1
563  s25 sent28    8052            2      Key    Correct    28    87       93        1
564  s25 sent29    4453           15      Key    Correct    29    87       51        1
565  s25 sent30    7247           25      Key  Incorrect    30   125       58        0
566  s25 sent31    9060            9      Key    Correct    31   118       77        1
567  s25 sent32    3322           32      Key    Correct    32    87       38        1
568  s26 sent01    2974           14      Jar    Correct     1   120       25        1
569  s26 sent02   15146            2      Jar  Incorrect     2   138      110        0
570  s26 sent03    3195           26      Jar  Incorrect     3   114       28        0
571  s26 sent04    3823           29      Jar  Incorrect     4   113       34        0
572  s26 sent05    6988            7      Jar    Correct     5   127       55        1
573  s26 sent06    5977           21      Jar    Correct     6   130       46        1
574  s26 sent07    2858           24      Jar    Correct     7    96       30        1
575  s26 sent08   10792            6      Jar    Correct     8   107      101        1
576  s26 sent09    3562           30      Jar    Correct     9   113       32        1
577  s26 sent10    5168           10      Jar    Correct    10   109       47        1
578  s26 sent11    5323           20      Jar    Correct    11    98       54        1
579  s26 sent12    1555           25      Jar    Correct    12   133       12        1
580  s26 sent13    7553            4      Jar    Correct    13   130       58        1
581  s26 sent14    3806            5      Jar    Correct    14    94       40        1
582  s26 sent15    3632           27      Jar  Incorrect    15    92       39        0
583  s26 sent16    9220           11      Jar    Correct    16   135       68        1
584  s26 sent17    4913           19      Key    Correct    17   126       39        1
585  s26 sent18    5544           17      Key    Correct    18   128       43        1
586  s26 sent19    6702           28      Key    Correct    19    96       70        1
587  s26 sent20    5359           22      Key    Correct    20    93       58        1
588  s26 sent21    2517            8      Key    Correct    21    95       26        1
589  s26 sent22   15134            3      Key  Incorrect    22   140      108        0
590  s26 sent23   15965            1      Key  Incorrect    23    90      177        0
591  s26 sent24    4170           32      Key  Incorrect    24    71       59        0
592  s26 sent25    9140           15      Key    Correct    25   129       71        1
593  s26 sent26    3567           16      Key    Correct    26    65       55        1
594  s26 sent27    4521           31      Key    Correct    27   118       38        1
595  s26 sent28    3100           13      Key  Incorrect    28    87       36        0
596  s26 sent29    4311            9      Key  Incorrect    29    87       50        0
597  s26 sent30    3236           12      Key    Correct    30   125       26        1
598  s26 sent31    3273           23      Key  Incorrect    31   118       28        0
599  s26 sent32    3135           18      Key    Correct    32    87       36        1
600  s27 sent01    4655           10      Jar    Correct     1   120       39        1
601  s27 sent02    3540           30      Jar    Correct     2   138       26        1
602  s27 sent03    4085           11      Jar  Incorrect     3   114       36        0
603  s27 sent04    3265           32      Jar  Incorrect     4   113       29        0
604  s27 sent05    5810           12      Jar  Incorrect     5   127       46        0
605  s27 sent06    2718           24      Jar  Incorrect     6   130       21        0
606  s27 sent07    3604           13      Jar  Incorrect     7    96       38        0
607  s27 sent08    4246           17      Jar  Incorrect     8   107       40        0
608  s27 sent09    2909           26      Jar    Correct     9   113       26        1
609  s27 sent10    3966            1      Jar    Correct    10   109       36        1
610  s27 sent11    2784           15      Jar    Correct    11    98       28        1
611  s27 sent12    2655           25      Jar    Correct    12   133       20        1
612  s27 sent13    2426            5      Jar    Correct    13   130       19        1
613  s27 sent14    3503            3      Jar    Correct    14    94       37        1
614  s27 sent15    4016           27      Jar    Correct    15    92       44        1
615  s27 sent16    2477           23      Jar    Correct    16   135       18        1
616  s27 sent17    5335            7      Key    Correct    17   126       42        1
617  s27 sent18    4099            8      Key    Correct    18   128       32        1
618  s27 sent19    3097           29      Key    Correct    19    96       32        1
619  s27 sent20    3884           20      Key    Correct    20    93       42        1
620  s27 sent21    2090           21      Key    Correct    21    95       22        1
621  s27 sent22    4375           18      Key    Correct    22   140       31        1
622  s27 sent23    2112            4      Key    Correct    23    90       23        1
623  s27 sent24    2553            2      Key    Correct    24    71       36        1
624  s27 sent25    5116            6      Key    Correct    25   129       40        1
625  s27 sent26    3748           16      Key    Correct    26    65       58        1
626  s27 sent27    3201           31      Key    Correct    27   118       27        1
627  s27 sent28    4197            9      Key    Correct    28    87       48        1
628  s27 sent29    2551           19      Key    Correct    29    87       29        1
629  s27 sent30    3516           22      Key    Correct    30   125       28        1
630  s27 sent31    4651           14      Key    Correct    31   118       39        1
631  s27 sent32    2533           28      Key    Correct    32    87       29        1
632  s28 sent01    8689           23      Jar    Correct     1   120       72        1
633  s28 sent02    8566           14      Jar    Correct     2   138       62        1
634  s28 sent03    6252           20      Jar  Incorrect     3   114       55        0
635  s28 sent04    3149           25      Jar  Incorrect     4   113       28        0
636  s28 sent05    5579           31      Jar  Incorrect     5   127       44        0
637  s28 sent06    4633           32      Jar  Incorrect     6   130       36        0
638  s28 sent07    4612           24      Jar  Incorrect     7    96       48        0
639  s28 sent08    7465            2      Jar    Correct     8   107       70        1
640  s28 sent09    5982           12      Jar  Incorrect     9   113       53        0
641  s28 sent10    2553           17      Jar    Correct    10   109       23        1
642  s28 sent11    2689           18      Jar    Correct    11    98       27        1
643  s28 sent12    4465            6      Jar  Incorrect    12   133       34        0
644  s28 sent13    3751           16      Jar    Correct    13   130       29        1
645  s28 sent14    3847           22      Jar  Incorrect    14    94       41        0
646  s28 sent15    4399            8      Jar  Incorrect    15    92       48        0
647  s28 sent16    9569            9      Jar  Incorrect    16   135       71        0
648  s28 sent17    4338           26      Key    Correct    17   126       34        1
649  s28 sent18    7309           15      Key    Correct    18   128       57        1
650  s28 sent19    3832           19      Key    Correct    19    96       40        1
651  s28 sent20    3515            7      Key    Correct    20    93       38        1
652  s28 sent21    5352           30      Key    Correct    21    95       56        1
653  s28 sent22    4685           11      Key    Correct    22   140       33        1
654  s28 sent23    6840           28      Key    Correct    23    90       76        1
655  s28 sent24    5491           27      Key  Incorrect    24    71       77        0
656  s28 sent25    6621           13      Key    Correct    25   129       51        1
657  s28 sent26    3806           10      Key    Correct    26    65       59        1
658  s28 sent27    4751            5      Key    Correct    27   118       40        1
659  s28 sent28   14194            1      Key    Correct    28    87      163        1
660  s28 sent29    6744           29      Key    Correct    29    87       78        1
661  s28 sent30    3722           21      Key    Correct    30   125       30        1
662  s28 sent31    5414            4      Key    Correct    31   118       46        1
663  s28 sent32    4485            3      Key    Correct    32    87       52        1
664  s29 sent01    5343           12      Jar  Incorrect     1   120       45        0
665  s29 sent02    5119           17      Jar  Incorrect     2   138       37        0
666  s29 sent03    7401            2      Jar  Incorrect     3   114       65        0
667  s29 sent04    5643           30      Jar  Incorrect     4   113       50        0
668  s29 sent05   11219            3      Jar  Incorrect     5   127       88        0
669  s29 sent06    4595            6      Jar  Incorrect     6   130       35        0
670  s29 sent07    5779           21      Jar    Correct     7    96       60        1
671  s29 sent08    5527           24      Jar    Correct     8   107       52        1
672  s29 sent09    3317           23      Jar  Incorrect     9   113       29        0
673  s29 sent10    5775           20      Jar  Incorrect    10   109       53        0
674  s29 sent11    7436            4      Jar  Incorrect    11    98       76        0
675  s29 sent12    6148           18      Jar  Incorrect    12   133       46        0
676  s29 sent13    6716           11      Jar  Incorrect    13   130       52        0
677  s29 sent14    4200           13      Jar  Incorrect    14    94       45        0
678  s29 sent15    5231           26      Jar  Incorrect    15    92       57        0
679  s29 sent17    7549            1      Key    Correct    17   126       60        1
680  s29 sent18   11233           25      Key  Incorrect    18   128       88        0
681  s29 sent19    5495           31      Key    Correct    19    96       57        1
682  s29 sent20    7981            7      Key    Correct    20    93       86        1
683  s29 sent21    7811           14      Key    Correct    21    95       82        1
684  s29 sent22    7745            9      Key    Correct    22   140       55        1
685  s29 sent23    5174           16      Key    Correct    23    90       57        1
686  s29 sent24    5047            5      Key  Incorrect    24    71       71        0
687  s29 sent25    4677           29      Key  Incorrect    25   129       36        0
688  s29 sent26    3514           27      Key    Correct    26    65       54        1
689  s29 sent27    6103           10      Key    Correct    27   118       52        1
690  s29 sent28    4641           28      Key  Incorrect    28    87       53        0
691  s29 sent29    6065            8      Key  Incorrect    29    87       70        0
692  s29 sent30    8714           19      Key  Incorrect    30   125       70        0
693  s29 sent31    7998           22      Key  Incorrect    31   118       68        0
694  s29 sent32    3596           15      Key    Correct    32    87       41        1
695  s03 sent01    3959           23      Jar    Correct     1   120       33        1
696  s03 sent02    2831           20      Jar    Correct     2   138       21        1
697  s03 sent03    8077            8      Jar  Incorrect     3   114       71        0
698  s03 sent04    2952           18      Jar  Incorrect     4   113       26        0
699  s03 sent05    2770           25      Jar  Incorrect     5   127       22        0
700  s03 sent06    3208           21      Jar  Incorrect     6   130       25        0
701  s03 sent07    2994           12      Jar  Incorrect     7    96       31        0
702  s03 sent08    4260           19      Jar  Incorrect     8   107       40        0
703  s03 sent09    4015           10      Jar    Correct     9   113       36        1
704  s03 sent10    2234           32      Jar    Correct    10   109       20        1
705  s03 sent11    4420           15      Jar    Correct    11    98       45        1
706  s03 sent12    7207           31      Jar    Correct    12   133       54        1
707  s03 sent13    3276           29      Jar    Correct    13   130       25        1
708  s03 sent14   11525            6      Jar    Correct    14    94      123        1
709  s03 sent15    3252            9      Jar    Correct    15    92       35        1
710  s03 sent16    8739            4      Jar  Incorrect    16   135       65        0
711  s03 sent17   23824            1      Key    Correct    17   126      189        1
712  s03 sent18    5826           16      Key  Incorrect    18   128       46        0
713  s03 sent19    6384            7      Key    Correct    19    96       67        1
714  s03 sent20    5082           27      Key    Correct    20    93       55        1
715  s03 sent21    4169           14      Key    Correct    21    95       44        1
716  s03 sent22    6045           30      Key    Correct    22   140       43        1
717  s03 sent23    4408           28      Key  Incorrect    23    90       49        0
718  s03 sent24    3857           13      Key  Incorrect    24    71       54        0
719  s03 sent25    4994            5      Key    Correct    25   129       39        1
720  s03 sent26    2581            3      Key    Correct    26    65       40        1
721  s03 sent27    8931           26      Key  Incorrect    27   118       76        0
722  s03 sent28    4108           17      Key  Incorrect    28    87       47        0
723  s03 sent29    5641            2      Key    Correct    29    87       65        1
724  s03 sent30    5935           11      Key  Incorrect    30   125       47        0
725  s03 sent31    5403           24      Key  Incorrect    31   118       46        0
726  s03 sent32    4582           22      Key    Correct    32    87       53        1
727  s30 sent01    4782            4      Jar  Incorrect     1   120       40        0
728  s30 sent02    5743           18      Jar  Incorrect     2   138       42        0
729  s30 sent03    4775            1      Jar    Correct     3   114       42        1
730  s30 sent04    3055            6      Jar    Correct     4   113       27        1
731  s30 sent05    5211            9      Jar    Correct     5   127       41        1
732  s30 sent06    5229            8      Jar    Correct     6   130       40        1
733  s30 sent07    4962           17      Jar    Correct     7    96       52        1
734  s30 sent08    3260           22      Jar    Correct     8   107       30        1
735  s30 sent09    6111           10      Jar    Correct     9   113       54        1
736  s30 sent10    2581           25      Jar    Correct    10   109       24        1
737  s30 sent11    2286           15      Jar    Correct    11    98       23        1
738  s30 sent12    5922           30      Jar    Correct    12   133       45        1
739  s30 sent13    3829            5      Jar    Correct    13   130       29        1
740  s30 sent14    4870           32      Jar    Correct    14    94       52        1
741  s30 sent15    8397           11      Jar    Correct    15    92       91        1
742  s30 sent16    4821           14      Jar    Correct    16   135       36        1
743  s30 sent17    4927           31      Key    Correct    17   126       39        1
744  s30 sent18    7061           27      Key  Incorrect    18   128       55        0
745  s30 sent19    3743           23      Key    Correct    19    96       39        1
746  s30 sent20    4885           19      Key  Incorrect    20    93       53        0
747  s30 sent21    2989           20      Key  Incorrect    21    95       31        0
748  s30 sent22    9289           13      Key    Correct    22   140       66        1
749  s30 sent23    4477           16      Key  Incorrect    23    90       50        0
750  s30 sent24    4442           26      Key    Correct    24    71       63        1
751  s30 sent25    5436            2      Key    Correct    25   129       42        1
752  s30 sent26    3944           12      Key    Correct    26    65       61        1
753  s30 sent27    4409           28      Key    Correct    27   118       37        1
754  s30 sent28    5972           21      Key    Correct    28    87       69        1
755  s30 sent29    6332           29      Key    Correct    29    87       73        1
756  s30 sent30    8409            7      Key    Correct    30   125       67        1
757  s30 sent31    6982           24      Key    Correct    31   118       59        1
758  s30 sent32    5340            3      Key    Correct    32    87       61        1
759  s31 sent01    2474            9      Jar    Correct     1   120       21        1
760  s31 sent02    5353            3      Jar    Correct     2   138       39        1
761  s31 sent03    4277           10      Jar  Incorrect     3   114       38        0
762  s31 sent04    5272           21      Jar  Incorrect     4   113       47        0
763  s31 sent05    5409           13      Jar    Correct     5   127       43        1
764  s31 sent06    3752            5      Jar  Incorrect     6   130       29        0
765  s31 sent07    5559           29      Jar    Correct     7    96       58        1
766  s31 sent08   10448           30      Jar  Incorrect     8   107       98        0
767  s31 sent09    8298           27      Jar  Incorrect     9   113       73        0
768  s31 sent10    3899           24      Jar    Correct    10   109       36        1
769  s31 sent11   11923            1      Jar    Correct    11    98      122        1
770  s31 sent12    5193           20      Jar  Incorrect    12   133       39        0
771  s31 sent13    1951           15      Jar  Incorrect    13   130       15        0
772  s31 sent14    3224           16      Jar    Correct    14    94       34        1
773  s31 sent15    4726            6      Jar    Correct    15    92       51        1
774  s31 sent16    4727           26      Jar  Incorrect    16   135       35        0
775  s31 sent17    5618            8      Key    Correct    17   126       45        1
776  s31 sent18    7037           12      Key    Correct    18   128       55        1
777  s31 sent19    9138           25      Key    Correct    19    96       95        1
778  s31 sent20    8195           23      Key  Incorrect    20    93       88        0
779  s31 sent21   12552           14      Key  Incorrect    21    95      132        0
780  s31 sent22    9487           19      Key  Incorrect    22   140       68        0
781  s31 sent23    3379            7      Key  Incorrect    23    90       38        0
782  s31 sent24    5575           31      Key    Correct    24    71       79        1
783  s31 sent25   10868            2      Key    Correct    25   129       84        1
784  s31 sent26    3229           18      Key    Correct    26    65       50        1
785  s31 sent27    4644            4      Key    Correct    27   118       39        1
786  s31 sent28    5574           28      Key  Incorrect    28    87       64        0
787  s31 sent29    4441           22      Key    Correct    29    87       51        1
788  s31 sent30    6851           11      Key  Incorrect    30   125       55        0
789  s31 sent31    8645           32      Key  Incorrect    31   118       73        0
790  s31 sent32    2405           17      Key  Incorrect    32    87       28        0
791  s32 sent01    3567           28      Jar  Incorrect     1   120       30        0
792  s32 sent02    5463            9      Jar  Incorrect     2   138       40        0
793  s32 sent03    3654            6      Jar    Correct     3   114       32        1
794  s32 sent04    3994           26      Jar    Correct     4   113       35        1
795  s32 sent05    4435           25      Jar    Correct     5   127       35        1
796  s32 sent06    3876           30      Jar    Correct     6   130       30        1
797  s32 sent07    3019           27      Jar    Correct     7    96       31        1
798  s32 sent08    3905           12      Jar    Correct     8   107       36        1
799  s32 sent09    3650           32      Jar    Correct     9   113       32        1
800  s32 sent10    3624            8      Jar    Correct    10   109       33        1
801  s32 sent11     109            2      Jar    Correct    11    98        1        1
802  s32 sent12    5306           18      Jar    Correct    12   133       40        1
803  s32 sent13    5077            5      Jar    Correct    13   130       39        1
804  s32 sent14    3311           14      Jar    Correct    14    94       35        1
805  s32 sent15    2579           29      Jar    Correct    15    92       28        1
806  s32 sent16    4241           22      Jar    Correct    16   135       31        1
807  s32 sent17    4634           16      Key  Incorrect    17   126       37        0
808  s32 sent18    4870           13      Key  Incorrect    18   128       38        0
809  s32 sent19    3577           24      Key  Incorrect    19    96       37        0
810  s32 sent20    3963           11      Key  Incorrect    20    93       43        0
811  s32 sent21       6            4      Key  Incorrect    21    95        0        0
812  s32 sent22    4419           17      Key  Incorrect    22   140       32        0
813  s32 sent23    2846            3      Key  Incorrect    23    90       32        0
814  s32 sent24    2591           15      Key  Incorrect    24    71       36        0
815  s32 sent25    3553           19      Key    Correct    25   129       28        1
816  s32 sent26    2416           20      Key    Correct    26    65       37        1
817  s32 sent27    6212           10      Key    Correct    27   118       53        1
818  s32 sent28    3561           23      Key    Correct    28    87       41        1
819  s32 sent29    2990           21      Key    Correct    29    87       34        1
820  s32 sent30    4368            1      Key    Correct    30   125       35        1
821  s32 sent31    3428            7      Key    Correct    31   118       29        1
822  s32 sent32    2991           31      Key    Correct    32    87       34        1
823  s04 sent01    9527           10      Jar    Correct     1   120       79        1
824  s04 sent02    9460           13      Jar    Correct     2   138       69        1
825  s04 sent03    8980           20      Jar  Incorrect     3   114       79        0
826  s04 sent04   10102           19      Jar  Incorrect     4   113       89        0
827  s04 sent05   13010            7      Jar  Incorrect     5   127      102        0
828  s04 sent06    9208           17      Jar  Incorrect     6   130       71        0
829  s04 sent07    4969           24      Jar  Incorrect     7    96       52        0
830  s04 sent08    3996           21      Jar  Incorrect     8   107       37        0
831  s04 sent09    4618           22      Jar    Correct     9   113       41        1
832  s04 sent10    6303           11      Jar    Correct    10   109       58        1
833  s04 sent11    7421            2      Jar    Correct    11    98       76        1
834  s04 sent12    6965           31      Jar    Correct    12   133       52        1
835  s04 sent13    6016           27      Jar    Correct    13   130       46        1
836  s04 sent14    8531            6      Jar    Correct    14    94       91        1
837  s04 sent15    4183           23      Jar    Correct    15    92       45        1
838  s04 sent16    7462            4      Jar    Correct    16   135       55        1
839  s04 sent17   11155           18      Key    Correct    17   126       89        1
840  s04 sent18    7052           32      Key    Correct    18   128       55        1
841  s04 sent19    8611           16      Key    Correct    19    96       90        1
842  s04 sent20    6251           12      Key    Correct    20    93       67        1
843  s04 sent21    4396            5      Key    Correct    21    95       46        1
844  s04 sent22   10577           26      Key    Correct    22   140       76        1
845  s04 sent23    6689           15      Key    Correct    23    90       74        1
846  s04 sent24    6762            1      Key    Correct    24    71       95        1
847  s04 sent25    4975           29      Key    Correct    25   129       39        1
848  s04 sent26    7550            9      Key    Correct    26    65      116        1
849  s04 sent27    5175           30      Key    Correct    27   118       44        1
850  s04 sent28    5187           25      Key    Correct    28    87       60        1
851  s04 sent29    9534            3      Key  Incorrect    29    87      110        0
852  s04 sent30    8853            8      Key    Correct    30   125       71        1
853  s04 sent31   11163           14      Key  Incorrect    31   118       95        0
854  s04 sent32    4065           28      Key    Correct    32    87       47        1
855  s05 sent01    6653            8      Jar    Correct     1   120       55        1
856  s05 sent02    4187           19      Jar    Correct     2   138       30        1
857  s05 sent03    5020           17      Jar  Incorrect     3   114       44        0
858  s05 sent04    2917           28      Jar  Incorrect     4   113       26        0
859  s05 sent05    5042           27      Jar  Incorrect     5   127       40        0
860  s05 sent06    5510           23      Jar  Incorrect     6   130       42        0
861  s05 sent07    2710           22      Jar  Incorrect     7    96       28        0
862  s05 sent08    5568           13      Jar  Incorrect     8   107       52        0
863  s05 sent09    3931            2      Jar    Correct     9   113       35        1
864  s05 sent10    3396            7      Jar    Correct    10   109       31        1
865  s05 sent11    3581           14      Jar    Correct    11    98       37        1
866  s05 sent12    4873           15      Jar    Correct    12   133       37        1
867  s05 sent13    2948           11      Jar    Correct    13   130       23        1
868  s05 sent14    3802           25      Jar    Correct    14    94       40        1
869  s05 sent15    2450            9      Jar    Correct    15    92       27        1
870  s05 sent17    4501            6      Key    Correct    17   126       36        1
871  s05 sent18    4531           29      Key    Correct    18   128       35        1
872  s05 sent19    3971           20      Key    Correct    19    96       41        1
873  s05 sent20    8523           31      Key    Correct    20    93       92        1
874  s05 sent21    2884            4      Key    Correct    21    95       30        1
875  s05 sent22    4687            5      Key    Correct    22   140       33        1
876  s05 sent23    3373           18      Key    Correct    23    90       37        1
877  s05 sent24    3143           26      Key    Correct    24    71       44        1
878  s05 sent25    5369           30      Key    Correct    25   129       42        1
879  s05 sent26    3837           24      Key    Correct    26    65       59        1
880  s05 sent27    4204            1      Key    Correct    27   118       36        1
881  s05 sent28    3562           12      Key    Correct    28    87       41        1
882  s05 sent29    4555           10      Key  Incorrect    29    87       52        0
883  s05 sent30    6392           21      Key    Correct    30   125       51        1
884  s05 sent31    4555           16      Key  Incorrect    31   118       39        0
885  s05 sent32    2584            3      Key    Correct    32    87       30        1
886  s06 sent01    4729           21      Jar    Correct     1   120       39        1
887  s06 sent02    3100           12      Jar    Correct     2   138       22        1
888  s06 sent03    2953           29      Jar  Incorrect     3   114       26        0
889  s06 sent04    3168           16      Jar  Incorrect     4   113       28        0
890  s06 sent05    6678            5      Jar  Incorrect     5   127       53        0
891  s06 sent06    5849            7      Jar  Incorrect     6   130       45        0
892  s06 sent07    2549           30      Jar  Incorrect     7    96       27        0
893  s06 sent08    6383           31      Jar  Incorrect     8   107       60        0
894  s06 sent09    2342           32      Jar    Correct     9   113       21        1
895  s06 sent10    4050           14      Jar    Correct    10   109       37        1
896  s06 sent11    1852           23      Jar    Correct    11    98       19        1
897  s06 sent12    3174           24      Jar    Correct    12   133       24        1
898  s06 sent13    2957           27      Jar    Correct    13   130       23        1
899  s06 sent14    1539           28      Jar    Correct    14    94       16        1
900  s06 sent15    6933            2      Jar    Correct    15    92       75        1
901  s06 sent16    4642            4      Jar    Correct    16   135       34        1
902  s06 sent17    2825           11      Key    Correct    17   126       22        1
903  s06 sent18    3129           10      Key    Correct    18   128       24        1
904  s06 sent19    2908           26      Key    Correct    19    96       30        1
905  s06 sent20    3839           15      Key    Correct    20    93       41        1
906  s06 sent21    2521           22      Key    Correct    21    95       27        1
907  s06 sent22    9483            3      Key    Correct    22   140       68        1
908  s06 sent23    3617            9      Key    Correct    23    90       40        1
909  s06 sent24    2036           18      Key    Correct    24    71       29        1
910  s06 sent25    2873           19      Key    Correct    25   129       22        1
911  s06 sent26    2372           20      Key    Correct    26    65       36        1
912  s06 sent27    6544           17      Key    Correct    27   118       55        1
913  s06 sent28    8962           13      Key    Correct    28    87      103        1
914  s06 sent29    5976            6      Key  Incorrect    29    87       69        0
915  s06 sent30    7034            1      Key    Correct    30   125       56        1
916  s06 sent31    2948           25      Key    Correct    31   118       25        1
917  s06 sent32    5269            8      Key    Correct    32    87       61        1
918  s07 sent01    4462           12      Jar    Correct     1   120       37        1
919  s07 sent02    4654            8      Jar  Incorrect     2   138       34        0
920  s07 sent03    5834           24      Jar    Correct     3   114       51        1
921  s07 sent04    6184           31      Jar  Incorrect     4   113       55        0
922  s07 sent05    7300           21      Jar  Incorrect     5   127       57        0
923  s07 sent06    5672           26      Jar  Incorrect     6   130       44        0
924  s07 sent07    3701           16      Jar  Incorrect     7    96       39        0
925  s07 sent08    4250           22      Jar    Correct     8   107       40        1
926  s07 sent09    3895            6      Jar    Correct     9   113       34        1
927  s07 sent10    3616           15      Jar    Correct    10   109       33        1
928  s07 sent11    4144           23      Jar    Correct    11    98       42        1
929  s07 sent12    7548           29      Jar    Correct    12   133       57        1
930  s07 sent13    3758           20      Jar    Correct    13   130       29        1
931  s07 sent14   16810            1      Jar  Incorrect    14    94      179        0
932  s07 sent15    4921           14      Jar    Correct    15    92       53        1
933  s07 sent16    6260           30      Jar    Correct    16   135       46        1
934  s07 sent17    8437           27      Key    Correct    17   126       67        1
935  s07 sent18    6687            2      Key    Correct    18   128       52        1
936  s07 sent19    3117            7      Key    Correct    19    96       32        1
937  s07 sent20    5605           13      Key    Correct    20    93       60        1
938  s07 sent21    4115           11      Key    Correct    21    95       43        1
939  s07 sent22    4953            4      Key    Correct    22   140       35        1
940  s07 sent23    3547           17      Key    Correct    23    90       39        1
941  s07 sent24    3597           25      Key    Correct    24    71       51        1
942  s07 sent25    4156            3      Key    Correct    25   129       32        1
943  s07 sent26    2674            5      Key    Correct    26    65       41        1
944  s07 sent27    4104           18      Key    Correct    27   118       35        1
945  s07 sent28    2738           10      Key    Correct    28    87       31        1
946  s07 sent29    4398            9      Key  Incorrect    29    87       51        0
947  s07 sent30    6397           19      Key    Correct    30   125       51        1
948  s07 sent31    5463           28      Key    Correct    31   118       46        1
949  s07 sent32    2688           32      Key    Correct    32    87       31        1
950  s08 sent01    6338           17      Jar    Correct     1   120       53        1
951  s08 sent02    6459           16      Jar    Correct     2   138       47        1
952  s08 sent03    6349            1      Jar    Correct     3   114       56        1
953  s08 sent04    4591           18      Jar  Incorrect     4   113       41        0
954  s08 sent05    6179           24      Jar  Incorrect     5   127       49        0
955  s08 sent06    7009            2      Jar    Correct     6   130       54        1
956  s08 sent07    4791           27      Jar  Incorrect     7    96       50        0
957  s08 sent08    5118           14      Jar  Incorrect     8   107       48        0
958  s08 sent09    7967           12      Jar    Correct     9   113       71        1
959  s08 sent10    4321           25      Jar    Correct    10   109       40        1
960  s08 sent11    6883           11      Jar    Correct    11    98       70        1
961  s08 sent12    5985            7      Jar  Incorrect    12   133       45        0
962  s08 sent13    4555            4      Jar  Incorrect    13   130       35        0
963  s08 sent14    4971           26      Jar    Correct    14    94       53        1
964  s08 sent15    5343           31      Jar    Correct    15    92       58        1
965  s08 sent16    5679           19      Jar    Correct    16   135       42        1
966  s08 sent17    6529            8      Key    Correct    17   126       52        1
967  s08 sent18    7001           30      Key    Correct    18   128       55        1
968  s08 sent19    5489           29      Key    Correct    19    96       57        1
969  s08 sent20    4188           21      Key    Correct    20    93       45        1
970  s08 sent21    3529           32      Key    Correct    21    95       37        1
971  s08 sent22    5724           20      Key    Correct    22   140       41        1
972  s08 sent23    2908           23      Key    Correct    23    90       32        1
973  s08 sent24    8074            9      Key    Correct    24    71      114        1
974  s08 sent25    4809            6      Key    Correct    25   129       37        1
975  s08 sent26    4412           22      Key    Correct    26    65       68        1
976  s08 sent27    4494            5      Key    Correct    27   118       38        1
977  s08 sent28    5728           10      Key    Correct    28    87       66        1
978  s08 sent29    7610           28      Key  Incorrect    29    87       87        0
979  s08 sent30    5555           13      Key    Correct    30   125       44        1
980  s08 sent31    6208           15      Key    Correct    31   118       53        1
981  s08 sent32    3789            3      Key    Correct    32    87       44        1
982  s09 sent01    4347           18      Jar  Incorrect     1   120       36        0
983  s09 sent02    3546           26      Jar    Correct     2   138       26        1
984  s09 sent03    3328           13      Jar    Correct     3   114       29        1
985  s09 sent04    2175           25      Jar    Correct     4   113       19        1
986  s09 sent05    4231           32      Jar    Correct     5   127       33        1
987  s09 sent06    6590           22      Jar  Incorrect     6   130       51        0
988  s09 sent07    5986            2      Jar    Correct     7    96       62        1
989  s09 sent08    3820           19      Jar    Correct     8   107       36        1
990  s09 sent09    5416            6      Jar    Correct     9   113       48        1
991  s09 sent10    4167            8      Jar  Incorrect    10   109       38        0
992  s09 sent11    3646           27      Jar    Correct    11    98       37        1
993  s09 sent12    3288           10      Jar    Correct    12   133       25        1
994  s09 sent13    4547           17      Jar    Correct    13   130       35        1
995  s09 sent14    5382           23      Jar  Incorrect    14    94       57        0
996  s09 sent15    3958           20      Jar    Correct    15    92       43        1
997  s09 sent16    4595           15      Jar    Correct    16   135       34        1
998  s09 sent17   10395           14      Key    Correct    17   126       83        1
999  s09 sent18    5351           28      Key  Incorrect    18   128       42        0
1000 s09 sent19    4168            9      Key    Correct    19    96       43        1
1001 s09 sent20    4446           21      Key  Incorrect    20    93       48        0
1002 s09 sent21    5612            5      Key    Correct    21    95       59        1
1003 s09 sent22   13547            1      Key  Incorrect    22   140       97        0
1004 s09 sent23    4296           29      Key  Incorrect    23    90       48        0
1005 s09 sent24    2986           11      Key  Incorrect    24    71       42        0
1006 s09 sent25    7146            3      Key    Correct    25   129       55        1
1007 s09 sent26    4018           30      Key    Correct    26    65       62        1
1008 s09 sent27    6185            4      Key    Correct    27   118       52        1
1009 s09 sent28    3023           12      Key    Correct    28    87       35        1
1010 s09 sent29    4887            7      Key    Correct    29    87       56        1
1011 s09 sent30    5508           16      Key    Correct    30   125       44        1
1012 s09 sent31    3697           31      Key  Incorrect    31   118       31        0
1013 s09 sent32    2237           24      Key    Correct    32    87       26        1
```

```r
names(ds0)
```

```
 [1] "Sub"          "Sent"         "TotalRT"      "SentPosition" "SentType"     "Corectness"   "Sent2"       
 [8] "Char."        "RTbyChar"     "Accuracy"    
```

Rename tagged data to be more workable in R while remaning sufficiently descriptive 

```r
# rename variables for easier handling
ds0 <- plyr::rename(ds0, 
            c("SentPosition"="pos",
              "SentType"="type",
              "Accuracy"="accuracy",
              "TotalRT"="trt",
              "RTbyChar"="crt"))
```
Inspection of reaction time data to find outliers that are likely not refelctive of real responses. 

```r
# with $
class(ds0$trt)
```

```
[1] "integer"
```

```r
str(ds0$trt)
```

```
 int [1:1013] 7481 8528 9806 6323 8141 4397 6333 4622 4299 4977 ...
```

```r
ds0$trt
```

```
   [1]  7481  8528  9806  6323  8141  4397  6333  4622  4299  4977  3825  8409  4785 10529  5141  8412  9348  4155 10231
  [20]  7463  5089  7129  6268  7361  7171  3838  8057  4450    65  6306  6729  2514  7410 12802  7017  3895  4549  4367
  [39]  3522  5819  2608  3365  6318  4745  4850  3630  2299  5241  5798  3361  3163  7076  5701  4223  3595  8441  3317
  [58]  3482  6779  3554  4457  3300  5949  3101  1245  6521  1806 12832  4590  2567  1568  2897  1684  2266  4781  2845
  [77]  4569  2289  6037  4481  2529  2435  2710  5538  4194  1818  2082  4650 14788  3546  3179  2929  2027  4768  2020
  [96]  3771  5951  3764  6769  3707  4094  7014  2297  4354  2568  2825  3993  2697  3990  3771  4764  3326  2290  3275
 [115]  3215  4068  2308  2279  4452  3354  5786  4582  2434  4321  4768  4757  1682  3097  4714  4126  5422 10024  5494
 [134]  3873  3581  2692  2501  4011  3381  2279  2868  2747  3196  5359  2806  3689  8027  3233  5176  8655  2292  3053
 [153]  5151  2227  3216  5807  2219  5261  5498  9145 10375  4662  5913  5335  7337  5642  7454 11758  6069  7027  6292
 [172]  4124  6857  9324  8015  5212  7418  8030  5438  7116  6770  4413  5175  5019  4975  5679  6005  3584  3294  6221
 [191]  4677  4002  6954  5562  4504  4654  9174  4125  5910  4198  3980  4314  2916  6521  9525 12466  5307  3504  2536
 [210]  4792  5251  7609  6069  3820  8593  4613  2863  6092  6054  5105  5546  5842  5910  5683  6849  7080  7334  3703
 [229]  4611  3767  6328  7517  6350  4687  4592  7614  6014  4980  7049  3099  5567  6895  4792  5782  3723  5239  6353
 [248]  5836  5830  8951  3861  5245  7047  6020  3343 10812  5744  4447  3335  8544  2816  3438  4179  5242  3034  6063
 [267]  5285  7566  3158  6303  2449  5337  3818  4276  3487  5562  2471  2865  4922  3863  6424  2635  5359  7696 18717
 [286]  4607 10263  7283  8206  8203  8305  4378  5342 10561 11626  9703  5252  6795  5918  6782  8089  7233  6822  7364
 [305]  4320  7730  9189  5129  5052 11150 10463 12328  7180  4425  3838  5987  2886  2287  2937  4027  5074  3625  2856
 [324]  5249  3585  5860  5460  3433  5216  3666  4367  3821  7630  5627  3271  4586  3689  3301  8044  4956  5408  4313
 [343]  5742  7489  3756  3151  2455  3769  6045  2289  3946  4334  4711  2910  3271  3312  3287  4214  3275  7200  2476
 [362]  4213  7148  6485  4116  2933  2502  4318  1978  3021  4461  3366  4121  1677  4511  4153  5734  2010  5205  4034
 [381]  5882  3818 23119  4044  3128  4552  6601  2364  4519  5416  5683  2545  4478  7418  5673  5423  5623  3860  5128
 [400]  5319  4393  2335  5393  4434  4335  3804  3917  6568  4631  5808 17312  5193  5145  5467  5577  4683  4025  3842
 [419]  3720  4182  4008  5803  3578  3789  9473  4390  9783  6006  5281  3291  6153  5633  4306  3231  3938  8603  6527
 [438]  4645  5436  4831  9044  4258  3661  5414  4889  4240  4316 21925  4783  3202  3893  1966  6378  3011  4015  2558
 [457]  4961  3846  2873  3465  4374  7376  5328  4729  6056  4120  5173  3607  3908  5320  7129  2107  4461  4406  8872
 [476]  4948  8346  7645  4012  3533 13313  4768  8957  7115  4038  6691  5696 13670  8284  6403  6520  3280 12419  4490
 [495]  5449  7672  6242  7179  8338  9785  8101  7768  5757  2305  3252  5951  5631  4641  3985  4270  2972  3333  3506
 [514]  3360  4996  4630  3370  3988  6223  6417  4437  3769  3769  3727  9759  5018  5920  3665  6400  6478 12447  5051
 [533]  5888  8623  5408  6515  5082  6688  4625 11181  7058  5788  5363  4056  5250  4153  4397  8290  8415  3279  3458
 [552]  8972 10913  6288  8573  4489  5827  6705  5672  5095  5734 11755  8052  4453  7247  9060  3322  2974 15146  3195
 [571]  3823  6988  5977  2858 10792  3562  5168  5323  1555  7553  3806  3632  9220  4913  5544  6702  5359  2517 15134
 [590] 15965  4170  9140  3567  4521  3100  4311  3236  3273  3135  4655  3540  4085  3265  5810  2718  3604  4246  2909
 [609]  3966  2784  2655  2426  3503  4016  2477  5335  4099  3097  3884  2090  4375  2112  2553  5116  3748  3201  4197
 [628]  2551  3516  4651  2533  8689  8566  6252  3149  5579  4633  4612  7465  5982  2553  2689  4465  3751  3847  4399
 [647]  9569  4338  7309  3832  3515  5352  4685  6840  5491  6621  3806  4751 14194  6744  3722  5414  4485  5343  5119
 [666]  7401  5643 11219  4595  5779  5527  3317  5775  7436  6148  6716  4200  5231  7549 11233  5495  7981  7811  7745
 [685]  5174  5047  4677  3514  6103  4641  6065  8714  7998  3596  3959  2831  8077  2952  2770  3208  2994  4260  4015
 [704]  2234  4420  7207  3276 11525  3252  8739 23824  5826  6384  5082  4169  6045  4408  3857  4994  2581  8931  4108
 [723]  5641  5935  5403  4582  4782  5743  4775  3055  5211  5229  4962  3260  6111  2581  2286  5922  3829  4870  8397
 [742]  4821  4927  7061  3743  4885  2989  9289  4477  4442  5436  3944  4409  5972  6332  8409  6982  5340  2474  5353
 [761]  4277  5272  5409  3752  5559 10448  8298  3899 11923  5193  1951  3224  4726  4727  5618  7037  9138  8195 12552
 [780]  9487  3379  5575 10868  3229  4644  5574  4441  6851  8645  2405  3567  5463  3654  3994  4435  3876  3019  3905
 [799]  3650  3624   109  5306  5077  3311  2579  4241  4634  4870  3577  3963     6  4419  2846  2591  3553  2416  6212
 [818]  3561  2990  4368  3428  2991  9527  9460  8980 10102 13010  9208  4969  3996  4618  6303  7421  6965  6016  8531
 [837]  4183  7462 11155  7052  8611  6251  4396 10577  6689  6762  4975  7550  5175  5187  9534  8853 11163  4065  6653
 [856]  4187  5020  2917  5042  5510  2710  5568  3931  3396  3581  4873  2948  3802  2450  4501  4531  3971  8523  2884
 [875]  4687  3373  3143  5369  3837  4204  3562  4555  6392  4555  2584  4729  3100  2953  3168  6678  5849  2549  6383
 [894]  2342  4050  1852  3174  2957  1539  6933  4642  2825  3129  2908  3839  2521  9483  3617  2036  2873  2372  6544
 [913]  8962  5976  7034  2948  5269  4462  4654  5834  6184  7300  5672  3701  4250  3895  3616  4144  7548  3758 16810
 [932]  4921  6260  8437  6687  3117  5605  4115  4953  3547  3597  4156  2674  4104  2738  4398  6397  5463  2688  6338
 [951]  6459  6349  4591  6179  7009  4791  5118  7967  4321  6883  5985  4555  4971  5343  5679  6529  7001  5489  4188
 [970]  3529  5724  2908  8074  4809  4412  4494  5728  7610  5555  6208  3789  4347  3546  3328  2175  4231  6590  5986
 [989]  3820  5416  4167  3646  3288  4547  5382  3958  4595 10395  5351  4168  4446  5612 13547  4296  2986  7146  4018
[1008]  6185  3023  4887  5508  3697  2237
```

```r
sort(ds0$trt, decreasing = FALSE)
```

```
   [1]     6    65   109  1245  1539  1555  1568  1677  1682  1684  1806  1818  1852  1951  1966  1978  2010  2020  2027
  [20]  2036  2082  2090  2107  2112  2175  2219  2227  2234  2237  2266  2279  2279  2286  2287  2289  2289  2290  2292
  [39]  2297  2299  2305  2308  2335  2342  2364  2372  2405  2416  2426  2434  2435  2449  2450  2455  2471  2474  2476
  [58]  2477  2501  2502  2514  2517  2521  2529  2533  2536  2545  2549  2551  2553  2553  2558  2567  2568  2579  2581
  [77]  2581  2584  2591  2608  2635  2655  2674  2688  2689  2692  2697  2710  2710  2718  2738  2747  2770  2784  2806
  [96]  2816  2825  2825  2831  2845  2846  2856  2858  2863  2865  2868  2873  2873  2884  2886  2897  2908  2908  2909
 [115]  2910  2916  2917  2929  2933  2937  2948  2948  2952  2953  2957  2972  2974  2986  2989  2990  2991  2994  3011
 [134]  3019  3021  3023  3034  3053  3055  3097  3097  3099  3100  3100  3101  3117  3128  3129  3135  3143  3149  3151
 [153]  3158  3163  3168  3174  3179  3195  3196  3201  3202  3208  3215  3216  3224  3229  3231  3233  3236  3252  3252
 [172]  3260  3265  3271  3271  3273  3275  3275  3276  3279  3280  3287  3288  3291  3294  3300  3301  3311  3312  3317
 [191]  3317  3322  3326  3328  3333  3335  3343  3354  3360  3361  3365  3366  3370  3373  3379  3381  3396  3428  3433
 [210]  3438  3458  3465  3482  3487  3503  3504  3506  3514  3515  3516  3522  3529  3533  3540  3546  3546  3547  3553
 [229]  3554  3561  3562  3562  3567  3567  3577  3578  3581  3581  3584  3585  3595  3596  3597  3604  3607  3616  3617
 [248]  3624  3625  3630  3632  3646  3650  3654  3661  3665  3666  3689  3689  3697  3701  3703  3707  3720  3722  3723
 [267]  3727  3743  3748  3751  3752  3756  3758  3764  3767  3769  3769  3769  3771  3771  3789  3789  3802  3804  3806
 [286]  3806  3818  3818  3820  3820  3821  3823  3825  3829  3832  3837  3838  3838  3839  3842  3846  3847  3857  3860
 [305]  3861  3863  3873  3876  3884  3893  3895  3895  3899  3905  3908  3917  3931  3938  3944  3946  3958  3959  3963
 [324]  3966  3971  3980  3985  3988  3990  3993  3994  3996  4002  4008  4011  4012  4015  4015  4016  4018  4025  4027
 [343]  4034  4038  4044  4050  4056  4065  4068  4085  4094  4099  4104  4108  4115  4116  4120  4121  4124  4125  4126
 [362]  4144  4153  4153  4155  4156  4167  4168  4169  4170  4179  4182  4183  4187  4188  4194  4197  4198  4200  4204
 [381]  4213  4214  4223  4231  4240  4241  4246  4250  4258  4260  4270  4276  4277  4296  4299  4306  4311  4313  4314
 [400]  4316  4318  4320  4321  4321  4334  4335  4338  4347  4354  4367  4367  4368  4374  4375  4378  4390  4393  4396
 [419]  4397  4397  4398  4399  4406  4408  4409  4412  4413  4419  4420  4425  4434  4435  4437  4441  4442  4446  4447
 [438]  4450  4452  4453  4457  4461  4461  4462  4465  4477  4478  4481  4485  4489  4490  4494  4501  4504  4511  4519
 [457]  4521  4531  4547  4549  4552  4555  4555  4555  4569  4582  4582  4586  4590  4591  4592  4595  4595  4607  4611
 [476]  4612  4613  4618  4622  4625  4630  4631  4633  4634  4641  4641  4642  4644  4645  4650  4651  4654  4654  4655
 [495]  4662  4677  4677  4683  4685  4687  4687  4711  4714  4726  4727  4729  4729  4745  4751  4757  4764  4768  4768
 [514]  4768  4775  4781  4782  4783  4785  4791  4792  4792  4809  4821  4831  4850  4870  4870  4873  4885  4887  4889
 [533]  4913  4921  4922  4927  4948  4953  4956  4961  4962  4969  4971  4975  4975  4977  4980  4994  4996  5018  5019
 [552]  5020  5042  5047  5051  5052  5074  5077  5082  5082  5089  5095  5105  5116  5118  5119  5128  5129  5141  5145
 [571]  5151  5168  5173  5174  5175  5175  5176  5187  5193  5193  5205  5211  5212  5216  5229  5231  5239  5241  5242
 [590]  5245  5249  5250  5251  5252  5261  5269  5272  5281  5285  5306  5307  5319  5320  5323  5328  5335  5335  5337
 [609]  5340  5342  5343  5343  5351  5352  5353  5359  5359  5359  5363  5369  5382  5393  5403  5408  5408  5409  5414
 [628]  5414  5416  5416  5422  5423  5436  5436  5438  5449  5460  5463  5463  5467  5489  5491  5494  5495  5498  5508
 [647]  5510  5527  5538  5544  5546  5555  5559  5562  5562  5567  5568  5574  5575  5577  5579  5605  5612  5618  5623
 [666]  5627  5631  5633  5641  5642  5643  5672  5672  5673  5679  5679  5683  5683  5696  5701  5724  5728  5734  5734
 [685]  5742  5743  5744  5757  5775  5779  5782  5786  5788  5798  5803  5807  5808  5810  5819  5826  5827  5830  5834
 [704]  5836  5842  5849  5860  5882  5888  5910  5910  5913  5918  5920  5922  5935  5949  5951  5951  5972  5976  5977
 [723]  5982  5985  5986  5987  6005  6006  6014  6016  6020  6037  6045  6045  6054  6056  6063  6065  6069  6069  6092
 [742]  6103  6111  6148  6153  6179  6184  6185  6208  6212  6221  6223  6242  6251  6252  6260  6268  6288  6292  6303
 [761]  6303  6306  6318  6323  6328  6332  6333  6338  6349  6350  6353  6378  6383  6384  6392  6397  6400  6403  6417
 [780]  6424  6459  6478  6485  6515  6520  6521  6521  6527  6529  6544  6568  6590  6601  6621  6653  6678  6687  6688
 [799]  6689  6691  6702  6705  6716  6729  6744  6762  6769  6770  6779  6782  6795  6822  6840  6849  6851  6857  6883
 [818]  6895  6933  6954  6965  6982  6988  7001  7009  7014  7017  7027  7034  7037  7047  7049  7052  7058  7061  7076
 [837]  7080  7115  7116  7129  7129  7146  7148  7171  7179  7180  7200  7207  7233  7247  7283  7300  7309  7334  7337
 [856]  7361  7364  7376  7401  7410  7418  7418  7421  7436  7454  7462  7463  7465  7481  7489  7517  7548  7549  7550
 [875]  7553  7566  7609  7610  7614  7630  7645  7672  7696  7730  7745  7768  7811  7967  7981  7998  8015  8027  8030
 [894]  8044  8052  8057  8074  8077  8089  8101  8141  8195  8203  8206  8284  8290  8298  8305  8338  8346  8397  8409
 [913]  8409  8412  8415  8437  8441  8523  8528  8531  8544  8566  8573  8593  8603  8611  8623  8645  8655  8689  8714
 [932]  8739  8853  8872  8931  8951  8957  8962  8972  8980  9044  9060  9138  9140  9145  9174  9189  9208  9220  9289
 [951]  9324  9348  9460  9473  9483  9487  9525  9527  9534  9569  9703  9759  9783  9785  9806 10024 10102 10231 10263
 [970] 10375 10395 10448 10463 10529 10561 10577 10792 10812 10868 10913 11150 11155 11163 11181 11219 11233 11525 11626
 [989] 11755 11758 11923 12328 12419 12447 12466 12552 12802 12832 13010 13313 13547 13670 14194 14788 15134 15146 15965
[1008] 16810 17312 18717 21925 23119 23824
```
Apply a filter to remove trials with a total RT<1000ms (these are behaviourally speaking not possible and must be due to an accidental response before task completion) as well as reaction times greater than 20000ms as these are upper-bound outliers and reflect less than 0.005% of the total dataset. 

```r
ds1<-subset(ds0, trt>1000)
dsf<-subset(ds1, trt<20000)
sort(dsf$trt, decreasing = FALSE)
```

```
   [1]  1245  1539  1555  1568  1677  1682  1684  1806  1818  1852  1951  1966  1978  2010  2020  2027  2036  2082  2090
  [20]  2107  2112  2175  2219  2227  2234  2237  2266  2279  2279  2286  2287  2289  2289  2290  2292  2297  2299  2305
  [39]  2308  2335  2342  2364  2372  2405  2416  2426  2434  2435  2449  2450  2455  2471  2474  2476  2477  2501  2502
  [58]  2514  2517  2521  2529  2533  2536  2545  2549  2551  2553  2553  2558  2567  2568  2579  2581  2581  2584  2591
  [77]  2608  2635  2655  2674  2688  2689  2692  2697  2710  2710  2718  2738  2747  2770  2784  2806  2816  2825  2825
  [96]  2831  2845  2846  2856  2858  2863  2865  2868  2873  2873  2884  2886  2897  2908  2908  2909  2910  2916  2917
 [115]  2929  2933  2937  2948  2948  2952  2953  2957  2972  2974  2986  2989  2990  2991  2994  3011  3019  3021  3023
 [134]  3034  3053  3055  3097  3097  3099  3100  3100  3101  3117  3128  3129  3135  3143  3149  3151  3158  3163  3168
 [153]  3174  3179  3195  3196  3201  3202  3208  3215  3216  3224  3229  3231  3233  3236  3252  3252  3260  3265  3271
 [172]  3271  3273  3275  3275  3276  3279  3280  3287  3288  3291  3294  3300  3301  3311  3312  3317  3317  3322  3326
 [191]  3328  3333  3335  3343  3354  3360  3361  3365  3366  3370  3373  3379  3381  3396  3428  3433  3438  3458  3465
 [210]  3482  3487  3503  3504  3506  3514  3515  3516  3522  3529  3533  3540  3546  3546  3547  3553  3554  3561  3562
 [229]  3562  3567  3567  3577  3578  3581  3581  3584  3585  3595  3596  3597  3604  3607  3616  3617  3624  3625  3630
 [248]  3632  3646  3650  3654  3661  3665  3666  3689  3689  3697  3701  3703  3707  3720  3722  3723  3727  3743  3748
 [267]  3751  3752  3756  3758  3764  3767  3769  3769  3769  3771  3771  3789  3789  3802  3804  3806  3806  3818  3818
 [286]  3820  3820  3821  3823  3825  3829  3832  3837  3838  3838  3839  3842  3846  3847  3857  3860  3861  3863  3873
 [305]  3876  3884  3893  3895  3895  3899  3905  3908  3917  3931  3938  3944  3946  3958  3959  3963  3966  3971  3980
 [324]  3985  3988  3990  3993  3994  3996  4002  4008  4011  4012  4015  4015  4016  4018  4025  4027  4034  4038  4044
 [343]  4050  4056  4065  4068  4085  4094  4099  4104  4108  4115  4116  4120  4121  4124  4125  4126  4144  4153  4153
 [362]  4155  4156  4167  4168  4169  4170  4179  4182  4183  4187  4188  4194  4197  4198  4200  4204  4213  4214  4223
 [381]  4231  4240  4241  4246  4250  4258  4260  4270  4276  4277  4296  4299  4306  4311  4313  4314  4316  4318  4320
 [400]  4321  4321  4334  4335  4338  4347  4354  4367  4367  4368  4374  4375  4378  4390  4393  4396  4397  4397  4398
 [419]  4399  4406  4408  4409  4412  4413  4419  4420  4425  4434  4435  4437  4441  4442  4446  4447  4450  4452  4453
 [438]  4457  4461  4461  4462  4465  4477  4478  4481  4485  4489  4490  4494  4501  4504  4511  4519  4521  4531  4547
 [457]  4549  4552  4555  4555  4555  4569  4582  4582  4586  4590  4591  4592  4595  4595  4607  4611  4612  4613  4618
 [476]  4622  4625  4630  4631  4633  4634  4641  4641  4642  4644  4645  4650  4651  4654  4654  4655  4662  4677  4677
 [495]  4683  4685  4687  4687  4711  4714  4726  4727  4729  4729  4745  4751  4757  4764  4768  4768  4768  4775  4781
 [514]  4782  4783  4785  4791  4792  4792  4809  4821  4831  4850  4870  4870  4873  4885  4887  4889  4913  4921  4922
 [533]  4927  4948  4953  4956  4961  4962  4969  4971  4975  4975  4977  4980  4994  4996  5018  5019  5020  5042  5047
 [552]  5051  5052  5074  5077  5082  5082  5089  5095  5105  5116  5118  5119  5128  5129  5141  5145  5151  5168  5173
 [571]  5174  5175  5175  5176  5187  5193  5193  5205  5211  5212  5216  5229  5231  5239  5241  5242  5245  5249  5250
 [590]  5251  5252  5261  5269  5272  5281  5285  5306  5307  5319  5320  5323  5328  5335  5335  5337  5340  5342  5343
 [609]  5343  5351  5352  5353  5359  5359  5359  5363  5369  5382  5393  5403  5408  5408  5409  5414  5414  5416  5416
 [628]  5422  5423  5436  5436  5438  5449  5460  5463  5463  5467  5489  5491  5494  5495  5498  5508  5510  5527  5538
 [647]  5544  5546  5555  5559  5562  5562  5567  5568  5574  5575  5577  5579  5605  5612  5618  5623  5627  5631  5633
 [666]  5641  5642  5643  5672  5672  5673  5679  5679  5683  5683  5696  5701  5724  5728  5734  5734  5742  5743  5744
 [685]  5757  5775  5779  5782  5786  5788  5798  5803  5807  5808  5810  5819  5826  5827  5830  5834  5836  5842  5849
 [704]  5860  5882  5888  5910  5910  5913  5918  5920  5922  5935  5949  5951  5951  5972  5976  5977  5982  5985  5986
 [723]  5987  6005  6006  6014  6016  6020  6037  6045  6045  6054  6056  6063  6065  6069  6069  6092  6103  6111  6148
 [742]  6153  6179  6184  6185  6208  6212  6221  6223  6242  6251  6252  6260  6268  6288  6292  6303  6303  6306  6318
 [761]  6323  6328  6332  6333  6338  6349  6350  6353  6378  6383  6384  6392  6397  6400  6403  6417  6424  6459  6478
 [780]  6485  6515  6520  6521  6521  6527  6529  6544  6568  6590  6601  6621  6653  6678  6687  6688  6689  6691  6702
 [799]  6705  6716  6729  6744  6762  6769  6770  6779  6782  6795  6822  6840  6849  6851  6857  6883  6895  6933  6954
 [818]  6965  6982  6988  7001  7009  7014  7017  7027  7034  7037  7047  7049  7052  7058  7061  7076  7080  7115  7116
 [837]  7129  7129  7146  7148  7171  7179  7180  7200  7207  7233  7247  7283  7300  7309  7334  7337  7361  7364  7376
 [856]  7401  7410  7418  7418  7421  7436  7454  7462  7463  7465  7481  7489  7517  7548  7549  7550  7553  7566  7609
 [875]  7610  7614  7630  7645  7672  7696  7730  7745  7768  7811  7967  7981  7998  8015  8027  8030  8044  8052  8057
 [894]  8074  8077  8089  8101  8141  8195  8203  8206  8284  8290  8298  8305  8338  8346  8397  8409  8409  8412  8415
 [913]  8437  8441  8523  8528  8531  8544  8566  8573  8593  8603  8611  8623  8645  8655  8689  8714  8739  8853  8872
 [932]  8931  8951  8957  8962  8972  8980  9044  9060  9138  9140  9145  9174  9189  9208  9220  9289  9324  9348  9460
 [951]  9473  9483  9487  9525  9527  9534  9569  9703  9759  9783  9785  9806 10024 10102 10231 10263 10375 10395 10448
 [970] 10463 10529 10561 10577 10792 10812 10868 10913 11150 11155 11163 11181 11219 11233 11525 11626 11755 11758 11923
 [989] 12328 12419 12447 12466 12552 12802 12832 13010 13313 13547 13670 14194 14788 15134 15146 15965 16810 17312 18717
```
Aggregate data such that for each subject a mean per-charatcer-rt by for each sentence type is reported, as well as an accuracy rating by sentence type

```r
agrt <-aggregate(dsf$crt, by=list(dsf$type,dsf$pos), 
                    FUN=mean, na.rm=TRUE)
agac<-aggregate(dsf$accuracy, by=list(dsf$type,dsf$pos), 
                FUN=mean, na.rm=TRUE)
dssent <- merge(agrt, agac, by=c("Group.1", "Group.2"))
dssent
```

```
   Group.1 Group.2      x.x       x.y
1      Jar       1 79.00000 0.6923077
2      Jar      10 48.25000 0.6250000
3      Jar      11 52.47059 0.7058824
4      Jar      12 40.75000 0.4375000
5      Jar      13 48.15385 0.5384615
6      Jar      14 39.87500 0.7500000
7      Jar      15 35.57143 0.7857143
8      Jar      16 43.26667 0.6000000
9      Jar      17 48.61905 0.5238095
10     Jar      18 39.37500 0.3750000
11     Jar      19 41.11765 0.5882353
12     Jar       2 66.06667 0.6000000
13     Jar      20 48.53333 0.5333333
14     Jar      21 41.00000 0.4615385
15     Jar      22 39.50000 0.7500000
16     Jar      23 36.00000 0.5882353
17     Jar      24 43.55000 0.5500000
18     Jar      25 35.05556 0.7222222
19     Jar      26 38.66667 0.5333333
20     Jar      27 35.81250 0.5625000
21     Jar      28 41.50000 0.4285714
22     Jar      29 38.58824 0.5294118
23     Jar       3 53.92857 0.5000000
24     Jar      30 43.42857 0.5714286
25     Jar      31 44.35294 0.5882353
26     Jar      32 36.66667 0.5000000
27     Jar       4 49.23529 0.4117647
28     Jar       5 44.23077 0.6923077
29     Jar       6 61.00000 0.5555556
30     Jar       7 45.40000 0.6000000
31     Jar       8 45.60000 0.4000000
32     Jar       9 46.43750 0.5625000
33     Key       1 89.25000 0.7500000
34     Key      10 50.81250 0.8750000
35     Key      11 46.66667 0.4666667
36     Key      12 47.62500 0.8125000
37     Key      13 50.26316 0.8421053
38     Key      14 62.68750 0.5625000
39     Key      15 47.50000 0.8333333
40     Key      16 52.70588 0.5294118
41     Key      17 45.72727 0.6363636
42     Key      18 47.87500 0.9375000
43     Key      19 48.93333 0.8000000
44     Key       2 60.33333 0.9333333
45     Key      20 41.94118 0.8823529
46     Key      21 53.36842 0.7894737
47     Key      22 56.68750 0.8750000
48     Key      23 52.53333 0.4666667
49     Key      24 56.33333 0.8333333
50     Key      25 56.71429 0.7857143
51     Key      26 51.70588 0.8235294
52     Key      27 55.56250 0.6250000
53     Key      28 52.55556 0.6111111
54     Key      29 49.46667 0.8666667
55     Key       3 55.50000 0.8333333
56     Key      30 50.61111 0.8888889
57     Key      31 46.78571 0.7857143
58     Key      32 47.10000 0.8000000
59     Key       4 44.78571 0.7142857
60     Key       5 51.00000 0.7894737
61     Key       6 49.42857 0.5714286
62     Key       7 51.76471 0.8823529
63     Key       8 52.47059 0.7058824
64     Key       9 63.18750 0.8125000
```

```r
#rename new variables
dssent <- plyr::rename(dssent, 
                      c("x.x"="rt",
                        "x.y"="accuracy",
                        "Group.1"="type", 
                        "Group.2"="pos"))
```
Aggregate data such that for each sentence a mean per-charatcer-rt by for each sentence type is reported, as well as an accuracy rating by sentence type. Note that sentence here refers not to the precise sentence stimuli presented, but the temporal position of the sentence within the experiment. 

```r
agrt2 <- aggregate(dsf$crt, by=list(dsf$type,dsf$Sub), 
                        FUN=mean, na.rm=TRUE)
agac2<-aggregate(dsf$accuracy, by=list(dsf$type,dsf$Sub), 
                FUN=mean, na.rm=TRUE)
dssub <- merge(agrt2, agac2, by=c("Group.1", "Group.2"))
dssub
```

```
   Group.1 Group.2      x.x       x.y
1      Jar     s01 57.87500 0.4375000
2      Jar     s02 34.06250 0.6875000
3      Jar     s03 42.00000 0.5625000
4      Jar     s04 65.12500 0.6250000
5      Jar     s05 36.46667 0.6000000
6      Jar     s06 34.31250 0.6250000
7      Jar     s07 51.87500 0.6250000
8      Jar     s08 50.75000 0.6250000
9      Jar     s09 38.06250 0.7500000
10     Jar     s10 44.12500 0.5000000
11     Jar     s11 33.46667 0.5333333
12     Jar     s12 36.46667 0.6000000
13     Jar     s13 34.13333 0.5333333
14     Jar     s14 60.25000 0.6250000
15     Jar     s15 44.00000 0.6250000
16     Jar     s16 50.40000 0.5333333
17     Jar     s17 45.56250 0.5625000
18     Jar     s18 71.93750 0.5000000
19     Jar     s19 36.12500 0.6250000
20     Jar     s20 40.46667 0.4666667
21     Jar     s21 49.56250 0.2500000
22     Jar     s22 35.46154 0.3846154
23     Jar     s23 60.12500 0.6250000
24     Jar     s24 36.18750 0.8125000
25     Jar     s25 51.12500 0.3750000
26     Jar     s26 48.68750 0.7500000
27     Jar     s27 31.43750 0.6250000
28     Jar     s28 46.31250 0.3750000
29     Jar     s29 52.66667 0.1333333
30     Jar     s30 41.75000 0.8750000
31     Jar     s31 48.62500 0.5000000
32     Jar     s32 33.80000 0.8666667
33     Key     s01 62.80000 0.8666667
34     Key     s02 37.68750 0.8750000
35     Key     s03 51.40000 0.5333333
36     Key     s04 73.37500 0.8750000
37     Key     s05 43.62500 0.8750000
38     Key     s06 44.25000 0.9375000
39     Key     s07 43.56250 0.9375000
40     Key     s08 54.37500 0.9375000
41     Key     s09 51.43750 0.6250000
42     Key     s10 48.18750 0.8750000
43     Key     s11 43.18750 0.5000000
44     Key     s12 36.93750 0.8750000
45     Key     s13 40.75000 0.8750000
46     Key     s14 61.53333 0.6000000
47     Key     s15 57.25000 0.8750000
48     Key     s16 56.56250 0.8750000
49     Key     s17 42.86667 0.8666667
50     Key     s18 74.75000 0.7500000
51     Key     s19 49.18750 0.8125000
52     Key     s20 47.31250 0.8125000
53     Key     s21 57.00000 0.8125000
54     Key     s22 45.50000 0.5000000
55     Key     s23 71.60000 0.4666667
56     Key     s24 61.12500 0.7500000
57     Key     s25 68.87500 0.7500000
58     Key     s26 57.50000 0.6250000
59     Key     s27 34.87500 1.0000000
60     Key     s28 58.12500 0.9375000
61     Key     s29 62.50000 0.5625000
62     Key     s30 54.06250 0.7500000
63     Key     s31 65.25000 0.5000000
64     Key     s32 36.40000 0.5333333
```

```r
#rename new variables
dssub <- plyr::rename(dssub, 
                       c("x.x"="rt",
                         "x.y"="accuracy",
                         "Group.1"="type", 
                         "Group.2"="subject"))
```

Save derived data so prepare for data analysis and graphing (in separate report)

```r
saveRDS(object=dssub, file="./data/derived/dialsubject.rds")
saveRDS(object=dssent, file="./data/derived/dialsentence.rds")
```
Clean up workspace 


