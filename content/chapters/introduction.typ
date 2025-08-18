= Introduction <intro>
This is the start of the chapters. Notice how the heading is different. These styling changes take place in *main.typ*. This is due to something Typst calls "scope". Changing something inside one scope does not change what's outside that scope. Therefore as the document progresses, headings and such have to be manually changed in the largest scope we can access, i.e. the main file. The largest scope available is the template file, but there we have no control over which files to include inside the document.

== Template structure <structure>
Typst is a bit different from LaTeX. It has a more traiditional approach to it's code rather than LaTeX macro-style programming. Therefore this project becomes more complex in it's file structure. I am ok with the trade-off, as it comes with more freedom to customize and higher readability.
The template structure is as follows:

#figure(
  align(left)[```typst
      exjobb_eit_typst/ //Root folder
      │
      ├── main.typ //Project root, this is the file to compile
      ├── main.pdf //The compiled file
      │
      ├── content/ //Contains the different parts of the project
      │   ├── chapters/
      │   │   └── example_chapter.typ
      │   ├── appendix.typ
      │   ├── bibliography.typ
      │   └── front-matter.typ
      │
      └── src/ //Sourcefiles
          ├── exjobb_eit.typ //The template file
          ├── style.typ //Functions for styling and numbering
          └── Dawn.tmTheme //Used for syntax highlighting
  ```
  ],
  caption: "Project structure",
) <project_structure>

It looks dawnting with this many files. However you do not have to take this into consideration. Looking at *main.typ* you can see how and when certain set/show rules are applied. Also you can see how to use the ```typst #include``` function. All you have to do to start writing is simply start a new file and write! A clear example of this is the existing ".typ" files inside the content folder. These are free from set/show rules and styling. Of course if you feel like making changes to the styling, go ahead!

Since the project is structured this way the only file needed for compilation is *main.typ*. To compile a file locally (with Typst installed) simply run the command ```typst typst compile main.typ``` for single time compilation or ```typst typst watch main.typ``` for continous compilation.

== Features of this template

This template is made to mimick the LaTeX version of the masters thesis on EIT. It includes: 

- Premade formatting in the template, all that is needed is to start typing!
- The ability to easily change the template to your taste.
- Independent numbering of equations, figures, tables and listings.
- Modern fonts for a professional look in accordance to LTH styling.
- Complete project structure.

=== A section which won't appear in the outline
This section is of depth 3. By the template, the outline (table of contents) is set to a maximum depth of 2.