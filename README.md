# SpotifyUtils
### Overview
This script is made in [AutoHotKey](https://www.autohotkey.com) to add features that Spotify should honestly already have.\
This script was **not** created to be customizable, but AHK is a pretty readable language, so custom changes should be easy!

### How it works
#### Global Hotkeys
SpotifyUtils sends Spotify's built-in [keyboard shortcuts](https://support.spotify.com/us/article/keyboard-shortcuts/) when a script hotkey is pressed. If the Spotify window is in the background, it will be put into focus without bringing the window into the foreground.
#### Blacklisted Songs
SpotifyUtils stores blacklisted songs in `spotify_blacklist.txt`. These songs are formatted as `%Artist% - %Title%`. When a song is added via hotkey, SpotifyUtils knows what the artist and title are because (luckily) the title of the Spotify window changes to show the track being played.\
Every second, SpotifyUtils looks at the title of the Spotify window and sees if it matches with any blacklisted songs. If it matches, the functions from global hotkeys are used to skip the song.

### Features:
- Ability to use Spotify hotkeys from any window
- Blacklist to automatically skip unwanted songs

### Notes:
- When the first song is added, a file called `spotify_blacklist.txt` will be created
- The blacklist file can be manually modified, but watch the format! There should always be an empty line at the end of the file.
- There are separate audio cues to notify when you have added or removed a song from the blacklist. There is also a sound when the song already exists in the blacklist.

### Hotkeys:
| Task | Hotkey |
-------|--------|
| Pause/Play | Win + Alt + S |
| Next Song | Win + Alt + D |
| Previous Song | Win + Alt + A |
| Volume Up | Win + Alt + X |
| Volume Down | Win + Alt + Z |
| Add song to blacklist | Win + Alt + Delete |
| Remove last song in blacklist | Win + Alt + Backspace |

### Installation:
Because this script is not compiled, AutoHotKey(https://www.autohotkey.com/download/) must be downloaded.
Once AHK is installed, download `SpotifyUtils.ahk` from the project files and open it to start it.

### Compiling:
AHK has a built in compiler that can be used to compile this script into a Windows executable. If you have AHK installed and you intend on keeping it, you do not need to do this to run the script. To compile, right click the downloaded `SpotifyUtils.ahk` file and click "Compile Script".

### References:
- The global hotkey functionality is heavily influenced by James Teh's [SpotifyGlobalKeys](https://gist.github.com/jcsteh/7ccbc6f7b1b7eb85c1c14ac5e0d65195)
- A long time spent browsing forums and docs
