# EIT Degree Project Template (Typst)

[![Built with Typst](https://img.shields.io/badge/Built%20with-Typst-333?logo=typst)](https://typst.app)  
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)  
[![Build PDF](https://github.com/your-username/exjobb_eit_typst/actions/workflows/build.yml/badge.svg)](https://github.com/EkholmCodes/exjobb_eit_typst/actions)

This repository contains a **Typst template** for writing degree projects at the institution.  
It provides a complete, ready-to-use structure for reports with modern styling and easy customization.

---

## Features

- **Premade formatting** – just start typing!  
- **Easily customizable** – adapt the template to your taste. 
- **Independent numbering** – equations, figures, tables, and listings looks modern and sleek. They also feature independent numbering.
- **Modern fonts** – professional look while honoring the LaTeX version of the template.  
- **Complete project structure** – everything is pre-organized for a smooth workflow.  

---

## Project Structure
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
│	├── figures/
│	│	└── example_image.jpg
│   └── front-matter.typ
│
└── src/ //Sourcefiles
  ├── exjobb_eit.typ //The template file
  ├── style.typ //Functions for styling and numbering
  └── Dawn.tmTheme //Used for syntax highlighting

---

## Getting Started

### 1. Install Typst

#### macOS  
```bash
brew install typst
```
### Windows
Download the latest release from [Typst GitHub releases](https://github.com/typst/typst/releases) and add it to your PATH.

### Online
Typst can also be run on their online editor.

### 2. Compile the project
For a single compilation. In the root folder, run 
```bash
typst compile main.typ
```
For continous compilation. In the root folder, run
```bash
typst watch main.typst
```
This will generate **main.pdf**.

### 3. Writing your thesis
* Add metadata as the thesis title, authors, supervisors etc to **main.typ**.
* Add chapters to content/chapters folder.
* Edit **frontmatter.typ**.
* Edit **appendix.typ**.
* Add sources to **bibliography.bib**

### 4. Customization
* **Styling**: Edit **style.typ** to adjust numbering, headings and formatting.
* **Template logic**: Edit **exjobb_eit.typ** to change the overall structure.
* **Syntax highlighting**: Switch out **Dawn.tmTheme**.

### Requirements
* [**Typst**](https://typst.com) > 0.13
* A text editor of your choice.
* **Fonts**: Adobe Garamond, Frutiger LT Std, CMU Serif, Source Code Pro. If any of these are unavailable to you, you can change the desired font in **style.typ**