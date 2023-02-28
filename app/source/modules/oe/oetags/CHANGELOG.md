# Change Log for OE Tags Module

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).


## [Unreleased]

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [2.3.1] - 2020-03-18

### Fixed
- fixed javascript when no tags are set, broke f.e. variants selection

## [2.3.0] - 2020-02-12

### Added
- added support for Wave & Custom Wave based themes
- changed labels to buttons for styles, since Bootstrap 4 doesnt have labels anymore.  
  Buttons are supported by both Bootstrap 3 & 4.
- upgraded metadata to 1.2

## [2.2.0] - 2019-10-07

### Added
- added Meta description and keywords fields for the tags overview page

## [2.1.0] - 2019-19-03

### Added
- gitattributes with excluded tests
- fixed oetagscontroller urls by adding config option for SEO url for a single tag page

### Fixed
- fixed code inspections issues
- fix empty articleList, articleList will not be null but an empty ArticleList
- fixed translations
- upgrade hints in readme

## [2.0.1] - 2017-12-07

### Added
- Module available on packagist

## [2.0.0] - 2017-12-05

### Changed
- Adapted the module to be compatible with OXID eShop 6.

[Unreleased]: https://github.com/OXIDprojects/tags-module/compare/HEAD...HEAD
