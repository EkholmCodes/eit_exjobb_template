# EIT Degree Project Template in Typst 

![Built with Typst](https://img.shields.io/badge/Built%20with-Typst-333?logo=typst)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An _unofficial_ Typst template made from the LaTeX version of the degree project at EIT, LTH.

# thesis.typ

## Configuration

### Document Fields

| Parameter | Type | Required / Default | Description |
| :--- | :--- | :--- | :--- |
| `thesis-title` | `string` / `content` | **Required** | The main title of the thesis. |
| `thesis-title-sv` | `string` / `content` | `none` | Swedish translation of the thesis title. |
| `thesis-subtitle` | `string` / `content` | `none` | Optional subtitle for the thesis. |
| `thesis-subtitle-sv` | `string` / `content` | `none` | Swedish translation of the subtitle. |
| `short-title` | `content` / `string` | `[#degree-level-en's thesis]` | Shortened title used in page headers. |
| `authors` | `array` | **Required** | List of authors. Expected structure:<br>`((name: "", email: ""),)` |
| `supervisors` | `dictionary` | **Required** | Dictionary containing supervisor details. Expected keys/structure:<br>`academic: (name: "", email: "", affiliation: "")`<br>`company: (name: "", email: "", affiliation: "")` |
| `examiner` | `dictionary` | **Required** | Dictionary containing examiner details. Expected structure:<br>`(name: "", email: "")` |
| `course-code` | `content` / `string` | `[EITM01]` | Course code for the thesis module. |
| `affiliations` | `array` / `dictionary` / `content` | `none` | Optional author or university affiliations. |
| `description` | `string` / `content` | `none` | Optional brief summary or metadata description. |
| `keywords` | `array` | `()` | List of keywords for document metadata. |
| `document-style` | `string` | `"original"` | Layout style for headers/headings. Allowed values: `"original"` or `"novel"`. |
| `front-cover-background` | `content` | `rect(width: 100%, height: 100%, fill: lu-light-brown)` | Visual element or color definition for the cover background. |
| `date` | `datetime` | `datetime.today()` | Publication or submission date. |
| `report-number` | `string` / `integer` | `none` | Report ID number. **Required if `print` is set to `true`**. |
| `issn` | `string` | `none` | ISSN identifier for published prints. |
| `print` | `bool` | `false` | Enables print mode formatting (requires `report-number`). |

---

Use the **state functions** like below:
```typst
#show: frontmatter

// Here goes your frontmatter

#show: mainmatter

// Here goes your mainmatter

#show: backmatter

// Here goes your appendicies
```


# Popular science summary

## Document fields
| Field | Type | Required / Default | Description |
| :--- | :--- | :--- | :--- |
| `summary-title` | `string` / `content` | **Required** | The title of the thesis summary. |
| `original-title` | `string` / `content` | **Required** | The original title of the full thesis. |
| `authors` | `array` | **Required** | List of author names/details (e.g., `("Author Name",)`). |
| `supervisors` | `dictionary` | **Required** | Dictionary containing supervisor details. Expected keys/structure:<br>`academic: (name: "", email: "", affiliation: "")`<br>`company: (name: "", email: "", affiliation: "")` |
| `examiner` | `dictionary` | **Required** | Dictionary containing examiner details. Expected keys/structure:<br>`(name: "", email: "")` |
| `lead-paragraph` | `string` / `content` | `none` | Optional introductory summary/lead text. |
| `thesis-link` | `string` | `none` | Optional link to the full thesis document/repository. |
| `presentation-date` | `datetime` | `datetime.today()` | The date of the presentation. Defaults to current date. |
| `lang` | `string` | `"sv"` | Language setting for the document. Allowed values: `"sv"` or `"en"`. |

# Goal docuemnt

## Document fields

| Parameter | Type | Required / Default | Description |
| :--- | :--- | :--- | :--- |
| `tentative-title` | `string` / `content` | **Required** | The working or tentative title for the thesis proposal/project. |
| `authors` | `array` | **Required** | List of authors or student details. |
| `start-date` | `datetime` | **Required** | Start date of the thesis project. |
| `end-date` | `datetime` | **Required** | End date or planned completion date of the project. |
| `course-code` | `string` / `content` | **Required** | Course code for the thesis module. |
| `academic-supervisor` | `string` / `dictionary` | **Required** | Details or name of the assigned academic supervisor. |
| `examiner` | `string` / `dictionary` | **Required** | Details or name of the assigned examiner. |
| `lang` | `string` | `"en"` | Language setting for the document. Allowed values: `"en"` or `"sv"`. |

# Project plan

## Document fields

| Parameter | Type | Required / Default | Description |
| :--- | :--- | :--- | :--- |
| `academic-supervisor` | `string` / `dictionary` | **Required** | Details or name of the assigned academic supervisor. |
| `examiner` | `string` / `dictionary` | **Required** | Details or name of the assigned examiner. |
| `lang` | `string` | `"en"` | Language setting for the document. Allowed values: `"en"` or `"sv"`. |