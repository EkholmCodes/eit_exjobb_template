= Introduction <intro>
This is the start of the chapters. Notice how the heading is different. These styling changes take place in the "main.typ" file. This is due to something Typst calls "scope". Changing something inside one scope does not change what's outside that scope. Therefore as the document progresses, headings and such have to be manually changed in the largest scope we can access, i.e. the main file. The largest scope available is the template file, but there we have no control over which files to include inside the document.

== Template structure <structure>
Typst is a bit different from LaTeX. It has a more traiditional approach to it's code rather than LaTeX macro-style programming. Therefore this project becomes more complex in it's file structure. I am ok with the trade-off, as it comes with more freedom to customize and higher readability.
The template is structured is as follows:

#figure(
  align(left)[```typst
      exjobb_eit_typst/
      │
      ├── main.typ //Acts as a root for the project, this is the file to compile.
      ├── main.pdf //The compiled file
      │
      ├── content/ //Contains the different parts of the project.
      │   ├── chapters/
      │   ├── appendix.typ
      │   ├── bibliography.typ
      │   └── front-matter.typ
      │
      └── src/ //Sourcefiles
          ├── exjobb_eit.typ //The template file
          ├── style.typ //Functions and definitions for styling and numbering
          └── Dawn.tmTheme //Used for syntax highlighting in listings, for example in Appendix A.
  ```
  ],
  caption: "Project structure",
)

It looks dawnting with this many files. However you do not have to take this into consideration. Looking at the "main.typ" file you can see how and when certain set/show rules are applied. Also you can see how to use the ```typst #include``` function. All you have to do to start writing is simply start a new file and write! A clear example of this is the existing ".typ" files inside the content folder. These are free from set/show rules and styling. Of course if you feel like making changes to the styling, go ahead!

=== A section which won't appear in the outline
This section is of depth 3. By the template, the outline (table of contents) is set to a maximum depth of 2.

== Another Section

#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Timing results],
)