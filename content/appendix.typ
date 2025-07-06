= Some extra material

Here begins the backmatter! Below is an example of how to include code. You can manually change the syntax highlightning by switching out the ".tmTheme" file in the template.

#figure(
	align(left, [```c
	void insertionSort(int a[], int n)
	{
	    int i, key, j;
	    for (i = 1; i < n; i++) {
	        key = a[i];
	        j = i - 1;

	        while (j >= 0 && a[j] > key) {
	            a[j + 1] = a[j];
	            j = j - 1;
	        }
	        a[j + 1] = key;
	    }
	}
	```]),
	caption: "Code snippet for insertionssort written in C."
)

To write raw text you follow the same approach as in Markdown. Three backticks to mark the start followed by another three to mark the end, specifiy the language with it's label @MarkdownSupport. For the example above, check "appendix.typ"