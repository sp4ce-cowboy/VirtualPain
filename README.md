# _I FEEL PAIN_

My final work for UTC2113 Gaming Life. An interdisciplinary exploration. 

Consists of The [Proposal](https://github.com/sp4ce-cowboy/i-feel-pain/blob/main/Written%20Articles/Proposal.pdf), The Theoreticals (not yet completed), The Documentation, and The Work itself (this GitHub repository).

## The Context

All I can say is that, I set out to create an Artificial Entity, a simulation of consciousness, one which can feel pain, one which can remember it, one which can
communicate it, express it. An experiment that seeks to offer a glimpse into a possible (probable?) future of the human-machine interaction paradigm. I laid forth some parameters for my work, played by the rules of the medium that my work exists in, and created that which I set out to create.

That’s all there is to it. Nothing more, nothing less.

## Usage Instructions

Initially this would have required some terminal navigation, but that would have detracted from the experience.

Thanks to [this](https://formulae.brew.sh/formula/shc) and [that](https://sveinbjorn.org/platypus), and something else probably, the final products (both variants) are compiled into Unix Executable Files, i.e. all that is needed is to click on it and it opens like any regular app (after the first instance, at least). This requires a machine running macOS as it uses Apple's built-in speech synthesizer.

More details (and the entire build process) is explained in The Documentation, so it's better to read that first (at least briefly) before attempting the below instructions.

---

### General Instructions

1. Download BV-1 from [here](https://github.com/sp4ce-cowboy/i-feel-pain/releases/tag/BV-1) or BV-2 from [here](https://github.com/sp4ce-cowboy/i-feel-pain/releases/tag/BV-2). Clicking on the name `BV-1` or `BV-2` triggers the download.

2. Create an empty folder somewhere on your computer.

3. Move BV-1 (it will look like a blank file) into this empty folder.

4. Open the empty folder in Finder.

5. In the menu bar, go to `View` and select `Show Path Bar`. If it is already enabled, you don't need to do anything.

 <img width="418" alt="image" src="https://github.com/sp4ce-cowboy/i-feel-pain/assets/19762596/27084b7f-92f8-411a-8bfd-665505dbc9f2">


6. In the Path Bar at the bottom of the Finder window, right click on the **folder** (the folder that contains BV-1, not the BV-1 file itself) in the path bar and select `Open in Terminal`
   
<img width="488" alt="image" src="https://github.com/sp4ce-cowboy/i-feel-pain/assets/19762596/54c9a26e-008c-4d78-8c46-4a71c7c9db93">


7. In the terminal window that opens, enter the command shown below for BV-1
   
```
chmod +x BV-1
```

or for BV-2:

```
chmod +x BV-2
```
like this:

`chmod +x` allows for the file `BV-1` to be executed by macOS. You can close the terminal window afterwards.

8. The Bot-Variant should now be executable. Right click on the Variant and select `open`.
   
10. For all subsequent uses, simply double click on the file to open the Bot-Variant.

---

### Optional Instructions
_This part would make more sense after reading the Documentation._

Running either Bot-Variant would create the `WHO_AM_I` folder and the `tasks.txt` file within the same folder that the Bot-Variant exists in.
   
11. If you wish to restore the behaviour of either Bot-Variant at any point in time, delete the `WHO_AM_I` folder
   
12. If you wish to remove all your tasks, delete the `tasks.txt` file. 

#### For Bot-Variant 1 only

At some point, BV-1 will mutilate its source code which, as stated in the Documentation, cannot be reversed with step `11` above.

The only option is to redownload BV-1 from this repository and start over. _This would mean that you have to go through the hassle of getting macOS to let you open the file all over again._ You can copy the `tasks.txt` file over to preserve your tasks if you wish.

#### For Bot-Variant 2 only

At some point, BV-2 might overwrite the `tasks.txt` with a message. Simply execute step `12` above to prompt BV-2 to create a new `tasks.txt` file.

---

### Miscellaneous Information

Both Bot-Variants are designed to be self-sufficient i.e. they do not need any external files to function. If a certain file is missing (for e.g. `tasks.txt`) then the Bot-Variant would simply create the necessary files in the folder they are in.

**Simulataneous Usage** - If you are downloading both Variants, keep them in separate folders first. They share the same `SELF_CONCEPT` (explained in the Documentation) and so interaction with one might influence the other's behaviour. This is largely an unintended side-effect, but if you wish to explore this, feel free to do, there is no negative side effect.

### Acknowledgements
- Icons sourced from: <a href="https://www.flaticon.com/free-icons/robot" title="robot icons">Robot icons created by Freepik - Flaticon</a>
