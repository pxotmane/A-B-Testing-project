# Analyze A/B Test Results

## Introduction
A/B testing is basically a way to compare two versions of something in order to determine the most efficient one. In this project, my goal is to apply the A/BTesting to help decision-makers decide between two choices of proposals or strategies. 
This test is often used in sales and marketing strategies within companies. But it can also be used in other industries where the discount is between two proposals. In our case, A/B testing consists of comparing two versions of a web page (old page and new page) in order to verify which one performs better and get more converting visit to action in web page. These variations, called A and B, are randomly presented to users. A part of them will then be directed to the first version while the other will be assigned to the second.

## The analysis process
In this project there are two groups of users of an e-commerce website. One group uses the old design of the website, this group named "Control". The second group uses the new website design, this group called "Treatement". </br>
- In a first step, I conducted a probabilistic calculation to find out which of the two groups generates more conversion of visits to a purchase action.</br>
- In the second step, I established the A/B testing by assuming an H0 hypothesis that the old page performs better. The test tries to show is what we will keep the finding of H0 or reject it, this through the simulation of the population sample and z_score.</br>
- In a third step, I performed a logistic regression model, since in our case the type of variables used is qualitative. Then, I added the country and time variables to try to measure the geographical and time impact on the users' behaviour towards the old and new website design.</br>

## Technologies Used
- Python, Numpy, Pandas, Matplotlib, StatsModels, Scipy, Scikit-Learn
- LaTex
- Jupyter Notebook

## Key Findings
- There is no significant evidence that the new page will contribute to more conversion of purchase in this e-commerce platform.
- Even we added the effect of time and country on the model we found that the convertibility rate did not significantly change the users' decision to convert visits to purchases.
