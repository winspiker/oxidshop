# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Known issues]  

- none

## [Unreleased]

### Changed in [1.2.1]

- improve JS issues for payment selection
- add capture support for sent orders

## [1.2.0] - 2020-02-24

### Added in [1.2.0]

- Third-party payment reference will also be stored in database
- CHANGELOG.md has been added

### Changed in [1.2.0]

- Database structure has been improved
- README.md has been moved

## [1.1.0] - 2019-12-23

### Changed in [1.1.0]

- Oxid order numbers will be send to CrefoPay API after checkout
- Callback controller tries to restore order from database, when session context has gone lost
- The logger has been optimized

### Fixed in [1.1.0]

- Not working PAID notifications has been fixed

## [1.0.0] - 2019-02-13

- Initial Release
