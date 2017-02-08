# ECE30Project

ECE 30
Introduction to Computer Engineering
Programming Project {Maximum Subarray Sum Problem}

1. Project Description
The goal of this project is to implement the maximum sum subarray problem in MIPS. The maximum subarray sum takes as input an array of integers and produces as output the maximum sum of any contiguous subarray in the original array.
For example: The input can be the array {-2, -5, 6, -2, -3, 1, 5, -6}. An example of a subarray is {-5,6,-2} but {-2,-3,5} is not a subarray. We seek to find the maximum sum of elements in any subarray of the given array. In this example, the highlighted subarray has the maximum sum, which is 7 (you can verify this for yourself by trying other subarrays; this value will be the maximum possible).
We solve this problem using divide-and-conquer. A divide-and-conquer algorithm works by recursively breaking down a problem into two or more sub-problems of the same or related type, until these become simple enough to be solved directly. 
In this project, we will develop a program to take as input an array, use a divide-and-conquer (function MaximumSubArraySum defined below) to calculate the maximum sum of any subarray of the array, and print the maximum sum on the console and exit.

2. Important Links
Your project must use the provided template file. While you are free to add any further helper functions, your code must implement the following functions according to the specifications given in this document.
The grader should be able to remove any of your functions (and any non-essential helper functions it may use) from your code and use it in another person's programming assignment without issue (i.e. do not flip the order of variables passed to functions via registers $a0 and $a1 or returned via $v0 and $v1, use the conventions given). Several functions are provided, along with all the text strings one needs to complete this project. These should not, in any form, be modified, unless explicitly instructed.
You should use MIPS assembly code best practices as far as register storing and stack management. See these quick guides for more info (they are excellent, so read them before asking questions):
•	http://logos.cs.uic.edu/366/notes/mips%20quick%20tutorial.htm

3. The Algorithm
Notation: if arr is an array, we use arr[s…e] to indicate the subarray that starts with element with index s and ends with element with index e (inclusive). 
We will develop a procedure called  MaximumSubarraySum.
The input: an array arr[], a starting index s, and an ending index e. 
The output: the maximum subarray sum in arr[s...e].
The recursive divide-and-conquer algorithmic: 
1.	Divide the array arr[s…e] in the middle into a left subarray arr[s…m] and a right subarray, arr[m+1…e], where m is the middle index: m=(s+e)/2.  
2.	Recursively call the MaximumSubarraySum function twice to find the maximum subarray sum for the left subarray and the right subarray.  
3.	Use a different function, called MaximumCrossingSum to find the maximum sum of any subarray of arr[s…e] that includes elements from both left and right subarrays.
4.	Return the maximum value among the two values computed in step 2 and the value computed in step 3. 

4.  Project Structure and Function Pseudo-Code
Your code must implement the following functions according to specification given below. Remember to manage your stack!
The following functions must be implemented or have been supplied:
4.1	main (Supplied):
1.	Saves state of all relevant registers on the stack. 
2.	Reads in the numbers and size of array from data segment.
3.	Calls the MaximumSumSubArray function to return the value of the maximum subarray sum.
4.	Calls PrintSum to print the value returned by MaximumSumSubArray on the console.
5.	Calls syscall to terminate the program.

4.2	PrintSum (Supplied):

•	$a0 holds the value to be printed.
•	This function has no return value.
It prints “Maximum Sub Array Sum is:” and a number on the console.

4.3	FindMax2 (To be implemented):
•	$a1 holds the first number.
•	$a2 holds the second number.
•	$v0 contains the maximum among the 2 input numbers.
This function returns the maximum between 2 numbers.

4.4	FindMax3 (To be implemented):
•	$a1 holds the first number.
•	$a2 holds the second number.
•	$a3 holds the third number.
•	$v0 contains the maximum among the 3 numbers.
This function does the following:
1.	Calls Maximum on the first 2 numbers and store return value.
2.	Calls Maximum on the return value in the previous step and the third number; returns the maximum of the result.

4.5	MaxSumBoundary (To be implemented):
The input is a subarray arr[s…e] and a direction (d). 
	If d==0, it computes the maximum sum of any subbarray of arr[s…e] that includes arr[e]. Thus, it considers the maximum sum among subarrays: arr[e]     arr[e-1…e]     arr[e-2…e]   …    arr[s…e]
	If d==1, it computes the maximum sum of any subarray of arr[s…e] that include arr[s]. Thus, it considers the maximum sum among subarrays:
         		arr[s]    arr[s…s+1]     arr[s…s+2]   …    arr[s…e]

•	$a0 contains address to arr[].
•	$a1 contains s 
•	$a2 contains e
•	$a3 is the direction (either 0 or 1)
•	$v0 returns the maximum subarray
This function does the following:
1.	if s==e, return arr[s].
2.	If $a3==0: 
    Call  MaxSumBoundary(arr,s,e-1,0) and save the result in a register x
    Return Maximum(arr[e], arr[e]+ x)
Else:
    Call  MaxSumBoundary(arr,s+1,e,1) and save the result in a register x
    Return Maximum(arr[s], arr[s]+ x)

4.6	MaximumCrossingSum (To be implemented):
•	$a0 contains arr[].
•	$a1 contains s. 	// s is the minimum (i.e. leftmost) index of the input array.
•	$a2 contains m.	// m is the middle ((s+h)/2) index of the input array.
•	$a3 contains e.	// e is the maximum (i.e. rightmost) index of the array.
•	$v0 returns the maximum sum of arrays that includes arr[m] and arr[m+1]
     
This function does the following:
1.	Call MaxSumBoundary on the left subarray a[s,m] with direction 0.
2.	Call MaxSumBoundary on the right subarray a[m+1,e] with direction 1.
3.	Return the sum of the above two values.

4.7	MaximumSubArraySum(To be implemented):
•	$a0 contains arr[]
•	$a1 contains s
•	$a2 contains e
This function does the following:
1.	If there is only one element i.e. (s==e) return  arr[s]
2.	Find the middle point of given array, m=(s+e)/2
3.	Call MaximumSubArraySum(arr[], s, m) to compute the maximum subarray sum of the left subarray arr[s…m].
4.	Calls MaximumSubArraySum(arr[], m+1, e) to compute the maximum subarray sum of the right subarray arr[m+1…e].
5.	Calls MaxCrossingSum(arr[],s,m,e)  to compute the maximum subarray sum that goes through the middle.
6.	Calls Maximum3 to return the maximum value among the values computed in 3, 4, and 5 

5. MIPS Program Requirements
You must submit your solution by emailing a completed file ABC_XYZ_winter2017_project.s, where ABC and XYZ are the @ucsd.edu of each student. 

6. Other criteria
We expect your code to be well-commented. Each instruction should be commented with a meaningful description of the operation. Ask yourself what kinds of comments would be useful if you didn't touch this code for a year or two and have completely forgotten how to code in MIPS. For example, this comment is bad as it tells you nothing:
addi $s0, $t0, -1 								# $s0 gets $t0 - 1
A good comment should explain the meaning behind the instruction. A better example would be:
addi $s0, $t0, -1 					# Initialize loop counter $s0 to ``n-1''
Each project team contributes their own unique code - no copying, cheating, or hiring help. Even if only one of the two partners is culpable, both students will be reported to Academic Affairs.

8. Working of the Algorithm
If the given array is {-2, -5, 6, -2, -3, 1, 5, -6}, then the maximum subarray sum is 7 represented by the green highlighted elements. Let’s see how this works for the example {-2, -5, 6, -2, -3, 1, 5, -6} by the use of the following flowchart:

 

We have to return the maximum value among the return values of the 3 functions
 
•	MaxSubArraySum(arr[],s,m)       (return values are represented as f1(x))
•	MaxSubArraySum(arr[],m+1,h)  (return values are represented as f2(x))
•	MaxCrossingSum(arr[],s,m,h)     (return values are represented as g(x))
The maximum value among the three values returned above is in f(x).
From the flowchart it can be seen that
•	The MaxSumSubArray function keeps on recursively calling itself to divide the array more and more till only a singleton set is left. 
•	The MaxCrossingSum is obtained as finding the maximum sum of the subarray formed such that it includes at least one element from both left and right subarrays. 
•	Finally, we return the maximum value among the 3 values. The recursions will implicitly compute values in a bottom to top manner till we get the final value of the Maximum subarray sum at the root of the tree.
