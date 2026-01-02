# City Normalizer

A Google Tag Manager variable template for both web and server containers that normalizes city names for server-side tracking by removing spaces, punctuation, and numbers while preserving UTF-8 characters.

## Overview

This template processes city names to meet the normalization requirements of advertising platforms like Facebook, Google, and TikTok. It converts to lowercase, removes unwanted characters, and preserves international characters (accents, diacritics).

## Installation

1. In your GTM container (web or server-side), go to **Templates** → **Variable Templates** → **Search Gallery**
2. Search for "City Normalizer"
3. Click **Add to workspace**

## Configuration

| Field | Description |
|-------|-------------|
| **Raw City Name** | The city name in its original form |

## Examples

| Input | Output |
|-------|--------|
| `New York` | `newyork` |
| `São Paulo` | `saopaulo` |
| `Čakovec` | `čakovec` |
| `München` | `münchen` |
| `L'Hospitalet` | `lhospitalet` |
| `St. Petersburg` | `stpetersburg` |
| `  LOS ANGELES  ` | `losangeles` |
| `District 5` | `district` |

## Features

- Converts to lowercase
- Removes spaces, punctuation, and special characters
- Removes numbers
- Preserves UTF-8 characters (accents, diacritics)
- Returns `undefined` for empty or invalid input
- Compliant with Facebook, Google, and TikTok normalization requirements

## Usage Example

1. Create a variable using this template
2. Set **Raw City Name** to your city data source (e.g., `{{Event Data - city}}`)
3. Use the normalized output in your tracking tags

## Compatibility

This template works in both:
- **Web GTM** containers
- **Server-side GTM** containers

## Author

**Metryx Studio**  
Website: [metryx.studio](https://metryx.studio)  
Contact: filip@metryx.studio

## License

Apache License 2.0
