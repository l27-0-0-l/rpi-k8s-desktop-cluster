# rpi-k8s-desktop-cluster


Below are initial drawings:

Network layout for multiple domain (3xswitch in ring)
https://docs.google.com/drawings/d/1XI8nkcKa3x-YcSedER6-IKUlBa9Y5fa52OVJSirwfQk/edit?usp=sharing

storage layout - having multiple pods (within daemonset) act as targets, and one pod acting as initiator, creating raid targets and providing storage share
https://docs.google.com/drawings/d/1XXn57l4X9QwumDOLttvCGhqcktzC4zwETvv7kQrHgRw/edit?usp=sharing

expected service layers - many on single drawing
https://docs.google.com/drawings/d/1kvcEVfH1zeM1cWgTxiEpEaI1fUz_su6O05IjGHCAz_0/edit?usp=sharing

power management - hardware project (probably arduino + eth + relay shield)
https://docs.google.com/drawings/d/1V3gBbgemZfL_gll-Gbh4ge6LJ9uGnUedN-kgccuC3VU/edit?usp=sharing

hdmi and audio - hdmi should have switch (hardwar project, probably arduino + eth shield + hdmi switch) and analog mixer
there will be a need for detection of connected hdmi, and labeling node with active hdmi connection
https://docs.google.com/drawings/d/1xN0cfwsOpq-x7y147crP51LZHoOkih-m13GIcx99OWI/edit?usp=sharing

keyboard and mouse
https://docs.google.com/drawings/d/1RBUqpRJxPFQtpxEOyP0FwwYWH5gkMkWKZMEl5JztnfE/edit?usp=sharing

https://docs.google.com/drawings/d/12uTbsPlmJqacferoNhRcVzllYPBdHpW0kgCveP47JpU/edit?usp=sharing

X windows - direct share or xpra ?
https://docs.google.com/drawings/d/1U2cdBkTbMWLFxoZTjdltxxMJNdGBr-sDb09HCYXnwOI/edit?usp=sharing


