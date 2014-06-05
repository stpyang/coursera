To generate tidyData.txt, clone this repository and run the R script.  For
example:

```
$ git clone https://github.com/stpyang/getdata-003.git temp
$ cd temp
$ R
> source("run_analysis.R")
```


This script run_analysis.R creates a new table called `tidyData.txt` that is 180
rows by 563 columns. The 180 rows correspond to unique (activity, subject) pairs
(6 activities times 30 subjects). The 563 columns correspond to 2 indexing
columns plus average measurements for each of the 561 features.  The first few
rows and columns of the table are shown below.

<pre>
> tidyData[1:10,1:5]
   activity subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1   WALKING       1         0.2773308       -0.01738382        -0.1111481
2   WALKING       2         0.2764266       -0.01859492        -0.1055004
3   WALKING       3         0.2755675       -0.01717678        -0.1126749
4   WALKING       4         0.2785820       -0.01483995        -0.1114031
5   WALKING       5         0.2778423       -0.01728503        -0.1077418
6   WALKING       6         0.2836589       -0.01689542        -0.1103032
7   WALKING       7         0.2755930       -0.01865367        -0.1109122
8   WALKING       8         0.2746863       -0.01866289        -0.1072521
9   WALKING       9         0.2785028       -0.01808920        -0.1108205
10  WALKING      10         0.2785741       -0.01702235        -0.1090575
</pre>

The code is straightforward.  The first section of code ensures that the
necessary data files are present and if so, loads them into memory.

The second section of code merges the training and test data for the signals,
activity, and subjects into data frames called `X`, `y`, and `subject`
respectively.  This data was loaded from the following files in the dataset:
`X_test.txt`, `X_train.txt`, `y_test.txt`, `y_train.txt`, `subjext_text.txt`,
and `subject_train.txt`.

The third section uses the `sapply` method to calculate the mean and standard
deviation of each feature.

The fourth section appends the appropriate activity and subject information to
the data frame `X`.

The fifth section uses the ddply method to group the rows of `X` by activity
and by subject, and take the means of each column according to the grouping.
Finally, we replace the activity number with its feature name for readability.

The last section saves the output in a file called tidyData.txt.
