<a id="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![project_license][license-shield]][license-url]
[![Email][email-shield]][email-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
	<a href="https://github.com/Gopmyc/Class">
		<img src="class_logo.jpg" alt="Logo" width="80" height="80">
	</a>

<h3 align="center">Class</h3>

  <p align="center">
	A lightweight, flexible, and extensible object-oriented programming (OOP) system for Lua.
	Provides class creation, inheritance, encapsulation, operator overloading, and utility helpers — all in a single file.
	Designed for seamless integration in any Lua project, with support for private members, super calls, and robust debugging tools. Inspired by :
	<br />
	<a href="https://github.com/vrld/hump/blob/master/class.lua"><strong>Hump.Class</strong></a>
	<br />
	<br />
	<a href="https://gopmyc.github.io/Class/"><strong>Explore the docs »</strong></a>
	<br />
	<br />
	<a href="https://github.com/Gopmyc/Class/blob/main/class.lua">View Demo</a>
	·
	<a href="https://github.com/Gopmyc/Class/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
	·
	<a href="https://github.com/Gopmyc/Class/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
	<li><a href="#about-the-project">About The Project</a></li>
	<li><a href="#built-with">Built With</a></li>
	<li>
	  <a href="#getting-started">Getting Started</a>
	  <ul>
		<li><a href="#prerequisites">Prerequisites</a></li>
		<li><a href="#installation">Installation</a></li>
	  </ul>
	</li>
	<li><a href="#usage">Usage</a></li>
	<li><a href="#roadmap">Roadmap</a></li>
	<li><a href="#contributing">Contributing</a></li>
	<li><a href="#license">License</a></li>
	<li><a href="#contact">Contact</a></li>
	<li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

`Class` is a self-contained OOP system written in pure Lua. Its goal is to bridge the gap between minimalistic design and powerful features. It is especially handy for environments like Garry's Mod or any Lua-based game/modding framework where OOP-like structures can simplify code organization.

**Key Features:**
- 🔧 Dynamic class creation
- 🧬 Inheritance with `super` call support
- 🧱 Public / private members
- 🔄 Operator overloading
- 🔍 Debug helpers

<p align="right"><a href="#readme-top">🔝</a></p>

### Built With

* ![Lua](https://img.shields.io/badge/Lua-000080?style=for-the-badge&logo=lua&logoColor=white)

<p align="right"><a href="#readme-top">🔝</a></p>

<!-- GETTING STARTED -->
## Getting Started

Here’s how to set up the project locally.

### Prerequisites

You’ll need Lua installed:

- [https://www.lua.org/download.html](https://www.lua.org/download.html)

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/Gopmyc/Class.git
   cd Class
	```

2. Include `class.lua` in your Lua project:

   ```lua
   require("class")
   ```

<!-- USAGE EXAMPLES -->

## Usage

```lua
local Class	=	require("class")
lcoal A		=	Class{
    foo	=	function()
		print('foo')
	end,
}

local B		=	Class{
    bar	=	function()
		print('bar')
	end,
}

-- single inheritance
local C		=	Class{__includes = A}
instance	=	C()
instance:foo() -- prints 'foo'
instance:bar() -- error: function not defined

-- multiple inheritance
local D		=	Class{__includes = {A,B}}
instance = D()
instance:foo() -- prints 'foo'
instance:bar() -- prints 'bar'
```

*For more examples, check the [documentation](https://gopmyc.github.io/Class/).*

<p align="right"><a href="#readme-top">🔝</a></p>

<!-- ROADMAP -->

## Roadmap

* [x] Basic class + inheritance
* [x] Private/protected fields
* [x] Super call support
* [x] Operator overloading
* [ ] Static fields / class-level attributes
* [ ] Decorators / Mixins
* [ ] Full test suite

Feel free to suggest features via [issues](https://github.com/Gopmyc/Class/issues).

<p align="right"><a href="#readme-top">🔝</a></p>

<!-- CONTRIBUTING -->

## Contributing

Contributions make open source better!
If you’ve got a fix or idea, fork and PR it.

Steps:

1. Fork this repo
2. Create a branch (`git checkout -b feature/MyFeature`)
3. Commit (`git commit -m 'Add MyFeature'`)
4. Push (`git push origin feature/MyFeature`)
5. Submit a Pull Request

### Top contributors:

<a href="https://github.com/Gopmyc/Class/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Gopmyc/Class" />
</a>

<p align="right"><a href="#readme-top">🔝</a></p>

<!-- LICENSE -->

## License

Distributed under the MIT License.
See [`LICENSE`](https://github.com/Gopmyc/Class/blob/main/LICENSE) for more info.

<p align="right"><a href="#readme-top">🔝</a></p>

<!-- CONTACT -->

## Contact

**Gopmyc**
📧 [gopmyc.pro@gmail.com](mailto:gopmyc.pro@gmail.com)
🔗 [https://github.com/Gopmyc/Class](https://github.com/Gopmyc/Class)

<p align="right"><a href="#readme-top">🔝</a></p>

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/Gopmyc/Class.svg?style=for-the-badge
[contributors-url]: https://github.com/Gopmyc/Class/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Gopmyc/Class.svg?style=for-the-badge
[forks-url]: https://github.com/Gopmyc/Class/network/members
[stars-shield]: https://img.shields.io/github/stars/Gopmyc/Class.svg?style=for-the-badge
[stars-url]: https://github.com/Gopmyc/Class/stargazers
[issues-shield]: https://img.shields.io/github/issues/Gopmyc/Class.svg?style=for-the-badge
[issues-url]: https://github.com/Gopmyc/Class/issues
[license-shield]: https://img.shields.io/github/license/Gopmyc/Class.svg?style=for-the-badge
[license-url]: https://github.com/Gopmyc/Class/blob/main/LICENSE
[email-shield]: https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white
[email-url]: mailto:gopmyc.pro@gmail.com
