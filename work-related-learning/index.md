---
title: "index"
author: "Nischal Shakya"
date: "2/1/2020"
output: 
    html_document: 
      fig_caption: yes
      fig_width: 8
      highlight: haddock
      keep_md: yes
---



## Java Programming One 
This section shows the information about Java Programming One.

```
##  [1] "Roll.No."            "Name"                "Full.Marks"         
##  [4] "Marks.Obtained"      "Full.Marks.1"        "Marks.Obtained.1"   
##  [7] "Full.Marks.2"        "Marks.Obtained.2"    "Full.Marks.3"       
## [10] "Marks.Obtained.3"    "Marks.Obtained.4"    "Full.Marks.4"       
## [13] "Marks.Obtained.5"    "Marks.Obtained.6"    "Internal.Marks"     
## [16] "Full.Marks.5"        "Marks.Obtained.7"    "Marks.Obtained..40."
## [19] "Total"               "Grade"               "Grade.Point"        
## [22] "Remarks"
```

```
##  [1] "Roll.No."                      "Name"                         
##  [3] "Tutorial.Full.Marks"           "Tutorial.Marks.Obtained"      
##  [5] "Group.Project.Full.Marks"      "Group.Project.Obtained.Marks" 
##  [7] "Assignment.Full.Marks"         "Assignment.Marks.Obtained"    
##  [9] "Mid.Term.Full.Marks"           "Mid.Term.Marks.Obtained"      
## [11] "Mid.Term.FifteenPercent.Marks" "Lab.Test.Full.Marks"          
## [13] "Lab.Test.Marks.Obtained"       "Lab.Test.FifteenPercent.Marks"
## [15] "Internal.Marks"                "FinalExam.Full.Marks"         
## [17] "Final.Exam.Marks.Obtained"     "Final.Exam.FortyPercent.Marks"
## [19] "Total"                         "Grade"                        
## [21] "Grade.Point"                   "Remarks"
```

Since, we are grouping student on basiscs of grade we have to filter unique grade.

```
## [1] "B-" "B"  "A"  "C-" "C"  "C+" "D"  "B+" "F"
```

General inforamtion about variables

```
## 'data.frame':	35 obs. of  22 variables:
##  $ Roll.No.                     : int  1001749291 1001749046 1001749153 1001749154 1001749155 1001749156 1001749157 1001749158 1001749159 1001749071 ...
##  $ Name                         : Factor w/ 35 levels "Aakash Maharjan",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ Tutorial.Full.Marks          : int  10 10 10 10 10 10 10 10 10 10 ...
##  $ Tutorial.Marks.Obtained      : int  8 10 8 10 10 9 10 9 9 8 ...
##  $ Group.Project.Full.Marks     : int  20 20 20 20 20 20 20 20 20 20 ...
##  $ Group.Project.Obtained.Marks : int  12 16 13 19 17 14 14 12 13 8 ...
##  $ Assignment.Full.Marks        : int  30 30 30 30 30 30 30 30 30 30 ...
##  $ Assignment.Marks.Obtained    : int  20 26 21 29 27 23 24 21 22 16 ...
##  $ Mid.Term.Full.Marks          : int  40 40 40 40 40 40 40 40 40 40 ...
##  $ Mid.Term.Marks.Obtained      : Factor w/ 20 levels "16","18","18.5",..: 12 15 8 17 18 20 11 6 6 4 ...
##  $ Mid.Term.FifteenPercent.Marks: int  11 13 9 14 14 0 11 8 8 8 ...
##  $ Lab.Test.Full.Marks          : int  20 20 20 20 20 20 20 20 20 20 ...
##  $ Lab.Test.Marks.Obtained      : int  12 3 10 20 18 9 14 3 7 5 ...
##  $ Lab.Test.FifteenPercent.Marks: int  9 2 8 15 14 7 11 2 5 4 ...
##  $ Internal.Marks               : int  40 41 38 58 55 30 45 32 36 27 ...
##  $ FinalExam.Full.Marks         : int  100 100 100 100 100 100 100 100 100 100 ...
##  $ Final.Exam.Marks.Obtained    : int  58 57 58 82 66 29 48 48 41 57 ...
##  $ Final.Exam.FortyPercent.Marks: int  23 23 23 33 26 12 19 19 16 23 ...
##  $ Total                        : int  63 64 61 91 81 42 64 51 52 50 ...
##  $ Grade                        : Factor w/ 9 levels "A","B","B-","B+",..: 3 2 3 1 1 6 3 5 5 5 ...
##  $ Grade.Point                  : num  2.67 3 2.67 4 4 1.67 2.67 2 2 2 ...
##  $ Remarks                      : Factor w/ 2 levels "","Absent": 1 1 1 1 1 1 1 1 1 1 ...
```

Now, what we want to know is total number number of student on basics of grade.
<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["NoOfStudent.Grade"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["NoOfStudent.n"],"name":[2],"type":["int"],"align":["right"]}],"data":[{"1":"D","2":"1"},{"1":"B+","2":"1"},{"1":"C-","2":"3"},{"1":"C+","2":"3"},{"1":"F","2":"3"},{"1":"A","2":"4"},{"1":"B","2":"5"},{"1":"B-","2":"6"},{"1":"C","2":"9"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Plot bargraph to know the total number of student on basics of grade.
![](index_files/figure-html/Java programming one bargraph-1.png)<!-- -->

Top 5 student of java programming one
<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Name"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["Total"],"name":[2],"type":["int"],"align":["right"]},{"label":["Grade"],"name":[3],"type":["fctr"],"align":["left"]},{"label":["Grade.Point"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"Nhyu Joshi","2":"73","3":"B+","4":"3.33"},{"1":"Amar Agrawal","2":"91","3":"A","4":"4.00"},{"1":"Anish Shrestha","2":"81","3":"A","4":"4.00"},{"1":"Faraz Ahmed Khan","2":"90","3":"A","4":"4.00"},{"1":"Sanjiv Dangi","2":"83","3":"A","4":"4.00"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Total number of student attending java programming one, summary and standard deviation

```
## [1] 35
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    0.00   50.00   58.00   56.06   64.00   91.00
```

```
## [1] 18.07491
```

## Java Programing Two 
This section shows the information about java programming two.

```
##  [1] "Student.ID"             "Name"                   "Full.Marks"            
##  [4] "Score"                  "Marks.Obtained..15.."   "Full.Marks.1"          
##  [7] "Marks.Obtained..15...1" "Full.Marks.2"           "Marks.Obtained..25.."  
## [10] "Full.Marks.3"           "Marks.Obtained..5.."    "Internal.Marks..60.."  
## [13] "Full.Marks.4"           "Score.1"                "Marks.Obtained..40.."  
## [16] "Total..100.."           "Grade.after.40..rule"   "Grade.Point"           
## [19] "Remarks"
```

```
##  [1] "Student.ID"                     "Name"                          
##  [3] "Mid.Term.Full.Marks"            "Mid.Term.Marks.Obtained"       
##  [5] "Mid.Term.Fifteen.Percent.Marks" "Lab.Test.Full.Marks"           
##  [7] "Lab.Test.Marks.Obtained"        "Assignment.Full.Marks"         
##  [9] "Assignment.Marks.Obtained"      "Tutorial.Full.Marks"           
## [11] "Tutorial.Marks.Obtained"        "Internal.Marks"                
## [13] "Final.Exam.Full.Marks"          "Final.Exam.Marks.Obtained"     
## [15] "Final.Exam.FortyPercent.Marks"  "Total"                         
## [17] "Grade"                          "Grade.Point"                   
## [19] "Remarks"
```

Filter unique grades 

```r
uniqueGradeJavaTwo <- getUniqueAttribute(javaTwoDf$Grade)

print(uniqueGradeJavaTwo)
```

```
##  [1] "B-" "D"  "A"  "C"  "C+" "F"  "C-" "D-" "B+" "A-" "B"
```
Total number of student on basics of grade. 

```
## 'data.frame':	31 obs. of  19 variables:
##  $ Student.ID                    : int  1001749291 1001749046 1001849560 1001749153 1001749154 1001749155 1001749156 1001749157 1001749158 1001749159 ...
##  $ Name                          : Factor w/ 31 levels "Aakash Maharjan",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ Mid.Term.Full.Marks           : int  50 50 50 50 50 50 50 50 50 50 ...
##  $ Mid.Term.Marks.Obtained       : int  6 9 2 17 38 8 2 3 4 2 ...
##  $ Mid.Term.Fifteen.Percent.Marks: int  2 3 1 5 11 2 1 1 1 1 ...
##  $ Lab.Test.Full.Marks           : int  15 15 15 15 15 15 15 15 15 15 ...
##  $ Lab.Test.Marks.Obtained       : int  15 15 15 15 15 15 12 15 15 12 ...
##  $ Assignment.Full.Marks         : int  25 25 25 25 25 25 25 25 25 25 ...
##  $ Assignment.Marks.Obtained     : int  22 22 12 19 23 22 19 21 22 22 ...
##  $ Tutorial.Full.Marks           : int  5 5 5 5 5 5 5 5 5 5 ...
##  $ Tutorial.Marks.Obtained       : int  5 5 3 5 5 5 5 5 5 5 ...
##  $ Internal.Marks                : int  44 45 31 44 54 44 37 42 43 40 ...
##  $ Final.Exam.Full.Marks         : int  100 100 100 100 100 100 100 100 100 100 ...
##  $ Final.Exam.Marks.Obtained     : int  45 45 8 42 70 41 40 41 40 41 ...
##  $ Final.Exam.FortyPercent.Marks : int  18 18 3 17 28 16 16 16 16 16 ...
##  $ Total                         : int  62 63 34 61 82 60 53 58 59 56 ...
##  $ Grade                         : Factor w/ 11 levels "A","A-","B","B-",..: 4 4 9 4 1 4 6 8 8 8 ...
##  $ Grade.Point                   : num  2.67 2.67 1 2.67 4 2.67 2 2.33 2.33 2.33 ...
##  $ Remarks                       : Factor w/ 5 levels "","Abs(F)","Abs(M), NS",..: 1 1 1 1 1 1 1 1 1 1 ...
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["NoOfStudent.Grade"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["NoOfStudent.n"],"name":[2],"type":["int"],"align":["right"]}],"data":[{"1":"D","2":"1"},{"1":"C","2":"1"},{"1":"D-","2":"1"},{"1":"B+","2":"1"},{"1":"A-","2":"1"},{"1":"F","2":"2"},{"1":"B","2":"2"},{"1":"A","2":"3"},{"1":"C-","2":"5"},{"1":"C+","2":"6"},{"1":"B-","2":"8"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Bar graph showing total number of student on basics of grade 
![](index_files/figure-html/Java two bargraph showing student on basics of grade-1.png)<!-- -->

Top 5 student of java programming one 
<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Name"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["Total"],"name":[2],"type":["int"],"align":["right"]},{"label":["Grade"],"name":[3],"type":["fctr"],"align":["left"]},{"label":["Grade.Point"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"Rasana Shakya","2":"72","3":"B+","4":"3.33"},{"1":"Sushant Dangol","2":"76","3":"A-","4":"3.67"},{"1":"Amar Agarwal","2":"82","3":"A","4":"4.00"},{"1":"Faraz Ahmed Khan","2":"86","3":"A","4":"4.00"},{"1":"Sanjiv Dangi","2":"82","3":"A","4":"4.00"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Total number of student, summary and standard deviation 

```
## [1] 31
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    3.00   50.50   59.00   55.74   62.50   86.00
```

```
## [1] 18.49138
```

## Java Web Programming 
This section shows the information of java web programming 

```
##  [1] "Student.ID"             "Name"                   "Full.Marks"            
##  [4] "Score"                  "Marks.Obtained..20.."   "Full.Marks.1"          
##  [7] "Assignment.Score..20."  "Full.Marks.2"           "Group.Proj..Score..20."
## [10] "Internal.Marks..60.."   "Full.Marks.3"           "Score.1"               
## [13] "Marks.Obtained..40.."   "Total..100.."           "Grade.after.40..rule"  
## [16] "Grade.Point"            "Remarks"
```

```
##  [1] "Student.ID"                          
##  [2] "Name"                                
##  [3] "Mid.Term.Full.Marks"                 
##  [4] "Mid.Term.Marks.Obtained"             
##  [5] "Mid.Term.Twenty.Percent.Marks"       
##  [6] "Individual.Assignment.Full.Marks"    
##  [7] "Individual.Assignment.Marks.Obtained"
##  [8] "Group.Assignment.Full.Marks"         
##  [9] "Group.Assignment.Marks.Obtained"     
## [10] "Internal.Marks"                      
## [11] "Final.Exam.Full.Marks"               
## [12] "Final.Exam.Marks.Obtained"           
## [13] "Final.Exam.FortyPercent.Marks"       
## [14] "Total"                               
## [15] "Grade"                               
## [16] "Grade.Point"                         
## [17] "Remarks"
```

Since, we are grouping student on basiscs of grade we have to filter unique grade.

```
## [1] "B-" "B"  "B+" "A"  "A-" "C+" "F"
```

Total number of student on basics of grade. 

```
## 'data.frame':	34 obs. of  17 variables:
##  $ Student.ID                          : int  1001749291 1001749046 1001749153 1001749154 1001749155 1001749156 1001749157 1001749158 1001749159 1001749071 ...
##  $ Name                                : Factor w/ 34 levels "Aakash Maharjan",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ Mid.Term.Full.Marks                 : int  50 50 50 50 50 50 50 50 50 50 ...
##  $ Mid.Term.Marks.Obtained             : int  6 13 17 41 12 21 28 37 15 11 ...
##  $ Mid.Term.Twenty.Percent.Marks       : int  2 5 7 16 5 8 11 15 6 4 ...
##  $ Individual.Assignment.Full.Marks    : int  20 20 20 20 20 20 20 20 20 20 ...
##  $ Individual.Assignment.Marks.Obtained: int  12 14 17 17 14 13 15 14 13 11 ...
##  $ Group.Assignment.Full.Marks         : int  20 20 20 20 20 20 20 20 20 20 ...
##  $ Group.Assignment.Marks.Obtained     : int  16 16 17 19 18 17 19 19 14 14 ...
##  $ Internal.Marks                      : int  30 35 41 52 37 38 45 48 33 29 ...
##  $ Final.Exam.Full.Marks               : int  100 100 100 100 100 100 100 100 100 100 ...
##  $ Final.Exam.Marks.Obtained           : int  76 81 76 97 73 87 75 71 55 66 ...
##  $ Final.Exam.FortyPercent.Marks       : int  30 32 30 39 29 35 30 28 22 26 ...
##  $ Total                               : int  60 67 71 91 66 73 75 76 55 55 ...
##  $ Grade                               : Factor w/ 7 levels "A","A-","B","B-",..: 4 3 5 1 3 5 2 2 6 6 ...
##  $ Grade.Point                         : num  2.67 3 3.33 4 3 3.33 3.67 3.67 2.33 2.33 ...
##  $ Remarks                             : Factor w/ 2 levels "","Abs (M), NS, Abs(F)": 1 1 1 1 1 1 1 1 1 1 ...
```

Bar graph showing total number of student on basics of grade 
![](index_files/figure-html/Java web programming bargraph showing student on basics of grade-1.png)<!-- -->

Top 5 student of java web programming
<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Name"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["Total"],"name":[2],"type":["int"],"align":["right"]},{"label":["Grade"],"name":[3],"type":["fctr"],"align":["left"]},{"label":["Grade.Point"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"Amar Agarwal","2":"91","3":"A","4":"4"},{"1":"Faraz Ahmed Khan","2":"92","3":"A","4":"4"},{"1":"Khushi Shrestha","2":"82","3":"A","4":"4"},{"1":"Sanjiv Dangi","2":"91","3":"A","4":"4"},{"1":"Udaya Agrawal","2":"82","3":"A","4":"4"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Total number of student, summary and standard deviation 

```
## [1] 34
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    0.00   61.25   70.50   64.71   74.75   92.00
```

```
## [1] 22.2391
```




