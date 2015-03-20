For calculating True Positives, True Negatives, False Positives and False
Negatives, we will not remove the recommended courses for already
completed courses with high ratings and see if they were actually being
recommended or not.

We have generated the index of top 3 predicted ratings of courses for all
students in test set and stored them in Recommend.txt

From there, we manually calculated the True Positives, True Negatives, False Positives 
and False Negatives.

			   Recommended           Not Recommended
Preferred      True Positives  : 75  False Negatives : 27
Not-Preferred  False Positives : 6   True Negatives  : 180