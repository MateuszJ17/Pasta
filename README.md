# Pasta
Simple copy and paste clipboard manager. Wokrs with images as well as text.


# Table of contents
1. [Description](#description)
1. [How to create executable](#how-to-create-executable)
1. [How to start at system start](#how-to-start-at-system-start)

# Description
<p>Pasta is a simple clipboard manager menubar tool that allows for storing up to 10 last copied items (images included). I've created it mainly for my own use as I missed clipboard history from windows when I've switched to macOS. It is built on top of system pasteboard and should keep all of it's behaviours in regards to copying text and images. </p>

<p>At the start you will be greeted by simple popup saying you need tostart by copying some items</p>
<img width="300" alt="obraz" src="https://user-images.githubusercontent.com/23579349/182027481-3da80395-b7f1-44c2-bb01-25aa41cf61b6.png">

<p>After you copy some text or images they will be displayed as rows (highlighted on hover with your system selected accent color)</p>
<img width="306" alt="obraz" src="https://user-images.githubusercontent.com/23579349/182027605-508e210e-c7e5-41aa-a7c1-7da1f58b3610.png">

<p>Then you can insert selected row back into system pasteboard simply by clicking it. You can also remove individual items, or clear the whole list. <b>Pasta stores up to 10 items. After that oldest item will be replaced with the newly copied one!</b></p>

# How to create executable
<p>After cloning the repo, open it in Xcode. After that go to Product > Archive >D istribute app and select the 'Copy app' option.</p>
<img width="754" alt="obraz" src="https://user-images.githubusercontent.com/23579349/182027825-8b498805-70f9-4458-8303-bf9f88654ffb.png">
<p>Then select the location and click 'Export'. The application should be there. After doing this you can simply drag and drop it into your system 'Applications' directory.</p>

# How to start at system start
<p>It's a matter of going to Preferences > Users & Groups > Login Items and adding it to auto-launch.</p>
