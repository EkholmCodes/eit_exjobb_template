# EIT Degree Project Template (Typst)

[![Built with Typst](https://img.shields.io/badge/Built%20with-Typst-333?logo=typst)](https://typst.app)  
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

This repository contains a **Typst template** for writing degree projects at EIT at Lund University.  
It provides a complete, ready-to-use structure for reports with modern styling and easy customization.

---

## Parameters and fields

The template has many fields which doesn't neccessarily need to be filled out, but makes the document more complete. Below are all fields with default value and comment on the specific type. If not mentioned, assume it is either of type content or string.

```typst
  thesis_title: [The Thesis title],
  subtitle: none,
  short_title: [A shorter title],
  authors: (), //Array of type dictionary with fields (name, affiliation, mail)
  supervisors: (), //Array of type content or string
  examinor: none,
  affiliations: (), //Array of type content or string
  degree: none,
  front_images: (), //Array of type string. The string is the path to the image.
  description: none,
  keywords: (), //Array of type string.
  print: false, //Boolean
  header_style: "original",  //String
  heading_style: "original", //String
  date: datetime.today(), //Datetime, created using datetime(year, month, day)
```

### Styling

#### Headings

There exists two headings, "original" and "mod". Default is "original"

#### Headers

There exists three headers, "original", "mod" and "alternating". Default is "original"

### The print parameter

When writing your thesis, you can set print to either true or false. Both cases prints the document on an A4. True will bind on the right side. False bind to the left and draw a box showing G5 dimensions.

## How to use

Download the repository and place it in your project. Then include it using

```typst
#import "PATH/exjobb_eit.typ": *

#show: doc.with(...)
```

Look into and compile _example.typ_ to see some functions and how the template is structured.

During writing, use 

```typst 
#show: frontmatter
```

```typst 
#show: mainmatter
```

```typst 
#show: backmatter
```

To tell the template where in the document you intend to write, in order to apply correct styling. For example

```typst
#show: frontmatter
#include("front.typ")

#show: mainmatter
#include("main.typ")

#show: backmatter
#include("appendix.typ")
