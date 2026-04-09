# 🎓 EIT Degree Project Template (Typst)

![Built with Typst](https://img.shields.io/badge/Built%20with-Typst-333?logo=typst)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An _unofficial_ Typst template made from the LaTeX version of the degree project at EIT, LTH.

## Configuration

### Document Fields

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `thesis_title` | `content/str` | `[The Thesis title]` | The main title of your project. |
| `subtitle` | `content/str` | `none` | An optional subtitle. |
| `short_title` | `content/str` | `[A shorter title]` | Used in headers/footers. |
| `authors` | `array` | `()` | List of dictionaries: `(name: "", affiliation: "", mail: "")`. |
| `supervisors` | `array` | `()` | List of strings or content. |
| `examinor` | `content/str` | `none` | Name of your examiner. |
| `affiliations` | `array` | `()` | Academic or corporate affiliations. |
| `degree` | `content/str` | `none` | Adds a line for which degree the thesis is meant for. Optional. |
| `coursecode` | `content/str` | `[EITM01]` | The coursecode for this thesis project. |
| `front_images` | `array` | `()` | Paths to images for the cover page. |
| `front-cover-background` | `content` | `rect(width: 100%, height: 100%, fill: lth_light_brown)` | Add a background to the front cover. |
| `keywords` | `array` | `()` | List of strings for metadata. |
| `description` | `content` | `none` | Description for metadata. |
| `date` | `datetime` | `datetime.today()` | Document date. |

### Styling Options

| Parameter | Options | Default | Description |
| :--- | :--- | :--- | :--- |
| `header_style` | `"original"`, `"mod"`, `"alternating"` | `"original"` | Top-of-page navigation style. |
| `heading_style` | `"original"`, `"mod"` | `"original"` | Section title formatting. |
| `print` | `true`, `false` | `false` | `true` binds on the right and renders a front cover page; `false` shows G5 guide boxes and binds to the left. |

---

## How to Use

1.  **Download** this repository and place it in your project folder.
2.  **Import** the template at the top of your main `.typ` file:

```typst
#import "PATH/exjobb_eit.typ": *

#show: doc.with(
  ..params
)
```
3. Use the **state functions** like below:
```typst
#show: frontmatter

// Here goes your frontmatter

#show: mainmatter

// Here goes your mainmatter

#show: backmatter

// Here goes your appendicies
```
