#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  args: 64OO67Be8wOXn6STqHxexr
#
#  Author: Hari Sekhon
#  Date: 2020-07-05 14:33:55 +0100 (Sun, 05 Jul 2020)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# https://developer.spotify.com/documentation/web-api/reference/search/search/

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="'<search_expression>"

# shellcheck disable=SC2034
usage_description="
Searches the Spotify API and returns the Spotify URIs for the first N tracks / artists / albums that match the given search expression

See this page for documentation on how to write query expressions:

https://developer.spotify.com/documentation/web-api/reference/search/search/

Example:

./${0##*/} artist:foo fighters track:arlandria


Uses spotify_search_json.sh which supports the following environment variable options:

Environment variable options:

\$SPOTIFY_SEARCH_TYPE  = track # default
                         artist
                         album

\$SPOTIFY_SEARCH_LIMIT = 1 # default

\$SPOTIFY_SEARCH_OFFSET = 0 # default


Requires \$SPOTIFY_ID and \$SPOTIFY_SECRET to be defined in the
environment for authentication, see spotify_api_token.sh for more details
"

# shellcheck disable=SC1090
. "$srcdir/lib/utils.sh"

help_usage "$@"

min_args 1 "$@"

"$srcdir/spotify_search_json.sh" "$@" |

#if [ "${SPOTIFY_SEARCH_TYPE:-}" = "artist" ]; then
#    jq -r '.artists.items[] | .uri'
#elif [ "${SPOTIFY_SEARCH_TYPE:-}" = "album" ]; then
#    jq -r '.albums.items[] | .uri'
#else
#    jq -r '.tracks.items[] | .uri'
#fi

jq -r ".${SPOTIFY_SEARCH_TYPE:-track}s.items[] | .uri"
